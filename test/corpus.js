// Gate 2: every course program must give the same code image as Keil A51 -> BL51 -> OH51.
//   node test/corpus.js            (reference hex files: ref/keil/<name>/<name>.hex, made by tools/keil.sh)
// Compares the byte images (which addresses hold a byte, and the byte), not the record layout of the hex files.
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');

const ROOT = path.join(__dirname, '..');
const dirs = ['ref/corpus', 'ref/practicals'];
let pass = 0, fail = 0;
for (const d of dirs) {
  if (!fs.existsSync(path.join(ROOT, d))) { console.log('skip  ' + d + ' (not in this copy of the repository)'); continue; }
  for (const f of fs.readdirSync(path.join(ROOT, d)).sort()) {
    const name = f.replace(/\.[^.]+$/, '');
    const src = fs.readFileSync(path.join(ROOT, d, f), 'utf8');
    const keilHex = path.join(ROOT, 'ref/keil', name, name + '.hex');
    const k = A.readHex(fs.readFileSync(keilHex, 'utf8'));
    const r = A.assemble(src, { name: f });
    const diffs = [];
    for (let a = 0; a < 65536; a++) {
      if (k.used[a] !== r.used[a] || (k.used[a] && k.image[a] !== r.image[a])) diffs.push(a);
    }
    const errs = r.messages.filter(m => m.severity === 'error');
    if (r.ok && diffs.length === 0) {
      pass++;
      const warn = r.messages.length ? '  (' + r.messages.map(m => 'line ' + m.line + ' ' + m.code).join(', ') + ')' : '';
      console.log('OK    ' + (d + '/' + f).padEnd(40) + String(r.size).padStart(5) + ' bytes, same as Keil' + warn);
    } else {
      fail++;
      console.log('FAIL  ' + d + '/' + f + ': ' + errs.length + ' errors, ' + diffs.length + ' bytes differ (Keil ' + k.size + ', ours ' + r.size + ')');
      for (const m of errs.slice(0, 5)) console.log('        line ' + m.line + ' ' + m.code + ' ' + m.text + ': ' + src.split(/\r?\n/)[m.line - 1].trim());
      for (const a of diffs.slice(0, 5)) {
        const l = r.lines.find(x => a >= x.addr && a < x.addr + x.bytes.length);
        console.log('        ' + a.toString(16).toUpperCase().padStart(4, '0') + 'H Keil ' + (k.used[a] ? k.image[a].toString(16).padStart(2, '0') : '--') +
          ' ours ' + (r.used[a] ? r.image[a].toString(16).padStart(2, '0') : '--') + (l ? '  line ' + l.line + ': ' + src.split(/\r?\n/)[l.line - 1].trim() : ''));
      }
    }
  }
}
console.log('\n' + pass + ' of ' + (pass + fail) + ' programs give the same image as Keil');
process.exit(fail ? 1 : 0);
