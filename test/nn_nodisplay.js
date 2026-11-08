// The time of one reading without the display interrupt, for the comparison with the AVR (tools/avr_run.py), whose
// readings have no display: each build's interrupt is measured (from the 2-cycle call to the end of RETI), and the
// reading time of test/nn_timing.js is scaled by (256 - that cost) / 256, since Timer 0 interrupts every 256 cycles.
// Writes ref/nn/results/nodisplay.json.
//   node test/nn_nodisplay.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');

const ROOT = path.join(__dirname, '..');
const J = f => JSON.parse(fs.readFileSync(path.join(ROOT, f), 'utf8'));
const V57 = J('nn/test_vectors.json');
const VMNIST = fs.existsSync(path.join(ROOT, 'nn/mnist_vectors.json')) ? J('nn/mnist_vectors.json') : [];
const BUILDS = [
  ['5x7, assembly', 'ref/nn/digit_nn.a51', V57],
  ['5x7, C as written, Keil C51', 'ref/nn/c/digit_nn_c.hex', V57],
  ['5x7, C as written, SDCC', 'ref/nn/c/sdcc/digit_nn.hex', V57],
  ['MNIST, assembly', 'ref/nn/mnist/digit_mnist.a51', VMNIST],
  ['MNIST, C as written, SDCC', 'ref/nn/c/mnist/sdcc/digit_mnist.hex', VMNIST],
];

function load(file) {
  const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
  const r = file.endsWith('.hex') ? A.readHex(text) : A.assemble(text);
  const b = new Board(E); b.load(r.image); b.reset();
  return { b, image: r.image, bytes: r.size };
}

function isrCost(file) {                          // cycles of each display interrupt over 200 000 idle cycles
  const { b, image } = load(file);
  b.run(T.ms(20));
  const costs = [];
  let start = -1;
  for (const c0 = b.cpu.cycles; b.cpu.cycles - c0 < 200000;) {
    const pc = b.cpu.pc;
    b.step();
    if (start < 0 && b.cpu.pc === 0x000B) start = b.cpu.cycles - 2;
    else if (start >= 0 && image[pc] === 0x32) { costs.push(b.cpu.cycles - start); start = -1; }   // RETI
  }
  if (Math.min(...costs) !== Math.max(...costs)) throw new Error(file + ': the interrupt cost varies');
  return costs[0];
}

const out = { made: new Date().toISOString(), by: 'test/nn_nodisplay.js', cycles_per_ms: T.MS, rows: [] };
for (const [name, file, vecs] of BUILDS) {
  const isr = isrCost(file);
  const { b, bytes } = load(file);
  const st = T.attach(b);
  b.run(T.ms(20));
  let sum = 0;
  for (const v of vecs) sum += T.reading(b, st, 'D' + v.pixels).cycles;
  const avg = sum / vecs.length, nodisp = avg * (256 - isr) / 256;
  const row = { name, file, inputs: vecs.length, bytes, isr_cycles: isr, avg_cycles: Math.round(avg),
    avg_cycles_without_display: Math.round(nodisp), ms_without_display: +(nodisp / T.MS).toFixed(2) };
  out.rows.push(row);
  console.log(JSON.stringify(row));
}
fs.writeFileSync(path.join(ROOT, 'ref/nn/results/nodisplay.json'), JSON.stringify(out, null, 1));
