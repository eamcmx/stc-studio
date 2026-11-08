/* stcisp.js: programs an STC89C52RC through its serial bootloader, from a web page (Web Serial) or from node.
 *
 * The protocol is a port of the Stc89Protocol class of stcgal 1.10, https://github.com/grigorig/stcgal
 *   Copyright (c) 2013-2015 Grigori Goronzy and others. MIT licence:
 *   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 *   documentation files (the "Software"), to deal in the Software without restriction, including without
 *   limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 *   Software, and to permit persons to whom the Software is furnished to do so, subject to the following
 *   conditions: The above copyright notice and this permission notice shall be included in all copies or
 *   substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 *   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Two things differ from stcgal, both found on the TSI board (docs/m1-programmer.md):
 *   - the restart: RTS off for 500 ms, then on (the board's RTS line switches the chip's power);
 *   - by default the whole session runs at one baud rate (19200), because Web Serial cannot change the rate of an
 *     open port. The bootloader accepts a handshake at 9600-57600 baud and a "switch" to the same rate.
 *
 *   const isp = new StcIsp(transport, { log, progress });
 *   const info = await isp.connect();          // restart the chip and read its status packet
 *   await isp.program(image, used);            // image: Uint8Array(65536), used: which bytes the program has
 *
 * A transport has: async write(Uint8Array), async read(timeoutMs) -> Uint8Array (whatever bytes arrived, maybe
 * none), async setRTS(bool), async setBaud(n) (optional), and baud (the current rate).
 */
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.StcIsp = factory();
}(typeof self !== 'undefined' ? self : this, function () {
  'use strict';

  const MODELS = { 0xF002: 'STC89C52RC/LE52RC', 0xF051: 'STC89C52', 0xF102: 'STC89C52RD+/LE52RD+' };
  const sleep = ms => new Promise(r => setTimeout(r, ms));
  const hex = b => Array.from(b, x => x.toString(16).toUpperCase().padStart(2, '0')).join(' ');

  class StcIsp {
    constructor(transport, opts) {
      opts = opts || {};
      this.t = transport;
      this.log = opts.log || (() => {});
      this.progress = opts.progress || (() => {});
      this.handshakeBaud = opts.handshakeBaud || transport.baud || 19200;
      this.transferBaud = opts.transferBaud || this.handshakeBaud;
      this.buf = [];
      this.info = null;
    }

    // ---- bytes in
    async fill(timeoutMs) {
      const got = await this.t.read(timeoutMs);
      if (got && got.length) for (const b of got) this.buf.push(b);
    }
    async readBytes(n, timeoutMs) {
      const end = Date.now() + timeoutMs;
      while (this.buf.length < n) {
        const left = end - Date.now();
        if (left <= 0) throw new Error('the chip did not answer in time');
        await this.fill(Math.min(left, 200));
      }
      return this.buf.splice(0, n);
    }
    // a chip packet: 46 B9 68 len_hi len_lo payload csum 16; len counts from 68 to 16. The status packet may come
    // without 46 B9 (stcgal accepts that too).
    async readPacket(timeoutMs = 3000) {
      let first = (await this.readBytes(1, timeoutMs))[0];
      let head;
      if (first === 0x68) head = [0x46, 0xB9, 0x68];
      else {
        if (first !== 0x46) throw new FrameError('wrong frame start ' + first.toString(16));
        const b = await this.readBytes(2, timeoutMs);
        if (b[0] !== 0xB9 || b[1] !== 0x68) throw new FrameError('wrong frame start');
        head = [0x46, 0xB9, 0x68];
      }
      const lb = await this.readBytes(2, timeoutMs);
      const len = (lb[0] << 8) | lb[1];
      if (len < 5 || len > 300) throw new FrameError('bad packet length ' + len);
      const rest = await this.readBytes(len - 3, timeoutMs);
      const pkt = head.concat(lb, rest);
      if (pkt[pkt.length - 1] !== 0x16) throw new FrameError('wrong frame end');
      const sum = pkt.slice(2, -2).reduce((s, x) => s + x, 0) & 0xFF;
      if (sum !== pkt[pkt.length - 2]) throw new FrameError('checksum wrong');
      this.log('<- ' + hex(pkt));
      return pkt.slice(5, -2);                    // the payload
    }

    // ---- bytes out: 46 B9 6A len payload csum 16
    async writePacket(payload) {
      const p = [0x46, 0xB9, 0x6A, 0, 0].concat(Array.from(payload));
      const len = payload.length + 5;
      p[3] = len >> 8; p[4] = len & 0xFF;
      p.push(p.slice(2).reduce((s, x) => s + x, 0) & 0xFF, 0x16);
      this.log('-> ' + hex(p));
      await this.t.write(Uint8Array.from(p));
    }

    // ---- 1. restart the chip and read its status packet
    async connect(opts) {
      opts = opts || {};
      const timeoutMs = opts.timeoutMs || 8000;
      this.buf = [];
      if (opts.restart !== false) {
        this.log('restart: RTS off 500 ms, then on');
        await this.t.setRTS(false);
        await sleep(500);
        await this.t.setRTS(true);
      }
      const end = Date.now() + timeoutMs;
      let status = null;
      while (!status) {
        if (Date.now() > end) throw new Error('no answer from the chip (is the board on, and is this the right port?)');
        await this.t.write(Uint8Array.of(0x7F));
        await this.fill(30);
        if (!this.buf.length) continue;
        try { status = await this.readPacket(500); }
        catch (e) { if (!(e instanceof FrameError) && !/in time/.test(e.message)) throw e; this.buf = []; }
      }
      return this.readStatus(status);
    }

    readStatus(s) {
      if (s[0] === 0x50) throw new Error('this chip uses the newer STC89 bootloader (stcgal "stc89a"), not supported yet');
      if (s[0] !== 0x00 || s.length < 23) throw new Error('unexpected status packet ' + hex(s));
      const msr = s[19];
      const t6 = !(msr & 1);
      let counter = 0;
      for (let i = 0; i < 8; i++) counter += (s[1 + 2 * i] << 8) | s[2 + 2 * i];
      counter /= 8;
      const clock = this.handshakeBaud * counter * (t6 ? 6 : 12) / 7;
      const magic = (s[20] << 8) | s[21];
      this.info = {
        magic, model: MODELS[magic] || 'unknown model ' + magic.toString(16).toUpperCase() + 'H',
        bsl: (s[17] >> 4) + '.' + (s[17] & 15) + String.fromCharCode(s[18]),
        msr, cpu6t: t6, clockHz: clock, status: Array.from(s),
      };
      this.log('chip: ' + this.info.model + ', bootloader ' + this.info.bsl + ', ' + (t6 ? '6T' : '12T') +
        ', clock ' + (clock / 1e6).toFixed(3) + ' MHz, option byte ' + msr.toString(16).toUpperCase() + 'H');
      return this.info;
    }

    // ---- 2. agree on the transfer baud rate and test it (stcgal Stc89Protocol.handshake)
    baudParams() {
      const sample = this.info.cpu6t ? 16 : 32;
      const brt = 65536 - Math.round(this.info.clockHz / (this.transferBaud * sample));
      const actual = this.info.clockHz / (sample * (65536 - brt));
      const errPct = Math.abs(this.transferBaud - actual) * 100 / this.transferBaud;
      let iap = 0x80;
      if (this.info.clockHz < 5e6) iap = 0x83; else if (this.info.clockHz < 10e6) iap = 0x82; else if (this.info.clockHz < 20e6) iap = 0x81;
      return { brt, brtCsum: (2 * (256 - brt)) & 0xFF, iap, delay: 0xA0, errPct };
    }
    async handshake() {
      const { brt, brtCsum, iap, delay, errPct } = this.baudParams();
      if (errPct > 5) this.log('warning: baud rate error ' + errPct.toFixed(1) + ' %');
      const change = this.transferBaud !== this.handshakeBaud;
      if (change && !this.t.setBaud) throw new Error('this connection cannot change its baud rate');
      await this.writePacket([0x8F, brt >> 8, brt & 0xFF, 0xFF - (brt >> 8), brtCsum, delay, iap]);
      await sleep(100);
      if (change) await this.t.setBaud(this.transferBaud);
      let r = await this.readPacket();
      if (change) await this.t.setBaud(this.handshakeBaud);
      if (r[0] !== 0x8F) throw new Error('baud check refused');
      await this.writePacket([0x8E, brt >> 8, brt & 0xFF, 0xFF - (brt >> 8), brtCsum, delay]);
      await sleep(100);
      if (change) await this.t.setBaud(this.transferBaud);
      r = await this.readPacket();
      if (r[0] !== 0x8E) throw new Error('baud switch refused');
      for (let k = 0; k < 4; k++) {
        await this.writePacket([0x80, 0x00, 0x00, 0x36, 0x01, this.info.magic >> 8, this.info.magic & 0xFF]);
        r = await this.readPacket();
        if (r[0] !== 0x80) throw new Error('ping refused');
      }
    }

    // ---- 3. erase, write, option byte, run (stcgal StcGal.program_mcu with Stc89Protocol)
    // The image stcgal sends: every byte from 0 to the last one the program has (gaps as 00H), then FFH up to a
    // multiple of 512 bytes.
    static flashImage(image, used) {
      let top = 0;
      for (let a = 0; a < 65536; a++) if (used[a]) top = a + 1;
      const n = Math.max(512, Math.ceil(top / 512) * 512);
      const out = new Uint8Array(n).fill(0xFF);
      for (let a = 0; a < top; a++) out[a] = used[a] ? image[a] : 0x00;
      return { data: out, top };
    }
    async program(image, used, opts) {
      opts = opts || {};
      const { data, top } = StcIsp.flashImage(image, used);
      const codeSize = 8192;                  // STC89C52RC: 8 KB of code flash
      if (top > codeSize) throw new Error('the program is ' + top + ' bytes long; the STC89C52RC holds ' + codeSize);
      await this.handshake();
      const blocks = ((data.length + 511) >> 9) * 2;
      this.log('erase ' + blocks + ' blocks of 256 bytes');
      await this.writePacket([0x84, blocks, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33]);
      let r = await this.readPacket(15000);
      if (r[0] !== 0x80) throw new Error('erase refused');
      for (let i = 0; i < data.length; i += 128) {
        const chunk = Array.from(data.subarray(i, i + 128));
        await this.writePacket([0x00, 0x00, 0x00, i >> 8, i & 0xFF, 0x00, 0x80].concat(chunk));
        r = await this.readPacket(5000);
        const sum = chunk.reduce((s, x) => s + x, 0) & 0xFF;
        if (r[0] !== 0x80) throw new Error('write refused at ' + i.toString(16).toUpperCase() + 'H');
        if (r[1] !== sum) throw new Error('the chip got different bytes at ' + i.toString(16).toUpperCase() + 'H');
        this.progress(i + 128, data.length);
      }
      // the option byte goes back as it was read, so 12T mode and the other options stay
      await this.writePacket([0x8D, this.info.msr, 0xFF, 0xFF, 0xFF]);
      r = await this.readPacket();
      if (r[0] !== 0x8D) throw new Error('option byte refused');
      if (opts.run !== false) await this.run();
      return { bytes: data.length, top };
    }
    async run() {
      await this.writePacket([0x82]);         // leave the bootloader and start the program
      this.log('program started');
    }
  }
  class FrameError extends Error {}

  // ---- Web Serial transport (Chrome and Edge). The port is opened once at one baud rate and kept open.
  class WebSerialTransport {
    constructor(port, baud) { this.port = port; this.baud = baud || 19200; this.reader = null; this.pending = null; }
    async open() {
      await this.port.open({ baudRate: this.baud, dataBits: 8, stopBits: 1, parity: 'none', bufferSize: 4096, flowControl: 'none' });
      await this.port.setSignals({ dataTerminalReady: true, requestToSend: true });
      this.writer = this.port.writable.getWriter();
      this.reader = this.port.readable.getReader();
    }
    async write(bytes) { await this.writer.write(bytes); }
    async setRTS(on) { await this.port.setSignals({ requestToSend: !!on }); }
    // read whatever arrives within timeoutMs; a read still waiting is kept for the next call
    async read(timeoutMs) {
      if (!this.pending) this.pending = this.reader.read();
      let timer;
      const timeout = new Promise(r => { timer = setTimeout(() => r(null), timeoutMs); });
      const got = await Promise.race([this.pending, timeout]);
      clearTimeout(timer);
      if (!got) return new Uint8Array(0);
      this.pending = null;
      if (got.done) throw new Error('the serial port closed');
      return got.value;
    }
    async close() {
      try { if (this.pending) { await this.reader.cancel(); } } catch (e) { /* closing anyway */ }
      try { this.reader.releaseLock(); } catch (e) { /* closing anyway */ }
      try { this.writer.releaseLock(); } catch (e) { /* closing anyway */ }
      await this.port.close();
    }
  }

  StcIsp.WebSerialTransport = WebSerialTransport;
  StcIsp.FrameError = FrameError;
  StcIsp.hex = hex;
  return StcIsp;
}));
