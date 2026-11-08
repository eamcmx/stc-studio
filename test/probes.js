// Line-by-line check against A51's own listings: for every probe file in ref/probes (and ref/probes/gj), each
// source line must get the same bytes as in Keil's .lst and must be flagged the same way (error / warning / clean).
//   node test/probes.js [-v]        (Keil listings: ref/keil-probes/<name>/<name>.lst, made by tools/keil.sh)
// Lines where STC Studio is deliberately stricter than A51 are listed in EXPECTED with the reason.
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const ROOT = path.join(__dirname, '..');
const verbose = process.argv.includes('-v');

// file:line -> why our flag differs from Keil's. Every entry is a case where A51 accepts input that makes no
// sense on an 8051 and writes a byte anyway (a warning, or nothing at all); STC Studio stops with an error.
const EXPECTED = {
  'ranges:14': 'MOV A,100H: A51 warns A52 and writes 00H; a data address above 0FFH is an error here (S1)',
  'ranges:15': 'MOV A,-1: A51 writes E5 6FH without a word; error S1 here',
  'ranges:22': 'MOV A,0FF80H: A51 writes a garbled byte ("E5/0" in its listing); error S1 here',
  'ranges:23': 'MOV A,0FFFFH: A51 writes E5 6FH without a word; error S1 here',
  'bits:12': 'SETB 100H: A51 writes D2 "G0" without a word; a bit address above 0FFH is an error here (S2)',
  'types:31': 'DW L1 ... fine in both; listed only if it ever differs',
  'types2:13': 'MOV A,L1-D1 = -30H: A51 writes E5 40H; error S1 here',
  'types2:15': 'MOV A,-D1: A51 writes E5 40H; error S1 here',
  'types2:47': 'MOV A,NOT D1: A51 writes E5 3FH; error S1 here',
  'types2:61': 'MOV A,D4 with D4 DATA 100H: A51 writes E5 "G0"; error S1 here',
  'jumps2:15': 'ORG 7FCH on top of earlier code: same bytes, plus warning S4 (code overlaps) here; A51 says nothing',
  'jumps2:16': 'the same overlap', 'jumps2:17': 'the same overlap', 'jumps2:18': 'the same overlap',
  'overlap:4': 'ORG 2 after 4 bytes at 0: same image (the last byte written wins), plus warning S4 here',
  'predef:83': 'DW PC: A51 writes 0000H without a word; error A9 here (a register is not a value)',
  'predef:84': 'DW DPTR: the same',
  'segs:21': 'DSEG without AT, with another DSEG AT further down: A51 puts NEXT at 7FH, the base of that later segment (a pass-1 leftover); error S10 here',
  'segs:24': 'follows from segs:21',
  'wrap:2': 'MOV 0FFFFH,#1: A51 writes a garbled address without a word; error S1 here',
};

function readLstSymbols(file) {
  const out = {};
  const t = fs.readFileSync(file, 'latin1');
  const i = t.indexOf('SYMBOL TABLE LISTING');
  if (i < 0) return out;
  for (const m of t.slice(i).matchAll(/^(\S+?)[ .]+C ADDR\s+([0-9A-F]{4})H/gm)) out[m[1].toUpperCase()] = parseInt(m[2], 16);
  return out;
}

function readLst(file) {
  const lines = new Map();
  const get = n => { if (!lines.has(n)) lines.set(n, { bytes: '', flags: new Set(), codes: [], addr: null }); return lines.get(n); };
  let last = null;
  for (const raw of fs.readFileSync(file, 'latin1').split(/\r?\n/)) {
    if (/^SYMBOL TABLE LISTING/.test(raw)) break;
    const m = /^\*\*\* (ERROR|WARNING) #(A\d+) IN (\d+)/.exec(raw);
    if (m) { const l = get(+m[3]); l.flags.add(m[1][0]); l.codes.push(m[2]); continue; }
    if (raw.length < 24 || /^A51 MACRO/.test(raw) || raw[16] === '+') continue;
    const loc = raw.slice(0, 4), obj = raw.slice(5, 17).trim(), no = raw.slice(17, 24).trim();
    if (no && /^\d+$/.test(no)) { last = get(+no); if (/^[0-9A-F]{4}$/.test(loc) && obj) { last.bytes += obj; if (last.addr === null) last.addr = parseInt(loc, 16); } }
    else if (!no && last && /^[0-9A-F]{4}$/.test(loc) && /^[0-9A-F/G]+$/.test(obj)) last.bytes += obj;
  }
  return lines;
}

// default: the hand-written probes; or `node test/probes.js <source dir> <Keil listing dir>`
const args = process.argv.slice(2).filter(x => !x.startsWith('-'));
const SETS = args.length === 2 ? [[args[0], args[1]]] : [['ref/probes', 'ref/keil-probes'], ['ref/probes/gj', 'ref/keil-probes/gj']];
const files = [];
for (const [d, kd] of SETS) {
  for (const f of fs.readdirSync(path.join(ROOT, d)).sort()) if (f.endsWith('.a51')) files.push([d, f, kd]);
}
let lineChecks = 0, byteChecks = 0, bad = 0, expected = 0, codeDiff = 0, drift = 0;
let imagesSame = 0, imagesCompared = 0;
for (const [d, f, kd] of files) {
  const name = f.replace(/\.a51$/, '');
  const lst = path.join(ROOT, kd, name, name + '.lst');
  if (!fs.existsSync(lst)) { console.log('no Keil listing for ' + f + ' (run tools/keil.sh)'); bad++; continue; }
  const keil = readLst(lst);
  const src = fs.readFileSync(path.join(ROOT, d, f), 'utf8');
  if (/^\s*\$INCLUDE/im.test(src)) continue;       // include files expand in Keil's listing; checked separately
  const srcLines = src.split(/\r?\n/);
  const r = A.assemble(src, { name: f });
  const ours = new Map();
  const getO = n => { if (!ours.has(n)) ours.set(n, { bytes: '', flags: new Set(), codes: [] }); return ours.get(n); };
  for (const l of r.lines) { const o = getO(l.line); if (o.addr === undefined) o.addr = l.addr; o.bytes += l.bytes.map(b => b.toString(16).toUpperCase().padStart(2, '0')).join(''); }
  for (const m of r.messages) { const o = getO(m.line); o.flags.add(m.severity === 'error' ? 'E' : 'W'); o.codes.push(m.code); }
  const hexFile = path.join(ROOT, kd, name, name + '.hex');
  if (fs.existsSync(hexFile)) {
    imagesCompared++;
    const k = A.readHex(fs.readFileSync(hexFile, 'utf8'));
    let diff = 0;
    for (let a = 0; a < 65536; a++) if (k.used[a] !== r.used[a] || (k.used[a] && k.image[a] !== r.image[a])) diff++;
    const errLines = r.messages.filter(m => m.severity === 'error').map(m => name + ':' + m.line);
    if (!r.ok && errLines.every(k => EXPECTED[k])) { expected++; }
    else if (diff || !r.ok) { bad++; console.log('IMAGE ' + name + ': Keil made a hex; ours ' + (r.ok ? diff + ' bytes differ' : 'has errors: ' + r.messages.filter(m => m.severity === 'error').map(m => m.line + ':' + m.code).join(' '))); }
    else imagesSame++;
  }
  const nums = new Set([...keil.keys(), ...ours.keys()]);
  let keilErrorSeen = false;
  // in a file A51 rejects, its labels can sit elsewhere (placeholder bytes for bad lines): then jumps differ too
  const ks = readLstSymbols(lst);
  const labelsAgree = Object.entries(ks).every(([n, v]) => !r.symbols[n] || r.symbols[n].type !== 'C' || r.symbols[n].value === v);
  const keilRejects = [...keil.values()].some(l => l.flags.has('E'));      // after a line Keil rejects, A51 may have reserved placeholder bytes: addresses drift
  for (const n of [...nums].sort((a, b) => a - b)) {
    if (n > srcLines.length) continue;
    const k = keil.get(n) || { bytes: '', flags: new Set(), codes: [] }, o = ours.get(n) || { bytes: '', flags: new Set(), codes: [] };
    lineChecks++;
    const key = name + ':' + n;
    const fk = [...k.flags].sort().join(''), fo = [...o.flags].sort().join('');
    const text = (srcLines[n - 1] || '').trim();
    let problem = null;
    // STC Studio warns (S4) when ORG puts code on top of earlier code; A51 says nothing. Same bytes either way.
    const onlyOverlap = fk === '' && fo === 'W' && o.codes.every(c => c === 'S4');
    if (onlyOverlap) { expected++; if (verbose) console.log('  expected ' + key + ': overlap warning S4'); continue; }
    else if (fk !== fo) problem = 'Keil flags [' + (k.codes.join(' ') || 'none') + '], ours [' + (o.codes.join(' ') || 'none') + ']';
    else if (!k.flags.has('E')) {
      if (keilErrorSeen && k.addr !== null && o.addr !== undefined && k.addr !== o.addr) { drift++; continue; }
      byteChecks++;
      if (k.bytes !== o.bytes && keilRejects && !labelsAgree) { byteChecks--; drift++; continue; }
      if (k.bytes !== o.bytes) problem = 'Keil bytes ' + (k.bytes || '-') + ', ours ' + (o.bytes || '-');
    }
    if (k.flags.has('E')) keilErrorSeen = true;
    // an excuse covers STC Studio being stricter, never a line A51 rejects and we accept
    if (problem && EXPECTED[key] && k.flags.has('E') && !o.flags.has('E')) problem += ' (we accept a line A51 rejects)';
    else if (problem && EXPECTED[key]) { expected++; if (verbose) console.log('  expected ' + key + ': ' + EXPECTED[key]); continue; }
    if (problem) { bad++; console.log('DIFF ' + key + '  ' + text + '\n       ' + problem); continue; }
    const kc = [...new Set(k.codes)].sort().join(' '), oc = [...new Set(o.codes)].sort().join(' ');
    if (kc !== oc) { codeDiff++; if (verbose) console.log('  code ' + key + '  ' + text + '  Keil ' + kc + ', ours ' + oc); }
  }
}
console.log('\n' + files.length + ' probe files, ' + lineChecks + ' lines compared, ' + byteChecks + ' of them byte for byte');
console.log(imagesSame + ' of ' + imagesCompared + ' files Keil could build give the same code image here');
console.log(drift + ' lines skipped for the byte check: their address moved after an error line (no hex either way)');
console.log(bad + ' lines differ from Keil, ' + expected + ' differ on purpose (stricter, see EXPECTED), ' +
  codeDiff + ' flagged the same but with another error number');
process.exit(bad ? 1 : 0);
