// The round trip of every board build in the simulator, for comparison with test/board_run.js on the chip: from the
// moment the first character of 'D' + inputs starts to arrive at the simulated serial port (19 200 baud, the host
// sending without pauses) to the moment the last character of the answer line (\n) has left it. Writes
// ref/nn/results/roundtrip_sim.json with the median of each build over the same inputs as the board run.
//   node test/nn_roundtrip.js [build names separated by |]
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
const VMNIST = fs.existsSync(path.join(ROOT, 'nn/mnist_vectors.json')) ? J('nn/mnist_vectors.json') : [];
const BUILDS = [                                   // the names and files of test/board_run.js
  ['asm 5x7', 'ref/nn/digit_nn.a51', V57],
  ['C as written', 'ref/nn/c/digit_nn_c.hex', V57],
  ['C, 32-bit multiply', 'ref/nn/c/digit_nn_c_long.hex', V57],
  ['C, optimized for size', 'ref/nn/c/digit_nn_c_size.hex', V57],
  ['C tuned', 'ref/nn/c/digit_nn_c_tuned.hex', V57],
  ['UCI binary', 'ref/nn/uci/digit_uci_bin.a51', VBIN],
  ['UCI 16 grey levels', 'ref/nn/uci/digit_uci_gray.a51', VGRAY],
  ['SDCC as written', 'ref/nn/c/sdcc/digit_nn.hex', V57],
  ['SDCC, 32-bit multiply', 'ref/nn/c/sdcc_long/digit_nn.hex', V57],
  ['SDCC tuned', 'ref/nn/c/sdcc_tuned/digit_nn.hex', V57],
  ['MNIST 14x14', 'ref/nn/mnist/digit_mnist.a51', VMNIST],
  ['MNIST SDCC as written', 'ref/nn/c/mnist/sdcc/digit_mnist.hex', VMNIST],
  ['MNIST SDCC tuned', 'ref/nn/c/mnist/sdcc_tuned/digit_mnist.hex', VMNIST],
].filter(b => !process.argv[2] || process.argv[2].split('|').includes(b[0]));
const median = a => { const s = a.slice().sort((x, y) => x - y), k = s.length >> 1; return s.length % 2 ? s[k] : (s[k - 1] + s[k]) / 2; };

const out = { made: new Date().toISOString(), by: 'test/nn_roundtrip.js', baud: 19200, cycles_per_ms: T.MS, builds: [] };
for (const [name, file, vecs] of BUILDS) {
  const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
  const r = file.endsWith('.hex') ? A.readHex(text) : A.assemble(text);
  const b = new Board(E); b.load(r.image); b.reset();
  let done = -1;
  b.onSerial = ch => { if (ch === 10) done = b.cpu.cycles; };
  b.run(T.ms(20));
  const times = [];
  for (const v of vecs) {
    done = -1;
    const s0 = b.cpu.cycles;
    b.serialIn(Array.from('D' + v.pixels, ch => ch.charCodeAt(0)));
    for (let guard = 0; done < 0; guard++) {
      if (guard > 20000) throw new Error(name + ': no answer');
      b.run(Math.round(0.05 * T.MS));
    }
    times.push((done - s0) / T.MS);
    b.run(T.ms(5));
  }
  const row = { name, file, inputs: vecs.length, median_round_trip_ms: +median(times).toFixed(1) };
  out.builds.push(row);
  console.log(JSON.stringify(row));
}
if (!process.argv[2]) fs.writeFileSync(path.join(ROOT, 'ref/nn/results/roundtrip_sim.json'), JSON.stringify(out, null, 1));
