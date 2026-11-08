/* editor.js: a small code editor for A51 source. A textarea (so typing, undo, copy and paste are the browser's
 * own) sits on top of a highlighted copy of the text; the gutter shows line numbers, errors, warnings,
 * breakpoints and the line the simulator is on.
 *
 *   const ed = new A51Editor(element, { onChange, onGutterClick });
 *   ed.value / ed.value = text;  ed.setMarks({ messages, breakpoints: Set(lines), pcLine });  ed.goto(line)
 */
(function () {
  'use strict';
  const MN = new Set('ACALL ADD ADDC AJMP ANL CALL CJNE CLR CPL DA DEC DIV DJNZ INC JB JBC JC JMP JNB JNC JNZ JZ LCALL LJMP MOV MOVC MOVX MUL NOP ORL POP PUSH RET RETI RL RLC RR RRC SETB SJMP SUBB SWAP XCH XCHD XRL'.split(' '));
  const DIR = new Set('ORG END DB DW DS DBIT EQU SET DATA IDATA XDATA CODE BIT USING NAME CSEG DSEG BSEG ISEG XSEG AT SEGMENT RSEG PUBLIC EXTRN'.split(' '));
  const REG = new Set('A AB C DPTR PC R0 R1 R2 R3 R4 R5 R6 R7'.split(' '));
  const OPW = new Set('MOD SHL SHR AND OR XOR NOT HIGH LOW EQ NE LT LE GT GE'.split(' '));
  const SFR = new Set(('P0 SP DPL DPH PCON TCON TMOD TL0 TL1 TH0 TH1 P1 SCON SBUF P2 IE P3 IP PSW ACC B ' +
    'IT0 IE0 IT1 IE1 TR0 TF0 TR1 TF1 RI TI RB8 TB8 REN SM2 SM1 SM0 EX0 ET0 EX1 ET1 ES EA RXD TXD INT0 INT1 T0 T1 WR RD ' +
    'PX0 PT0 PX1 PT1 PS P OV RS0 RS1 F0 AC CY AR0 AR1 AR2 AR3 AR4 AR5 AR6 AR7').split(' '));
  const esc = s => s.replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]));

  function highlight(line) {
    if (/^\s*\$/.test(line)) {                     // a control line such as $NOMOD51
      const i = line.indexOf(';');
      return i < 0 ? '<i class="d">' + esc(line) + '</i>' : '<i class="d">' + esc(line.slice(0, i)) + '</i><i class="c">' + esc(line.slice(i)) + '</i>';
    }
    const RE = /(;.*$)|('(?:[^']|'')*'?|"(?:[^"]|"")*"?)|([A-Za-z_?][A-Za-z0-9_?]*)(\s*:)?|(\d[0-9A-Za-z]*)|([#@$])|([^\sA-Za-z0-9_?;'"#@$]+)|(\s+)/g;
    let out = '', m, first = true;
    while ((m = RE.exec(line))) {
      const t = m[0];
      if (m[1]) out += '<i class="c">' + esc(t) + '</i>';
      else if (m[2]) out += '<i class="s">' + esc(t) + '</i>';
      else if (m[3]) {
        const u = m[3].toUpperCase();
        let k = '';
        if (m[4] && first) k = 'l';
        else if (MN.has(u)) k = 'm';
        else if (DIR.has(u)) k = 'd';
        else if (REG.has(u)) k = 'r';
        else if (OPW.has(u)) k = 'o';
        else if (SFR.has(u)) k = 'y';
        out += (k ? '<i class="' + k + '">' + esc(m[3]) + '</i>' : esc(m[3])) + (m[4] ? esc(m[4]) : '');
      } else if (m[5]) out += '<i class="n">' + esc(t) + '</i>';
      else if (m[6]) out += '<i class="o">' + esc(t) + '</i>';
      else out += esc(t);
      if (!m[8]) first = false;
    }
    return out;
  }

  class A51Editor {
    constructor(root, opts) {
      this.opts = opts || {};
      root.classList.add('ed');
      root.innerHTML = '<div class="ed-gutter"><div class="ed-gin"></div></div><div class="ed-main"><pre class="ed-hl" aria-hidden="true"></pre>' +
        '<textarea class="ed-ta" spellcheck="false" autocapitalize="off" autocomplete="off" wrap="off" aria-label="Assembly source"></textarea></div>';
      this.root = root;
      this.ta = root.querySelector('.ed-ta');
      this.hl = root.querySelector('.ed-hl');
      this.gin = root.querySelector('.ed-gin');
      this.marks = { messages: [], breakpoints: new Set(), pcLine: 0 };
      this.pending = false;
      this.ta.addEventListener('input', () => { this.schedule(); if (this.opts.onChange) this.opts.onChange(); });
      this.ta.addEventListener('scroll', () => this.sync());
      this.ta.addEventListener('keydown', e => this.key(e));
      this.gin.addEventListener('click', e => {
        const row = e.target.closest('[data-line]');
        if (row && this.opts.onGutterClick) this.opts.onGutterClick(+row.dataset.line);
      });
      new ResizeObserver(() => this.sync()).observe(root);
      this.render();
    }
    get value() { return this.ta.value; }
    set value(v) { this.ta.value = v; this.ta.scrollTop = 0; this.ta.scrollLeft = 0; this.ta.setSelectionRange(0, 0); this.render(); }
    schedule() { if (!this.pending) { this.pending = true; requestAnimationFrame(() => { this.pending = false; this.render(); }); } }
    setMarks(m) { Object.assign(this.marks, m); this.render(); }
    render() {
      const lines = this.ta.value.split('\n');
      const byLine = new Map();
      for (const msg of this.marks.messages || []) {
        const cur = byLine.get(msg.line);
        if (!cur || (cur.severity === 'warning' && msg.severity === 'error')) byLine.set(msg.line, msg);
      }
      let h = '', g = '';
      for (let i = 0; i < lines.length; i++) {
        const n = i + 1, msg = byLine.get(n);
        const cls = (msg ? (msg.severity === 'error' ? ' err' : ' warn') : '') + (n === this.marks.pcLine ? ' pc' : '');
        h += '<span class="ed-l' + cls + '">' + (highlight(lines[i]) || ' ') + '\n</span>';
        const bp = this.marks.breakpoints.has(n);
        g += '<div data-line="' + n + '" class="' + (bp ? 'bp' : '') + (msg ? ' g' + msg.severity[0] : '') + (n === this.marks.pcLine ? ' gpc' : '') + '"' +
          (msg ? ' title="' + esc(msg.code + ' ' + msg.text) + '"' : '') + '>' + n + '</div>';
      }
      this.hl.innerHTML = h;
      this.gin.innerHTML = g;
      this.sync();
    }
    sync() {
      const x = this.ta.scrollLeft, y = this.ta.scrollTop;
      this.hl.style.transform = 'translate(' + (-x) + 'px,' + (-y) + 'px)';
      this.gin.style.transform = 'translateY(' + (-y) + 'px)';
    }
    lineHeight() { return parseFloat(getComputedStyle(this.ta).lineHeight) || 18; }
    // put the caret on a line (select it) and scroll it into the middle third
    goto(line, select) {
      const lines = this.ta.value.split('\n');
      let pos = 0;
      for (let i = 0; i < line - 1 && i < lines.length; i++) pos += lines[i].length + 1;
      const end = pos + (lines[line - 1] || '').length;
      this.ta.focus({ preventScroll: true });
      this.ta.setSelectionRange(select ? pos : end, end);
      this.reveal(line);
    }
    reveal(line) {
      const lh = this.lineHeight(), top = (line - 1) * lh, h = this.ta.clientHeight;
      if (top < this.ta.scrollTop + lh || top > this.ta.scrollTop + h - 2 * lh) this.ta.scrollTop = Math.max(0, top - h / 3);
      this.sync();
    }
    key(e) {
      if (e.key === 'Tab' && !e.ctrlKey && !e.altKey && !e.metaKey) {
        e.preventDefault();
        document.execCommand('insertText', false, '\t');   // keeps the browser's undo history
      }
    }
  }
  window.A51Editor = A51Editor;
  window.A51Editor.highlight = highlight;
})();
