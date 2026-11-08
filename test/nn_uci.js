// The digit reader on the UCI handwritten digits (8 x 8), on the simulated board: both programs made by
// nn/train_uci.py must answer every one of the 1797 test digits exactly like the Python reference (digit and ten
// scores, and the display); then accuracy against the true labels, time and size are printed.
//   python nn/train_uci.py && node test/nn_uci.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const MS = Board.CYCLES_PER_S / 1000;
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

let bad = 0;
const rows = [];
for (const kind of ['bin', 'gray']) {
  const r = A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/uci/digit_uci_' + kind + '.a51'), 'utf8'));
  if (!r.ok) { console.log(kind, 'does not assemble', r.messages.slice(0, 3)); process.exit(1); }
  const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/uci_vectors_' + kind + '.json'), 'utf8'));
  const b = new Board(E); b.load(r.image); b.reset();
  const st = T.attach(b);
  b.run(Math.round(20 * MS));
  if (st.out !== 'NN READY\r\n') { console.log(kind, 'greeting', JSON.stringify(st.out)); bad++; }
  let wrong = 0, right = 0, sum = 0, max = 0, displayBad = 0;
  vecs.forEach((v, n) => {
    const x = T.reading(b, st, 'D' + v.pixels), out = x.raw;   // see test/nn_timing.js
    const m = /^=(\d)((?: [0-9A-F]{6}){10})\r\n$/.exec(out);
    if (!m || +m[1] !== v.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(v.scores)) {
      wrong++; if (wrong < 4) console.log(kind, 'differs at', n, JSON.stringify(out).slice(0, 80));
    }
    if (m && +m[1] === v.label) right++;
    const t = x.ms; sum += t; max = Math.max(max, t);
    if (n % 200 === 0) {                    // look at the display now and then
      b.frame(); b.run(Math.round(30 * MS));
      if (Board.text(b.frame()) !== 'nn ' + v.digit) displayBad++;
    } else b.run(Math.round(2 * MS));
  });
  bad += wrong + displayBad;
  rows.push([kind, r.size, vecs.length, (100 * right / vecs.length).toFixed(2), wrong, (sum / vecs.length).toFixed(1), max.toFixed(1), displayBad]);
}
console.log('| Input coding | Bytes | Test digits | Read correctly (board) | Answers unlike Python | Average reading | Longest | Display faults |');
console.log('|---|---|---|---|---|---|---|---|');
for (const r of rows) console.log('| ' + r[0] + ' | ' + r[1] + ' | ' + r[2] + ' | ' + r[3] + ' % | ' + r[4] + ' | ' + r[5] + ' ms | ' + r[6] + ' ms | ' + r[7] + ' |');
const save = (name, data) => { const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
  fs.writeFileSync(path.join(d, name + '.json'), JSON.stringify(Object.assign({ made: new Date().toISOString(), by: 'test/' + path.basename(__filename) }, data), null, 1)); };
save('uci', { problems: bad, columns: ['coding', 'bytes', 'test_digits', 'accuracy_pct', 'answers_unlike_python', 'avg_ms', 'max_ms', 'display_faults'], rows });
console.log(bad ? bad + ' problems' : 'both programs answer every test digit exactly like the Python reference');
process.exit(bad ? 1 : 0);
