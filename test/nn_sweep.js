// The sweep programs of nn/study.py (UCI digits, 64-H-10 networks, H = 8 to 32, binary and 16 grey levels) on the
// simulated board: each must answer its test digits exactly like the Python reference (digit and ten scores); then
// its size, its use of internal RAM and the time of one reading (test/nn_timing.js) are written to
// ref/nn/results/sweep.json.
//   python nn/study.py && node test/nn_sweep.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const DIR = path.join(ROOT, 'ref/nn/sweep');
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

let bad = 0;
const rows = [];
for (const f of fs.readdirSync(DIR).filter(f => f.endsWith('.a51'))) {
  const [, kind, H] = /^uci_(bin|gray)_h(\d+)\.a51$/.exec(f);
  const r = A.assemble(fs.readFileSync(path.join(DIR, f), 'utf8'));
  if (!r.ok) { console.log(f, 'does not assemble', r.messages.slice(0, 3)); bad++; continue; }
  const vecs = JSON.parse(fs.readFileSync(path.join(DIR, f.replace('.a51', '.json')), 'utf8'));
  const b = new Board(E); b.load(r.image); b.reset();
  const st = T.attach(b);
  b.run(T.ms(20));
  let wrong = 0, sum = 0, lo = Infinity, hi = 0;
  for (const v of vecs) {
    const x = T.reading(b, st, 'D' + v.pixels);
    const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(x.line);
    if (!m || +m[1] !== v.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(v.scores)) wrong++;
    sum += x.cycles; lo = Math.min(lo, x.cycles); hi = Math.max(hi, x.cycles);
  }
  bad += wrong;
  const sym = n => r.symbols[n] && r.symbols[n].value;
  const ramTop = sym('SCORE') + 30;                      // first byte above the scores
  rows.push({ kind, H: +H, bytes: r.size, digits: vecs.length, answers_unlike_python: wrong,
    avg_cycles: Math.round(sum / vecs.length), min_cycles: lo, max_cycles: hi, avg_ms: +(sum / vecs.length / T.MS).toFixed(2),
    ram_top: '0x' + ramTop.toString(16).toUpperCase() });
}
rows.sort((p, q) => (p.kind < q.kind ? -1 : p.kind > q.kind ? 1 : p.H - q.H));
console.log('| Coding | H | Bytes | Average reading | Shortest | Longest | RAM up to | Answers unlike Python |');
console.log('|---|---|---|---|---|---|---|---|');
for (const x of rows) console.log(`| ${x.kind} | ${x.H} | ${x.bytes} | ${x.avg_ms} ms | ${(x.min_cycles / T.MS).toFixed(1)} ms | ${(x.max_cycles / T.MS).toFixed(1)} ms | ${x.ram_top} | ${x.answers_unlike_python} |`);
const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
fs.writeFileSync(path.join(d, 'sweep.json'), JSON.stringify({ made: new Date().toISOString(), by: 'test/nn_sweep.js', cycles_per_ms: T.MS, rows }, null, 1));
console.log(bad ? bad + ' answers differ from Python' : 'every sweep program answers its test digits like the Python reference');
process.exit(bad ? 1 : 0);
