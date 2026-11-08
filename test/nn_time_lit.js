// Time of one reading against the number of lit squares (0 to 35, the first n squares lit), for the assembly
// program, its ablation variants and the C builds, on the simulated board. Writes ref/nn/results/time_lit.json.
//   node test/nn_time_lit.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const MS = Board.CYCLES_PER_S / 1000;
const BUILDS = [
  ['assembly', 'ref/nn/digit_nn.a51'],
  ['asm, no binary inputs', 'ref/nn/ablation/no_binary.a51'],
  ['asm, no row pointer', 'ref/nn/ablation/no_rowptr.a51'],
  ['asm, no MUL AB', 'ref/nn/ablation/no_mulab.a51'],
  ['asm, 32-bit sums', 'ref/nn/ablation/sum32.a51'],
  ['asm, no shortcuts', 'ref/nn/ablation/no_shortcuts.a51'],
  ['asm, binary only (b)', 'ref/nn/ablation/factorial/b.a51'],
  ['asm, 32-bit sums (brm)', 'ref/nn/ablation/factorial/brm.a51'],
  ['C as written', 'ref/nn/c/digit_nn_c.hex'],
  ['C, 32-bit multiply', 'ref/nn/c/digit_nn_c_long.hex'],
  ['C, optimized for size', 'ref/nn/c/digit_nn_c_size.hex'],
  ['C tuned for the 8051', 'ref/nn/c/digit_nn_c_tuned.hex'],
  ['SDCC as written', 'ref/nn/c/sdcc/digit_nn.hex'],
  ['SDCC tuned for the 8051', 'ref/nn/c/sdcc_tuned/digit_nn.hex'],
];
const LIT = [0, 5, 10, 15, 20, 25, 30, 35];
const series = [];
for (const [name, file] of BUILDS) {
  const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
  const img = file.endsWith('.hex') ? A.readHex(text) : A.assemble(text);
  const b = new Board(E); b.load(img.image); b.reset();
  const st = T.attach(b);
  b.run(Math.round(20 * MS));
  const ms = [];
  for (const n of LIT) {
    ms.push(+T.reading(b, st, 'D' + '1'.repeat(n) + '0'.repeat(35 - n)).ms.toFixed(2));   // see test/nn_timing.js
  }
  series.push({ name, file, bytes: img.size, ms });
  console.log(name.padEnd(24), ms.join('  '));
}
const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
fs.writeFileSync(path.join(d, 'time_lit.json'), JSON.stringify({ made: new Date().toISOString(), by: 'test/nn_time_lit.js', lit: LIT, series }, null, 1));
