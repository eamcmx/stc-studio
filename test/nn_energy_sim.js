// The display-off builds of nn/energy_build.py on the simulated board (11 Nov 2026): every answer must equal Python's,
// the display interrupt must never run, and the average reading time (test/nn_timing.js: last input character read
// to first answer character written) is the t of E = V x I x t for that build. Writes ref/nn/results/energy_sim.json.
//   python nn/energy_build.py && node test/nn_energy_sim.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');

const ROOT = path.join(__dirname, '..');
const J = f => JSON.parse(fs.readFileSync(path.join(ROOT, f), 'utf8'));
const V57 = J('nn/test_vectors.json'), VBIN = J('nn/uci_vectors_bin.json'), VGRAY = J('nn/uci_vectors_gray.json');
const VMNIST = J('nn/mnist_vectors.json');
const BUILDS = [
  ['5x7, assembly', 'ref/nn/energy/digit_nn_marker_dark.a51', V57],
  ['5x7, C as written, SDCC', 'ref/nn/energy/c/sdcc/build/digit_nn.hex', V57],
  ['UCI binary, assembly', 'ref/nn/energy/digit_uci_bin_dark.a51', VBIN],
  ['UCI 16 grey levels, assembly', 'ref/nn/energy/digit_uci_gray_dark.a51', VGRAY],
  ['MNIST, assembly', 'ref/nn/energy/digit_mnist_dark.a51', VMNIST],
  ['MNIST, C as written, SDCC', 'ref/nn/energy/c/mnist/sdcc/build/digit_mnist.hex', VMNIST],
  ['MNIST, C tuned, SDCC', 'ref/nn/energy/c/mnist/sdcc_tuned/build/digit_mnist.hex', VMNIST],
].filter(b => !process.argv[2] || process.argv[2].split('|').includes(b[0]));
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

const out = { made: new Date().toISOString(), by: 'test/nn_energy_sim.js', cycles_per_ms: T.MS, rows: [] };
for (const [name, file, vecs] of BUILDS) {
  const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
  const r = file.endsWith('.hex') ? A.readHex(text) : A.assemble(text);
  if (file.endsWith('.a51') && !r.ok) throw new Error(file + ' does not assemble');
  const b = new Board(E); b.load(r.image); b.reset();
  let isr = 0;
  const step = b.step.bind(b);
  b.step = () => { const n = step(); if (b.cpu.pc === 0x000B) isr++; return n; };
  const st = T.attach(b);
  b.run(T.ms(20));
  let sum = 0, bad = 0;
  for (const v of vecs) {
    const res = T.reading(b, st, 'D' + v.pixels);
    sum += res.cycles;
    const m = /^=(\d)((?: [0-9A-F]{6}){10})\r\n$/.exec(res.raw);
    if (!m || +m[1] !== v.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(v.scores)) bad++;
  }
  const row = { name, file, inputs: vecs.length, answers_unlike_python: bad, display_interrupts: isr, bytes: r.size,
    avg_cycles: Math.round(sum / vecs.length), avg_ms: +(sum / vecs.length / T.MS).toFixed(4) };
  out.rows.push(row);
  console.log(JSON.stringify(row));
}
fs.writeFileSync(path.join(ROOT, 'ref/nn/results/energy_sim' + (process.argv[2] ? '_part' : '') + '.json'), JSON.stringify(out, null, 1));
