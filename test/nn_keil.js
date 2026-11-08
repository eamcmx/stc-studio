// Every assembly program of the paper (ref/nn/**/*.a51) against Keil: each is built with tools/keil.sh (A51, BL51,
// OH51) in a temporary folder; where the evaluation linker could link it (2 KB limit) the code image must equal
// Keil's, otherwise every source line must get the same address and bytes as in A51's listing.
// Writes ref/nn/results/keil_nn.json. Needs Keil C51 in C:/Keil_v5 and bash.
//   node test/nn_keil.js
'use strict';
const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync } = require('child_process');
const A = require('../src/asm51.js');

const ROOT = path.join(__dirname, '..');
const TMP = fs.mkdtempSync(path.join(os.tmpdir(), 'keil-nn-'));

function readLst(file) {                       // as in test/probes.js
  const lines = new Map();
  const get = n => { if (!lines.has(n)) lines.set(n, { bytes: '', addr: null, err: false }); return lines.get(n); };
  let last = null;
  for (const raw of fs.readFileSync(file, 'latin1').split(/\r?\n/)) {
    if (/^SYMBOL TABLE LISTING/.test(raw)) break;
    const m = /^\*\*\* (ERROR|WARNING) #(A\d+) IN (\d+)/.exec(raw);
    if (m) { get(+m[3]).err = true; continue; }
    if (raw.length < 24 || /^A51 MACRO/.test(raw) || raw[16] === '+') continue;
    const loc = raw.slice(0, 4), obj = raw.slice(5, 17).trim(), no = raw.slice(17, 24).trim();
    if (no && /^\d+$/.test(no)) { last = get(+no); if (/^[0-9A-F]{4}$/.test(loc) && obj) { last.bytes += obj; if (last.addr === null) last.addr = parseInt(loc, 16); } }
    else if (!no && last && /^[0-9A-F]{4}$/.test(loc) && /^[0-9A-F/G]+$/.test(obj)) last.bytes += obj;
  }
  return lines;
}

const files = [];
(function walk(d) {
  for (const f of fs.readdirSync(path.join(ROOT, d)).sort()) {
    const p = d + '/' + f;
    if (fs.statSync(path.join(ROOT, p)).isDirectory()) walk(p); else if (f.endsWith('.a51')) files.push(p);
  }
})('ref/nn');
const rows = [];
for (const f of files) {
  const name = path.basename(f, '.a51'), out = path.join(TMP, f.replace(/[/.]/g, '_'));
  try { execFileSync('bash', [path.join(ROOT, 'tools/keil.sh'), path.join(ROOT, f), out], { stdio: 'ignore' }); } catch (e) { /* over 2 KB: no hex */ }
  const r = A.assemble(fs.readFileSync(path.join(ROOT, f), 'utf8'), { name });
  const hex = path.join(out, name + '.hex');
  let how, same;
  if (fs.existsSync(hex)) {
    const k = A.readHex(fs.readFileSync(hex, 'utf8'));
    let diff = 0;
    for (let a = 0; a < 65536; a++) if (k.used[a] !== r.used[a] || (k.used[a] && k.image[a] !== r.image[a])) diff++;
    how = 'linked image'; same = diff === 0;
  } else {
    const lst = readLst(path.join(out, name + '.lst'));
    let diff = 0;
    for (const l of r.lines) {
      if (!l.bytes || !l.bytes.length) continue;
      const k = lst.get(l.line), ours = Array.from(l.bytes, b => b.toString(16).toUpperCase().padStart(2, '0')).join('');
      if (!k || k.err || k.bytes !== ours || k.addr !== l.addr) diff++;
    }
    how = 'A51 listing, line by line (over the 2 KB of the evaluation linker)'; same = diff === 0;
  }
  rows.push({ file: f, bytes: r.size, compared: how, same_as_keil: same });
  console.log((same ? 'same  ' : 'DIFFERS ') + f.padEnd(44) + String(r.size).padStart(6) + ' bytes, ' + how);
}
fs.rmSync(TMP, { recursive: true, force: true });
const res = { made: new Date().toISOString(), by: 'test/nn_keil.js', programs: rows.length, same: rows.filter(x => x.same_as_keil).length, rows };
fs.writeFileSync(path.join(ROOT, 'ref/nn/results/keil_nn.json'), JSON.stringify(res, null, 1));
console.log(res.same + ' of ' + res.programs + ' programs give the same bytes as Keil');
process.exit(res.same === res.programs ? 0 : 1);
