// Writes app/examples.js, the Examples menu, from the course programs in ref/corpus, ref/nn and ref/practicals
// (the files the assembler is tested on, so every example is known to give Keil's bytes).
//   node tools/make_examples.js
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n?/g, '\n');

const groups = [
  { group: 'Board demos', items: [
    ['demo2', 'Demo 2: stopwatch, race, light show, Pong (no sound)', 'ref/corpus/demo2.a51'],
    ['demo', 'Demo 1: piano, memory game, song, reaction timer (buzzer)', 'ref/corpus/demo.a51'],
  ] },
  { group: 'Neural network', items: [
    ['nn', 'Digit reader: draw a digit in the Digit pad, the board reads it', 'ref/nn/digit_nn.a51'],
  ] },
  { group: 'Lab 6: the board', items: [
    ['ex2', 'Ex 2: one-digit counter', 'ref/corpus/his_ex2_counter.asm'],
    ['ex3', 'Ex 3: LED toggle with debounce', 'ref/corpus/his_ex3_debounce.asm'],
    ['l1', 'Running light D1 to D8', 'ref/corpus/l1_running_light.asm'],
    ['b1', 'Count S2 presses on the LEDs (no debounce)', 'ref/corpus/b1_edge_count.asm'],
    ['c1', 'Counter on digit 4, S2 adds one', 'ref/corpus/c1_counter.asm'],
    ['m1', 'Four digits from RAM 30H-33H', 'ref/corpus/m1_four_digits.asm'],
    ['ta', 'Your turn A: up with S2, down with S3', 'ref/corpus/sol_ta.asm'],
    ['tb', 'Your turn B: 00 to 99 on digits 3 and 4', 'ref/corpus/sol_tb.asm'],
    ['e1', 'E1: every other LED', 'ref/corpus/sol_e1.asm'],
    ['e3', 'E3: a 5 ms delay loop', 'ref/corpus/sol_e3.asm'],
    ['v1', 'The AI\'s "0" (3FH on digit 1)', 'ref/corpus/v1_ai_code.asm'],
  ] },
  { group: 'The 25 practicals', items: [] },
];
// the practicals' titles come from the course engine next to this repository; the public release has neither
const fixtures = path.join(ROOT, '../_i8051/fixtures.json');
const titles = fs.existsSync(fixtures) && fs.existsSync(path.join(ROOT, 'ref/practicals')) ? JSON.parse(fs.readFileSync(fixtures, 'utf8')) : [];
for (const p of titles) {
  const t = p.title.replace(/\s+—\s+/g, ': ').replace(/—/g, '-');
  groups[3].items.push(['p' + String(p.n).padStart(2, '0'), 'P' + p.n + ' ' + t, 'ref/practicals/p' + String(p.n).padStart(2, '0') + '.a51']);
}
// a program that is not in this copy of the repository (the course programs of the public release) is left out
const out = groups.map(g => ({ group: g.group, items: g.items.filter(([, , f]) => fs.existsSync(path.join(ROOT, f)))
  .map(([id, title, f]) => ({ id, title, file: path.basename(f).replace(/\.asm$/, '.a51'), source: read(f) })) }))
  .filter(g => g.items.length);
const js = '// Made by tools/make_examples.js from ref/corpus, ref/nn and ref/practicals. Do not edit by hand.\n' +
  'window.STC_EXAMPLES = ' + JSON.stringify(out, null, 1) + ';\n';
fs.mkdirSync(path.join(ROOT, 'app'), { recursive: true });
fs.writeFileSync(path.join(ROOT, 'app', 'examples.js'), js);
console.log('app/examples.js: ' + out.reduce((n, g) => n + g.items.length, 0) + ' programs, ' + (js.length / 1024).toFixed(0) + ' KB');
