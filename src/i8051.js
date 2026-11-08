/* i8051.js — a faithful 8051 / STC89C52RC assembler + emulator.
 * Decodes REAL 8051 machine code (so disassembly bytes match Keil: 74 25, 78 10, 89, 80 FE ...).
 * Used by the CSSA Topic-4 ISA lecture and the 25-practicals module. Works in Node and the browser.
 * Verified against the teacher's Expected Register Snapshots — see test.js.
 * v2 (2026-11-05): external pins for the board view (buttons pull a pin LOW), latch-vs-pin port reads,
 * INT0/INT1 sampled from P3.2/P3.3, IP priorities. Board checks: test_board.js.
 *
 * Memory model:
 *   lowRAM[0..127]  direct OR indirect (banks 00-1F, bit area 20-2F, stack, scratch 30-7F)
 *   upperRAM[0..127] indirect only (@Ri 80-FF)
 *   SFRs            direct only (80-FF); the named ones live in CPU fields
 *   xram[0..65535]  external data (MOVX)
 *   code[0..65535]  program memory (MOVC, fetch)
 */
(function (root) {
  'use strict';

  // ---- SFR addresses ----
  var SFR = { P0:0x80, SP:0x81, DPL:0x82, DPH:0x83, PCON:0x87, TCON:0x88, TMOD:0x89,
              TL0:0x8A, TL1:0x8B, TH0:0x8C, TH1:0x8D, P1:0x90, SCON:0x98, SBUF:0x99,
              P2:0xA0, IE:0xA8, P3:0xB0, IP:0xB8, PSW:0xD0, ACC:0xE0, B:0xF0 };
  // bit-addressable SFR base addresses (address % 8 == 0)
  var BITSFR = { 0x80:'P0', 0x88:'TCON', 0x90:'P1', 0x98:'SCON', 0xA0:'P2',
                 0xA8:'IE', 0xB0:'P3', 0xB8:'IP', 0xD0:'PSW', 0xE0:'ACC', 0xF0:'B' };

  // bit names → bit address (common ones used in the practicals)
  var BITNAME = { C:0xD7, CY:0xD7, AC:0xD6, F0:0xD5, RS1:0xD4, RS0:0xD3, OV:0xD2, P:0xD0,
                  TF1:0x8F, TR1:0x8E, TF0:0x8D, TR0:0x8C, IE1:0x8B, IT1:0x8A, IE0:0x89, IT0:0x88,
                  EA:0xAF, ET2:0xAD, ES:0xAC, ET1:0xAB, EX1:0xAA, ET0:0xA9, EX0:0xA8,
                  PT2:0xBD, PS:0xBC, PT1:0xBB, PX1:0xBA, PT0:0xB9, PX0:0xB8,
                  SM0:0x9F, SM1:0x9E, SM2:0x9D, REN:0x9C, TB8:0x9B, RB8:0x9A, TI:0x99, RI:0x98,
                  RXD:0xB0, TXD:0xB1, 'INT0':0xB2, 'INT1':0xB3, T0:0xB4, T1:0xB5, WR:0xB6, RD:0xB7 };

  // ============================ ASSEMBLER ============================
  function parseNum(tok) {
    if (tok == null) return null;
    tok = tok.trim();
    var m;
    if ((m = /^([0-9A-Fa-f]+)H$/.exec(tok))) return parseInt(m[1], 16);
    if ((m = /^0[xX]([0-9A-Fa-f]+)$/.exec(tok))) return parseInt(m[1], 16);
    if ((m = /^([01]+)B$/.exec(tok))) return parseInt(m[1], 2);
    if ((m = /^([0-9]+)D?$/.exec(tok))) return parseInt(m[1], 10);
    return null;
  }
  // resolve a "byte" symbol (SFR name, number) to a direct address
  function resolveDirect(tok, sym) {
    tok = tok.trim();
    if (SFR.hasOwnProperty(tok.toUpperCase())) return SFR[tok.toUpperCase()];
    if (sym && sym.hasOwnProperty(tok)) return sym[tok];
    var n = parseNum(tok);
    return n;
  }
  // resolve a bit operand ("20H.0", "PSW.0", "ACC.7", "P1.3", "TR0", "C") to a bit address
  function resolveBit(tok, sym) {
    tok = tok.trim();
    var up = tok.toUpperCase();
    if (up === 'C' || up === 'CY') return 0xD7;
    if (sym && sym.hasOwnProperty(tok) && sym[tok] != null) return sym[tok];   // user-defined BIT symbol
    if (BITNAME.hasOwnProperty(up)) return BITNAME[up];
    var m = /^(.+)\.([0-7])$/.exec(tok);
    if (m) {
      var base = m[1].trim(); var bit = parseInt(m[2], 10);
      var addr = resolveDirect(base, sym);
      if (addr == null) return null;
      if (addr >= 0x20 && addr <= 0x2F) return (addr - 0x20) * 8 + bit;     // bit area
      if (addr >= 0x80 && (addr & 7) === 0) return addr + bit;               // bit-addressable SFR
      return null;
    }
    // a bare number is a direct bit address
    var n = parseNum(tok);
    return n;
  }

  function assemble(src) {
    var lines = src.replace(/\r/g, '').split('\n');
    var sym = {};           // EQU symbols + labels
    var prog = [];          // {addr,line,text,bytes:[...unresolved...]}
    var org = 0, pc = 0;
    // ---- pass 1: collect labels & EQU, compute addresses ----
    var items = [];
    for (var li = 0; li < lines.length; li++) {
      var raw = lines[li];
      var line = raw.replace(/;.*$/, '').trim();
      if (!line) continue;
      // label:
      var lm = /^([A-Za-z_]\w*)\s*:\s*(.*)$/.exec(line);
      var label = null;
      if (lm) { label = lm[1]; line = lm[2].trim(); }
      // symbol-defining directives: EQU / DATA / IDATA / XDATA (→ direct address) and BIT (→ bit address)
      var em = /^([A-Za-z_]\w*)\s+EQU\s+(.+)$/i.exec(line);
      if (em) { var ev = resolveDirect(em[2].trim(), sym);
        // "BUZZER EQU P3.6": Keil takes a bit expression after EQU too, so give the symbol the bit address
        if (ev == null && /\.[0-7]$/.test(em[2].trim())) ev = resolveBit(em[2].trim(), sym);
        sym[em[1]] = (ev != null ? ev : parseNum(em[2])); continue; }
      var dm = /^([A-Za-z_]\w*)\s+(?:DATA|IDATA|XDATA)\s+(.+)$/i.exec(line);
      if (dm) { sym[dm[1]] = resolveDirect(dm[2].trim(), sym); continue; }
      var bm = /^([A-Za-z_]\w*)\s+BIT\s+(.+)$/i.exec(line);
      if (bm) { sym[bm[1]] = resolveBit(bm[2].trim(), sym); continue; }
      if (label) sym[label] = null; // placeholder, addr filled below
      if (!line) { if (label) items.push({label:label, line:li, text:'', dir:'LABEL'}); continue; }
      var mn = line.split(/\s+/)[0].toUpperCase();
      // segment + assembler-control directives: CSEG AT n acts like ORG; the rest are no-ops for this emulator
      if (mn === 'CSEG' || mn === 'DSEG' || mn === 'BSEG' || mn === 'XSEG' || mn === 'ISEG') {
        var atm = /AT\s+(\S+)/i.exec(line);
        if (mn === 'CSEG' && atm) items.push({dir:'ORG', val:parseNum(atm[1]), label:label, line:li});
        else if (label) items.push({label:label, line:li, text:'', dir:'LABEL'});
        continue;
      }
      if (mn === 'USING' || mn === 'NAME' || mn === 'PUBLIC' || mn === 'EXTRN' || mn === 'RSEG') {
        if (label) items.push({label:label, line:li, text:'', dir:'LABEL'}); continue;
      }
      if (mn === 'ORG') { items.push({dir:'ORG', val:parseNum(line.split(/\s+/)[1]), label:label, line:li}); continue; }
      if (mn === 'END') { items.push({dir:'END', line:li, label:label}); continue; }
      if (mn === 'DB')  { items.push({dir:'DB', text:line.replace(/^DB\s+/i,''), label:label, line:li}); continue; }
      items.push({dir:'INSN', text:line, label:label, line:li});
    }
    // assign addresses
    pc = 0;
    for (var i = 0; i < items.length; i++) {
      var it = items[i];
      if (it.dir === 'ORG') { pc = it.val; if (it.label) sym[it.label] = pc; continue; }
      if (it.dir === 'END') continue;
      if (it.label) sym[it.label] = pc;
      if (it.dir === 'LABEL') continue;
      if (it.dir === 'DB') { it.addr = pc; var vals = it.text.split(',').map(function(x){return parseNum(x.trim())||0;}); it.size = vals.length; it.vals = vals; pc += it.size; continue; }
      if (it.dir === 'INSN') { it.addr = pc; it.size = insnSize(it.text); pc += it.size; }
    }
    // ---- pass 2: encode ----
    var code = new Uint8Array(65536);
    var lineMap = {};   // addr -> source line index
    var addrOfLine = {};
    var maxAddr = 0; var err = null;
    for (var j = 0; j < items.length; j++) {
      var it2 = items[j];
      if (it2.dir === 'DB') { for (var k=0;k<it2.vals.length;k++) code[it2.addr+k]=it2.vals[k]&0xFF; lineMap[it2.addr]=it2.line; maxAddr=Math.max(maxAddr,it2.addr+it2.size); continue; }
      if (it2.dir !== 'INSN') continue;
      var enc;
      try { enc = encode(it2.text, it2.addr, sym); }
      catch (e) { err = 'Line ' + (it2.line+1) + ': ' + e.message + '  [' + it2.text + ']'; break; }
      for (var b = 0; b < enc.length; b++) code[it2.addr + b] = enc[b] & 0xFF;
      lineMap[it2.addr] = it2.line; addrOfLine[it2.line] = it2.addr;
      maxAddr = Math.max(maxAddr, it2.addr + enc.length);
    }
    return { code: code, length: maxAddr, lineMap: lineMap, addrOfLine: addrOfLine, symbols: sym, error: err, sourceLines: lines };
  }

  // size of an instruction (for pass-1 addressing) — depends on operand forms
  function insnSize(text) {
    var p = splitInsn(text); var m = p.mnem, a = p.args;
    switch (m) {
      case 'NOP': case 'RET': case 'RETI': case 'RR': case 'RRC': case 'RL': case 'RLC':
      case 'SWAP': case 'DA': case 'MUL': case 'DIV': case 'CPL': case 'CLR':
        if (m==='CPL'||m==='CLR') { if (a[0]==='A'||a[0]==='C') return 1; return 2; }
        return 1;
      case 'INC': case 'DEC':
        if (a[0]==='A') return 1; if (/^@R[01]$/.test(a[0])) return 1; if (/^R[0-7]$/.test(a[0])) return 1;
        if (a[0]==='DPTR') return 1; return 2; // INC direct
      case 'SETB': return 2;
      case 'PUSH': case 'POP': return 2;
      case 'MOV':
        return movSize(a);
      case 'MOVC': case 'MOVX': return 1;
      case 'ADD': case 'ADDC': case 'SUBB': case 'ANL': case 'ORL': case 'XRL':
        return logicArithSize(m, a);
      case 'XCH': if (/^R[0-7]$/.test(a[1])||/^@R[01]$/.test(a[1])) return 1; return 2;
      case 'XCHD': return 1;
      case 'SJMP': return 2;
      case 'AJMP': case 'ACALL': return 2;
      case 'LJMP': case 'LCALL': return 3;
      case 'JMP': return 1; // JMP @A+DPTR
      case 'JZ': case 'JNZ': case 'JC': case 'JNC': return 2;
      case 'JB': case 'JNB': case 'JBC': return 3;
      case 'CJNE': return 3;
      case 'DJNZ': if (/^R[0-7]$/.test(a[0])) return 2; return 3;
      default: return 1;
    }
  }
  function movSize(a) {
    var d = a[0], s = a[1];
    if (d === 'DPTR') return 3;                       // MOV DPTR,#imm16
    if (d === 'A') { if (s[0]==='#') return 2; if (/^R[0-7]$/.test(s)||/^@R[01]$/.test(s)) return 1; return 2; } // MOV A,direct=2
    if (/^R[0-7]$/.test(d)) { if (s[0]==='#') return 2; if (s==='A') return 1; return 2; }   // MOV Rn,direct=2
    if (/^@R[01]$/.test(d)) { if (s[0]==='#') return 2; if (s==='A') return 1; return 2; }   // MOV @Ri,direct=2
    if (d === 'C') return 2;                          // MOV C,bit
    // dest is direct/bit
    if (s === 'C') return 2;                          // MOV bit,C
    if (s === 'A') return 2;                          // MOV direct,A
    if (/^R[0-7]$/.test(s)) return 2;                 // MOV direct,Rn
    if (/^@R[01]$/.test(s)) return 2;                 // MOV direct,@Ri
    if (s[0]==='#') return 3;                         // MOV direct,#imm
    return 3;                                         // MOV direct,direct
  }
  function logicArithSize(m, a) {
    var d = a[0], s = a[1];
    if (d === 'A') { if (s[0]==='#') return 2; if (/^R[0-7]$/.test(s)||/^@R[01]$/.test(s)) return 1; return 2; }
    if (d === 'C') return 2;                          // ANL/ORL C,bit
    // dest direct
    if (s === 'A') return 2;                          // ANL direct,A
    if (s[0]==='#') return 3;                         // ANL direct,#imm
    return 2;
  }

  function splitInsn(text) {
    var t = text.trim();
    var sp = t.indexOf(' ');
    if (sp < 0) return { mnem: t.toUpperCase(), args: [] };
    var mnem = t.slice(0, sp).toUpperCase();
    var rest = t.slice(sp + 1).trim();
    var args = splitArgs(rest);
    return { mnem: mnem, args: args };
  }
  function splitArgs(rest) {
    // split on commas not inside @A+DPTR etc. (no nested commas in 8051)
    return rest.split(',').map(function (x) { return x.trim(); }).filter(function (x) { return x.length; });
  }

  function rnum(tok){ var m=/^R([0-7])$/.exec(tok); return m?parseInt(m[1],10):null; }
  function rinum(tok){ var m=/^@R([01])$/.exec(tok); return m?parseInt(m[1],10):null; }
  function imm(tok){ return tok && tok[0]==='#'; }
  function immVal(tok, sym){ var s=tok.slice(1).trim(); if (sym && sym.hasOwnProperty(s) && sym[s]!=null) return sym[s]; var n=parseNum(s); if(n==null) throw new Error('bad immediate '+tok); return n; }

  // encode one instruction -> array of bytes
  function encode(text, addr, sym) {
    var p = splitInsn(text); var m = p.mnem, a = p.args;
    function direct(tok){ var d=resolveDirect(tok, sym); if(d==null) throw new Error('unknown symbol '+tok); return d&0xFF; }
    function bit(tok){ var bb=resolveBit(tok, sym); if(bb==null) throw new Error('bad bit '+tok); return bb&0xFF; }
    // "$" is this instruction's own address, as in Keil: SJMP $ waits in place
    function here(label){ return label.trim()==='$' ? addr : null; }
    function rel(label){ var t=here(label); if(t==null) t=resolveDirect(label,sym); if(t==null){ var n=parseNum(label); if(n==null) throw new Error('bad target '+label); t=n; } var off=t-(addr+ /*size set later*/ relSize(m,a)); if(off<-128||off>127) throw new Error('rel out of range to '+label); return off & 0xFF; }
    function addr16(label){ var t=here(label); if(t==null) t=resolveDirect(label,sym); if(t==null){t=parseNum(label);} if(t==null) throw new Error('bad addr '+label); return [(t>>8)&0xFF, t&0xFF]; }
    function addr11(label){ var t=here(label); if(t==null) t=resolveDirect(label,sym); if(t==null){t=parseNum(label);} if(t==null) throw new Error('bad addr '+label); return t; }

    switch (m) {
      case 'NOP': return [0x00];
      case 'RET': return [0x22];
      case 'RETI': return [0x32];
      case 'RR': return [0x03];
      case 'RRC': return [0x13];
      case 'RL': return [0x23];
      case 'RLC': return [0x33];
      case 'SWAP': return [0xC4];
      case 'DA': return [0xD4];
      case 'MUL': return [0xA4];
      case 'DIV': return [0x84];
      case 'CPL':
        if (a[0]==='A') return [0xF4];
        if (a[0]==='C') return [0xB3];
        return [0xB2, bit(a[0])];
      case 'CLR':
        if (a[0]==='A') return [0xE4];
        if (a[0]==='C') return [0xC3];
        return [0xC2, bit(a[0])];
      case 'SETB':
        if (a[0]==='C') return [0xD3];
        return [0xD2, bit(a[0])];
      case 'INC':
        if (a[0]==='A') return [0x04];
        if (a[0]==='DPTR') return [0xA3];
        if (rnum(a[0])!=null) return [0x08 | rnum(a[0])];
        if (rinum(a[0])!=null) return [0x06 | rinum(a[0])];
        return [0x05, direct(a[0])];
      case 'DEC':
        if (a[0]==='A') return [0x14];
        if (rnum(a[0])!=null) return [0x18 | rnum(a[0])];
        if (rinum(a[0])!=null) return [0x16 | rinum(a[0])];
        return [0x15, direct(a[0])];
      case 'PUSH': return [0xC0, direct(a[0])];
      case 'POP': return [0xD0, direct(a[0])];
      case 'ADD': case 'ADDC': case 'SUBB': {
        var base = m==='ADD'?0x24 : m==='ADDC'?0x34 : 0x94;
        var s=a[1];
        if (imm(s)) return [base, immVal(s,sym)];
        if (rnum(s)!=null) return [(base+0x04) | rnum(s)];
        if (rinum(s)!=null) return [(base+0x02) | rinum(s)];
        return [base+0x01, direct(s)];
      }
      case 'ANL': case 'ORL': case 'XRL': {
        var b0 = m==='ANL'?0x50 : m==='ORL'?0x40 : 0x60;
        var d=a[0], s2=a[1];
        if (d==='A') {
          if (imm(s2)) return [b0|0x04, immVal(s2,sym)];
          if (rnum(s2)!=null) return [(b0|0x08) | rnum(s2)];
          if (rinum(s2)!=null) return [(b0|0x06) | rinum(s2)];
          return [b0|0x05, direct(s2)];
        }
        if (d==='C') { // ANL C,bit / ORL C,bit  (XRL has no bit form)
          if (m==='ANL') return [0x82, bit(s2)];
          if (m==='ORL') return [0x72, bit(s2)];
          throw new Error('XRL C,bit not valid');
        }
        // direct dest
        if (s2==='A') return [b0|0x02, direct(d)];
        if (imm(s2)) return [b0|0x03, direct(d), immVal(s2,sym)];
        throw new Error('bad '+m+' form '+text);
      }
      case 'XCH':
        if (rnum(a[1])!=null) return [0xC8 | rnum(a[1])];
        if (rinum(a[1])!=null) return [0xC6 | rinum(a[1])];
        return [0xC5, direct(a[1])];
      case 'XCHD': return [0xD6 | rinum(a[1])];
      case 'MOV': return encMov(a, sym, direct, bit);
      case 'MOVC':
        if (/PC/i.test(a[1])) return [0x83];
        return [0x93]; // @A+DPTR
      case 'MOVX':
        if (a[0]==='A') { if (/DPTR/i.test(a[1])) return [0xE0]; return [0xE2 | rinum(a[1])]; }
        else { if (/DPTR/i.test(a[0])) return [0xF0]; return [0xF2 | rinum(a[0])]; }
      case 'SJMP': return [0x80, rel(a[0])];
      case 'LJMP': return [0x02].concat(addr16(a[0]));
      case 'LCALL': return [0x12].concat(addr16(a[0]));
      case 'AJMP': { var t=addr11(a[0]); return [0x01 | ((t&0x700)>>3), t&0xFF]; }
      case 'ACALL': { var t2=addr11(a[0]); return [0x11 | ((t2&0x700)>>3), t2&0xFF]; }
      case 'JMP': return [0x73]; // @A+DPTR
      case 'JZ': return [0x60, rel(a[0])];
      case 'JNZ': return [0x70, rel(a[0])];
      case 'JC': return [0x40, rel(a[0])];
      case 'JNC': return [0x50, rel(a[0])];
      case 'JB': return [0x20, bit(a[0]), rel(a[1])];
      case 'JNB': return [0x30, bit(a[0]), rel(a[1])];
      case 'JBC': return [0x10, bit(a[0]), rel(a[1])];
      case 'CJNE': {
        var x=a[0];
        if (x==='A') { if (imm(a[1])) return [0xB4, immVal(a[1],sym), rel(a[2])]; return [0xB5, direct(a[1]), rel(a[2])]; }
        if (rnum(x)!=null) return [0xB8 | rnum(x), immVal(a[1],sym), rel(a[2])];
        if (rinum(x)!=null) return [0xB6 | rinum(x), immVal(a[1],sym), rel(a[2])];
        throw new Error('bad CJNE');
      }
      case 'DJNZ':
        if (rnum(a[0])!=null) return [0xD8 | rnum(a[0]), rel(a[1])];
        return [0xD5, direct(a[0]), rel(a[1])];
      default: throw new Error('unknown mnemonic '+m);
    }
  }
  function relSize(m,a){ // bytes BEFORE the rel operand's end (i.e., full insn size) for rel target math
    return insnSize((m+' '+(a.join(','))).trim());
  }
  function encMov(a, sym, direct, bit) {
    var d=a[0], s=a[1];
    if (d==='DPTR') { var v=immVal(s,sym); return [0x90,(v>>8)&0xFF, v&0xFF]; }
    if (d==='A') {
      if (imm(s)) return [0x74, immVal(s,sym)];
      if (rnum(s)!=null) return [0xE8 | rnum(s)];
      if (rinum(s)!=null) return [0xE6 | rinum(s)];
      if (s==='C') throw new Error('MOV A,C invalid');
      return [0xE5, direct(s)];
    }
    if (rnum(d)!=null) {
      if (imm(s)) return [0x78 | rnum(d), immVal(s,sym)];
      if (s==='A') return [0xF8 | rnum(d)];
      return [0xA8 | rnum(d), direct(s)];
    }
    if (rinum(d)!=null) {
      if (imm(s)) return [0x76 | rinum(d), immVal(s,sym)];
      if (s==='A') return [0xF6 | rinum(d)];
      return [0xA6 | rinum(d), direct(s)];
    }
    if (d==='C') return [0xA2, bit(s)];           // MOV C,bit
    // dest is direct/bit
    if (s==='C') return [0x92, bit(d)];           // MOV bit,C
    if (s==='A') return [0xF5, direct(d)];
    if (rnum(s)!=null) return [0x88 | rnum(s), direct(d)];
    if (rinum(s)!=null) return [0x86 | rinum(s), direct(d)];
    if (imm(s)) return [0x75, direct(d), immVal(s,sym)];
    return [0x85, direct(s), direct(d)];          // MOV direct,direct : byte2=src, byte3=dest
  }

  // ============================ CPU ============================
  function CPU(opts) { opts=opts||{}; this.xtal = opts.xtal || 11059200; this.reset(); }
  CPU.prototype.reset = function () {
    this.lowRAM = new Uint8Array(128);
    this.upperRAM = new Uint8Array(128);
    this.xram = new Uint8Array(65536);
    this.code = new Uint8Array(65536);
    this.codeLen = 0; this.lineMap = {};
    this.acc=0; this.b=0; this.psw=0; this.sp=0x07; this.dpl=0; this.dph=0; this.pc=0;
    this.p0=0xFF; this.p1=0xFF; this.p2=0xFF; this.p3=0xFF;
    this.tcon=0; this.tmod=0; this.tl0=0; this.th0=0; this.tl1=0; this.th1=0;
    this.scon=0; this.sbuf=0; this.ie=0; this.ip=0; this.pcon=0;
    this.sfrOther = new Uint8Array(128);
    this.cycles=0; this.steps=0; this.halted=false; this.inISR=0;
    this.lastTF0=false;
    if (!this.pins) this.pins=[0xFF,0xFF,0xFF,0xFF];   // external pin drive, 0 = pulled LOW (button)
    this.isrLv=[]; this.retiHold=false; this.ie0Hold=false;
    this.lastINT0=1; this.lastINT1=1;
  };
  CPU.prototype.load = function (asm) {
    this.code = asm.code; this.codeLen = asm.length; this.lineMap = asm.lineMap; this.symbols=asm.symbols;
    this.pc = 0;
  };
  CPU.prototype.bank = function(){ return (this.psw>>3)&3; };
  CPU.prototype.getR = function(n){ return this.lowRAM[this.bank()*8 + n]; };
  CPU.prototype.setR = function(n,v){ this.lowRAM[this.bank()*8 + n]=v&0xFF; };
  CPU.prototype.setACC = function(v){ this.acc=v&0xFF; this.setParity(); };
  CPU.prototype.setParity = function(){ var x=this.acc, c=0; while(x){ c^=1; x&=x-1; } if(c) this.psw|=0x01; else this.psw&=~0x01; };

  CPU.prototype.readDirect = function (a) {
    a&=0xFF;
    switch(a){
      case 0xE0: return this.acc; case 0xF0: return this.b; case 0xD0: return this.psw;
      case 0x81: return this.sp; case 0x82: return this.dpl; case 0x83: return this.dph;
      case 0x80: return this.p0&this.pins[0]; case 0x90: return this.p1&this.pins[1];
      case 0xA0: return this.p2&this.pins[2]; case 0xB0: return this.p3&this.pins[3];
      case 0x88: return this.tcon; case 0x89: return this.tmod; case 0x8A: return this.tl0; case 0x8C: return this.th0;
      case 0x8B: return this.tl1; case 0x8D: return this.th1; case 0x98: return this.scon; case 0x99: return this.sbuf;
      case 0xA8: return this.ie; case 0xB8: return this.ip; case 0x87: return this.pcon;
    }
    if (a<0x80) return this.lowRAM[a];
    return this.sfrOther[a-0x80];
  };
  // read-modify-write instructions read the port LATCH, not the pin
  CPU.prototype.readLatch = function (a) {
    a&=0xFF;
    if (a===0x80) return this.p0; if (a===0x90) return this.p1; if (a===0xA0) return this.p2; if (a===0xB0) return this.p3;
    return this.readDirect(a);
  };
  CPU.prototype.writeDirect = function (a,v) {
    a&=0xFF; v&=0xFF;
    switch(a){
      case 0xE0: this.acc=v; this.setParity(); return; case 0xF0: this.b=v; return; case 0xD0: this.psw=v; return;
      case 0x81: this.sp=v; return; case 0x82: this.dpl=v; return; case 0x83: this.dph=v; return;
      case 0x80: this.p0=v; return; case 0x90: this.p1=v; return; case 0xA0: this.p2=v; return; case 0xB0: this.p3=v; return;
      case 0x88: this.tcon=v; return; case 0x89: this.tmod=v; return; case 0x8A: this.tl0=v; return; case 0x8C: this.th0=v; return;
      case 0x8B: this.tl1=v; return; case 0x8D: this.th1=v; return; case 0x98: this.scon=v; return; case 0x99: this.sbuf=v; return;
      case 0xA8: this.ie=v; return; case 0xB8: this.ip=v; return; case 0x87: this.pcon=v; return;
    }
    if (a<0x80) this.lowRAM[a]=v; else this.sfrOther[a-0x80]=v;
  };
  CPU.prototype.readIndirect = function(a){ a&=0xFF; return a<0x80 ? this.lowRAM[a] : this.upperRAM[a-0x80]; };
  CPU.prototype.writeIndirect = function(a,v){ a&=0xFF; v&=0xFF; if(a<0x80) this.lowRAM[a]=v; else this.upperRAM[a-0x80]=v; };

  CPU.prototype.readBit = function(b){ b&=0xFF; var byteAddr,bit;
    if (b<0x80){ byteAddr=0x20+(b>>3); bit=b&7; return (this.lowRAM[byteAddr]>>bit)&1; }
    byteAddr=b&0xF8; bit=b&7; return (this.readDirect(byteAddr)>>bit)&1; };
  CPU.prototype.readBitLatch = function(b){ b&=0xFF;
    if (b<0x80) return this.readBit(b);
    return (this.readLatch(b&0xF8)>>(b&7))&1; };
  CPU.prototype.writeBit = function(b,val){ b&=0xFF; var byteAddr,bit,cur;
    if (b<0x80){ byteAddr=0x20+(b>>3); bit=b&7; cur=this.lowRAM[byteAddr]; this.lowRAM[byteAddr]= val? (cur|(1<<bit)) : (cur&~(1<<bit)); return; }
    byteAddr=b&0xF8; bit=b&7; cur=this.readLatch(byteAddr); this.writeDirect(byteAddr, val? (cur|(1<<bit)) : (cur&~(1<<bit))); };

  CPU.prototype.dptr = function(){ return (this.dph<<8)|this.dpl; };
  CPU.prototype.setDPTR = function(v){ this.dph=(v>>8)&0xFF; this.dpl=v&0xFF; };
  CPU.prototype.push = function(v){ this.sp=(this.sp+1)&0xFF; this.writeIndirect(this.sp, v); };
  CPU.prototype.pop = function(){ var v=this.readIndirect(this.sp); this.sp=(this.sp-1)&0xFF; return v; };

  function setCY(cpu,v){ if(v) cpu.psw|=0x80; else cpu.psw&=~0x80; }
  function getCY(cpu){ return (cpu.psw>>7)&1; }
  function setAC(cpu,v){ if(v) cpu.psw|=0x40; else cpu.psw&=~0x40; }
  function setOV(cpu,v){ if(v) cpu.psw|=0x04; else cpu.psw&=~0x04; }

  // fetch helpers
  CPU.prototype.fetch = function(){ var v=this.code[this.pc&0xFFFF]; this.pc=(this.pc+1)&0xFFFF; return v; };

  // execute one instruction; returns cycles
  CPU.prototype.step = function () {
    if (this.halted) return 0;
    var startPC = this.pc;
    var op = this.fetch();
    var cyc = 1;
    var self=this;
    function imm8(){ return self.fetch(); }
    function dir(){ return self.fetch(); }
    function relTarget(){ var r=self.fetch(); var off=(r<128)?r:r-256; return (self.pc+off)&0xFFFF; }
    var hi=op&0xF0, lo=op&0x0F, n=op&0x07, ri=op&0x01;

    // Rn / @Ri instruction families handled by ranges
    if (op===0x00) { /*NOP*/ }
    else if (op===0x02) { var t=(this.fetch()<<8)|this.fetch(); this.pc=t; cyc=2; }
    else if (op===0x12) { var t2=(this.fetch()<<8)|this.fetch(); this.push(this.pc&0xFF); this.push((this.pc>>8)&0xFF); this.pc=t2; cyc=2; }
    else if (op===0x22) { var h=this.pop(); var l=this.pop(); this.pc=((h<<8)|l)&0xFFFF; cyc=2; } // RET (pop high then low? see push order)
    else if (op===0x32) { var h2=this.pop(); var l2=this.pop(); this.pc=((h2<<8)|l2)&0xFFFF; this.inISR=Math.max(0,this.inISR-1); this.isrLv.pop(); this.retiHold=true; cyc=2; }
    else if ((op&0x1F)===0x01) { // AJMP
      var page=(op&0xE0)<<3; var a8=this.fetch(); this.pc=(this.pc&0xF800)|page|a8; cyc=2; }
    else if ((op&0x1F)===0x11) { // ACALL
      var page2=(op&0xE0)<<3; var a82=this.fetch(); this.push(this.pc&0xFF); this.push((this.pc>>8)&0xFF); this.pc=(this.pc&0xF800)|page2|a82; cyc=2; }
    else if (op===0x80) { this.pc=relTarget(); cyc=2; } // SJMP
    else if (op===0x73) { this.pc=(this.dptr()+this.acc)&0xFFFF; cyc=2; } // JMP @A+DPTR
    else if (op===0x60) { var tt=relTarget(); if(this.acc===0) this.pc=tt; cyc=2; } // JZ
    else if (op===0x70) { var tt2=relTarget(); if(this.acc!==0) this.pc=tt2; cyc=2; } // JNZ
    else if (op===0x40) { var tt3=relTarget(); if(getCY(this)) this.pc=tt3; cyc=2; } // JC
    else if (op===0x50) { var tt4=relTarget(); if(!getCY(this)) this.pc=tt4; cyc=2; } // JNC
    else if (op===0x20) { var bb=dir(); var tt5=relTarget(); if(this.readBit(bb)) this.pc=tt5; cyc=2; } // JB
    else if (op===0x30) { var bb2=dir(); var tt6=relTarget(); if(!this.readBit(bb2)) this.pc=tt6; cyc=2; } // JNB
    else if (op===0x10) { var bb3=dir(); var tt7=relTarget(); if(this.readBitLatch(bb3)){ this.writeBit(bb3,0); this.pc=tt7; } cyc=2; } // JBC
    // ---- MOV A,#  / direct / @Ri / Rn ----
    else if (op===0x74) { this.setACC(imm8()); }
    else if (op===0x75) { var d=dir(); var v=imm8(); this.writeDirect(d,v); cyc=2; } // MOV direct,#imm
    else if (op>=0x76 && op<=0x77) { this.writeIndirect(this.getR(op&1), imm8()); } // MOV @Ri,#imm
    else if (op>=0x78 && op<=0x7F) { this.setR(n, imm8()); } // MOV Rn,#imm
    else if (op===0xE5) { this.setACC(this.readDirect(dir())); } // MOV A,direct
    else if (op===0xE6 || op===0xE7) { this.setACC(this.readIndirect(this.getR(op&1))); } // MOV A,@Ri
    else if (op>=0xE8 && op<=0xEF) { this.setACC(this.getR(n)); } // MOV A,Rn
    else if (op===0xF5) { this.writeDirect(dir(), this.acc); } // MOV direct,A
    else if (op===0xF6 || op===0xF7) { this.writeIndirect(this.getR(op&1), this.acc); } // MOV @Ri,A
    else if (op>=0xF8 && op<=0xFF) { this.setR(n, this.acc); } // MOV Rn,A
    else if (op===0xA8+0 || (op>=0xA8 && op<=0xAF)) { this.setR(n, this.readDirect(dir())); cyc=2; } // MOV Rn,direct (2 cycles, as in the Intel table)
    else if (op===0xA6 || op===0xA7) { this.writeIndirect(this.getR(op&1), this.readDirect(dir())); cyc=2; } // MOV @Ri,direct
    else if (op===0x88 || (op>=0x88 && op<=0x8F)) { var dd=dir(); this.writeDirect(dd, this.getR(n)); cyc=2; } // MOV direct,Rn
    else if (op===0x86 || op===0x87) { var dd2=dir(); this.writeDirect(dd2, this.readIndirect(this.getR(op&1))); cyc=2; } // MOV direct,@Ri
    else if (op===0x85) { var src=dir(); var dst=dir(); this.writeDirect(dst, this.readDirect(src)); cyc=2; } // MOV direct,direct
    else if (op===0x90) { this.dph=imm8(); this.dpl=imm8(); cyc=2; } // MOV DPTR,#imm16
    else if (op===0xA2) { setCY(this, this.readBit(dir())); } // MOV C,bit
    else if (op===0x92) { var bd=dir(); this.writeBit(bd, getCY(this)); cyc=2; } // MOV bit,C
    // ---- MOVC / MOVX ----
    else if (op===0x93) { this.setACC(this.code[(this.dptr()+this.acc)&0xFFFF]); cyc=2; } // MOVC A,@A+DPTR
    else if (op===0x83) { this.setACC(this.code[(this.pc+this.acc)&0xFFFF]); cyc=2; } // MOVC A,@A+PC
    else if (op===0xE0) { this.setACC(this.xram[this.dptr()&0xFFFF]); cyc=2; } // MOVX A,@DPTR
    else if (op===0xE2 || op===0xE3) { this.setACC(this.xram[this.getR(op&1)]); cyc=2; }
    else if (op===0xF0) { this.xram[this.dptr()&0xFFFF]=this.acc; cyc=2; } // MOVX @DPTR,A
    else if (op===0xF2 || op===0xF3) { this.xram[this.getR(op&1)]=this.acc; cyc=2; }
    // ---- arithmetic ----
    else if (op===0x24) { this.add(imm8(),0); }
    else if (op===0x25) { this.add(this.readDirect(dir()),0); }
    else if (op===0x26 || op===0x27) { this.add(this.readIndirect(this.getR(op&1)),0); }
    else if (op>=0x28 && op<=0x2F) { this.add(this.getR(n),0); }
    else if (op===0x34) { this.add(imm8(),getCY(this)); }
    else if (op===0x35) { this.add(this.readDirect(dir()),getCY(this)); }
    else if (op===0x36 || op===0x37) { this.add(this.readIndirect(this.getR(op&1)),getCY(this)); }
    else if (op>=0x38 && op<=0x3F) { this.add(this.getR(n),getCY(this)); }
    else if (op===0x94) { this.sub(imm8()); }
    else if (op===0x95) { this.sub(this.readDirect(dir())); }
    else if (op===0x96 || op===0x97) { this.sub(this.readIndirect(this.getR(op&1))); }
    else if (op>=0x98 && op<=0x9F) { this.sub(this.getR(n)); }
    else if (op===0x04) { this.setACC(this.acc+1); }
    else if (op===0x05) { var da=dir(); this.writeDirect(da,(this.readLatch(da)+1)&0xFF); }
    else if (op===0x06 || op===0x07) { var ai=this.getR(op&1); this.writeIndirect(ai,(this.readIndirect(ai)+1)&0xFF); }
    else if (op>=0x08 && op<=0x0F) { this.setR(n,(this.getR(n)+1)&0xFF); }
    else if (op===0x14) { this.setACC(this.acc-1); }
    else if (op===0x15) { var db=dir(); this.writeDirect(db,(this.readLatch(db)-1)&0xFF); }
    else if (op===0x16 || op===0x17) { var ai2=this.getR(op&1); this.writeIndirect(ai2,(this.readIndirect(ai2)-1)&0xFF); }
    else if (op>=0x18 && op<=0x1F) { this.setR(n,(this.getR(n)-1)&0xFF); }
    else if (op===0xA3) { this.setDPTR((this.dptr()+1)&0xFFFF); cyc=2; } // INC DPTR
    else if (op===0xA4) { var pr=this.acc*this.b; this.acc=pr&0xFF; this.b=(pr>>8)&0xFF; setCY(this,0); setOV(this, pr>255?1:0); this.setParity(); cyc=4; } // MUL
    else if (op===0x84) { if(this.b===0){ setOV(this,1);} else { var q=Math.floor(this.acc/this.b), r=this.acc%this.b; this.acc=q&0xFF; this.b=r&0xFF; setOV(this,0);} setCY(this,0); this.setParity(); cyc=4; } // DIV
    else if (op===0xD4) { this.da(); } // DA A
    // ---- logical ----
    else if (op===0x54) { this.setACC(this.acc & imm8()); }
    else if (op===0x55) { this.setACC(this.acc & this.readDirect(dir())); }
    else if (op===0x56 || op===0x57) { this.setACC(this.acc & this.readIndirect(this.getR(op&1))); }
    else if (op>=0x58 && op<=0x5F) { this.setACC(this.acc & this.getR(n)); }
    else if (op===0x52) { var d52=dir(); this.writeDirect(d52, this.readLatch(d52)&this.acc); }
    else if (op===0x53) { var d53=dir(); var i53=imm8(); this.writeDirect(d53, this.readLatch(d53)&i53); cyc=2; }
    else if (op===0x44) { this.setACC(this.acc | imm8()); }
    else if (op===0x45) { this.setACC(this.acc | this.readDirect(dir())); }
    else if (op===0x46 || op===0x47) { this.setACC(this.acc | this.readIndirect(this.getR(op&1))); }
    else if (op>=0x48 && op<=0x4F) { this.setACC(this.acc | this.getR(n)); }
    else if (op===0x42) { var d42=dir(); this.writeDirect(d42, this.readLatch(d42)|this.acc); }
    else if (op===0x43) { var d43=dir(); var i43=imm8(); this.writeDirect(d43, this.readLatch(d43)|i43); cyc=2; }
    else if (op===0x64) { this.setACC(this.acc ^ imm8()); }
    else if (op===0x65) { this.setACC(this.acc ^ this.readDirect(dir())); }
    else if (op===0x66 || op===0x67) { this.setACC(this.acc ^ this.readIndirect(this.getR(op&1))); }
    else if (op>=0x68 && op<=0x6F) { this.setACC(this.acc ^ this.getR(n)); }
    else if (op===0x62) { var d62=dir(); this.writeDirect(d62, this.readLatch(d62)^this.acc); }
    else if (op===0x63) { var d63=dir(); var i63=imm8(); this.writeDirect(d63, this.readLatch(d63)^i63); cyc=2; }
    else if (op===0x72) { var b72=dir(); setCY(this, getCY(this) | this.readBit(b72)); cyc=2; } // ORL C,bit
    else if (op===0x82) { var b82=dir(); setCY(this, getCY(this) & this.readBit(b82)); cyc=2; } // ANL C,bit
    else if (op===0xA0) { var bA0=dir(); setCY(this, getCY(this) | (this.readBit(bA0)?0:1)); cyc=2; } // ORL C,/bit
    else if (op===0xB0) { var bB0=dir(); setCY(this, getCY(this) & (this.readBit(bB0)?0:1)); cyc=2; } // ANL C,/bit
    else if (op===0xE4) { this.setACC(0); } // CLR A
    else if (op===0xF4) { this.setACC(~this.acc & 0xFF); } // CPL A
    else if (op===0xC3) { setCY(this,0); } // CLR C
    else if (op===0xD3) { setCY(this,1); } // SETB C
    else if (op===0xB3) { setCY(this, getCY(this)?0:1); } // CPL C
    else if (op===0xC2) { this.writeBit(dir(),0); } // CLR bit
    else if (op===0xD2) { this.writeBit(dir(),1); } // SETB bit
    else if (op===0xB2) { var bx=dir(); this.writeBit(bx, this.readBitLatch(bx)?0:1); } // CPL bit
    // ---- rotate ----
    else if (op===0x23) { var a23=this.acc; this.setACC(((a23<<1)|(a23>>7))&0xFF); } // RL
    else if (op===0x03) { var a03=this.acc; this.setACC(((a03>>1)|(a03<<7))&0xFF); } // RR
    else if (op===0x33) { var a33=this.acc, c33=getCY(this); setCY(this,(a33>>7)&1); this.setACC(((a33<<1)|c33)&0xFF); } // RLC
    else if (op===0x13) { var a13=this.acc, c13=getCY(this); setCY(this,a13&1); this.setACC(((a13>>1)|(c13<<7))&0xFF); } // RRC
    else if (op===0xC4) { var a4=this.acc; this.setACC(((a4<<4)|(a4>>4))&0xFF); } // SWAP
    // ---- XCH / XCHD ----
    else if (op===0xC5) { var dc=dir(); var tmp=this.acc; this.setACC(this.readDirect(dc)); this.writeDirect(dc,tmp); }
    else if (op===0xC6 || op===0xC7) { var ac=this.getR(op&1); var t6=this.acc; this.setACC(this.readIndirect(ac)); this.writeIndirect(ac,t6); }
    else if (op>=0xC8 && op<=0xCF) { var t8=this.acc; this.setACC(this.getR(n)); this.setR(n,t8); }
    else if (op===0xD6 || op===0xD7) { var ad=this.getR(op&1); var mlo=this.readIndirect(ad)&0x0F; var alo=this.acc&0x0F; this.setACC((this.acc&0xF0)|mlo); this.writeIndirect(ad,(this.readIndirect(ad)&0xF0)|alo); }
    // ---- stack ----
    else if (op===0xC0) { this.push(this.readDirect(dir())); cyc=2; } // PUSH
    else if (op===0xD0) { this.writeDirect(dir(), this.pop()); cyc=2; } // POP
    // ---- CJNE ----
    else if (op===0xB4) { var iv=imm8(); var rt=relTarget(); var c=this.acc; if(c!==iv) this.pc=rt; setCY(this, c<iv?1:0); cyc=2; }
    else if (op===0xB5) { var dv=this.readDirect(dir()); var rt2=relTarget(); var c2=this.acc; if(c2!==dv) this.pc=rt2; setCY(this, c2<dv?1:0); cyc=2; }
    else if (op===0xB6 || op===0xB7) { var iv2=imm8(); var rt3=relTarget(); var c3=this.readIndirect(this.getR(op&1)); if(c3!==iv2) this.pc=rt3; setCY(this, c3<iv2?1:0); cyc=2; }
    else if (op>=0xB8 && op<=0xBF) { var iv3=imm8(); var rt4=relTarget(); var c4=this.getR(n); if(c4!==iv3) this.pc=rt4; setCY(this, c4<iv3?1:0); cyc=2; }
    // ---- DJNZ ----
    else if (op===0xD5) { var dq=dir(); var rt5=relTarget(); var nv=(this.readLatch(dq)-1)&0xFF; this.writeDirect(dq,nv); if(nv!==0) this.pc=rt5; cyc=2; }
    else if (op>=0xD8 && op<=0xDF) { var rt6=relTarget(); var nv2=(this.getR(n)-1)&0xFF; this.setR(n,nv2); if(nv2!==0) this.pc=rt6; cyc=2; }
    else { /* unknown opcode: treat as NOP but flag */ this.unknown = op; }

    this.cycles += cyc; this.steps++;
    this.lastInsnAddr = startPC; this.lastInsnLen = (this.pc - startPC) & 0xFFFF;
    this.tickTimers(cyc);
    this.sampleExtInt();
    this.checkInterrupts();
    return cyc;
  };

  CPU.prototype.add = function (operand, carry) {
    var a=this.acc, r=a+operand+carry;
    var c3 = ((a&0xF)+(operand&0xF)+carry) > 0xF;
    var c7 = r > 0xFF;
    var c6 = ((a&0x7F)+(operand&0x7F)+carry) > 0x7F;
    setCY(this, c7?1:0); setAC(this, c3?1:0); setOV(this, (c7^c6)?1:0);
    this.setACC(r&0xFF);
  };
  CPU.prototype.sub = function (operand) {
    var a=this.acc, cy=getCY(this), r=a-operand-cy;
    var b3 = ((a&0xF) - (operand&0xF) - cy) < 0;
    var b7 = r < 0;
    var b6 = ((a&0x7F) - (operand&0x7F) - cy) < 0;
    setCY(this, b7?1:0); setAC(this, b3?1:0); setOV(this, (b7^b6)?1:0);
    this.setACC(r&0xFF);
  };
  CPU.prototype.da = function () {
    var a=this.acc, cy=getCY(this);
    if ((a&0x0F)>9 || (this.psw&0x40)) { a+=0x06; }
    if (((a&0xFF0)>>4)>9 || cy || a>0xFF) { a+=0x60; setCY(this,1); }
    this.setACC(a&0xFF);
  };

  // simple Timer0/1 mode-1 model (enough for the polling/interrupt practicals)
  CPU.prototype.tickTimers = function (cyc) {
    // Timer0
    if (this.tcon & 0x10) { // TR0
      if ((this.tmod & 0x03) === 0x01) { // mode 1, 16-bit
        var t = ((this.th0<<8)|this.tl0) + cyc;
        if (t > 0xFFFF) { t &= 0xFFFF; this.tcon |= 0x20; } // set TF0
        this.th0=(t>>8)&0xFF; this.tl0=t&0xFF;
      } else if ((this.tmod & 0x03) === 0x02) { // mode 2, 8-bit auto-reload
        var t2 = this.tl0 + cyc;
        while (t2 > 0xFF) { t2 = t2 - 0x100 + this.th0; this.tcon |= 0x20; }
        this.tl0 = t2 & 0xFF;
      }
    }
    // Timer1
    if (this.tcon & 0x40) { // TR1
      if ((this.tmod & 0x30) === 0x10) {
        var u = ((this.th1<<8)|this.tl1) + cyc;
        if (u > 0xFFFF) { u &= 0xFFFF; this.tcon |= 0x80; }
        this.th1=(u>>8)&0xFF; this.tl1=u&0xFF;
      }
    }
  };
  // INT0 = P3.2, INT1 = P3.3. IT0/IT1 = 1: a falling edge sets IE0/IE1. IT = 0: the flag follows the pin.
  CPU.prototype.sampleExtInt = function () {
    var pin=this.p3&this.pins[3], i0=(pin>>2)&1, i1=(pin>>3)&1;
    if (this.tcon & 0x01) { if (this.lastINT0 && !i0) this.tcon |= 0x02; }
    else if (!i0) this.tcon |= 0x02; else if (!this.ie0Hold) this.tcon &= ~0x02;
    if (this.tcon & 0x04) { if (this.lastINT1 && !i1) this.tcon |= 0x08; }
    else if (!i1) this.tcon |= 0x08; else this.tcon &= ~0x08;
    this.lastINT0=i0; this.lastINT1=i1;
  };
  // sources in the 8051 polling order: [IE enable bit, TCON flag, vector, IP bit, TCON IT bit (0 = timer)]
  var INTSRC = [[0x01,0x02,0x0003,0x01,0x01], [0x02,0x20,0x000B,0x02,0], [0x04,0x08,0x0013,0x04,0x04], [0x08,0x80,0x001B,0x08,0]];
  CPU.prototype.checkInterrupts = function () {
    if (!(this.ie & 0x80)) return; // EA
    if (this.retiHold) { this.retiHold=false; return; } // one more instruction runs after RETI
    var cur = this.isrLv.length ? this.isrLv[this.isrLv.length-1] : -1;
    for (var lv=1; lv>cur; lv--) {           // high-priority requests first; only a higher level nests
      for (var k=0; k<INTSRC.length; k++) {
        var s=INTSRC[k];
        if (!(this.ie & s[0]) || !(this.tcon & s[1]) || (((this.ip & s[3])?1:0)!==lv)) continue;
        if (!s[4] || (this.tcon & s[4])) this.tcon &= ~s[1];   // timer flags and edge flags clear on entry
        if (s[2]===0x0003) this.ie0Hold=false;
        this.vector(s[2], lv); return;
      }
    }
  };
  CPU.prototype.vector = function (addr, lv) {
    this.push(this.pc&0xFF); this.push((this.pc>>8)&0xFF); this.pc=addr; this.inISR++; this.isrLv.push(lv||0);
  };
  CPU.prototype.trigINT0 = function(){ this.tcon |= 0x02; this.ie0Hold=true; }; // set IE0 (one press)
  // the outside world: pull a port pin LOW (button pressed) or let it go (released)
  CPU.prototype.setPin = function (port, bit, level) {
    if (level) this.pins[port] |= (1<<bit); else this.pins[port] &= ~(1<<bit);
  };
  CPU.prototype.pinLevel = function (port) { return [this.p0,this.p1,this.p2,this.p3][port] & this.pins[port]; };

  // run until SJMP-to-self (idle loop) or step cap
  CPU.prototype.run = function (maxSteps) {
    maxSteps = maxSteps || 200000;
    for (var i=0;i<maxSteps;i++){
      var pc=this.pc;
      // "SJMP $" is the idle loop. Stop ONLY when interrupts are disabled — otherwise it is an
      // interrupt-wait that must keep spinning so timers/ISRs continue to fire.
      if (this.code[pc]===0x80 && this.code[(pc+1)&0xFFFF]===0xFE && !(this.ie & 0x80)) { this.idleAt=pc; return {stopped:'idle', steps:i}; }
      this.step();
    }
    return {stopped:'cap', steps:maxSteps};
  };

  CPU.prototype.snapshot = function () {
    return { A:this.acc, B:this.b, PSW:this.psw, SP:this.sp, DPL:this.dpl, DPH:this.dph,
             DPTR:this.dptr(), PC:this.pc, CY:getCY(this), AC:(this.psw>>6)&1, OV:(this.psw>>2)&1, P:this.psw&1,
             R:[0,1,2,3,4,5,6,7].map(function(i){return this.getR(i);},this),
             P0:this.p0,P1:this.p1,P2:this.p2,P3:this.p3 };
  };

  var API = { assemble: assemble, CPU: CPU, SFR: SFR, BITNAME: BITNAME, insnSize: insnSize };
  if (typeof module !== 'undefined' && module.exports) module.exports = API;
  else root.i8051 = API;
})(typeof window !== 'undefined' ? window : globalThis);
