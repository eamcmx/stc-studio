// Ablation of the digit reader on the simulated board: each variant in ref/nn/ablation (made by nn/ablation.py)
// must still give the Python reference's answer for every test drawing; then its size and time are printed.
// Then the same for all 16 combinations of the four switches, into ref/nn/results/ablation_factorial.json.
//   python nn/ablation.py && node test/nn_ablation.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const MS = Board.CYCLES_PER_S / 1000;
const DIR = path.join(ROOT, 'ref/nn/ablation');
const ORDER = ['all_shortcuts', 'no_binary', 'no_rowptr', 'no_mulab', 'sum32', 'no_shortcuts'];
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/test_vectors.json'), 'utf8'));
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

const reading = (b, st, pixels) => T.reading(b, st, 'D' + pixels);   // see test/nn_timing.js

let bad = 0;
const rows = [];
let base = null;
for (const name of ORDER) {
  const r = A.assemble(fs.readFileSync(path.join(DIR, name + '.a51'), 'utf8'));
  if (!r.ok) { console.log(name, 'does not assemble', r.messages.slice(0, 3)); bad++; continue; }
  const b = new Board(E); b.load(r.image); b.reset();
  const st = T.attach(b);
  b.run(Math.round(20 * MS));
  let sum = 0, wrong = 0;
  for (const t of vecs) {
    const x = reading(b, st, t.pixels);
    const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(x.line);
    if (!m || +m[1] !== t.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(t.scores)) wrong++;
    sum += x.ms;
  }
  bad += wrong;
  const empty = reading(b, st, '0'.repeat(35)).ms, full = reading(b, st, '1'.repeat(35)).ms;
  const avg = sum / vecs.length;
  if (!base) base = avg;
  rows.push([name, r.size, avg.toFixed(1), (avg / base).toFixed(2), empty.toFixed(1), ((full - empty) / 35).toFixed(2), full.toFixed(1), wrong]);
}
console.log('| Variant | Bytes | Average reading | Relative | Empty grid | Per lit square | Full grid | Answers unlike Python |');
console.log('|---|---|---|---|---|---|---|---|');
for (const r of rows) console.log('| ' + r[0] + ' | ' + r[1] + ' | ' + r[2] + ' ms | ' + r[3] + ' | ' + r[4] + ' ms | ' + r[5] + ' ms | ' + r[6] + ' ms | ' + r[7] + ' |');
const save = (name, data) => { const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
  fs.writeFileSync(path.join(d, name + '.json'), JSON.stringify(Object.assign({ made: new Date().toISOString(), by: 'test/' + path.basename(__filename) }, data), null, 1)); };
save('ablation', { drawings: vecs.length, answers_unlike_python: bad, columns: ['variant', 'bytes', 'avg_ms', 'relative', 'empty_ms', 'per_lit_ms', 'full_ms', 'answers_unlike_python'], rows });

// all 16 combinations (ref/nn/ablation/factorial): b = binary inputs, r = row pointer, m = MUL AB with the sign
// split, s = 24-bit sums; the name lists the switches that are on
const FDIR = path.join(DIR, 'factorial');
const frows = [];
for (const f of fs.readdirSync(FDIR).filter(f => f.endsWith('.a51')).sort()) {
  const name = f.replace('.a51', '');
  const r = A.assemble(fs.readFileSync(path.join(FDIR, f), 'utf8'));
  if (!r.ok) { console.log(name, 'does not assemble', r.messages.slice(0, 3)); bad++; continue; }
  const b = new Board(E); b.load(r.image); b.reset();
  const st = T.attach(b);
  b.run(Math.round(20 * MS));
  let sum = 0, wrong = 0;
  for (const t of vecs) {
    const x = reading(b, st, t.pixels);
    const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(x.line);
    if (!m || +m[1] !== t.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(t.scores)) wrong++;
    sum += x.cycles;
  }
  bad += wrong;
  const empty = reading(b, st, '0'.repeat(35)).cycles, full = reading(b, st, '1'.repeat(35)).cycles;
  frows.push([name, r.size, Math.round(sum / vecs.length), +(sum / vecs.length / MS).toFixed(2), empty, full, wrong]);
}
frows.sort((p, q) => q[2] - p[2]);
console.log('| Switches on | Bytes | Average cycles | Average ms | Empty grid (cycles) | Full grid (cycles) | Answers unlike Python |');
console.log('|---|---|---|---|---|---|---|');
for (const r of frows) console.log('| ' + r.join(' | ') + ' |');
save('ablation_factorial', { drawings: vecs.length, cycles_per_ms: MS,
  switches: { b: 'binary inputs', r: 'row pointer', m: 'MUL AB with the sign split', s: '24-bit sums' },
  columns: ['switches_on', 'bytes', 'avg_cycles', 'avg_ms', 'empty_cycles', 'full_cycles', 'answers_unlike_python'], rows: frows });
console.log(bad ? bad + ' answers differ from Python' : 'every variant gives the Python answer for all ' + vecs.length + ' drawings');
process.exit(bad ? 1 : 0);
