/* asm51.js: an 8051 assembler that follows Keil A51 (C51 9.61) for absolute programs.
 *
 *   const r = ASM51.assemble(sourceText, { name: 'prog.a51' });
 *   r.ok           true when there are no errors (warnings allowed)
 *   r.messages     [{ line, severity: 'error'|'warning', code: 'A45', text }] in line order
 *   r.image        Uint8Array(65536) code memory, r.used = Uint8Array(65536) with 1 where a byte was written
 *   r.size         number of code bytes written, r.top = highest address written + 1
 *   r.hex          Intel HEX text (null when there are errors)
 *   r.listing      a listing in the layout of A51's .lst file
 *   r.lines        per source line: { line, addr, bytes: [...] } for lines that make code
 *   r.addrLine     { address: line } for the first byte of every instruction and data line
 *   r.symbols      { NAME: { name, type: 'C'|'D'|'I'|'X'|'B'|'N', value } } for the program's own symbols
 *
 * What it covers: two or more passes with forward references, ORG, END, DB, DW, DS, DBIT, EQU, SET, DATA, IDATA,
 * XDATA, CODE, BIT, USING (AR0-AR7), NAME, CSEG/DSEG/BSEG/ISEG/XSEG [AT n], $NOMOD51 and $INCLUDE (REG51.INC or
 * REG52.INC), the predefined 8051 SFR and bit names, every 8051 instruction, generic JMP and CALL, expressions with
 * A51's operators and precedence, symbol types (a code label is not a data address), and Keil's error numbers.
 * Not covered (reported as errors, never ignored): relocatable segments (SEGMENT, RSEG, PUBLIC, EXTRN), macros and
 * conditional assembly. Each rule here was checked against A51 itself; see test/ and ref/probes/.
 */
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.ASM51 = factory();
}(typeof self !== 'undefined' ? self : this, function () {
  'use strict';

  // ------------------------------------------------------------------ messages
  const MSG = {
    A1: 'ILLEGAL CHARACTER IN NUMERIC CONSTANT', A4: 'BAD INDIRECT REGISTER', A5: 'ILLEGAL USE OF A RESERVED WORD',
    A7: 'LABEL NOT PERMITTED', A8: 'ATTEMPT TO DEFINE AN ALREADY DEFINED LABEL', A9: 'SYNTAX ERROR',
    A10: 'ATTEMPT TO DEFINE AN ALREADY DEFINED SYMBOL', A11: 'STRING CONTAINS ZERO OR MORE THAN TWO CHARACTERS',
    A13: "')' EXPECTED", A15: 'MISSING FACTOR', A16: 'DIVIDE BY ZERO ERROR',
    A17: 'INVALID BYTE BASE IN BIT ADDRESS EXPRESSION', A18: 'OUT OF RANGE OR NON-TYPELESS BIT-OFFSET',
    A21: 'EXPRESSION WITH FORWARD REFERENCE NOT PERMITTED', A22: 'EXPRESSION TYPE DOES NOT MATCH INSTRUCTION',
    A27: 'LOCATION COUNTER MAY NOT POINT BELOW SEGMENT BASE', A29: 'SEGMENT LIMIT EXCEEDED', A34: "',' EXPECTED",
    A36: 'INVALID NUMBER FOR REGISTERBANK', A37: 'OPERATION INVALID IN THIS SEGMENT',
    A38: 'NUMBER OF OPERANDS DOES NOT MATCH INSTRUCTION', A39: 'REGISTER OPERAND EXPECTED', A40: 'INVALID REGISTER',
    A41: "MISSING 'END' STATEMENT", A45: 'UNDEFINED SYMBOL (PASS-2)', A46: 'CODE-ADDRESS EXPECTED',
    A48: 'DATA-ADDRESS EXPECTED', A51: 'TARGET OUT OF RANGE', A52: 'VALUE HAS BEEN TRUNCATED TO 8 BITS',
    A53: "MISSING 'USING' INFORMATION", A68: 'UNKNOWN CONTROL OR BAD ARGUMENT(S)',
    A73: 'TEXT FOUND BEYOND END STATEMENT - IGNORED',
    // STC Studio's own checks: places where A51 prints a warning or silently makes wrong code
    S1: 'DATA ADDRESS OUT OF RANGE (00H TO 0FFH)', S2: 'BIT ADDRESS OUT OF RANGE (00H TO 0FFH)',
    S3: 'NOT SUPPORTED HERE (NEEDS THE KEIL LINKER OR MACRO PROCESSOR)', S4: 'CODE OVERLAPS EARLIER CODE',
    S5: 'ILLEGAL CHARACTER', S6: 'STRING NOT TERMINATED',
    S8: 'JUMP SIZES DO NOT SETTLE', S9: 'INCLUDE FILE NOT AVAILABLE',
    S10: 'GIVE THIS SEGMENT AN AT ADDRESS (A51 WOULD CONTINUE A LATER SEGMENT HERE)',
  };
  const WARNINGS = new Set(['A41', 'A52', 'A73', 'S4']);

  // ------------------------------------------------------------------ predefined symbols (A51 $MOD51)
  const SFR51 = { P0: 0x80, SP: 0x81, DPL: 0x82, DPH: 0x83, PCON: 0x87, TCON: 0x88, TMOD: 0x89, TL0: 0x8A, TL1: 0x8B,
    TH0: 0x8C, TH1: 0x8D, P1: 0x90, SCON: 0x98, SBUF: 0x99, P2: 0xA0, IE: 0xA8, P3: 0xB0, IP: 0xB8, PSW: 0xD0,
    ACC: 0xE0, B: 0xF0 };
  const BIT51 = { IT0: 0x88, IE0: 0x89, IT1: 0x8A, IE1: 0x8B, TR0: 0x8C, TF0: 0x8D, TR1: 0x8E, TF1: 0x8F,
    RI: 0x98, TI: 0x99, RB8: 0x9A, TB8: 0x9B, REN: 0x9C, SM2: 0x9D, SM1: 0x9E, SM0: 0x9F,
    EX0: 0xA8, ET0: 0xA9, EX1: 0xAA, ET1: 0xAB, ES: 0xAC, EA: 0xAF,
    RXD: 0xB0, TXD: 0xB1, INT0: 0xB2, INT1: 0xB3, T0: 0xB4, T1: 0xB5, WR: 0xB6, RD: 0xB7,
    PX0: 0xB8, PT0: 0xB9, PX1: 0xBA, PT1: 0xBB, PS: 0xBC,
    P: 0xD0, OV: 0xD2, RS0: 0xD3, RS1: 0xD4, F0: 0xD5, AC: 0xD6, CY: 0xD7 };
  // what Keil's REG52.INC adds to the 8051 set (the file defines everything again, so it needs $NOMOD51 first)
  const SFR52 = { T2CON: 0xC8, RCAP2L: 0xCA, RCAP2H: 0xCB, TL2: 0xCC, TH2: 0xCD };
  const BIT52 = { ET2: 0xAD, PT2: 0xBD, T2EX: 0x91, T2: 0x90, TF2: 0xCF, EXF2: 0xCE, RCLK: 0xCD, TCLK: 0xCC,
    EXEN2: 0xCB, TR2: 0xCA, C_T2: 0xC9, CP_RL2: 0xC8 };

  // ------------------------------------------------------------------ the instruction set
  // Operand patterns: register forms are written as themselves; '#' = 8-bit immediate, '#16' = 16-bit immediate,
  // 'dir' = data address, 'bit' = bit address, '/bit' = complemented bit, 'rel' = relative target,
  // 'a11' = AJMP/ACALL target, 'a16' = LJMP/LCALL target, 'gen' = generic JMP/CALL target.
  // Codes: a number is the opcode; Rn and @Ri forms add the register number.
  const T = {
    ACALL: [[['a11'], 0x11]],
    ADD: [[['A', 'Rn'], 0x28], [['A', 'dir'], 0x25], [['A', '@Ri'], 0x26], [['A', '#'], 0x24]],
    ADDC: [[['A', 'Rn'], 0x38], [['A', 'dir'], 0x35], [['A', '@Ri'], 0x36], [['A', '#'], 0x34]],
    AJMP: [[['a11'], 0x01]],
    ANL: [[['A', 'Rn'], 0x58], [['A', 'dir'], 0x55], [['A', '@Ri'], 0x56], [['A', '#'], 0x54], [['dir', 'A'], 0x52],
      [['dir', '#'], 0x53], [['C', 'bit'], 0x82], [['C', '/bit'], 0xB0]],
    CALL: [[['gen'], 'CALL']],
    CJNE: [[['A', 'dir', 'rel'], 0xB5], [['A', '#', 'rel'], 0xB4], [['Rn', '#', 'rel'], 0xB8], [['@Ri', '#', 'rel'], 0xB6]],
    CLR: [[['A'], 0xE4], [['C'], 0xC3], [['bit'], 0xC2]],
    CPL: [[['A'], 0xF4], [['C'], 0xB3], [['bit'], 0xB2]],
    DA: [[['A'], 0xD4]],
    DEC: [[['A'], 0x14], [['Rn'], 0x18], [['dir'], 0x15], [['@Ri'], 0x16]],
    DIV: [[['AB'], 0x84]],
    DJNZ: [[['Rn', 'rel'], 0xD8], [['dir', 'rel'], 0xD5]],
    INC: [[['A'], 0x04], [['Rn'], 0x08], [['dir'], 0x05], [['@Ri'], 0x06], [['DPTR'], 0xA3]],
    JB: [[['bit', 'rel'], 0x20]], JBC: [[['bit', 'rel'], 0x10]], JNB: [[['bit', 'rel'], 0x30]],
    JC: [[['rel'], 0x40]], JNC: [[['rel'], 0x50]], JZ: [[['rel'], 0x60]], JNZ: [[['rel'], 0x70]],
    JMP: [[['@A+DPTR'], 0x73], [['gen'], 'JMP']],
    LCALL: [[['a16'], 0x12]], LJMP: [[['a16'], 0x02]],
    MOV: [[['A', 'Rn'], 0xE8], [['A', 'dir'], 0xE5], [['A', '@Ri'], 0xE6], [['A', '#'], 0x74],
      [['Rn', 'A'], 0xF8], [['Rn', 'dir'], 0xA8], [['Rn', '#'], 0x78],
      [['dir', 'A'], 0xF5], [['dir', 'Rn'], 0x88], [['dir', 'dir'], 0x85], [['dir', '@Ri'], 0x86], [['dir', '#'], 0x75],
      [['@Ri', 'A'], 0xF6], [['@Ri', 'dir'], 0xA6], [['@Ri', '#'], 0x76],
      [['C', 'bit'], 0xA2], [['bit', 'C'], 0x92], [['DPTR', '#16'], 0x90]],
    MOVC: [[['A', '@A+DPTR'], 0x93], [['A', '@A+PC'], 0x83]],
    MOVX: [[['A', '@Ri'], 0xE2], [['A', '@DPTR'], 0xE0], [['@Ri', 'A'], 0xF2], [['@DPTR', 'A'], 0xF0]],
    MUL: [[['AB'], 0xA4]],
    NOP: [[[], 0x00]],
    ORL: [[['A', 'Rn'], 0x48], [['A', 'dir'], 0x45], [['A', '@Ri'], 0x46], [['A', '#'], 0x44], [['dir', 'A'], 0x42],
      [['dir', '#'], 0x43], [['C', 'bit'], 0x72], [['C', '/bit'], 0xA0]],
    POP: [[['dir'], 0xD0]], PUSH: [[['dir'], 0xC0]],
    RET: [[[], 0x22]], RETI: [[[], 0x32]],
    RL: [[['A'], 0x23]], RLC: [[['A'], 0x33]], RR: [[['A'], 0x03]], RRC: [[['A'], 0x13]],
    SETB: [[['C'], 0xD3], [['bit'], 0xD2]],
    SJMP: [[['rel'], 0x80]],
    SUBB: [[['A', 'Rn'], 0x98], [['A', 'dir'], 0x95], [['A', '@Ri'], 0x96], [['A', '#'], 0x94]],
    SWAP: [[['A'], 0xC4]],
    XCH: [[['A', 'Rn'], 0xC8], [['A', 'dir'], 0xC5], [['A', '@Ri'], 0xC6]],
    XCHD: [[['A', '@Ri'], 0xD6]],
    XRL: [[['A', 'Rn'], 0x68], [['A', 'dir'], 0x65], [['A', '@Ri'], 0x66], [['A', '#'], 0x64], [['dir', 'A'], 0x62],
      [['dir', '#'], 0x63]],
  };
  const PAT_SIZE = { '#': 1, '#16': 2, dir: 1, bit: 1, '/bit': 1, rel: 1, a11: 1, a16: 2 };
  const EXPR_PATS = new Set(['#', '#16', 'dir', 'bit', '/bit', 'rel', 'a11', 'a16', 'gen']);
  const REGS = new Set(['A', 'AB', 'C', 'DPTR', 'PC', 'R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7']);
  const DIRECTIVES = new Set(['ORG', 'END', 'DB', 'DW', 'DS', 'DBIT', 'USING', 'NAME', 'CSEG', 'DSEG', 'BSEG', 'ISEG',
    'XSEG', 'EQU', 'SET', 'DATA', 'IDATA', 'XDATA', 'CODE', 'BIT', 'AT']);
  const SYMDEF = new Set(['EQU', 'SET', 'DATA', 'IDATA', 'XDATA', 'CODE', 'BIT']);
  const UNSUPPORTED = new Set(['SEGMENT', 'RSEG', 'PUBLIC', 'EXTRN', 'EXTERN', 'MACRO', 'ENDM', 'EXITM', 'REPT', 'IRP',
    'IRPC', 'LOCAL', 'IF', 'IFDEF', 'IFNDEF', 'ELSE', 'ELSEIF', 'ENDIF', 'INCLUDE']);
  const WORD_OPS = new Set(['MOD', 'SHL', 'SHR', 'AND', 'OR', 'XOR', 'NOT', 'HIGH', 'LOW', 'EQ', 'NE', 'LT', 'LE', 'GT', 'GE']);
  const RESERVED = new Set([...Object.keys(T), ...DIRECTIVES, ...REGS, ...WORD_OPS]);
  const REL = { EQ: 'EQ', '=': 'EQ', NE: 'NE', '<>': 'NE', LT: 'LT', '<': 'LT', LE: 'LE', '<=': 'LE', GT: 'GT', '>': 'GT',
    GE: 'GE', '>=': 'GE' };

  // ------------------------------------------------------------------ tokens
  // code may be two numbers joined by '+': A51 reports some faults twice (e.g. A4 then A9)
  class AsmError extends Error { constructor(code) { super(code); this.code = code; } }

  function parseNumber(s) {
    let m = /^0x([0-9a-f]+)$/i.exec(s);
    if (m) return parseInt(m[1], 16) & 0xFFFF;
    const last = s[s.length - 1].toUpperCase(), body = s.slice(0, -1);
    let digits, base;
    if (last === 'H') { digits = body; base = 16; }
    else if (last === 'B') { digits = body; base = 2; }
    else if (last === 'O' || last === 'Q') { digits = body; base = 8; }
    else if (last === 'D') { digits = body; base = 10; }
    else { digits = s; base = 10; }
    const ok = { 16: /^[0-9a-f]+$/i, 2: /^[01]+$/, 8: /^[0-7]+$/, 10: /^[0-9]+$/ }[base];
    if (!digits || !ok.test(digits)) throw new AsmError('A1');
    let v = 0;
    for (const ch of digits) v = (v * base + parseInt(ch, base)) % 0x10000;   // A51 keeps 16 bits
    return v;
  }

  function tokenize(text) {
    const toks = [];
    let i = 0;
    const n = text.length;
    while (i < n) {
      const ch = text[i];
      if (ch === ' ' || ch === '\t' || ch === '\f' || ch === '\v') { i++; continue; }
      if (ch === ';') break;
      const at = i;
      if (/[A-Za-z_?]/.test(ch)) {
        let j = i + 1;
        while (j < n && /[A-Za-z0-9_?]/.test(text[j])) j++;
        const s = text.slice(i, j);
        toks.push({ k: 'id', s, u: s.toUpperCase(), at });
        i = j;
      } else if (/[0-9]/.test(ch)) {
        let j = i + 1;
        while (j < n && /[A-Za-z0-9]/.test(text[j])) j++;
        toks.push({ k: 'num', s: text.slice(i, j), at });
        i = j;
      } else if (ch === "'" || ch === '"') {
        let j = i + 1, s = '';
        for (;;) {
          if (j >= n) throw new AsmError('S6');
          if (text[j] === ch) {
            if (text[j + 1] === ch) { s += ch; j += 2; continue; }
            break;
          }
          s += text[j++];
        }
        toks.push({ k: 'str', s, at });
        i = j + 1;
      } else {
        const two = text.substr(i, 2);
        if (two === '<=' || two === '>=' || two === '<>') { toks.push({ k: 'op', s: two, at }); i += 2; continue; }
        if ('+-*/()<>=,#@.$:'.includes(ch)) { toks.push({ k: 'op', s: ch, at }); i++; continue; }
        throw new AsmError('S5');
      }
    }
    return toks;
  }

  // string -> bytes the way A51 reads a UTF-8 file: one byte per character below 80H, UTF-8 for the rest
  function strBytes(s) {
    const out = [];
    for (const ch of s) {
      const c = ch.codePointAt(0);
      if (c < 0x80) out.push(c);
      else if (c < 0x800) out.push(0xC0 | (c >> 6), 0x80 | (c & 63));
      else if (c < 0x10000) out.push(0xE0 | (c >> 12), 0x80 | ((c >> 6) & 63), 0x80 | (c & 63));
      else out.push(0xF0 | (c >> 18), 0x80 | ((c >> 12) & 63), 0x80 | ((c >> 6) & 63), 0x80 | (c & 63));
    }
    return out;
  }

  // ------------------------------------------------------------------ expressions
  // Precedence, tightest first, as A51 evaluates it (ref/probes/exprs.a51, prec2.a51):
  //   HIGH LOW  |  * / MOD  |  + -  (unary + - only at the start of a sum)  |  SHL SHR  |
  //   EQ NE LT LE GT GE = <> < <= > >=  |  NOT  |  AND  |  OR XOR
  // The bit selector '.' binds tightest of all: P3.2+1 is bit 0B3H.
  function parseExpr(toks, pos) {
    let i = pos;
    const peek = () => toks[i];
    const isOp = (t, s) => t && ((t.k === 'op' && t.s === s) || (t.k === 'id' && t.u === s));
    function need() {                       // a factor is required here
      const t = peek();
      if (!t) throw new AsmError('A15');
      return t;
    }
    function prim() {
      const t = need();
      if (t.k === 'op' && t.s === '(') {
        i++;
        const e = orx();
        if (!isOp(peek(), ')')) throw new AsmError('A13');
        i++;
        return e;
      }
      if (t.k === 'num') { i++; return { k: 'num', v: parseNumber(t.s) }; }
      if (t.k === 'str') {
        i++;
        const b = strBytes(t.s);
        if (b.length === 0 || b.length > 2) throw new AsmError('A11');
        return { k: 'num', v: b.length === 1 ? b[0] : (b[0] << 8) | b[1] };
      }
      if (t.k === 'op' && t.s === '$') { i++; return { k: 'loc' }; }
      if (t.k === 'id' && !RESERVED.has(t.u)) { i++; return { k: 'sym', name: t.u, at: t.at }; }
      throw new AsmError('A9');
    }
    function post() {
      const a = prim();
      if (isOp(peek(), '.')) { i++; return { k: 'bit', a, b: prim() }; }
      return a;
    }
    function unx() {
      const t = peek();
      if (t && t.k === 'id' && (t.u === 'HIGH' || t.u === 'LOW')) { i++; need(); return { k: 'un', op: t.u, a: unx() }; }
      return post();
    }
    function mulx() {
      let a = unx();
      for (;;) {
        const t = peek();
        if (isOp(t, '*') || isOp(t, '/') || isOp(t, 'MOD')) { i++; a = { k: 'bin', op: t.k === 'id' ? t.u : t.s, a, b: unx() }; }
        else return a;
      }
    }
    function addx() {
      let a;
      const t0 = peek();
      if (isOp(t0, '-') || isOp(t0, '+')) { i++; need(); const m = mulx(); a = t0.s === '-' ? { k: 'un', op: 'NEG', a: m } : m; }
      else a = mulx();
      for (;;) {
        const t = peek();
        if (isOp(t, '+') || isOp(t, '-')) { i++; a = { k: 'bin', op: t.s, a, b: mulx() }; }
        else return a;
      }
    }
    function shx() {
      let a = addx();
      for (;;) {
        const t = peek();
        if (isOp(t, 'SHL') || isOp(t, 'SHR')) { i++; a = { k: 'bin', op: t.u, a, b: addx() }; }
        else return a;
      }
    }
    function relx() {
      let a = shx();
      for (;;) {
        const t = peek();
        const r = t && REL[t.k === 'id' ? t.u : t.s];
        if (r && (t.k === 'op' || t.k === 'id')) { i++; a = { k: 'bin', op: r, a, b: shx() }; }
        else return a;
      }
    }
    function notx() {
      const t = peek();
      if (isOp(t, 'NOT')) { i++; need(); return { k: 'un', op: 'NOT', a: relx() }; }
      return relx();
    }
    function andx() {
      let a = notx();
      while (isOp(peek(), 'AND')) { i++; a = { k: 'bin', op: 'AND', a, b: notx() }; }
      return a;
    }
    function orx() {
      let a = andx();
      for (;;) {
        const t = peek();
        if (isOp(t, 'OR') || isOp(t, 'XOR')) { i++; a = { k: 'bin', op: t.u, a, b: andx() }; }
        else return a;
      }
    }
    const e = orx();
    return { e, next: i };
  }

  // ------------------------------------------------------------------ operands
  // one operand: { kind: 'reg', r: 'A'|'Rn'|..., n } or { kind: 'imm'|'not'|'expr', e }
  function parseOperand(toks) {
    if (toks.length === 0) throw new AsmError('A9');
    const t = toks[0];
    if (t.k === 'op' && t.s === '#') {
      if (toks.length === 1) throw new AsmError('A15');
      return { kind: 'imm', e: wholeExpr(toks, 1) };
    }
    if (t.k === 'op' && t.s === '/') return { kind: 'not', e: wholeExpr(toks, 1) };
    if (t.k === 'op' && t.s === '@') {
      const r = toks[1];
      if (r && r.k === 'id' && (r.u === 'R0' || r.u === 'R1') && toks.length === 2) return { kind: 'reg', r: '@Ri', n: +r.u[1] };
      if (r && r.k === 'id' && r.u === 'DPTR' && toks.length === 2) return { kind: 'reg', r: '@DPTR' };
      if (r && r.k === 'id' && r.u === 'A' && toks.length === 4 && toks[2].k === 'op' && toks[2].s === '+' && toks[3].k === 'id') {
        if (toks[3].u === 'DPTR') return { kind: 'reg', r: '@A+DPTR' };
        if (toks[3].u === 'PC') return { kind: 'reg', r: '@A+PC' };
      }
      throw new AsmError('A4+A9');
    }
    if (t.k === 'id' && REGS.has(t.u)) {
      if (toks.length > 1) throw new AsmError(toks[1].k === 'op' ? 'A38+A9' : 'A9');
      if (/^R[0-7]$/.test(t.u)) return { kind: 'reg', r: 'Rn', n: +t.u[1] };
      return { kind: 'reg', r: t.u };
    }
    return { kind: 'expr', e: wholeExpr(toks, 0) };
  }
  function wholeExpr(toks, from, leftoverCode = 'A9') {
    const { e, next } = parseExpr(toks, from);
    if (next < toks.length) throw new AsmError(leftoverCode);
    return e;
  }
  function splitCommas(toks) {
    const parts = [[]];
    let depth = 0;
    for (const t of toks) {
      if (t.k === 'op' && t.s === '(') depth++;
      if (t.k === 'op' && t.s === ')') depth--;
      if (t.k === 'op' && t.s === ',' && depth === 0) parts.push([]);
      else parts[parts.length - 1].push(t);
    }
    return parts;
  }

  // ------------------------------------------------------------------ statements
  function parseLine(text) {
    const st = { label: null, kind: 'empty' };
    let toks;
    try { toks = tokenize(text); } catch (e) { st.err = e.code.split('+'); st.kind = 'bad'; return st; }
    if (toks.length === 0) return st;
    let i = 0;
    if (toks[0].k === 'id' && toks[1] && toks[1].k === 'op' && toks[1].s === ':') {
      if (RESERVED.has(toks[0].u)) { st.err = ['A5', 'A9']; st.kind = 'bad'; return st; }
      st.label = toks[0];
      i = 2;
      if (toks[i] && toks[i].k === 'id' && toks[i + 1] && toks[i + 1].k === 'op' && toks[i + 1].s === ':') {
        st.err = ['A7']; st.kind = 'bad'; return st;
      }
    } else if (toks[0].k === 'num' && toks[1] && toks[1].k === 'op' && toks[1].s === ':') {
      st.err = ['A9', 'A7']; st.kind = 'bad'; return st;
    }
    const rest = toks.slice(i);
    if (rest.length === 0) { st.kind = 'label'; return st; }
    const h = rest[0];
    try {
      if (h.k !== 'id') throw new AsmError('A9');
      if (T[h.u]) {
        st.kind = 'insn'; st.mn = h.u;
        const args = rest.slice(1);
        if (args.length === 0) { st.ops = []; return st; }
        const parts = splitCommas(args);
        if (parts.some(p => p.length === 0)) {
          // "MOV A," -> A38 and A9 like A51 (no form with that many operands); "MOV A,#1," -> A9 only
          const n = parts.filter(p => p.length).length;
          st.err = T[h.u].some(([pats]) => pats.length === n) ? ['A9'] : ['A38', 'A9'];
          st.kind = 'bad'; return st;
        }
        st.ops = parts.map(parseOperand);
        return st;
      }
      if (UNSUPPORTED.has(h.u) || (rest[1] && rest[1].k === 'id' && (rest[1].u === 'SEGMENT' || rest[1].u === 'MACRO'))) {
        throw new AsmError('S3');
      }
      if (DIRECTIVES.has(h.u) && !SYMDEF.has(h.u)) {
        st.kind = 'dir'; st.dir = h.u;
        const args = rest.slice(1);
        if (st.label && !['DB', 'DW', 'DS', 'DBIT'].includes(h.u)) { st.kind = 'label'; st.err = ['A9']; return st; }
        parseDirective(st, args);
        return st;
      }
      if (rest[1] && rest[1].k === 'id' && SYMDEF.has(rest[1].u)) {
        if (st.label || RESERVED.has(h.u)) throw new AsmError('A9');
        st.kind = 'symdef'; st.name = h; st.def = rest[1].u;
        if (rest.length < 3) throw new AsmError('A15');
        st.e = wholeExpr(rest, 2);
        return st;
      }
      throw new AsmError('A9');
    } catch (e) {
      if (!(e instanceof AsmError)) throw e;
      st.err = e.code.split('+');
      st.kind = st.label ? 'label' : 'bad';
      return st;
    }
  }

  function parseDirective(st, args) {
    const d = st.dir;
    if (d === 'END' || d === 'NAME') return;
    if (d === 'DB' || d === 'DW') {
      st.items = [];
      if (args.length === 0) return;
      const parts = splitCommas(args);
      parts.forEach((p, k) => {
        if (p.length === 0) throw new AsmError(k === parts.length - 1 ? 'A9' : 'A15');
        if (d === 'DB' && p[0].k === 'str' && (p.length === 1 || strBytes(p[0].s).length !== 1)) {
          if (p.length > 1) throw new AsmError('A34');
          st.items.push({ str: strBytes(p[0].s) });
        } else st.items.push({ e: wholeExpr(p, 0, 'A34') });
      });
      return;
    }
    if (d === 'CSEG' || d === 'DSEG' || d === 'BSEG' || d === 'ISEG' || d === 'XSEG') {
      if (args.length === 0) return;
      if (args[0].k !== 'id' || args[0].u !== 'AT') throw new AsmError('A9');
      if (args.length === 1) throw new AsmError('A15');
      st.at = wholeExpr(args, 1);
      return;
    }
    // ORG, DS, DBIT, USING: one expression
    if (args.length === 0) throw new AsmError('A15');
    st.e = wholeExpr(args, 0);
  }

  // ------------------------------------------------------------------ the assembler
  function assemble(source, opts) {
    opts = opts || {};
    const name = opts.name || 'source.a51';
    const srcLines = String(source).replace(/\r\n?/g, '\n').split('\n');
    if (srcLines.length > 1 && srcLines[srcLines.length - 1] === '') srcLines.pop();
    const messages = [];
    const msgSeen = new Set();
    const report = (line, code) => {
      const key = line + ':' + code;
      if (msgSeen.has(key)) return;
      msgSeen.add(key);
      messages.push({ line, code, severity: WARNINGS.has(code) ? 'warning' : 'error', text: MSG[code] });
    };

    // ---- read the lines: controls, END, statements
    const stmts = [];
    let mod51 = true, endSeen = false, afterEndWarned = false;
    const includes = [];           // { at: statement index, set: 'REG51'|'REG52' }
    for (let k = 0; k < srcLines.length; k++) {
      const line = k + 1, text = srcLines[k];
      if (endSeen) {
        if (!afterEndWarned && text.replace(/;.*/, '').trim()) { report(line, 'A73'); afterEndWarned = true; }
        continue;
      }
      const ctl = /^\s*\$(.*)$/.exec(text);
      if (ctl) {
        const c = ctl[1].replace(/;.*/, '').trim().toUpperCase();
        const inc = /^(?:INCLUDE|IC)\s*\(\s*([^)]+?)\s*\)$/.exec(c);
        if (c === 'NOMOD51' || c === 'NOMO') mod51 = false;
        else if (c === 'MOD51' || c === 'MO') mod51 = true;
        else if (inc) {
          const f = inc[1].replace(/^.*[\\/]/, '');
          if (f === 'REG51.INC' || f === 'REG52.INC') includes.push({ at: stmts.length, set: f.slice(0, 5), line });
          else report(line, 'S9');
        } else if (!/^(NO)?(LIST|SYMBOLS|SB|XREF|XR|PRINT|PR|OBJECT|OJ|DEBUG|DB|PAGING|PI|GEN|GO|COND|CO|MACRO|MR|REGISTERBANK|RB)\b|^(TITLE|TT|PAGELENGTH|PL|PAGEWIDTH|PW|EJECT|EJ|SAVE|SA|RESTORE|RS|DATE|DA|ERRORPRINT|EP)\b/.test(c)) {
          report(line, 'A68');
        }
        continue;
      }
      const st = parseLine(text);
      st.line = line;
      stmts.push(st);
      if (st.kind === 'dir' && st.dir === 'END') endSeen = true;
    }
    if (!endSeen) report(srcLines.length || 1, 'A41');
    // A51 continues a segment given without AT oddly when another AT segment of the same kind comes later in the
    // file (ref/probes/segs.a51: NEXT lands at the base of the later segment). Ask for the address instead.
    stmts.forEach((st, k) => {
      if (st.kind !== 'dir' || !/^[CDBIX]SEG$/.test(st.dir) || st.at) return;
      if (stmts.slice(k + 1).some(o => o.kind === 'dir' && o.dir === st.dir && o.at)) report(st.line, 'S10');
    });

    // ---- the symbol table
    const sym = new Map();           // NAME -> { name, type, value, line (defining line, 0 = predefined), kind }
    const predef = (tab, type) => { for (const [n, v] of Object.entries(tab)) sym.set(n, { name: n, type, value: v, line: 0, kind: 'pre' }); };
    if (mod51) { predef(SFR51, 'D'); predef(BIT51, 'B'); }
    const incAt = new Map(includes.map(x => [x.at, x]));

    // ---- evaluation
    // A value is { v: 16-bit number, t: type }, types as in A51's symbol table: C code, D data, I idata,
    // X xdata, B bit, N a plain number. fwd = it used a symbol defined further down (its value from the last pass),
    // unknown = a symbol not defined anywhere yet.
    // ctx: { final, loc, locType, prev (values of the last pass), definedNow (names defined so far this pass), bank }
    function evalE(e, ctx) {
      switch (e.k) {
        case 'num': return { v: e.v, t: 'N' };
        case 'loc': return { v: ctx.loc & 0xFFFF, t: ctx.locType };
        case 'sym': {
          const s = sym.get(e.name);
          if (s && (s.kind === 'pre' || ctx.definedNow.has(e.name))) return { v: s.value, t: s.type };
          if (ctx.prev.has(e.name)) { const p = ctx.prev.get(e.name); return { v: p.value, t: p.type, fwd: true }; }
          if (/^AR[0-7]$/.test(e.name)) {          // absolute register addresses, set by USING
            if (ctx.bank === null) { if (ctx.final) throw new AsmError('A53'); return { v: 0, t: 'D' }; }
            return { v: ctx.bank * 8 + +e.name[2], t: 'D' };
          }
          if (ctx.final) throw new AsmError('A45');
          return { v: 0, t: 'N', unknown: true, fwd: true };
        }
        case 'un': {
          const a = evalE(e.a, ctx);
          const v = e.op === 'NEG' ? -a.v : e.op === 'NOT' ? ~a.v : e.op === 'HIGH' ? (a.v >> 8) & 0xFF : a.v & 0xFF;
          return { v: v & 0xFFFF, t: 'N', unknown: a.unknown, fwd: a.fwd };
        }
        case 'bin': {
          const a = evalE(e.a, ctx), b = evalE(e.b, ctx);
          let v, t = 'N';
          switch (e.op) {
            case '+': v = a.v + b.v; t = a.t === 'N' ? b.t : b.t === 'N' ? a.t : 'N'; break;
            case '-': v = a.v - b.v; t = b.t === 'N' ? a.t : 'N'; break;
            case '*': v = a.v * b.v; break;
            case '/': if (b.v === 0) { if (ctx.final) throw new AsmError('A16'); v = 0; } else v = Math.floor(a.v / b.v); break;
            case 'MOD': if (b.v === 0) { if (ctx.final) throw new AsmError('A16'); v = 0; } else v = a.v % b.v; break;
            case 'SHL': v = b.v >= 16 ? 0 : a.v << b.v; break;
            case 'SHR': v = b.v >= 16 ? 0 : a.v >>> b.v; break;
            case 'AND': v = a.v & b.v; break;
            case 'OR': v = a.v | b.v; break;
            case 'XOR': v = a.v ^ b.v; break;
            case 'EQ': v = +(a.v === b.v); break;
            case 'NE': v = +(a.v !== b.v); break;
            case 'LT': v = +(a.v < b.v); break;
            case 'LE': v = +(a.v <= b.v); break;
            case 'GT': v = +(a.v > b.v); break;
            case 'GE': v = +(a.v >= b.v); break;
          }
          return { v: v & 0xFFFF, t, unknown: a.unknown || b.unknown, fwd: a.fwd || b.fwd };
        }
        case 'bit': {
          const a = evalE(e.a, ctx), b = evalE(e.b, ctx);
          const r = { t: 'B', unknown: a.unknown || b.unknown, fwd: a.fwd || b.fwd };
          if (r.unknown && !ctx.final) return Object.assign(r, { v: 0 });
          if ((a.t !== 'N' && a.t !== 'D') || !((a.v >= 0x20 && a.v <= 0x2F) || (a.v >= 0x80 && a.v <= 0xFF && (a.v & 7) === 0))) {
            if (ctx.final) throw new AsmError('A17');
            return Object.assign(r, { v: 0 });
          }
          if (b.t !== 'N' || b.v > 7) { if (ctx.final) throw new AsmError('A18'); return Object.assign(r, { v: 0 }); }
          r.v = a.v < 0x80 ? (a.v - 0x20) * 8 + b.v : a.v + b.v;
          return r;
        }
      }
      throw new Error('bad node');
    }

    // ---- layout: run the program text until every address and value stays where it was
    const image = new Uint8Array(65536), used = new Uint8Array(65536);
    const owners = new Map();         // NAME -> { line, kind } of the statement that defined it first
    let prev = new Map();             // NAME -> { value, type } from the last pass
    let genPrev = new Map();          // statement index -> size of a generic JMP/CALL in the last pass
    const MAX_PASSES = 40;
    for (let pass = 0; ; pass++) {
      const r = runPass(false);
      const stable = pass > 0 && r.values.size === prev.size && [...r.values].every(([k, v]) => {
        const p = prev.get(k); return p && p.value === v.value && p.type === v.type;
      }) && [...r.gen].every(([k, v]) => genPrev.get(k) === v);
      prev = r.values; genPrev = r.gen;
      if (stable) break;
      if (pass === MAX_PASSES) { report(1, 'S8'); break; }
    }
    const finalLines = runPass(true).lines;

    function runPass(final) {
      const values = new Map(), gen = new Map(), lines = [];
      const definedNow = new Set();
      const segs = { C: { base: 0, loc: 0 }, D: null, I: null, X: null, B: null };
      let cur = 'C', bank = null;
      const ctx = { final, prev, definedNow, loc: 0, locType: 'C', bank: null };
      const err = (line, code) => { if (final) report(line, code); };

      // A51: a label may not reuse any name (A8); EQU, DATA, BIT ... may not reuse one either (A10), except that
      // SET may be repeated and EQU may follow SET (ref/probes/redef.a51)
      function define(line, n, shown, type, value, kind) {
        const s = sym.get(n);
        if (s && s.kind === 'pre') { err(line, kind === 'label' ? 'A8' : 'A10'); return; }
        const o = owners.get(n);
        if (!o) owners.set(n, { line, kind });
        else if (o.line !== line && !(o.kind === 'set' && (kind === 'set' || kind === 'equ'))) {
          err(line, kind === 'label' ? 'A8' : 'A10');
          return;
        }
        sym.set(n, { name: s ? s.name : shown, type, value: value & 0xFFFF, line, kind });
        definedNow.add(n);
        values.set(n, { value: value & 0xFFFF, type });
      }

      for (let si = 0; si < stmts.length; si++) {
        const inc = incAt.get(si);
        if (inc) {
          const tabs = inc.set === 'REG52' ? [[SFR51, 'D'], [BIT51, 'B'], [SFR52, 'D'], [BIT52, 'B']] : [[SFR51, 'D'], [BIT51, 'B']];
          for (const [tab, type] of tabs) for (const [n, v] of Object.entries(tab)) define(inc.line, n, n, type, v, 'inc');
        }
        const st = stmts[si];
        const line = st.line;
        if (st.err && final) st.err.forEach(c => report(line, c));
        if (!segs[cur]) segs[cur] = { base: 0, loc: 0 };
        const s = segs[cur];
        ctx.loc = s.loc; ctx.locType = cur; ctx.bank = bank;
        const out = { line, addr: s.loc, bytes: [], seg: cur };
        const tryEv = (e) => {
          try { return evalE(e, ctx); } catch (x) { if (!(x instanceof AsmError)) throw x; x.code.split('+').forEach(c => err(line, c)); return null; }
        };

        if (st.label) { define(line, st.label.u, st.label.s, cur, s.loc, 'label'); out.label = true; }
        if (st.kind === 'symdef') {
          const r = tryEv(st.e);
          if (r) {
            const want = { DATA: 'D', IDATA: 'I', XDATA: 'X', CODE: 'C', BIT: 'B' }[st.def];
            if (want && r.t !== 'N' && r.t !== want) err(line, 'A48');
            else {
              const type = want || r.t;
              define(line, st.name.u, st.name.s, type, r.v, st.def === 'SET' ? 'set' : 'equ');
              out.value = { v: r.v, t: type };
            }
          }
        } else if (st.kind === 'dir') {
          const d = st.dir;
          if (d === 'ORG') {
            const r = tryEv(st.e);
            if (r) { if (r.v < s.base) err(line, 'A27'); else s.loc = r.v; }
            out.addr = s.loc; out.org = true;
          } else if (d === 'CSEG' || d === 'DSEG' || d === 'BSEG' || d === 'ISEG' || d === 'XSEG') {
            cur = d[0];
            if (st.at) { const r = tryEv(st.at); const base = r ? r.v : 0; segs[cur] = { base, loc: base }; }
            else if (!segs[cur]) segs[cur] = { base: 0, loc: 0 };
            out.seg = cur; out.segDir = true;
          } else if (d === 'USING') {
            const r = tryEv(st.e);
            if (r) { if (r.fwd) err(line, 'A21'); else if (r.v > 3) err(line, 'A36'); else bank = r.v; }
          } else if (d === 'DS' || d === 'DBIT') {
            if ((d === 'DBIT') !== (cur === 'B')) err(line, 'A37');
            else {
              const r = tryEv(st.e);
              let n = 0;
              if (r) { if (r.fwd) err(line, 'A21'); n = r.v; }
              s.loc += n;
              out.reserve = n;
              if (s.loc > { D: 0x80, I: 0x100, B: 0x80, X: 0x10000, C: 0x10000 }[cur]) err(line, 'A29');
            }
          } else if (d === 'DB' || d === 'DW') {
            if (cur !== 'C') err(line, 'A37');
            else {
              for (const it of st.items) {
                if (it.str) { out.bytes.push(...it.str); continue; }
                ctx.loc = s.loc + out.bytes.length;
                const r = tryEv(it.e);
                const v = r ? r.v : 0;
                if (d === 'DB') { if (r && final) check8(v, line); out.bytes.push(v & 0xFF); }
                else out.bytes.push((v >> 8) & 0xFF, v & 0xFF);
              }
            }
          }
        } else if (st.kind === 'insn') {
          if (cur !== 'C') err(line, 'A37');
          else out.bytes = encode(st, s.loc, ctx, final, line, si, gen);
        }
        if (out.bytes.length) {
          out.addr = s.loc;
          if (final) {
            for (let k = 0; k < out.bytes.length; k++) {
              const a = s.loc + k;
              if (a > 0xFFFF) { report(line, 'A29'); break; }
              if (used[a]) report(line, 'S4');
              image[a] = out.bytes[k];
              used[a] = 1;
            }
          }
          s.loc += out.bytes.length;
        }
        lines.push(out);
      }
      return { values, gen, lines };
    }

    function check8(v, line) {
      const hi = v >> 8;
      if (hi !== 0 && hi !== 0xFF) report(line, 'A52');
    }

    // ---- one instruction -> bytes
    function encode(st, addr, ctx, final, line, si, gen) {
      const forms = T[st.mn];
      const ops = st.ops;
      const err = (code) => { if (final) report(line, code); };
      const match = forms.find(([pats]) => pats.length === ops.length && pats.every((p, k) => fits(p, ops[k])));
      if (!match) {
        if (final) {
          // A51 evaluates the operands first: an undefined symbol or a missing USING is reported instead
          let evalErr = null;
          ctx.loc = addr;
          for (const o of ops) if (o.e && !evalErr) {
            try { evalE(o.e, ctx); } catch (x) { if (!(x instanceof AsmError)) throw x; evalErr = x.code; }
          }
          if (evalErr) evalErr.split('+').forEach(err);
          else report(line, mismatchCode(forms, ops, st.mn));
        }
        return [];
      }
      const [pats, opc] = match;
      if (opc === 'JMP' || opc === 'CALL') return generic(opc, ops[0], addr, ctx, final, line, si, gen);
      let size = 1 + pats.reduce((n, p) => n + (PAT_SIZE[p] || 0), 0);
      const bytes = [typeof opc === 'number' ? opc : 0];
      const after = [];
      ctx.loc = addr;
      let first = bytes;
      for (let k = 0; k < pats.length; k++) {
        const p = pats[k], o = ops[k];
        if (p === 'Rn' || p === '@Ri') { first[0] += o.n; continue; }
        if (!EXPR_PATS.has(p)) continue;
        let r;
        try { r = evalE(o.e, ctx); } catch (x) { if (!(x instanceof AsmError)) throw x; x.code.split('+').forEach(err); r = { v: 0, t: 'N' }; }
        switch (p) {
          case '#': if (final) check8(r.v, line); after.push(r.v & 0xFF); break;
          case '#16': after.push((r.v >> 8) & 0xFF, r.v & 0xFF); break;
          case 'dir':
            if (final && r.t !== 'N' && r.t !== 'D') err('A48');
            else if (final && r.v > 0xFF) err('S1');
            after.push(r.v & 0xFF); break;
          case 'bit': case '/bit':
            if (final && r.t !== 'N' && r.t !== 'B') err('A48');
            else if (final && r.v > 0xFF) err('S2');
            after.push(r.v & 0xFF); break;
          case 'rel': {
            if (final && r.t !== 'N' && r.t !== 'C') err('A46');
            const off = r.v - (addr + size);
            if (final && (off < -128 || off > 127)) err('A51');
            after.push(off & 0xFF); break;
          }
          case 'a11': {
            if (final && r.t !== 'N' && r.t !== 'C') err('A46');
            if (final && ((addr + 2) & 0xF800) !== (r.v & 0xF800)) err('A51');
            first[0] |= ((r.v >> 8) & 7) << 5;
            after.push(r.v & 0xFF); break;
          }
          case 'a16':
            if (final && r.t !== 'N' && r.t !== 'C') err('A46');
            after.push((r.v >> 8) & 0xFF, r.v & 0xFF); break;
        }
      }
      // MOV direct,direct is the one instruction whose bytes run source first: 85 src dst
      if (opc === 0x85) after.reverse();
      return bytes.concat(after);
    }

    // generic JMP / CALL: the shortest form for the target. A target not seen yet counts as LJMP/LCALL in the
    // first pass; later passes shrink it until nothing moves (this matches A51 on ref/probes/gj/*.a51).
    function generic(kind, op, addr, ctx, final, line, si, gen) {
      ctx.loc = addr;
      let r;
      try { r = evalE(op.e, ctx); } catch (x) { if (!(x instanceof AsmError)) throw x; if (final) x.code.split('+').forEach(c => report(line, c)); r = { v: 0, t: 'N' }; }
      if (final && r.t !== 'N' && r.t !== 'C') report(line, 'A46');
      const t = r.v;
      let bytes;
      if (r.unknown) bytes = kind === 'JMP' ? [0x02, 0, 0] : [0x12, 0, 0];
      else if (kind === 'JMP' && t - (addr + 2) >= -128 && t - (addr + 2) <= 127) bytes = [0x80, (t - (addr + 2)) & 0xFF];
      else if (((addr + 2) & 0xF800) === (t & 0xF800)) bytes = [(kind === 'JMP' ? 0x01 : 0x11) | (((t >> 8) & 7) << 5), t & 0xFF];
      else bytes = [kind === 'JMP' ? 0x02 : 0x12, (t >> 8) & 0xFF, t & 0xFF];
      gen.set(si, bytes.length);
      return bytes;
    }

    function fits(p, o) {
      if (EXPR_PATS.has(p)) {
        if (p === '#' || p === '#16') return o.kind === 'imm';
        if (p === '/bit') return o.kind === 'not';
        return o.kind === 'expr';
      }
      return o.kind === 'reg' && o.r === p;
    }
    // which error A51 gives when no form matches (checked against ref/probes/misc.a51, ops3.a51)
    function mismatchCode(forms, ops, mn) {
      if (!forms.some(([p]) => p.length === ops.length)) return 'A38';
      // MOV checks its destination first: MOV C,#1 and MOV DPTR,A are 'invalid register' in A51
      if (mn === 'MOV' && ops[0].kind === 'reg' && (ops[0].r === 'C' || ops[0].r === 'DPTR')) return 'A40';
      let cand = forms.filter(([p]) => p.length === ops.length);
      for (let k = 0; k < ops.length; k++) {
        const ok = cand.filter(([p]) => fits(p[k], ops[k]));
        if (ok.length === 0) {
          const allowed = cand.map(([p]) => p[k]);
          const regAllowed = allowed.some(p => !EXPR_PATS.has(p));
          const plainAllowed = allowed.some(p => EXPR_PATS.has(p) && p !== '#' && p !== '#16');
          const o = ops[k];
          if (o.kind === 'reg' && o.r[0] === '@' && allowed.every(p => p.startsWith('@A+'))) return 'A39';
          if (o.kind === 'reg') return regAllowed ? 'A40' : 'A22';
          // an address where only A or #n fits: 'register expected' (ANL 30H,30H); where only #n fits: A22
          if (o.kind === 'expr') return regAllowed ? 'A39' : 'A22';
          // #n or /bit where it does not fit: A22 if an address would, else 'register expected' (MOVX @R0,#1)
          return plainAllowed ? 'A22' : 'A39';
        }
        cand = ok;
      }
      return 'A9';
    }

    // ---- results
    messages.sort((a, b) => a.line - b.line);
    const ok = !messages.some(m => m.severity === 'error');
    let size = 0, top = 0;
    for (let a = 0; a < 65536; a++) if (used[a]) { size++; top = a + 1; }
    const addrLine = {};
    const lines = [];
    for (const l of finalLines) if (l.bytes.length) {
      lines.push({ line: l.line, addr: l.addr, bytes: l.bytes.slice() });
      if (!(l.addr in addrLine)) addrLine[l.addr] = l.line;
    }
    const symbols = {};
    for (const [n, s] of sym) if (s.kind !== 'pre' && s.kind !== 'inc') symbols[n] = { name: s.name, type: s.type, value: s.value };
    return {
      ok, messages, image, used, size, top, lines, addrLine, symbols,
      hex: ok ? toHex(image, used) : null,
      listing: makeListing(name, srcLines, finalLines, messages, symbols),
    };
  }

  // ------------------------------------------------------------------ Intel HEX, records of up to 16 bytes like OH51
  function toHex(image, used) {
    const out = [];
    let a = 0;
    while (a < 65536) {
      if (!used[a]) { a++; continue; }
      let n = 0;
      while (n < 16 && a + n < 65536 && used[a + n]) n++;
      const rec = [n, (a >> 8) & 0xFF, a & 0xFF, 0];
      for (let k = 0; k < n; k++) rec.push(image[a + k]);
      const sum = (-rec.reduce((s, b) => s + b, 0)) & 0xFF;
      out.push(':' + rec.concat(sum).map(b => b.toString(16).toUpperCase().padStart(2, '0')).join(''));
      a += n;
    }
    out.push(':00000001FF');
    return out.join('\r\n') + '\r\n';
  }

  function readHex(text) {
    const image = new Uint8Array(65536), used = new Uint8Array(65536);
    let ext = 0;
    for (const raw of String(text).split(/\r?\n/)) {
      const line = raw.trim();
      if (!line) continue;
      if (line[0] !== ':') throw new Error('not an Intel HEX line: ' + line.slice(0, 20));
      const b = [];
      for (let i = 1; i < line.length; i += 2) b.push(parseInt(line.substr(i, 2), 16));
      if (b.some(Number.isNaN) || b.length < 5 || b.length !== b[0] + 5) throw new Error('bad Intel HEX record: ' + line.slice(0, 20));
      if ((b.reduce((s, x) => s + x, 0) & 0xFF) !== 0) throw new Error('Intel HEX checksum wrong: ' + line.slice(0, 20));
      const n = b[0], addr = (b[1] << 8) | b[2], type = b[3];
      if (type === 0) for (let k = 0; k < n; k++) { const a = ext + addr + k; if (a < 65536) { image[a] = b[4 + k]; used[a] = 1; } }
      else if (type === 1) break;
      else if (type === 2) ext = ((b[4] << 8) | b[5]) << 4;
      else if (type === 4) ext = ((b[4] << 8) | b[5]) << 16;
    }
    let size = 0, top = 0;
    for (let a = 0; a < 65536; a++) if (used[a]) { size++; top = a + 1; }
    return { image, used, size, top };
  }

  // ------------------------------------------------------------------ listing in the shape of A51's .lst
  function makeListing(name, srcLines, lines, messages, symbols) {
    const byLine = new Map();
    for (const l of lines) byLine.set(l.line, l);
    const msgs = new Map();
    for (const m of messages) { if (!msgs.has(m.line)) msgs.set(m.line, []); msgs.get(m.line).push(m); }
    const h4 = v => v.toString(16).toUpperCase().padStart(4, '0');
    const hx = b => b.map(x => x.toString(16).toUpperCase().padStart(2, '0')).join('');
    const out = ['STC STUDIO 8051 ASSEMBLER (A51 COMPATIBLE)    ' + name, '', 'LOC  OBJ            LINE     SOURCE', ''];
    for (let k = 0; k < srcLines.length; k++) {
      const n = k + 1, l = byLine.get(n), src = srcLines[k].replace(/\t/g, '    ');
      const ln = String(n).padStart(6);
      if (l && l.bytes.length) {
        for (let j = 0; j < l.bytes.length; j += 4) {
          const chunk = l.bytes.slice(j, j + 4);
          out.push((h4(l.addr + j) + ' ' + hx(chunk)).padEnd(18) + (j === 0 ? ln + '     ' + src : ''));
        }
      } else if (l && l.value) out.push(('  ' + h4(l.value.v)).padEnd(18) + ln + '     ' + src);
      else if (l && (l.org || l.reserve !== undefined || l.label)) out.push(h4(l.addr).padEnd(18) + ln + '     ' + src);
      else if (l && l.segDir) out.push('----'.padEnd(18) + ln + '     ' + src);
      else out.push(''.padEnd(18) + ln + '     ' + src);
      for (const m of msgs.get(n) || []) out.push('*** ' + m.severity.toUpperCase() + ' #' + m.code + ' IN ' + n + ' (' + name + ', LINE ' + n + '): ' + m.text);
    }
    out.push('', 'SYMBOL TABLE LISTING', '------ ----- -------', '', 'N A M E             T Y P E  V A L U E');
    const tn = { C: 'C ADDR', D: 'D ADDR', I: 'I ADDR', X: 'X ADDR', B: 'B ADDR', N: 'NUMB  ' };
    for (const s of Object.values(symbols).sort((a, b) => a.name.toUpperCase() < b.name.toUpperCase() ? -1 : 1)) {
      const v = s.type === 'B' ? (s.value < 0x80 ? h4(0x20 + (s.value >> 3)) + 'H.' + (s.value & 7) : h4(s.value & 0xF8) + 'H.' + (s.value & 7)) : h4(s.value) + 'H';
      out.push((s.name + ' ').padEnd(20, '.') + ' ' + tn[s.type] + '   ' + v);
    }
    const ne = messages.filter(m => m.severity === 'error').length, nw = messages.length - ne;
    out.push('', 'ASSEMBLY COMPLETE.  ' + nw + ' WARNING(S), ' + ne + ' ERROR(S)');
    return out.join('\n') + '\n';
  }

  return { assemble, readHex, toHex, tokenize, MSG, version: '0.1' };
}));
