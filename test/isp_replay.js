// Checks the STC89 programmer port (src/stcisp.js) without the board.
//   node test/isp_replay.js
// 1. Replay: the chip's answers recorded when stcgal flashed demo2 on Emmanuel's board (ref/m1/flash_demo2.log,
//    2400 baud handshake, 115200 transfer) are fed back; every packet our code sends must equal stcgal's.
// 2. A simulated bootloader at one baud rate (the way the web page runs): the flash it ends up with must equal the
//    program, and a wrong checksum from the chip must stop the run with an error.
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const StcIsp = require('../src/stcisp.js');
const ROOT = path.join(__dirname, '..');
let failures = 0;
const check = (ok, what) => { console.log((ok ? 'ok    ' : 'FAIL  ') + what); if (!ok) failures++; };
const bytesOf = s => s.trim().split(/\s+/).map(x => parseInt(x, 16));

async function replay(logFile, hexFile) {
  const log = fs.readFileSync(path.join(ROOT, logFile), 'utf8');
  const seq = [...log.matchAll(/(->|<-) Packet data: ([0-9A-F ]+)/g)].map(m => ({ dir: m[1], b: bytesOf(m[2]) }));
  const status = seq.shift();                     // the chip's status packet, answered to the 7FH pulses
  let i = 0, mismatches = 0, sent = 0;
  const queue = [];
  const t = {
    baud: 2400,
    async write(bytes) {
      const b = Array.from(bytes);
      if (b.length === 1 && b[0] === 0x7F) { if (!queue.length && i === 0) queue.push(...status.b); return; }
      const exp = seq[i++];
      sent++;
      if (!exp || exp.dir !== '->' || exp.b.join() !== b.join()) {
        mismatches++;
        if (mismatches < 4) console.log('   expected ' + (exp ? StcIsp.hex(exp.b) : 'nothing') + '\n   sent     ' + StcIsp.hex(b));
      }
      while (seq[i] && seq[i].dir === '<-') queue.push(...seq[i++].b);
    },
    async read() { return Uint8Array.from(queue.splice(0, queue.length)); },
    async setRTS() {},
    async setBaud(b) { this.baud = b; },
  };
  const isp = new StcIsp(t, { handshakeBaud: 2400, transferBaud: 115200 });
  const info = await isp.connect();
  const k = A.readHex(fs.readFileSync(path.join(ROOT, hexFile), 'utf8'));
  await isp.program(k.image, k.used);
  check(info.model === 'STC89C52RC/LE52RC' && info.bsl === '6.6C' && !info.cpu6t, 'status packet read: ' + info.model + ', BSL ' + info.bsl + ', 12T');
  check(mismatches === 0 && i === seq.length, logFile + ': ' + sent + ' packets sent, ' + mismatches + ' differ from stcgal, ' + (seq.length - i) + ' left over');
}

// a bootloader that answers like the STC89C52RC on the board (status packet from the log)
function fakeChip(statusPayload, opts) {
  opts = opts || {};
  const flash = new Uint8Array(8192).fill(0xFF);
  const out = [];
  let rx = [], started = false, erased = false, ran = false, optionByte = null;
  const reply = payload => {
    const p = [0x46, 0xB9, 0x68, 0, 0].concat(payload);
    const len = payload.length + 5;
    p[3] = len >> 8; p[4] = len & 0xFF;
    p.push(p.slice(2).reduce((s, x) => s + x, 0) & 0xFF, 0x16);
    out.push(...p);
  };
  const t = {
    baud: 19200,
    async write(bytes) {
      for (const b of bytes) rx.push(b);
      if (!started) { if (rx.includes(0x7F)) { started = true; rx = []; reply(statusPayload); } return; }
      while (rx.length >= 5 && rx[0] === 0x46) {
        const len = (rx[3] << 8) | rx[4];
        if (rx.length < len + 2) return;
        const p = rx.splice(0, len + 2), pl = p.slice(5, -2);
        if ((p.slice(2, -2).reduce((s, x) => s + x, 0) & 0xFF) !== p[p.length - 2]) throw new Error('fake chip: bad checksum from host');
        const c = pl[0];
        if (c === 0x8F || c === 0x8E) reply(pl);
        else if (c === 0x80) reply([0x80]);
        else if (c === 0x84) { erased = true; flash.fill(0xFF); reply([0x80, 0xF0, 0x02, 1, 2, 3, 4, 5, 6]); }
        else if (c === 0x00) {
          const a = (pl[3] << 8) | pl[4], data = pl.slice(7);
          if (!erased) throw new Error('fake chip: write before erase');
          data.forEach((b, k) => { flash[a + k] &= b; });
          let sum = data.reduce((s, x) => s + x, 0) & 0xFF;
          if (opts.corruptAt === a) sum ^= 1;
          reply([0x80, sum]);
        } else if (c === 0x8D) { optionByte = pl[1]; reply([0x8D]); }
        else if (c === 0x82) ran = true;
        else throw new Error('fake chip: unknown command ' + c.toString(16));
      }
    },
    async read() { return Uint8Array.from(out.splice(0, out.length)); },
    async setRTS() {},
  };
  return { t, flash, state: () => ({ erased, ran, optionByte }) };
}

async function single(hexFile) {
  const log = fs.readFileSync(path.join(ROOT, 'ref/m1/flash_demo2.log'), 'utf8');
  const st = bytesOf(/<- Packet data: ([0-9A-F ]+)/.exec(log)[1]);
  const statusPayload = st.slice(5, -2);
  const k = A.readHex(fs.readFileSync(path.join(ROOT, hexFile), 'utf8'));
  const chip = fakeChip(statusPayload);
  const isp = new StcIsp(chip.t, { handshakeBaud: 19200 });
  await isp.connect();
  const r = await isp.program(k.image, k.used);
  let same = true;
  for (let a = 0; a < 8192; a++) {
    const want = a < r.top ? (k.used[a] ? k.image[a] : 0x00) : 0xFF;
    if (chip.flash[a] !== want) { same = false; break; }
  }
  const s = chip.state();
  check(same && s.ran && s.optionByte === 0xFD, hexFile + ' at one rate (19200): fake chip holds the program, option byte FDH kept, program started');
  const bad = fakeChip(statusPayload, { corruptAt: 0x100 });
  const isp2 = new StcIsp(bad.t, { handshakeBaud: 19200 });
  await isp2.connect();
  let msg = '';
  try { await isp2.program(k.image, k.used); } catch (e) { msg = e.message; }
  check(/different bytes at 100H/.test(msg) && !bad.state().ran, 'a wrong checksum from the chip stops the run: "' + msg + '"');
}

(async () => {
  await replay('ref/m1/flash_demo2.log', 'ref/m1/demo2_keil.hex');
  await replay('ref/m1/flash_ex2.log', 'ref/m1/ex2_keil.hex');
  await single('ref/m1/demo2_keil.hex');
  console.log(failures ? failures + ' FAILED' : 'all programmer checks passed');
  process.exit(failures ? 1 : 0);
})().catch(e => { console.log('FAIL ' + e.stack); process.exit(1); });
