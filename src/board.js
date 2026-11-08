/* board.js: the TSI STC89C52RC board around the course CPU (src/i8051.js, an unchanged copy of
 * _i8051/i8051.js, the engine of the published 3981 simulator pages).
 *
 * Board wiring (CW3, checked on Emmanuel's board): P0.0-P0.7 = segments a-g, dp and LEDs D1-D8, all lit by 0
 * (the LEDs always mirror P0); P1.3-P1.6 = digits 1-4 left to right, on at 0; P3.5, P3.4, P3.3, P3.2 = buttons S5,
 * S4, S3, S2, 0 when pressed; P3.6 = passive buzzer. 11.0592 MHz, 12 clocks per machine cycle.
 *
 * What this file adds to the course CPU, on the CPU object only (the shared engine file is not changed):
 *   - Timer 2 of the 8052 (auto-reload, capture and baud-rate modes, TF2, vector 002BH, IE.5, IP.5);
 *   - Timers 0 and 1 in all four modes, with GATE and counter mode (T0 = P3.4, T1 = P3.5);
 *   - the serial port in mode 1 (8 data bits) with its baud rate from Timer 1 or Timer 2, TI and RI, vector 0023H;
 *   - the 2 machine cycles an interrupt call takes (the course engine jumps to the vector for free);
 *   - a stop on the one undefined opcode, A5H.
 *
 *   const b = new Board(i8051);  b.load(image);  b.run(cycles);  b.frame()  ->  what the eye sees
 */
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.Board = factory();
}(typeof self !== 'undefined' ? self : this, function () {
  'use strict';

  const XTAL = 11059200;
  const CYCLES_PER_S = XTAL / 12;                  // 921 600 machine cycles a second
  const BUTTONS = { S5: 5, S4: 4, S3: 3, S2: 2 };  // P3 bit of each button
  const T2 = { T2CON: 0x48, RCAP2L: 0x4A, RCAP2H: 0x4B, TL2: 0x4C, TH2: 0x4D };   // index in sfrOther (address-80H)

  class Board {
    constructor(i8051) {
      this.E = i8051;
      this.cpu = new i8051.CPU({ xtal: XTAL });
      this.image = new Uint8Array(65536);
      this.onSerial = null;                       // function (byte) for every byte the program sends
      this.onBuzzer = null;                       // function (level, cycles): the P3.6 level for so many cycles
      this.extend();
      this.clearFrame();
    }

    // ---------------------------------------------------------------- the CPU additions
    extend() {
      const cpu = this.cpu, board = this;
      const s = () => cpu.sfrOther;
      cpu.txLeft = 0; cpu.rxQueue = []; cpu.rxLeft = 0;
      cpu.lastT0pin = 1; cpu.lastT1pin = 1;
      // timers: replaces the engine's Timer 0/1 model (modes 1 and 2 only) for this CPU
      cpu.tickTimers = function (cyc) {
        const pin3 = this.p3 & this.pins[3];
        const t0pin = (pin3 >> 4) & 1, t1pin = (pin3 >> 5) & 1;
        const t0edges = (this.lastT0pin && !t0pin) ? 1 : 0, t1edges = (this.lastT1pin && !t1pin) ? 1 : 0;
        this.lastT0pin = t0pin; this.lastT1pin = t1pin;
        const tm = this.tmod;
        // Timer 0
        const gate0 = !(tm & 0x08) || ((pin3 >> 2) & 1);
        const run0 = (this.tcon & 0x10) && gate0;
        const n0 = (tm & 0x04) ? t0edges : cyc;
        const m0 = tm & 3;
        if (m0 === 3) {
          // mode 3: TL0 is an 8-bit timer of its own (TR0, TF0); TH0 counts machine cycles under TR1 and sets TF1
          if (run0) { let v = this.tl0 + n0; if (v > 0xFF) { this.tcon |= 0x20; } this.tl0 = v & 0xFF; }
          if (this.tcon & 0x40) { let v = this.th0 + cyc; if (v > 0xFF) { this.tcon |= 0x80; } this.th0 = v & 0xFF; }
        } else if (run0 && n0) count(this, 0, m0, n0);
        // Timer 1 (stops in mode 3; while Timer 0 is in mode 3 it still runs, but without TF1)
        const m1 = (tm >> 4) & 3;
        const gate1 = !(tm & 0x80) || ((pin3 >> 3) & 1);
        const run1 = (this.tcon & 0x40) && gate1 && m1 !== 3;
        const n1 = (tm & 0x40) ? t1edges : cyc;
        let ovf1 = 0;
        if (run1 && n1) ovf1 = count(this, 1, m1, n1, m0 === 3);
        // Timer 2
        const t2con = s()[T2.T2CON];
        let ovf2 = 0;
        if (t2con & 0x04) {
          const baud = t2con & 0x30;              // RCLK or TCLK: baud-rate generator, counts clock/2 = 6x machine cycles
          let t = ((s()[T2.TH2] << 8) | s()[T2.TL2]) + (baud ? cyc * 6 : (t2con & 0x02 ? 0 : cyc));
          const reload = (s()[T2.RCAP2H] << 8) | s()[T2.RCAP2L];
          while (t > 0xFFFF) {
            ovf2++;
            if (baud || !(t2con & 0x01)) t = t - 0x10000 + reload; else t -= 0x10000;
            if (!baud) s()[T2.T2CON] |= 0x80;     // TF2; the program clears it
          }
          s()[T2.TH2] = (t >> 8) & 0xFF; s()[T2.TL2] = t & 0xFF;
        }
        board.serialTick(cyc, ovf1, ovf2);
      };
      function count(c, n, mode, add, noFlag) {
        const thK = n ? 'th1' : 'th0', tlK = n ? 'tl1' : 'tl0', tf = n ? 0x80 : 0x20;
        let ovf = 0;
        if (mode === 0) {                          // 13 bits: TL low 5 bits, TH 8 bits
          let v = ((c[thK] << 5) | (c[tlK] & 0x1F)) + add;
          while (v > 0x1FFF) { v -= 0x2000; ovf++; }
          c[thK] = (v >> 5) & 0xFF; c[tlK] = (c[tlK] & 0xE0) | (v & 0x1F);
        } else if (mode === 1) {
          let v = ((c[thK] << 8) | c[tlK]) + add;
          while (v > 0xFFFF) { v -= 0x10000; ovf++; }
          c[thK] = (v >> 8) & 0xFF; c[tlK] = v & 0xFF;
        } else if (mode === 2) {                   // 8-bit auto-reload from TH
          let v = c[tlK] + add;
          while (v > 0xFF) { v = v - 0x100 + c[thK]; ovf++; }
          c[tlK] = v & 0xFF;
        }
        if (ovf && !noFlag) c.tcon |= tf;
        return ovf;
      }

      // interrupts: the engine's rules (high priority first, only a higher level nests, one instruction after RETI)
      // with all six sources of the 8052 in its polling order, and the 2 cycles of the call
      const SRC = [
        { en: 0x01, ip: 0x01, vec: 0x03, req: c => c.tcon & 0x02, ack: c => { if (c.tcon & 0x01) c.tcon &= ~0x02; c.ie0Hold = false; } },
        { en: 0x02, ip: 0x02, vec: 0x0B, req: c => c.tcon & 0x20, ack: c => { c.tcon &= ~0x20; } },
        { en: 0x04, ip: 0x04, vec: 0x13, req: c => c.tcon & 0x08, ack: c => { if (c.tcon & 0x04) c.tcon &= ~0x08; } },
        { en: 0x08, ip: 0x08, vec: 0x1B, req: c => c.tcon & 0x80, ack: c => { c.tcon &= ~0x80; } },
        { en: 0x10, ip: 0x10, vec: 0x23, req: c => c.scon & 0x03, ack: () => {} },                 // RI, TI stay set
        { en: 0x20, ip: 0x20, vec: 0x2B, req: c => c.sfrOther[T2.T2CON] & 0xC0, ack: () => {} },   // TF2, EXF2 stay set
      ];
      cpu.checkInterrupts = function () {
        if (!(this.ie & 0x80)) return;
        if (this.retiHold) { this.retiHold = false; return; }
        const cur = this.isrLv.length ? this.isrLv[this.isrLv.length - 1] : -1;
        for (let lv = 1; lv > cur; lv--) {
          for (const q of SRC) {
            if (!(this.ie & q.en) || !q.req(this) || (((this.ip & q.ip) ? 1 : 0) !== lv)) continue;
            q.ack(this);
            this.vector(q.vec, lv);
            this.cycles += 2;                     // the LCALL to the vector: 2 machine cycles
            this.tickTimers(2);
            return;
          }
        }
      };

      // the serial port: writing SBUF sends a byte (TI after 10 bit times); bytes typed in come in through SBUF/RI
      const read = cpu.readDirect;
      cpu.readDirect = function (a) { return (a & 0xFF) === 0x99 ? (this.rxBuf || 0) : read.call(this, a); };
      const write = cpu.writeDirect;
      cpu.writeDirect = function (a, v) {
        write.call(this, a, v);
        if ((a & 0xFF) === 0x99) { this.txByte = v & 0xFF; this.txLeft = 10; this.txTicks = 0; }
      };
    }

    // one tick of the serial bit clock = one baud period; ovf1/ovf2 = timer overflows in the last instruction
    serialTick(cyc, ovf1, ovf2) {
      const c = this.cpu;
      const mode = (c.scon >> 6) & 3;
      if (mode !== 1 && mode !== 3) return;
      const t2con = c.sfrOther[T2.T2CON];
      const smod = (c.pcon >> 7) & 1;
      // Timer 1: baud = overflows / 32 (x2 with SMOD); Timer 2 (TCLK/RCLK): baud = overflows / 16
      const div = (t2con & 0x30) ? 16 : (smod ? 16 : 32);
      const ticks = (t2con & 0x30) ? ovf2 : ovf1;
      if (!ticks) return;
      c.serialSub = (c.serialSub || 0) + ticks;
      while (c.serialSub >= div) {
        c.serialSub -= div;
        if (c.txLeft > 0 && --c.txLeft === 0) { c.scon |= 0x02; if (this.onSerial) this.onSerial(c.txByte); }
        if (c.scon & 0x10) {                       // REN
          if (c.rxLeft > 0) { if (--c.rxLeft === 0) { c.rxBuf = c.rxByte; c.scon |= 0x01; } }
          else if (c.rxQueue.length && !(c.scon & 0x01)) { c.rxByte = c.rxQueue.shift(); c.rxLeft = 10; }
        }
      }
    }
    serialIn(bytes) { for (const b of bytes) this.cpu.rxQueue.push(b & 0xFF); }

    // ---------------------------------------------------------------- program and buttons
    load(image) {
      this.image.set(image);
      const c = this.cpu;
      c.reset();
      c.code = this.image;
      c.lineMap = {};
      c.pc = 0;
      c.pins = [0xFF, 0xFF, 0xFF, 0xFF];
      c.txLeft = 0; c.rxQueue = []; c.rxLeft = 0; c.serialSub = 0; c.rxBuf = 0; c.lastT0pin = 1; c.lastT1pin = 1;
      this.stop = null;
      this.clearFrame();
    }
    reset() { this.load(this.image); }
    setButton(name, down) { this.cpu.setPin(3, BUTTONS[name], down ? 0 : 1); }

    // ---------------------------------------------------------------- running
    // one instruction; returns the machine cycles it took (with an interrupt call that followed it)
    step() {
      const c = this.cpu;
      const pc = c.pc;
      if (c.code[pc] === 0xA5) { this.stop = { why: 'undefined opcode A5H at ' + hex4(pc) + 'H', pc }; return 0; }
      const key = (c.p0 & c.pins[0]) | ((c.p1 & c.pins[1]) << 8);
      const buz = ((c.p3 & c.pins[3]) >> 6) & 1;
      const before = c.cycles;
      c.step();
      const cyc = c.cycles - before;
      this.stateCyc.set(key, (this.stateCyc.get(key) || 0) + cyc);
      this.frameCyc += cyc;
      if (buz !== this.lastBuz) { this.buzMoves++; this.lastBuz = buz; }
      if (this.onBuzzer) this.onBuzzer(buz, cyc);
      return cyc;
    }
    // run for about n machine cycles; stops early at a breakpoint or a fault. Returns the cycles run.
    run(n, breakpoints) {
      const c = this.cpu, end = c.cycles + n;
      const start = c.cycles;
      while (c.cycles < end) {
        if (breakpoints && breakpoints.has(c.pc) && c.cycles !== start) { this.stop = { why: 'breakpoint', pc: c.pc }; break; }
        if (!this.step()) break;
      }
      return c.cycles - start;
    }
    ms() { return this.cpu.cycles / CYCLES_PER_S * 1000; }

    // ---------------------------------------------------------------- what the eye sees
    // Each instruction's cycles count for the P0/P1 state it ran under, so a multiplexed display blends the way the
    // real one does. frame() returns the share of time each segment, LED and digit enable was on since the last call.
    clearFrame() { this.stateCyc = new Map(); this.frameCyc = 0; this.buzMoves = 0; this.lastBuz = 1; }
    frame() {
      const seg = new Float32Array(32), led = new Float32Array(8), dig = new Float32Array(4);
      const c = this.cpu;
      const add = (key, f) => {
        const p0 = key & 0xFF, p1 = (key >> 8) & 0xFF;
        for (let k = 0; k < 8; k++) if (!((p0 >> k) & 1)) led[k] += f;
        for (let d = 0; d < 4; d++) if (!((p1 >> (3 + d)) & 1)) {
          dig[d] += f;
          for (let k = 0; k < 8; k++) if (!((p0 >> k) & 1)) seg[d * 8 + k] += f;
        }
      };
      if (this.frameCyc > 0) for (const [key, cyc] of this.stateCyc) add(key, cyc / this.frameCyc);
      else add((c.p0 & c.pins[0]) | ((c.p1 & c.pins[1]) << 8), 1);
      const buzzing = this.buzMoves;
      this.clearFrame();
      return { seg, led, dig, buzzing };
    }
  }
  const hex4 = v => v.toString(16).toUpperCase().padStart(4, '0');

  // segment patterns (bit 0 = a ... bit 6 = g, bit 7 = dp; 0 = lit) -> characters, for tests and the status line
  const GLYPH = { 0xC0: '0', 0xF9: '1', 0xA4: '2', 0xB0: '3', 0x99: '4', 0x92: '5', 0x82: '6', 0xF8: '7', 0x80: '8', 0x90: '9',
    0x88: 'A', 0x83: 'b', 0xC6: 'C', 0xA1: 'd', 0x86: 'E', 0x8E: 'F', 0xC2: 'G', 0x89: 'H', 0xCF: 'I', 0xC7: 'L', 0xAB: 'n',
    0xA3: 'o', 0x8C: 'P', 0xAF: 'r', 0x87: 't', 0xC1: 'U', 0xBF: '-', 0xFF: ' ' };
  // the four digits as text, from a frame: a segment counts as lit at a quarter of the light of a digit on its own
  Board.text = function (fr) {
    let s = '';
    for (let d = 0; d < 4; d++) {
      let code = 0xFF;
      if (fr.dig[d] > 0.05) for (let k = 0; k < 8; k++) if (fr.seg[d * 8 + k] > fr.dig[d] * 0.5) code &= ~(1 << k);
      const g = GLYPH[code | 0x80];
      s += g === undefined ? '?' : g + (code & 0x80 ? '' : '.');
    }
    return s;
  };
  Board.CYCLES_PER_S = CYCLES_PER_S;
  Board.BUTTONS = BUTTONS;
  return Board;
}));
