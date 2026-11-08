// Random programs made of A51 words and symbols: the assembler must never throw, and whenever it reports no
// error the program must assemble to the same bytes a second time (no state left over between runs).
//   node test/fuzz.js [count]
'use strict';
const A = require('../src/asm51.js');

const WORDS = ['MOV', 'ADD', 'SJMP', 'JMP', 'CALL', 'ACALL', 'AJMP', 'LJMP', 'CJNE', 'DJNZ', 'JB', 'SETB', 'CLR', 'CPL',
  'PUSH', 'POP', 'MOVC', 'MOVX', 'INC', 'DEC', 'XCH', 'ORL', 'ANL', 'NOP', 'RET', 'DB', 'DW', 'DS', 'ORG', 'END', 'EQU',
  'SET', 'BIT', 'DATA', 'CODE', 'USING', 'CSEG', 'DSEG', 'AT', 'A', 'B', 'C', 'R0', 'R7', '@R0', '@R1', '@A+DPTR', 'DPTR',
  'AB', 'ACC', 'P1', 'P3.2', 'TR0', 'AR3', 'HIGH', 'LOW', 'NOT', 'AND', 'OR', 'MOD', 'SHL', 'EQ', 'L1', 'L2', 'X', 'Y',
  '$', '#', '#5', '#0FFH', '30H', '20H.1', '7FFH', '1000H', "'A'", '"xy"', "'", '0x1F', '12Q', '2B', '(', ')', '+', '-',
  '*', '/', ',', '.', ':', ';', 'L1:', 'L2:', 'X EQU 5', 'Y BIT 21H.0', '\t', '?', '_Z', 'é'];
let seed = 12345;
const rnd = n => {                         // mulberry32
  seed = (seed + 0x6D2B79F5) | 0;
  let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
  t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
  return (((t ^ (t >>> 14)) >>> 0) % n);
};
const count = +process.argv[2] || 3000;
let clean = 0, withErrors = 0;
for (let k = 0; k < count; k++) {
  const lines = [];
  const nl = 1 + rnd(12);
  for (let i = 0; i < nl; i++) {
    const nw = rnd(7);
    const w = [];
    for (let j = 0; j < nw; j++) w.push(WORDS[rnd(WORDS.length)]);
    lines.push((rnd(2) ? ' ' : '') + w.join(rnd(3) ? ' ' : ','));
  }
  const src = lines.join('\n');
  let r;
  try { r = A.assemble(src); } catch (e) { console.log('THROWS on:\n' + src + '\n' + e.stack); process.exit(1); }
  if (r.ok) {
    clean++;
    const r2 = A.assemble(src);
    if (r2.hex !== r.hex) { console.log('NOT REPEATABLE:\n' + src); process.exit(1); }
  } else withErrors++;
}
console.log(count + ' random programs: none threw; ' + clean + ' assembled cleanly (and the same twice), ' + withErrors + ' got errors');
