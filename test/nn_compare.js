// The digit reader in assembly against the C builds, on the simulated board (cycle counts of the 8051 at
// 11.0592 MHz, 12 clocks per cycle). Every version must give the Python reference's answer for every test
// drawing; then it prints size and time.
//   node test/nn_compare.js
// The C builds come from tools/keil_c.sh (see docs/m6-c-vs-asm.md for the commands).
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const T = require('./nn_timing.js');
const ROOT = path.join(__dirname, '..');
const MS = Board.CYCLES_PER_S / 1000;
const TABLES = { asm: 48 + 35 * 24 + 10 * 27 + 4 + 10 + 11, c: 48 + 35 * 24 + 40 + 240 + 4 + 10 + 17 + 11 };

const versions = [
  ['Assembly (ref/nn/digit_nn.a51)', A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/digit_nn.a51'), 'utf8')), TABLES.asm],
  ['C as written (digit_nn_c.hex)', 'ref/nn/c/digit_nn_c.hex', TABLES.c],
  ['C, 32-bit multiply (digit_nn_c_long.hex)', 'ref/nn/c/digit_nn_c_long.hex', TABLES.c],
  ['C, optimized for size (digit_nn_c_size.hex)', 'ref/nn/c/digit_nn_c_size.hex', TABLES.c],
  ['C tuned for the 8051 (digit_nn_c_tuned.hex)', 'ref/nn/c/digit_nn_c_tuned.hex', TABLES.c],
  // the same source compiled by SDCC 4.6.0 (tools/sdcc_c.ps1)
  ['SDCC: C as written (sdcc/digit_nn.hex)', 'ref/nn/c/sdcc/digit_nn.hex', TABLES.c],
  ['SDCC: C as written, --opt-code-speed (sdcc_speed)', 'ref/nn/c/sdcc_speed/digit_nn.hex', TABLES.c],
  ['SDCC: C, 32-bit multiply (sdcc_long)', 'ref/nn/c/sdcc_long/digit_nn.hex', TABLES.c],
  ['SDCC: C, --opt-code-size (sdcc_size)', 'ref/nn/c/sdcc_size/digit_nn.hex', TABLES.c],
  ['SDCC: C tuned for the 8051 (sdcc_tuned)', 'ref/nn/c/sdcc_tuned/digit_nn.hex', TABLES.c],
].map(([name, src, tables]) => ({ name, img: typeof src === 'string' ? A.readHex(fs.readFileSync(path.join(ROOT, src), 'utf8')) : src, tables }));
const vecs = JSON.parse(fs.readFileSync(path.join(ROOT, 'nn/test_vectors.json'), 'utf8'));
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };

// one reading: from the read of the last square to the write of the first character of the answer
const reading = (b, st, pixels) => T.reading(b, st, 'D' + pixels);   // see test/nn_timing.js

let bad = 0;
const rows = [];
for (const v of versions) {
  const b = new Board(E); b.load(v.img.image); b.reset();
  const st = T.attach(b);
  b.run(Math.round(20 * MS));
  let sum = 0;
  for (const t of vecs) {
    const r = reading(b, st, t.pixels);
    const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(r.line);
    if (!m || +m[1] !== t.digit || JSON.stringify(m[2].trim().split(' ').map(s24)) !== JSON.stringify(t.scores)) bad++;
    sum += r.ms;
  }
  const empty = reading(b, st, '0'.repeat(35)).ms, full = reading(b, st, '1'.repeat(35)).ms;
  rows.push([v.name, v.img.size, v.img.size - v.tables, (sum / vecs.length).toFixed(1), empty.toFixed(1), ((full - empty) / 35).toFixed(2), full.toFixed(1)]);
}
console.log('| Version | Bytes | Without the tables | Average reading (' + vecs.length + ' drawings) | Empty grid | Per lit square | Full grid |');
console.log('|---|---|---|---|---|---|---|');
for (const r of rows) console.log('| ' + r[0] + ' | ' + r[1] + ' | ' + r[2] + ' | ' + r[3] + ' ms | ' + r[4] + ' ms | ' + r[5] + ' ms | ' + r[6] + ' ms |');
const save = (name, data) => { const d = path.join(ROOT, 'ref/nn/results'); fs.mkdirSync(d, { recursive: true });
  fs.writeFileSync(path.join(d, name + '.json'), JSON.stringify(Object.assign({ made: new Date().toISOString(), by: 'test/' + path.basename(__filename) }, data), null, 1)); };
save('compare', { drawings: vecs.length, answers_unlike_python: bad, columns: ['version', 'bytes', 'bytes_without_tables', 'avg_ms', 'empty_ms', 'per_lit_ms', 'full_ms'], rows });
console.log(bad ? bad + ' answers differ from Python' : 'every version gives the Python answer for all ' + vecs.length + ' drawings');
process.exit(bad ? 1 : 0);
