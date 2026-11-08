// The generator (nn/gen51.py) against the programs written before it: the UCI programs it writes into ref/nn/gen/
// must assemble to the same bytes as ref/nn/uci/digit_uci_*.a51 (written by nn/train_uci.py).
//   python nn/gen51.py && node test/gen51_check.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const ROOT = path.join(__dirname, '..');
let bad = 0;
for (const kind of ['bin', 'gray']) {
  const a = A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/gen/uci_' + kind + '.a51'), 'utf8'));
  const b = A.assemble(fs.readFileSync(path.join(ROOT, 'ref/nn/uci/digit_uci_' + kind + '.a51'), 'utf8'));
  if (!a.ok || !b.ok) { console.log(kind, 'does not assemble', (a.messages || []).slice(0, 2), (b.messages || []).slice(0, 2)); bad++; continue; }
  let diff = 0;
  for (let i = 0; i < Math.max(a.image.length, b.image.length); i++) if (a.image[i] !== b.image[i]) diff++;
  console.log('UCI ' + kind + ': generator ' + a.size + ' bytes, train_uci ' + b.size + ' bytes, ' + (diff ? diff + ' bytes differ' : 'same bytes'));
  if (diff || a.size !== b.size) bad++;
}
process.exit(bad ? 1 : 0);
