// The digit reader (ref/nn/digit_nn.a51) on the simulated board, against the Python reference.
//   python nn/train_digits.py   (writes the weights and nn/test_vectors.json)
//   node test/nn_test.js [file.hex]   (a build of the C version, say; default: assemble ref/nn/digit_nn.a51)
// Every test vector goes in over the serial port as D + 35 characters; the board's answer (digit and 10 scores)
// must be the same as int_forward() in nn/train_digits.py, number for number, and the display must show the digit.
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const ROOT = path.join(__dirname, '..');

const hexArg = process.argv[2];
const r = hexArg ? A.readHex(fs.readFileSync(hexArg, 'utf8')) :
  A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/digit_nn.a51'), 'utf8'), { name: 'digit_nn.a51' });
if (!hexArg && !r.ok) { console.log('assembly failed', r.messages); process.exit(1); }
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/test_vectors.json'), 'utf8'));

const b = new Board(E);
b.load(r.image); b.reset();
let out = '', firstOut = -1;
b.onSerial = c => { if (firstOut < 0) firstOut = b.cpu.cycles; out += String.fromCharCode(c); };
const MS = Board.CYCLES_PER_S / 1000;

b.run(Math.round(20 * MS));
let fails = 0;
const ok = (c, what) => { if (!c) { fails++; if (fails < 10) console.log('FAIL  ' + what); } };
ok(out === 'NN READY\r\n', 'greeting: ' + JSON.stringify(out));

let worst = 0, n = 0, total = 0, fastest = 1e9;
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };
for (const v of vecs) {
  out = ''; firstOut = -1;
  b.serialIn(Array.from('D' + v.pixels, ch => ch.charCodeAt(0)));
  // run until the last pixel is in, note the time, then until the answer line is complete
  let inAt = -1;
  for (let k = 0; k < 2000 && !out.endsWith('\n'); k++) {
    b.run(Math.round(0.1 * MS));
    if (inAt < 0 && b.cpu.rxQueue.length === 0 && !b.cpu.rxLeft && !(b.cpu.scon & 1)) inAt = b.cpu.cycles;
  }
  const m = out.match(/^=(\d)((?: [0-9A-F]{6}){10})\r\n$/);
  ok(m, 'answer format for ' + v.pixels + ': ' + JSON.stringify(out));
  if (!m) continue;
  const scores = m[2].trim().split(' ').map(s24);
  ok(+m[1] === v.digit, v.pixels + ' digit ' + m[1] + ', Python says ' + v.digit);
  ok(JSON.stringify(scores) === JSON.stringify(v.scores), v.pixels + ' scores ' + scores + ' vs ' + v.scores);
  const t = (firstOut - inAt) / MS;
  worst = Math.max(worst, t); fastest = Math.min(fastest, t); total += t;
  b.frame();                                   // forget the brightness so far, then look at the display for 30 ms
  b.run(Math.round(30 * MS));
  const shown = Board.text(b.frame());
  ok(shown === 'nn ' + v.digit, 'display ' + JSON.stringify(shown) + ' for digit ' + v.digit);
  n++;
}
console.log(n + ' of ' + vecs.length + ' vectors answered; ' + (fails ? fails + ' FAILED' : 'all digits, scores and displays agree with Python'));
console.log('time from the last pixel received to the first answer character sent (the reading plus 0.5 ms of sending; test/nn_timing.js times the reading alone): ' + (total / n).toFixed(1) + ' ms on average, ' +
  fastest.toFixed(1) + ' to ' + worst.toFixed(1) + ' ms');
console.log('program: ' + r.size + ' bytes, ' + r.top.toString(16).toUpperCase() + 'H is the first free address');
process.exit(fails ? 1 : 0);
