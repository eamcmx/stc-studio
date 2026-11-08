// The MNIST program (nn/train_mnist.py, written by nn/gen51.py) on the simulated board: it must fit the chip's 8 KB of
// flash and answer every one of the 10 000 test digits exactly like the Python reference (digit and ten scores); then
// accuracy, the time of one reading (test/nn_timing.js) and the size are written to ref/nn/results/mnist_sim.json.
//   python nn/train_mnist.py && node test/nn_mnist.js [how many test digits, default all]
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

const r = A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/mnist/digit_mnist.a51'), 'utf8'));
if (!r.ok) { console.log('does not assemble', r.messages.slice(0, 3)); process.exit(1); }
if (r.top > 8192) { console.log('too big for the 8 KB of flash: ends at ' + r.top.toString(16)); process.exit(1); }
const n = +process.argv[2] || Infinity;
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/mnist_vectors.json'), 'utf8')).slice(0, n);
const b = new Board(E); b.load(r.image); b.reset();
const st = T.attach(b);
b.run(T.ms(20));
if (st.out !== 'NN READY\r\n') { console.log('greeting', JSON.stringify(st.out)); process.exit(1); }
let wrong = 0, right = 0, sum = 0, lo = Infinity, hi = 0, displayBad = 0, litSum = 0;
const sp = r.symbols.SCORE.value + 30;
vecs.forEach((v, i) => {
  const x = T.reading(b, st, 'D' + v.pixels);
  const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(x.line);
  if (!m || +m[1] !== v.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(v.scores)) {
    wrong++; if (wrong < 4) console.log('differs at', i, x.line.slice(0, 60));
  }
  if (m && +m[1] === v.label) right++;
  sum += x.cycles; lo = Math.min(lo, x.cycles); hi = Math.max(hi, x.cycles);
  litSum += v.pixels.split('1').length - 1;
  if (i % 1000 === 0) { b.frame(); b.run(T.ms(30)); if (Board.text(b.frame()) !== 'nn ' + v.digit) displayBad++; }   // as in test/nn_uci.js
  if (i % 1000 === 999) console.log('  ' + (i + 1) + ' of ' + vecs.length + ', ' + (i + 1 - wrong) + ' equal');
});
const res = { made: new Date().toISOString(), by: 'test/nn_mnist.js', bytes: r.size, flash_end: r.top, ram_scores_end: '0x' + sp.toString(16),
  digits: vecs.length, answers_unlike_python: wrong, display_faults: displayBad, read_correctly: right,
  accuracy_pct: +(100 * right / vecs.length).toFixed(2), avg_cycles: Math.round(sum / vecs.length), avg_ms: +(sum / vecs.length / T.MS).toFixed(2),
  min_ms: +(lo / T.MS).toFixed(2), max_ms: +(hi / T.MS).toFixed(2), avg_lit: +(litSum / vecs.length).toFixed(2), cycles_per_ms: T.MS };
console.log(JSON.stringify(res, null, 1));
fs.writeFileSync(path.join(ROOT, 'ref/nn/results/mnist_sim.json'), JSON.stringify(res, null, 1));
process.exit(wrong || displayBad ? 1 : 0);
