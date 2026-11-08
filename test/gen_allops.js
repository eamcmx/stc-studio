// Writes ref/probes/allops.a51: every 8051 instruction form, each register, a spread of operand values, written
// in plain A51 syntax (not taken from the assembler's own table), so Keil's listing can check every opcode.
//   node test/gen_allops.js
'use strict';
const fs = require('fs');
const path = require('path');

const L = [];
const R = [0, 1, 2, 3, 4, 5, 6, 7].map(n => 'R' + n);
const I = ['@R0', '@R1'];
const D = ['30H', '7FH', 'P1', 'ACC', '0', '0FFH'];
const N = ['#0', '#5AH', '#0FFH', '#-1', "#'A'"];
const BITS = ['20H.3', 'P1.2', 'ACC.7', 'CY', '0', '7FH', '0FFH', 'TR0'];

L.push(' ORG 0', 'TOP:');
for (const op of ['ADD', 'ADDC', 'SUBB', 'ANL', 'ORL', 'XRL']) {
  for (const r of R) L.push(` ${op} A,${r}`);
  for (const d of D) L.push(` ${op} A,${d}`);
  for (const i of I) L.push(` ${op} A,${i}`);
  for (const n of N) L.push(` ${op} A,${n}`);
  if (op === 'ANL' || op === 'ORL' || op === 'XRL') {
    for (const d of D.slice(0, 3)) L.push(` ${op} ${d},A`, ` ${op} ${d},#33H`);
  }
  if (op === 'ANL' || op === 'ORL') for (const b of BITS.slice(0, 4)) L.push(` ${op} C,${b}`, ` ${op} C,/${b}`);
}
for (const op of ['INC', 'DEC']) {
  L.push(` ${op} A`);
  for (const r of R) L.push(` ${op} ${r}`);
  for (const d of D) L.push(` ${op} ${d}`);
  for (const i of I) L.push(` ${op} ${i}`);
}
L.push(' INC DPTR', ' MUL AB', ' DIV AB', ' DA A');
for (const op of ['CLR', 'CPL']) { L.push(` ${op} A`, ` ${op} C`); for (const b of BITS) L.push(` ${op} ${b}`); }
L.push(' SETB C');
for (const b of BITS) L.push(` SETB ${b}`);
for (const op of ['RL', 'RLC', 'RR', 'RRC', 'SWAP']) L.push(` ${op} A`);
// MOV in every form
for (const r of R) L.push(` MOV A,${r}`, ` MOV ${r},A`, ` MOV ${r},30H`, ` MOV ${r},#12H`, ` MOV 40H,${r}`);
for (const d of D) L.push(` MOV A,${d}`, ` MOV ${d},A`, ` MOV ${d},#9`, ` MOV ${d},31H`, ` MOV 32H,${d}`);
for (const i of I) L.push(` MOV A,${i}`, ` MOV ${i},A`, ` MOV ${i},33H`, ` MOV ${i},#44H`, ` MOV 34H,${i}`);
for (const n of N) L.push(` MOV A,${n}`);
for (const b of BITS) L.push(` MOV C,${b}`, ` MOV ${b},C`);
L.push(' MOV DPTR,#1234H', ' MOV DPTR,#0', ' MOV DPTR,#TOP', ' MOV DPTR,#-2');
L.push(' MOVC A,@A+DPTR', ' MOVC A,@A+PC', ' MOVX A,@DPTR', ' MOVX @DPTR,A');
for (const i of I) L.push(` MOVX A,${i}`, ` MOVX ${i},A`);
for (const d of D) L.push(` PUSH ${d}`, ` POP ${d}`);
for (const r of R) L.push(` XCH A,${r}`);
for (const d of D) L.push(` XCH A,${d}`);
for (const i of I) L.push(` XCH A,${i}`, ` XCHD A,${i}`);
// jumps, backward and forward, in short groups so every target is in range
let g = 0;
function group(lines) { g++; L.push('BACK' + g + ':'); for (const x of lines) L.push(x.replace(/BACK/g, 'BACK' + g).replace(/FWD/g, 'FWD' + g)); L.push('FWD' + g + ':'); }
for (const op of ['JC', 'JNC', 'JZ', 'JNZ', 'SJMP']) group([` ${op} BACK`, ` ${op} FWD`, ` ${op} $`]);
for (const op of ['JB', 'JNB', 'JBC']) group(BITS.slice(0, 4).flatMap(b => [` ${op} ${b},BACK`, ` ${op} ${b},FWD`]));
group(R.flatMap(r => [` DJNZ ${r},BACK`, ` DJNZ ${r},FWD`]));
group(D.map(d => ` DJNZ ${d},BACK`));
group(D.map(d => ` CJNE A,${d},FWD`));
group(N.map(n => ` CJNE A,${n},BACK`));
group(R.map(r => ` CJNE ${r},#7,FWD`).concat(I.map(i => ` CJNE ${i},#8,BACK`)));
L.push('BACK:', ' NOP', 'FWD:');
for (const t of ['TOP', 'FWD', 'BACK', '$', '123H', '200H', '400H', '500H', '600H', '7FFH']) L.push(` AJMP ${t}`, ` ACALL ${t}`);
for (const t of ['TOP', 'FWD', 'BACK', 'FAR', '$', '123H', '0FFFFH']) L.push(` LJMP ${t}`, ` LCALL ${t}`);
L.push(' JMP @A+DPTR', ' JMP BACK', ' JMP FWD', ' JMP TOP', ' JMP FAR', ' CALL TOP', ' CALL FAR', ' CALL AHEAD');
L.push('AHEAD: NOP', ' RET', ' RETI', ' NOP');
L.push(' DB 0,1,7FH,80H,0FFH,-1,-128,\'Hello\',"x""y",\'\'', ' DW 0,1234H,TOP,FAR,\'AB\',-1');
L.push(' ORG 1000H', 'FAR: NOP', ' JMP FAR', ' CALL TOP', ' JMP TOP', ' CALL FAR', ' END');
fs.writeFileSync(path.join(__dirname, '..', 'ref', 'probes', 'allops.a51'), L.join('\r\n') + '\r\n');
console.log('allops.a51:', L.length, 'lines');
