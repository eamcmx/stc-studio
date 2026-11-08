// The board model (src/board.js) on programs whose behaviour is known.
//   node test/board_test.js
'use strict';
const fs = require('fs');
const path = require('path');
const A = require('../src/asm51.js');
const E = require('../src/i8051.js');
const Board = require('../src/board.js');
const ROOT = path.join(__dirname, '..');
let fails = 0;
const ok = (c, what) => { console.log((c ? 'ok    ' : 'FAIL  ') + what); if (!c) fails++; };
const asm = f => { const r = A.assemble(fs.readFileSync(path.join(ROOT, f), 'utf8')); if (!r.ok) throw new Error(f + ': ' + JSON.stringify(r.messages)); return r; };
const src = s => { const r = A.assemble(s); if (!r.ok) throw new Error(JSON.stringify(r.messages)); return r; };
const CPS = Board.CYCLES_PER_S, msC = ms => Math.round(ms * CPS / 1000);
// the course programs (Lab 6) and the course engine are not in the public release: those checks are skipped there
const has = f => fs.existsSync(path.join(ROOT, f));
const skip = what => console.log('skip  ' + what + ' (not in this copy of the repository)');

// 0. the CPU is the course engine, unchanged
if (!has('../_i8051/i8051.js')) skip('src/i8051.js against the course engine _i8051/i8051.js');
else ok(fs.readFileSync(path.join(ROOT, 'src/i8051.js'), 'utf8') === fs.readFileSync(path.join(ROOT, '../_i8051/i8051.js'), 'utf8'),
  'src/i8051.js is byte for byte the course engine _i8051/i8051.js');

// 1. his Ex 2: digit 1 counts 0..9, about one step a second
if (!has('ref/corpus/his_ex2_counter.asm')) skip('Ex 2 counter');
else {
  const b = new Board(E); b.load(asm('ref/corpus/his_ex2_counter.asm').image);
  const seen = [];
  for (let t = 0; t < 120; t++) { b.run(msC(100)); const s = Board.text(b.frame()); if (s[0] !== seen[seen.length - 1]) seen.push(s[0]); }
  const digits = seen.filter(c => /\d/.test(c)).join('');
  ok(digits === '012345678901', 'Ex 2 on digit 1 over 12 s (just over 1 s a number): ' + digits);
}

// 2. demo2: the intro ends in the menu CrLP; S5 opens the stopwatch; the time matches the earlier harness
{
  const b = new Board(E); b.load(asm('ref/corpus/demo2.a51').image);
  let tMenu = null;
  for (let t = 0; t < 400 && tMenu === null; t++) { b.run(msC(50)); if (Board.text(b.frame()) === 'CrLP') tMenu = b.ms(); }
  // the same program on the earlier harness (board-demo-2/test/sim.js: course engine plus Timer 2, no call cycles)
  if (!has('../academy/board-demo-2/test/sim.js')) {
    skip('the earlier demo2 harness');
    ok(tMenu !== null, 'demo2 shows CrLP at ' + (tMenu || 0).toFixed(0) + ' ms');
  } else {
    const Old = require(path.join(ROOT, '../academy/board-demo-2/test/sim.js'));
    const o = new Old.Board(path.join(ROOT, 'ref/m1/demo2_keil.hex'));
    o.runUntil(() => o.text() === '[CrLP]', 20000);
    ok(tMenu !== null && Math.abs(tMenu - o.ms()) < 60, 'demo2 shows CrLP at ' + (tMenu || 0).toFixed(0) + ' ms (earlier harness: ' + o.ms().toFixed(0) + ' ms)');
  }
  // S5: the name scrolls past ("CHrono", 1.5 s), then the stopwatch reads 0.00
  b.setButton('S5', true); b.run(msC(80)); b.setButton('S5', false); b.run(msC(2000)); b.frame(); b.run(msC(100));
  const t1 = Board.text(b.frame());
  ok(t1 === ' 0.00', 'S5 opens Chrono: ' + JSON.stringify(t1));
  // Timer 2 interrupts: one every 1152 cycles
  let entries = 0; const cpu = b.cpu;
  for (let k = 0; k < msC(1000);) { const pc = cpu.pc; k += b.step(); if (pc !== 0x2B && cpu.pc === 0x2B) entries++; }
  ok(Math.abs(entries - CPS / 1152) <= 1, 'Timer 2 vectors to 002BH ' + entries + ' times a second (921600/1152 = 800)');
}

// 3. an interrupt call costs 2 machine cycles: a Timer 0 mode 1 ISR that reloads itself runs 2 cycles slower per period
{
  const prog = src(`
        ORG 0
        LJMP MAIN
        ORG 0BH
        MOV TH0,#HIGH(-1000)
        MOV TL0,#LOW(-1000)
        INC R7
        RETI
MAIN:   MOV TMOD,#01H
        MOV TH0,#HIGH(-1000)
        MOV TL0,#LOW(-1000)
        SETB ET0
        SETB EA
        SETB TR0
        SJMP $
        END`);
  const period = (cpu, stepFn) => {
    const at = [];
    while (at.length < 6) { const pc = cpu.pc; stepFn(); if (pc !== 0x0B && cpu.pc === 0x0B) at.push(cpu.cycles); }
    return (at[5] - at[1]) / 4;
  };
  const b = new Board(E); b.load(prog.image);
  const pNew = period(b.cpu, () => b.step());
  const plain = new E.CPU(); plain.load({ code: Uint8Array.from(prog.image), length: prog.top, lineMap: {}, symbols: {} });
  const pOld = period(plain, () => plain.step());
  ok(pNew - pOld === 2, 'Timer 0 reloaded in its ISR: period ' + pOld + ' cycles on the plain engine, ' + pNew + ' here (2 for the call)');
}

// 4. buttons: his P13 lights D1 (P0.0) while S2 (P3.2) is held
if (!has('ref/corpus/his_p13_button_poll.asm')) skip('P13 button poll');
else {
  const b = new Board(E); b.load(asm('ref/corpus/his_p13_button_poll.asm').image);
  b.run(msC(20)); b.frame(); b.run(msC(20)); const off = b.frame().led[0];
  b.setButton('S2', true); b.run(msC(5)); b.frame(); b.run(msC(20)); const on = b.frame().led[0];
  b.setButton('S2', false); b.run(msC(5)); b.frame(); b.run(msC(20)); const off2 = b.frame().led[0];
  ok(off === 0 && on > 0.9 && off2 === 0, 'P13: D1 lit ' + on.toFixed(2) + ' of the time with S2 held, ' + off + ' and ' + off2 + ' without');
}

// 5. serial: "HI" at 9600 baud (Timer 1 mode 2, TH1 = FDH) takes 10 bit times a byte
{
  const prog = src(`
        ORG 0
        MOV SCON,#50H
        MOV TMOD,#20H
        MOV TH1,#0FDH
        MOV TL1,#0FDH
        SETB TR1
        MOV SBUF,#'H'
W1:     JNB TI,W1
        CLR TI
        MOV SBUF,#'I'
W2:     JNB TI,W2
        CLR TI
        SJMP $
        END`);
  const b = new Board(E); b.load(prog.image);
  const got = [];
  b.onSerial = byte => got.push([String.fromCharCode(byte), b.cpu.cycles]);
  b.run(msC(5));
  const gap = got.length === 2 ? (got[1][1] - got[0][1]) / CPS * 1000 : 0;
  ok(got.map(g => g[0]).join('') === 'HI' && Math.abs(gap - 10 / 9600 * 1000) < 0.02,
    'serial: sent ' + JSON.stringify(got.map(g => g[0]).join('')) + ', ' + gap.toFixed(3) + ' ms a byte (9600 baud: 1.042 ms)');
  // and in: a byte typed in arrives in SBUF with RI
  const echo = src(`
        ORG 0
        MOV SCON,#50H
        MOV TMOD,#20H
        MOV TH1,#0FDH
        SETB TR1
W:      JNB RI,W
        MOV A,SBUF
        CLR RI
        MOV P1,A
        SJMP $
        END`);
  const e = new Board(E); e.load(echo.image); e.run(msC(1)); e.serialIn([0x5A]); e.run(msC(3));
  ok(e.cpu.p1 === 0x5A, 'serial in: byte 5AH typed in reaches P1 = ' + e.cpu.p1.toString(16).toUpperCase() + 'H');
}

// 6. the buzzer program demo.a51: P3.6 moves, and the half period of its first song note
{
  const b = new Board(E); b.load(asm('ref/corpus/demo.a51').image);
  let last = 1, lastAt = 0; const halves = [];
  b.onBuzzer = (lv) => { if (lv !== last) { if (lastAt) halves.push(b.cpu.cycles - lastAt); lastAt = b.cpu.cycles; last = lv; } };
  b.run(msC(4000));
  ok(halves.length > 100, 'demo.a51 moves the buzzer pin: ' + halves.length + ' edges in the first 4 s');
}

console.log(fails ? fails + ' FAILED' : 'all board checks passed');
process.exit(fails ? 1 : 0);
