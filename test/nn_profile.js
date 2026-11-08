// Cycle profile of one reading of the digit reader, on the simulated board, and annotated listings for the paper.
//   node test/nn_profile.js
// 1. Every instruction's cost in machine cycles, measured: the program runs one instruction at a time and the cost of
//    each address is recorded (8051 instruction times do not depend on the data; an interrupt entry adds its own 2
//    cycles, so the smallest cost seen at an address is the instruction's).
// 2. The budget of one reading by stage (the stages are the program's own labels), from the moment the last square
//    has been stored to the first character of the answer, for an empty grid, the test 7, a full grid and the average
//    of the 346 test drawings. Cycles spent in the display interrupt are counted apart.
// 3. ref/nn/results/listings/*.txt: the code of each stage with its cycles, for the paper (without comments).
// The same for the C build (ref/nn/c/digit_nn_c.hex): per-address costs, used to annotate the compiler's listing.
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const ROOT = path.join(__dirname, '..');
const OUT = path.join(ROOT, 'ref/nn/results');
const MS = Board.CYCLES_PER_S / 1000;
const SRC = fs.readFileSync(path.join(ROOT, 'ref/nn/digit_nn.a51'), 'utf8');
const r = A.assemble(SRC);
const sym = n => r.symbols[n].value;
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/test_vectors.json'), 'utf8'));

// stages by code address: each label starts a stage, which runs to the next label in this list
const STAGES = [['RDPIX', 'receive'], ['L1B', 'layer 1: biases'], ['L1P', 'layer 1: weights'], ['RL1', 'ReLU and shift'],
  ['L2K', 'layer 2'], ['AMAX', 'largest score'], ['SEND', 'answer'], ['GETC', 'serial'], ['T0ISR', 'display interrupt'], ['DSEL', 'tables']];
const bounds = STAGES.map(([l, name]) => [sym(l), name]).sort((a, b) => a[0] - b[0]);
// the instructions before L1B that set up layer 1 (after the last square) belong to it
const stageOf = pc => { let s = 'display interrupt'; for (const [a, name] of bounds) if (pc >= a) s = name; return s; };   // below RDPIX: the interrupt vector

const l1p = sym('L1P');
function profile(image, isrRange, startPc, stopPc, drawings) {
  const b = new Board(E); b.load(image); b.reset();
  const cost = new Map();
  let out = '';
  b.onSerial = c => { out += String.fromCharCode(c); };
  b.run(Math.round(20 * MS));
  const runs = [];
  for (const px of drawings) {
    out = '';
    b.serialIn(Array.from('D' + px, c => c.charCodeAt(0)));
    let on = false, total = 0;
    const by = {};
    for (let guard = 0; guard < 2e6; guard++) {
      const pc = b.cpu.pc;
      if (!on && pc === startPc) on = true;
      if (on && pc === stopPc) break;
      const c0 = b.cpu.cycles;
      b.step();
      let c = b.cpu.cycles - c0, irq = 0;
      if (b.cpu.pc === 0x000B) { irq = 2; c -= 2; }        // the interrupt was taken after this instruction: its call
      if (!cost.has(pc) || c < cost.get(pc)) cost.set(pc, c);
      if (on) {
        const st = pc >= isrRange[0] && pc < isrRange[1] ? 'display interrupt' : (pc >= startPc && pc < l1p ? 'layer 1: biases' : stageOf(pc));
        by[st] = (by[st] || 0) + c; total += c + irq;
        if (irq) by['display interrupt'] = (by['display interrupt'] || 0) + irq;
      }
    }
    while (!out.endsWith('\n')) b.run(Math.round(1 * MS));
    b.run(Math.round(5 * MS));
    runs.push({ total, by });
  }
  return { cost, runs };
}

// the asm program: from the first instruction after the pixel loop to the first call of PUTC
const afterPixels = r.lines.find(l => l.addr > sym('NEXTPX') && l.bytes.length && SRC.split('\n')[l.line - 1].includes('MOV     DPTR,#B1')).addr;
const firstPutc = sym('PUTC');
const isr = [sym('T0ISR'), sym('DSEL')];
const seven = '11111000110001100110001000110001000';
const sets = { 'empty grid': ['0'.repeat(35)], 'the test 7': [seven], 'full grid': ['1'.repeat(35)], '346 drawings (average)': vecs.map(v => v.pixels) };
const result = { cycles_per_ms: MS, stages: STAGES.map(s => s[1]), cases: {} };
let costAsm = null;
for (const [name, list] of Object.entries(sets)) {
  const p = profile(r.image, isr, afterPixels, firstPutc, list);
  costAsm = costAsm || p.cost;
  for (const [k, v] of p.cost) if (!costAsm.has(k) || v < costAsm.get(k)) costAsm.set(k, v);
  const n = p.runs.length, by = {};
  for (const run of p.runs) for (const [k, v] of Object.entries(run.by)) by[k] = (by[k] || 0) + v / n;
  const total = p.runs.reduce((s, x) => s + x.total, 0) / n;
  result.cases[name] = { total_cycles: Math.round(total), total_ms: +(total / MS).toFixed(2),
    by_stage: Object.fromEntries(Object.entries(by).map(([k, v]) => [k, Math.round(v)])) };
  console.log(name.padEnd(24), Math.round(total), 'cycles', (total / MS).toFixed(2), 'ms |',
    Object.entries(by).map(([k, v]) => k + ' ' + Math.round(v)).join(', '));
}

// annotated listings of the stages: code, cycles, and a short comment at each label (the source's own comments are
// too long for a column of the paper)
const NOTE = {
  L1B: 'copy the 48 bias bytes', L1P: 'input i: lit?', L1J: 'add weight j to sum j', L1NEG: 'negative: high byte FFH',
  L1HI: 'high byte, with the carry', L1NEXT: 'DPTR to the next row', L1N2: 'next input',
  RL1: '16-bit sum j; negative?', RSH: 'shift right S times', RSAT: 'cap at 255', RLOW: 'low byte',
  RZERO: 'negative: 0', RSTORE: 'store hidden value j',
  L2K: 'digit k: its 24-bit bias', L2J: 'weight j: sign split', L2NEG: 'negative: size, subtract', L2NEXT: 'next weight',
  L2N2: 'next digit',
  AMAX: 'score k > best? (signed)', AMNEXT: 'next score',
  T0ISR: 'save PSW, A, DPTR',
};
function listing(fromMarker, toMarker) {
  const lines = SRC.split('\n');
  const a = lines.findIndex(l => l.startsWith(fromMarker));
  let b = lines.findIndex((l, i) => i > a && l.startsWith(toMarker));
  if (b < 0) b = lines.length;
  const byLine = new Map(r.lines.filter(x => x.bytes.length).map(x => [x.line, x]));
  const out = [];
  for (let i = a + 1; i < b; i++) {
    const raw = lines[i];
    if (!raw.trim() || /^\s*;/.test(raw)) continue;
    const code = raw.split(';')[0].replace(/\s+$/, '');
    const cm = raw.includes(';') ? raw.slice(raw.indexOf(';') + 1).trim() : '';
    const L = byLine.get(i + 1);
    const cyc = L && costAsm.has(L.addr) ? String(costAsm.get(L.addr)) : (L ? '-' : '');
    const m = /^(\S*:)?\s*(\S+)?\s*(.*)$/.exec(code);
    const label = (m[1] || '').padEnd(8), op = (m[2] || '').padEnd(5), args = (m[3] || '').padEnd(15);
    const note = m[1] ? NOTE[m[1].slice(0, -1)] : '';   // a short comment where a block starts (its label)
    out.push(((label + op + args).padEnd(28) + cyc.padStart(2) + (note ? '  ; ' + note : '')).replace(/\s+$/, ''));
  }
  return out.join('\n');
}
const L = {
  layer1: listing('; ---- layer 1:', '; ---- ReLU'),
  relu: listing('; ---- ReLU', '; ---- layer 2'),
  layer2: listing('; ---- layer 2', '; ---- the largest score'),
  argmax: listing('; ---- the largest score', '; ---- show it'),
  isr: listing('; ---- Timer 0', 'DSEL:'),
};
fs.mkdirSync(path.join(OUT, 'listings'), { recursive: true });
for (const [k, v] of Object.entries(L)) fs.writeFileSync(path.join(OUT, 'listings', k + '.txt'), v + '\n');

// the C build: per-address costs, to annotate the compiler's listing of the layer-1 loop
const C = A.readHex(fs.readFileSync(path.join(ROOT, 'ref/nn/c/digit_nn_c.hex'), 'utf8'));
{
  const b = new Board(E); b.load(C.image); b.reset();
  let out = ''; b.onSerial = ch => { out += String.fromCharCode(ch); };
  b.run(Math.round(20 * MS));
  const cost = {};
  out = ''; b.serialIn(Array.from('D' + seven, ch => ch.charCodeAt(0)));
  for (let g = 0; g < 3e6 && !out.endsWith('\n'); g++) {
    const pc = b.cpu.pc, c0 = b.cpu.cycles; b.step(); const c = b.cpu.cycles - c0;
    if (!(pc in cost) || c < cost[pc]) cost[pc] = c;
  }
  result.c_cost_by_address = cost;
}
{
  // ?PR?MAIN?T starts at 0CBAH in the map (T.M51); the listing shows offsets in the module
  const lst = fs.readFileSync(path.join(ROOT, 'ref/nn/c/digit_nn_c.lst'), 'latin1').split(/\r?\n/);
  const a = lst.findIndex(l => /SOURCE LINE # 78$/.test(l)), b = lst.findIndex((l, i) => i > a && /SOURCE LINE # (\d+)$/.test(l) && +/SOURCE LINE # (\d+)$/.exec(l)[1] > 80);
  const outL = [];
  for (const l of lst.slice(a, b)) {
    const m = /^([0-9A-F]{4}) ([0-9A-F]+)\s+(?:R\s+)?(\S+)\s*(.*)$/.exec(l);
    const lab = /^([0-9A-F]{4})\s+(\?C\d+):/.exec(l);
    if (lab) { outL.push(lab[2] + ':'); continue; }
    if (!m) continue;
    const addr = 0x0CBA + parseInt(m[1], 16), cyc = result.c_cost_by_address[addr];
    outL.push(('       ' + m[3].padEnd(5) + m[4].trim().replace(/\s+/g, ' ').padEnd(16)).padEnd(28) + String(cyc === undefined ? '-' : cyc).padStart(2));
  }
  fs.writeFileSync(path.join(OUT, 'listings', 'c51_layer1.txt'), outL.join('\n') + '\n');
}
fs.writeFileSync(path.join(OUT, 'profile.json'), JSON.stringify(Object.assign({ made: new Date().toISOString(), by: 'test/nn_profile.js' }, result), null, 1));
console.log('listings and profile written to ref/nn/results');
