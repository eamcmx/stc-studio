// The measurement build (ref/nn/energy/digit_nn_marker.a51) on the simulated board: the answers must not change,
// and the low pulse on P2.0 must last as long as the reading (last square in, to the first character out).
//   python nn/energy_build.py && node test/nn_marker.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const ROOT = path.join(__dirname, '..');
const MS = Board.CYCLES_PER_S / 1000;
const file = process.argv[2] || 'ref/nn/energy/digit_nn_marker.a51';
const r = A.assemble(fs.readFileSync(path.join(ROOT, file), 'utf8'));
if (!r.ok) { console.log(r.messages.slice(0, 3)); process.exit(1); }
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/test_vectors.json'), 'utf8'));
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };
const b = new Board(E); b.load(r.image); b.reset();
let out = '', first = -1;
b.onSerial = c => { if (first < 0) first = b.cpu.cycles; out += String.fromCharCode(c); };
b.run(Math.round(20 * MS));
let bad = 0, worstGap = 0, sum = 0, n = 0;
for (const v of vecs) {                 // all 346 test drawings, as in the other timings
  out = ''; first = -1;
  b.serialIn(Array.from('D' + v.pixels, c => c.charCodeAt(0)));
  let fell = -1, rose = -1, last = b.cpu.p2 & 1;
  while (!out.endsWith('\n')) {           // instruction by instruction, to catch the edges exactly
    b.step();
    const p = b.cpu.p2 & 1;
    if (last === 1 && p === 0) fell = b.cpu.cycles;
    if (last === 0 && p === 1) rose = b.cpu.cycles;
    last = p;
  }
  const m = /^=(\d)((?: [0-9A-F]{6}){10})\r\n$/.exec(out);
  if (!m || +m[1] !== v.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(v.scores)) bad++;
  const pulse = (rose - fell) / MS, toFirst = (first - fell) / MS;
  worstGap = Math.max(worstGap, Math.abs(toFirst - pulse)); sum += pulse; n++;
}
console.log(file + ': ' + n + ' readings: ' + (bad ? bad + ' answers differ' : 'answers as the Python reference') +
  '; P2.0 low for ' + (sum / n).toFixed(2) + ' ms on average; the pulse ends at most ' + (worstGap * 1000).toFixed(0) +
  ' us before the first character of the answer; program ' + r.size + ' bytes');
const save = (name, data) => { const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
  fs.writeFileSync(path.join(d, name + '.json'), JSON.stringify(Object.assign({ made: new Date().toISOString(), by: 'test/' + path.basename(__filename) }, data), null, 1)); };
save('marker_' + path.basename(file, '.a51'), { file, readings: n, answers_unlike_python: bad, avg_pulse_ms: +(sum / n).toFixed(3), max_gap_us: Math.round(worstGap * 1000), bytes: r.size });
process.exit(bad ? 1 : 0);
