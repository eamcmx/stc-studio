// Writes random but mostly sensible A51 programs to ref/random/r000.a51 ... for a differential test against Keil:
//   node test/gen_random.js 200 && for f in ref/random/*.a51; do tools/keil.sh $f ref/keil-random/$(basename ${f%.a51}); done
//   node test/probes.js ref/random ref/keil-random
'use strict';
const fs = require('fs');
const path = require('path');
const n = +process.argv[2] || 200;
// --clean: leave out the planted mistakes, so that most programs build in Keil and whole images can be compared
const CLEAN = process.argv.includes('--clean');
const OUT = CLEAN ? 'random-clean' : 'random';
let seed = +process.argv[3] || 777;
// mulberry32: the low bits of a plain LCG repeat too soon (the first run picked almost only MOV, INC and JMP)
const rnd = k => {
  seed = (seed + 0x6D2B79F5) | 0;
  let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
  t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
  return (((t ^ (t >>> 14)) >>> 0) % k);
};
const pick = a => a[rnd(a.length)];

const LABELS = ['L1', 'L2', 'L3', 'LOOP', 'NEXT', 'DONE', 'TAB', 'SUB1', 'FAR1'];
const DIRS = ['30H', '7FH', 'P1', 'P3', 'ACC', 'B', 'SP', 'CNT', 'CNT+1', 'AR2', '0E0H', '25H', 'TL0', 'PSW'];
const IMMS = ['#0', '#1', '#0FFH', '#-1', '#20', "#'A'", '#K1', '#K1*2', '#HIGH(TAB)', '#LOW(TAB)', '#LOW(1500)',
  '#255', '#256', '#100B', '#77Q', '#0x3C', '#1 SHL 4', '#NOT 0', '#K1 AND 0FH', '#(K1+3)/2', '#CNT'];
const BITS = ['P1.0', 'P3.2', 'ACC.7', 'CY', 'TR0', 'EA', 'FLAG', '20H.5', '2FH.0', 'P0.7', 'FLAG+1', 'RS0'];
const TARGETS = () => [pick(LABELS), '$', '$+3', '$-2', pick(LABELS) + '+1'];
function insn() {
  const r = rnd(40);
  const R = 'R' + rnd(8), I = '@R' + rnd(2), D = pick(DIRS), M = pick(IMMS), BT = pick(BITS), T = pick(TARGETS());
  switch (r) {
    case 0: return `MOV A,${pick([R, I, D, M])}`;
    case 1: return `MOV ${pick([R, I, D])},${pick(['A', M, D])}`;
    case 2: return `MOV ${D},${pick([R, I, D, M])}`;
    case 3: return pick([`MOV C,${BT}`, `MOV ${BT},C`]);
    case 4: return `MOV DPTR,#${pick(['TAB', '1234H', 'FAR1', 'K1*100H'])}`;
    case 5: return `${pick(['ADD', 'ADDC', 'SUBB'])} A,${pick([R, I, D, M])}`;
    case 6: return `${pick(['ANL', 'ORL', 'XRL'])} ${pick(['A', D])},${pick([R, I, D, M, 'A'])}`;
    case 7: return `${pick(['ANL', 'ORL'])} C,${pick([BT, '/' + BT])}`;
    case 8: return `${pick(['INC', 'DEC'])} ${pick(['A', R, I, D, 'DPTR'])}`;
    case 9: return `${pick(['CLR', 'CPL', 'SETB'])} ${pick(['A', 'C', BT])}`;
    case 10: return pick(['RL A', 'RLC A', 'RR A', 'RRC A', 'SWAP A', 'DA A', 'MUL AB', 'DIV AB', 'NOP', 'RET', 'RETI']);
    case 11: return `${pick(['SJMP', 'JZ', 'JNZ', 'JC', 'JNC'])} ${T}`;
    case 12: return `${pick(['JB', 'JNB', 'JBC'])} ${BT},${T}`;
    case 13: return `DJNZ ${pick([R, D])},${T}`;
    case 14: return `CJNE ${pick(['A,' + D, 'A,' + M, R + ',' + M, I + ',' + M])},${T}`;
    case 15: return `${pick(['AJMP', 'ACALL', 'LJMP', 'LCALL'])} ${pick(LABELS)}`;
    case 16: return `${pick(['JMP', 'CALL'])} ${pick(LABELS)}`;
    case 17: return pick(['MOVC A,@A+DPTR', 'MOVC A,@A+PC', 'MOVX A,@DPTR', 'MOVX @DPTR,A', `MOVX A,${I}`, `MOVX ${I},A`, 'JMP @A+DPTR']);
    case 18: return `${pick(['PUSH', 'POP'])} ${D}`;
    case 19: return `${pick(['XCH', 'XCHD'])} A,${pick([R, I, D])}`;
    case 20: return `DB ${pick(['1,2,3', "'Hi',0", 'K1,K1+1', 'TAB-L1', '"a""b"', '0FFH,-1', 'LOW(TAB),HIGH(TAB)'])}`;
    case 21: return `DW ${pick(['TAB', 'L1,L2', '1234H', "'AB'", 'K1*K1'])}`;
    case 22: if (CLEAN) return 'NOP'; return pick(['MOV A,R8', 'MOV R0,R1', 'ADD R0,A', 'MOV A,@R2', 'SJMP', 'MOV A,#', 'PUSH A', 'CLR ACC',
      'SETB 30H.0', 'MOV A,L1', 'LJMP CNT', 'MOV C,#1', 'DB 1,', 'MOV A,UNDEF', 'JB FLAG.1,$', 'X Y Z']);
    default: return `MOV A,${pick([R, D, M])}`;
  }
}
const outDir = path.join(__dirname, '..', 'ref', OUT);
fs.mkdirSync(outDir, { recursive: true });
for (let k = 0; k < n; k++) {
  const L = [];
  L.push('K1 EQU ' + pick(['5', '10H', '3*4', 'K2+1']), 'K2 EQU 7', 'CNT DATA 40H', 'FLAG BIT 21H.3');
  if (rnd(4) === 0) L.push(' USING ' + rnd(4));
  L.push(' ORG ' + pick(['0', '0', '30H', '100H', '7E0H']));
  const used = new Set();
  const m = 10 + rnd(50);
  for (let i = 0; i < m; i++) {
    let lab = '';
    if (rnd(5) === 0) { const c = pick(LABELS); if (!used.has(c)) { used.add(c); lab = c + ':'; } }
    L.push(lab + (lab && rnd(2) ? ' ' : '\t') + insn() + (rnd(4) === 0 ? '   ; comment, with ;' : ''));
  }
  for (const c of LABELS) if (!used.has(c)) {
    if (c === 'FAR1' && rnd(2)) L.push(' ORG ' + pick(['900H', '800H', '7F0H']));
    L.push(c + ': ' + (c === 'TAB' ? 'DB 1,2,3' : 'NOP'));
  }
  L.push(' END');
  fs.writeFileSync(path.join(outDir, 'r' + String(k).padStart(3, '0') + '.a51'), L.join('\r\n') + '\r\n');
}
console.log(n + ' programs in ref/' + OUT);
