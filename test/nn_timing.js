// One reading of a digit-reader build on the simulated board, timed the same way for every build (assembly or C):
// from the program's read of the last input character from SBUF to its write of the first character of the answer
// to SBUF. Both moments are seen inside the instruction that does them, so the time is exact to the cycle and does
// not depend on how the build is written. (Until 8 Nov 2026 the harnesses stopped the clock when the first
// character had been sent, 10 bit times or 480 machine cycles later, and polled every 0.02 ms.)
//   const T = require('./nn_timing.js');
//   const b = new Board(E); b.load(image); b.reset();
//   const st = T.attach(b); b.run(T.ms(20));          // greeting
//   const r = T.reading(b, st, 'D' + pixels);          // { cycles, ms, line }
'use strict';
const Board = require('../src/board.js');
const MS = Board.CYCLES_PER_S / 1000;

function attach(b) {
  const c = b.cpu, st = { lastRead: -1, firstWrite: -1, out: '' };
  const rd = c.readDirect;
  c.readDirect = function (a) { if ((a & 0xFF) === 0x99) st.lastRead = this.cycles; return rd.call(this, a); };
  const wr = c.writeDirect;
  c.writeDirect = function (a, v) { if ((a & 0xFF) === 0x99 && st.firstWrite < 0) st.firstWrite = this.cycles; wr.call(this, a, v); };
  b.onSerial = ch => { st.out += String.fromCharCode(ch); };
  return st;
}

function reading(b, st, text) {
  st.out = ''; st.firstWrite = -1;
  b.serialIn(Array.from(text, ch => ch.charCodeAt(0)));
  for (let guard = 0; !st.out.endsWith('\n'); guard++) {
    if (guard > 20000) throw new Error('no answer');
    b.run(Math.round(0.05 * MS));
  }
  b.run(Math.round(5 * MS));
  const cycles = st.firstWrite - st.lastRead;
  return { cycles, ms: cycles / MS, line: st.out.trim(), raw: st.out };
}

module.exports = { attach, reading, MS, ms: t => Math.round(t * MS) };
