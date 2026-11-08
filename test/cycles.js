// The machine cycles the simulator charges for each of the 255 defined 8051 opcodes, against the instruction table of
// the classic 12T core (the Intel MCS-51 table; the STC89C52RC in 12T mode uses the same counts). Every timing in
// ref/nn/results rests on these counts.
//   node test/cycles.js
// (Until 8 Nov 2026 MOV Rn,direct, A8H-AFH, cost 1 cycle here instead of 2, and ORL C,/bit and ANL C,/bit, A0H and
// B0H, were not run at all; round trips on the chip confirmed the 2 cycles.)
'use strict';
const E = require('../src/i8051.js');
const Board = require('../src/board.js');

const two = new Set([0x02, 0x12, 0x22, 0x32, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80, 0x73, 0x43, 0x53, 0x63,
  0x72, 0x82, 0xA0, 0xB0, 0x75, 0x83, 0x93, 0x85, 0x86, 0x87, 0x90, 0x92, 0xA3, 0xA6, 0xA7, 0xB4, 0xB5, 0xB6, 0xB7,
  0xC0, 0xD0, 0xD5, 0xE0, 0xE2, 0xE3, 0xF0, 0xF2, 0xF3]);
for (let n = 0; n < 8; n++) [0x88, 0xA8, 0xB8, 0xD8].forEach(b => two.add(b + n));
for (let n = 0; n < 8; n++) { two.add(0x01 + 32 * n); two.add(0x11 + 32 * n); }      // AJMP, ACALL
const want = op => (op === 0x84 || op === 0xA4 ? 4 : two.has(op) ? 2 : 1);           // DIV AB, MUL AB: 4

const bad = [];
for (let op = 0; op < 256; op++) {
  if (op === 0xA5) continue;                                                       // not an instruction
  const img = new Uint8Array(65536);
  img[0] = 0x02; img[1] = 0x01; img[2] = 0x00;                                      // LJMP 0100H
  img[0x100] = op; img[0x101] = 0x30; img[0x102] = 0x05;                            // operands: 30H, then 5
  const b = new Board(E); b.load(img); b.reset();
  b.step();
  const c0 = b.cpu.cycles; b.step();
  const got = b.cpu.cycles - c0;
  if (got !== want(op)) bad.push(op.toString(16).toUpperCase().padStart(2, '0') + 'H: ' + got + ' cycles, the table says ' + want(op));
}
// the two bit instructions that were missing: C = C or not bit, C = C and not bit
const bit = (op, c, v) => {
  const img = new Uint8Array(65536); img[0] = op; img[1] = 0x00;                    // bit 0 of 20H
  const b = new Board(E); b.load(img); b.reset();
  b.cpu.writeDirect(0x20, v); b.cpu.writeDirect(0xD0, c ? 0x80 : 0);
  b.step();
  return (b.cpu.readDirect(0xD0) >> 7) & 1;
};
for (const c of [0, 1]) for (const v of [0, 1]) {
  if (bit(0xA0, c, v) !== (c | (v ^ 1))) bad.push('ORL C,/bit with C=' + c + ', bit=' + v);
  if (bit(0xB0, c, v) !== (c & (v ^ 1))) bad.push('ANL C,/bit with C=' + c + ', bit=' + v);
}
console.log(bad.length ? bad.join('\n') : 'all 255 opcodes take the cycles of the 8051 table; ORL C,/bit and ANL C,/bit give the right carry');
process.exit(bad.length ? 1 : 0);
