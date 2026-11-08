/* app.js: STC Studio. Editor -> assembler (src/asm51.js) -> simulated board (src/board.js on the course CPU)
 * -> real board over Web Serial (src/stcisp.js). */
(function () {
  'use strict';
  const $ = id => document.getElementById(id);
  const CPS = Board.CYCLES_PER_S;
  const KEY = 'stc-studio:';
  const store = {
    get(k) { try { return localStorage.getItem(KEY + k); } catch (e) { return null; } },
    set(k, v) { try { localStorage.setItem(KEY + k, v); } catch (e) { /* private window: nothing kept */ } },
  };
  const hex2 = v => v.toString(16).toUpperCase().padStart(2, '0');
  const hex4 = v => v.toString(16).toUpperCase().padStart(4, '0');
  const esc = s => String(s).replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

  // ------------------------------------------------------------------ state
  const S = {
    name: 'untitled.a51', dirty: false,
    hexMode: false,            // a .hex file is open: no source to assemble
    result: null,              // the last assembler result
    builtFrom: null,           // the source text of that result
    image: null, used: null,   // what the simulator runs and Flash writes
    breakpoints: new Set(),    // source lines
    running: false, raf: 0,
  };
  const board = new Board(window.i8051);
  const buzzer = new Buzzer(CPS);
  board.onBuzzer = (lv, cyc) => buzzer.feed(lv, cyc, speed());
  const speed = () => +$('speed').value;

  // ------------------------------------------------------------------ editor
  const ed = new A51Editor($('editor'), {
    onChange() { setDirty(true); },
    onGutterClick(line) {
      if (S.breakpoints.has(line)) S.breakpoints.delete(line); else S.breakpoints.add(line);
      ed.setMarks({ breakpoints: S.breakpoints });
    },
  });
  function setDirty(d) { S.dirty = d; $('dirty').textContent = d ? '(changed)' : ''; if (d) store.set('src', ed.value); }
  function setName(n) { S.name = n; $('fname').textContent = n; store.set('name', n); }

  const START = [
    '; New program for the TSI STC89C52RC board',
    ';   P0 = segments a-g, dp and LEDs D1-D8 (lit by 0)   P1.3-P1.6 = digits 1-4 (on at 0)',
    ';   P3.5 P3.4 P3.3 P3.2 = buttons S5 S4 S3 S2 (0 when pressed)   P3.6 = buzzer',
    '',
    '        ORG     0000H',
    '        LJMP    MAIN',
    '',
    '        ORG     0030H',
    'MAIN:   MOV     SP,#60H',
    '        MOV     P0,#0FEH        ; 1111 1110: only D1 lit',
    'LOOP:   SJMP    LOOP',
    '',
    '        END',
    '',
  ].join('\n');

  function loadSource(text, name) {
    stopRun();
    S.hexMode = false;
    ed.ta.readOnly = false;
    ed.value = text;
    setName(name);
    setDirty(false);
    store.set('src', text);
    S.breakpoints.clear();
    S.result = null; S.builtFrom = null; S.image = null;
    ed.setMarks({ messages: [], breakpoints: S.breakpoints, pcLine: 0 });
    $('tab-lst').textContent = '';
    showMessages(null);
    $('bHex').disabled = true;
    assemble();
  }
  function loadHex(text, name) {
    let h;
    try { h = ASM51.readHex(text); } catch (e) { setSummary('This is not an Intel HEX file: ' + e.message, 'bad'); return; }
    stopRun();
    S.hexMode = true;
    ed.value = '; ' + name + ': an Intel HEX file, ' + h.size + ' bytes (0000H to ' + hex4(Math.max(0, h.top - 1)) + 'H).\n' +
      '; There is no source to assemble: Run and Flash use these bytes as they are.\n;\n' + text.split(/\r?\n/).map(l => '; ' + l).join('\n');
    ed.ta.readOnly = true;
    setName(name);
    setDirty(false);
    S.result = null; S.builtFrom = null;
    S.image = h.image; S.used = h.used;
    ed.setMarks({ messages: [], pcLine: 0 });
    $('tab-lst').textContent = '';
    setSummary('Opened ' + name + ': ' + h.size + ' bytes ready to run and to flash.', 'ok');
    $('bHex').disabled = true;
    board.load(S.image);
    paintAll();
  }

  // ------------------------------------------------------------------ assemble
  function assemble() {
    if (S.hexMode) return true;
    const text = ed.value;
    const r = ASM51.assemble(text, { name: S.name });
    S.result = r; S.builtFrom = text;
    ed.setMarks({ messages: r.messages });
    $('tab-lst').textContent = r.listing;
    showMessages(r);
    $('bHex').disabled = !r.ok;
    if (r.ok) {
      stopRun();
      S.image = r.image; S.used = r.used;
      board.load(S.image);
      paintAll();
    }
    return r.ok;
  }
  function upToDate() { return S.hexMode || (S.result && S.builtFrom === ed.value && S.result.ok); }
  function showMessages(r) {
    const box = $('tab-msg');
    if (!r) { box.innerHTML = '<div class="summary">Write a program or pick one from Examples, then Assemble.</div>'; $('msgCount').textContent = ''; return; }
    const errs = r.messages.filter(m => m.severity === 'error').length, warns = r.messages.length - errs;
    let head;
    if (r.ok) {
      const pct = (100 * r.top / 8192).toFixed(0);
      head = '<div class="summary ok">Assembled: ' + r.size + ' bytes of code, 0000H to ' + hex4(Math.max(0, r.top - 1)) + 'H (' + pct +
        ' % of the 8 KB flash). ' + (warns ? warns + ' warning' + (warns > 1 ? 's' : '') + '.' : 'No errors.') + '</div>';
    } else head = '<div class="summary bad">' + errs + ' error' + (errs > 1 ? 's' : '') + (warns ? ', ' + warns + ' warning' + (warns > 1 ? 's' : '') : '') +
      '. Click a line to go to it.</div>';
    const lines = ed.value.split('\n');
    box.innerHTML = head + r.messages.map(m => '<div class="msg" data-line="' + m.line + '"><span>Line ' + m.line + '</span><span class="sev-' + m.severity + '">' +
      m.severity + ' ' + m.code + '</span><span>' + esc(m.text) + '<code>' + esc((lines[m.line - 1] || '').trim()) + '</code></span></div>').join('');
    $('msgCount').textContent = r.messages.length ? '(' + r.messages.length + ')' : '';
    showTab('msg');
  }
  function setSummary(text, cls) { $('tab-msg').innerHTML = '<div class="summary ' + (cls || '') + '">' + esc(text) + '</div>'; showTab('msg'); }
  $('tab-msg').addEventListener('click', e => { const m = e.target.closest('[data-line]'); if (m) ed.goto(+m.dataset.line, true); });
  function showTab(t) {
    for (const b of document.querySelectorAll('.tabs button')) b.classList.toggle('on', b.dataset.tab === t);
    for (const k of ['msg', 'lst', 'ser', 'pad']) $('tab-' + k).classList.toggle('hidden', k !== t);
  }
  for (const b of document.querySelectorAll('.tabs button')) b.onclick = () => showTab(b.dataset.tab);

  // ------------------------------------------------------------------ the board picture
  const NS = 'http://www.w3.org/2000/svg';
  const el = (tag, attrs, parent) => { const e = document.createElementNS(NS, tag); for (const k in attrs) e.setAttribute(k, attrs[k]); if (parent) parent.appendChild(e); return e; };
  const text = (x, y, s, size, parent, anchor, fill) => { const t = el('text', { x, y, 'font-size': size, 'text-anchor': anchor || 'middle', fill: fill || '#d6def5', 'font-family': 'Inter, Segoe UI, sans-serif' }, parent); t.textContent = s; return t; };
  const P = {};
  function buildBoard() {
    const svg = el('svg', { viewBox: '0 0 520 330', role: 'img', 'aria-label': 'Simulated STC89C52RC board' });
    const defs = el('defs', {}, svg);
    const f = el('filter', { id: 'glow', x: '-50%', y: '-50%', width: '200%', height: '200%' }, defs);
    el('feGaussianBlur', { stdDeviation: '2.2', result: 'b' }, f);
    const mg = el('feMerge', {}, f); el('feMergeNode', { in: 'b' }, mg); el('feMergeNode', { in: 'SourceGraphic' }, mg);
    el('rect', { x: 2, y: 2, width: 516, height: 326, rx: 14, fill: '#173a86', stroke: '#0e2a66', 'stroke-width': 3 }, svg);
    for (const [cx, cy] of [[18, 18], [502, 18], [18, 312], [502, 312]]) el('circle', { cx, cy, r: 6, fill: '#0b1f4d' }, svg);
    // 4-digit display
    el('rect', { x: 28, y: 26, width: 300, height: 118, rx: 6, fill: '#0c0c0c', stroke: '#2c2c2c' }, svg);
    P.seg = [];
    const T = 9;
    const hs = (x0, x1, y) => [[x0, y], [x0 + T / 2, y - T / 2], [x1 - T / 2, y - T / 2], [x1, y], [x1 - T / 2, y + T / 2], [x0 + T / 2, y + T / 2]];
    const vs = (x, y0, y1) => [[x, y0], [x + T / 2, y0 + T / 2], [x + T / 2, y1 - T / 2], [x, y1], [x - T / 2, y1 - T / 2], [x - T / 2, y0 + T / 2]];
    const pts = a => a.map(p => p[0].toFixed(1) + ',' + p[1].toFixed(1)).join(' ');
    for (let d = 0; d < 4; d++) {
      const x = 52 + d * 70, y = 40, w = 40, h = 86, sk = 6;          // slight slant, like the real digits
      const sl = (p) => p.map(([px, py]) => [px + sk * (1 - (py - y) / h), py]);
      const polys = [hs(x + 2, x + w - 2, y), vs(x + w, y + 2, y + h / 2 - 2), vs(x + w, y + h / 2 + 2, y + h - 2), hs(x + 2, x + w - 2, y + h),
        vs(x, y + h / 2 + 2, y + h - 2), vs(x, y + 2, y + h / 2 - 2), hs(x + 2, x + w - 2, y + h / 2)];
      const g = el('g', {}, svg);
      const segs = polys.map(p => el('polygon', { points: pts(sl(p)), fill: '#ff4a12' }, g));
      segs.push(el('circle', { cx: x + w + 10, cy: y + h, r: 4.5, fill: '#ff4a12' }, g));
      P.seg.push(segs);
      text(x + 20, 140, 'P1.' + (3 + d), 9, svg, 'middle', '#7f90b8');
    }
    // buzzer
    el('circle', { cx: 400, cy: 70, r: 34, fill: '#111' }, svg);
    el('circle', { cx: 400, cy: 70, r: 6, fill: '#2a2a2a' }, svg);
    P.waves = [el('path', { d: 'M440 50 Q452 70 440 90', stroke: '#9fd0ff', 'stroke-width': 3, fill: 'none', 'stroke-linecap': 'round', opacity: 0 }, svg),
      el('path', { d: 'M450 40 Q467 70 450 100', stroke: '#9fd0ff', 'stroke-width': 3, fill: 'none', 'stroke-linecap': 'round', opacity: 0 }, svg)];
    text(400, 122, 'buzzer P3.6', 10, svg);
    P.hz = text(400, 138, '', 11, svg, 'middle', '#ffffff');
    // the chip
    el('rect', { x: 28, y: 168, width: 300, height: 66, rx: 4, fill: '#1e9e8c' }, svg);
    el('rect', { x: 46, y: 176, width: 264, height: 50, rx: 3, fill: '#151515' }, svg);
    for (let k = 0; k < 20; k++) { el('rect', { x: 50 + k * 13, y: 170, width: 6, height: 5, fill: '#c9c9c9' }, svg); el('rect', { x: 50 + k * 13, y: 227, width: 6, height: 5, fill: '#c9c9c9' }, svg); }
    text(178, 206, 'STC89C52RC', 16, svg, 'middle', '#cfcfcf');
    text(178, 222, '11.0592 MHz, 12T', 9, svg, 'middle', '#8a8a8a');
    // LEDs D1 (top) to D8 (bottom)
    P.led = [];
    for (let k = 0; k < 8; k++) {
      const y = 166 + k * 19;
      el('circle', { cx: 455, cy: y, r: 7.5, fill: '#3a1209', stroke: '#5c2414' }, svg);
      P.led.push(el('circle', { cx: 455, cy: y, r: 7, fill: '#ff3b12', opacity: 0 }, svg));
      text(432, y + 3.5, 'D' + (k + 1), 9.5, svg, 'end');
      text(474, y + 3.5, 'P0.' + k, 8.5, svg, 'start', '#7f90b8');
    }
    // buttons S5 S4 S3 S2, then RST
    P.btn = {};
    const BTN = [['S5', 'P3.5'], ['S4', 'P3.4'], ['S3', 'P3.3'], ['S2', 'P3.2'], ['RST', 'reset']];
    BTN.forEach(([name, pin], k) => {
      const cx = 64 + k * 66, cy = 282;
      const g = el('g', { class: 'btn-cap', role: 'button', 'aria-label': name + ' (' + pin + ')', tabindex: 0 }, svg);
      el('rect', { x: cx - 20, y: cy - 20, width: 40, height: 40, rx: 4, fill: '#d8d8d8', stroke: '#9a9a9a' }, g);
      const cap = el('circle', { cx, cy, r: 12, fill: '#1c1c1c' }, g);
      text(cx, cy - 26, name, 11, svg);
      text(cx, cy + 34, pin, 8.5, svg, 'middle', '#7f90b8');
      P.btn[name] = { g, cap, down: false };
      const press = (down) => { P.btn[name].down = down; cap.setAttribute('r', down ? 10 : 12); cap.setAttribute('fill', down ? '#4a4a4a' : '#1c1c1c'); buttonChanged(name, down); };
      g.addEventListener('pointerdown', e => { e.preventDefault(); g.setPointerCapture(e.pointerId); press(true); });
      g.addEventListener('pointerup', () => press(false));
      g.addEventListener('pointercancel', () => press(false));
      g.addEventListener('keydown', e => { if (e.key === ' ' || e.key === 'Enter') { e.preventDefault(); if (!P.btn[name].down) press(true); } });
      g.addEventListener('keyup', e => { if (e.key === ' ' || e.key === 'Enter') press(false); });
      P.btn[name].press = press;
    });
    $('board').appendChild(svg);
  }
  function buttonChanged(name, down) {
    if (name === 'RST') { if (!down) { board.reset(); paintAll(); simMsg('Reset: the program starts again from 0000H.'); } return; }
    board.setButton(name, down);
    if (!S.running) paintRegs();
  }
  // brightness: share of time lit, eased like the eye sees a multiplexed display
  const shown = { seg: new Float32Array(32), led: new Float32Array(8) };
  function paintBoard(fr, dtMs) {
    const a = dtMs ? 1 - Math.exp(-dtMs / 35) : 1;
    for (let i = 0; i < 32; i++) shown.seg[i] += (Math.min(1, fr.seg[i] * 4) - shown.seg[i]) * a;
    for (let i = 0; i < 8; i++) shown.led[i] += (fr.led[i] - shown.led[i]) * a;
    for (let d = 0; d < 4; d++) for (let k = 0; k < 8; k++) {
      const v = shown.seg[d * 8 + k];
      const node = P.seg[d][k];
      node.setAttribute('fill', v < 0.02 ? '#2a120c' : '#ff4a12');
      node.setAttribute('opacity', v < 0.02 ? 1 : (0.3 + 0.7 * Math.sqrt(v)).toFixed(3));
      if (v >= 0.02) node.setAttribute('filter', 'url(#glow)'); else node.removeAttribute('filter');
    }
    for (let k = 0; k < 8; k++) {
      const v = shown.led[k];
      P.led[k].setAttribute('opacity', v < 0.01 ? 0 : (0.25 + 0.75 * Math.sqrt(v)).toFixed(3));
      if (v >= 0.01) P.led[k].setAttribute('filter', 'url(#glow)'); else P.led[k].removeAttribute('filter');
    }
    const on = buzzer.act > 0.01;
    P.waves[0].setAttribute('opacity', on ? Math.min(1, 0.35 + buzzer.act * 2).toFixed(2) : 0);
    P.waves[1].setAttribute('opacity', on ? Math.min(1, 0.2 + buzzer.act * 1.5).toFixed(2) : 0);
    P.hz.textContent = buzzer.label();
  }

  // ------------------------------------------------------------------ registers
  let prevRegs = {};
  function paintRegs() {
    const c = board.cpu;
    const bank = (c.psw >> 3) & 3;
    const t2 = c.sfrOther;
    const cells = [
      ['A', hex2(c.acc)], ['B', hex2(c.b)], ['SP', hex2(c.sp)], ['DPTR', hex4(c.dptr())],
      ['PC', hex4(c.pc)], ['PSW', hex2(c.psw)], ['CY AC OV', ((c.psw >> 7) & 1) + ' ' + ((c.psw >> 6) & 1) + ' ' + ((c.psw >> 2) & 1)], ['bank', String(bank)],
    ];
    for (let n = 0; n < 8; n++) cells.push(['R' + n, hex2(c.lowRAM[bank * 8 + n])]);
    cells.push(['P0', hex2(c.p0 & c.pins[0])], ['P1', hex2(c.p1 & c.pins[1])], ['P2', hex2(c.p2 & c.pins[2])], ['P3', hex2(c.p3 & c.pins[3])]);
    cells.push(['TMOD', hex2(c.tmod)], ['TCON', hex2(c.tcon)], ['IE', hex2(c.ie)], ['IP', hex2(c.ip)]);
    cells.push(['T0', hex2(c.th0) + hex2(c.tl0)], ['T1', hex2(c.th1) + hex2(c.tl1)], ['T2', hex2(t2[0x4D]) + hex2(t2[0x4C])], ['T2CON', hex2(t2[0x48])]);
    const now = {};
    $('regs').innerHTML = cells.map(([k, v]) => { now[k] = v; const chg = prevRegs[k] !== undefined && prevRegs[k] !== v; return '<span class="k">' + k + '</span><span class="v' + (chg ? ' chg' : '') + '">' + v + '</span>'; }).join('');
    prevRegs = now;
    const line = lineOfPC();
    $('pcInfo').textContent = 'PC ' + hex4(c.pc) + 'H' + (line ? ', line ' + line : '');
    $('simTime').textContent = (c.cycles / CPS).toFixed(3) + ' s';
  }
  function lineOfPC() { return S.result && !S.hexMode ? S.result.addrLine[board.cpu.pc] || 0 : 0; }
  function paintAll() { paintBoard(board.frame(), 0); paintRegs(); markPC(false); }
  function markPC(scroll) {
    const line = S.running ? 0 : lineOfPC();
    ed.setMarks({ pcLine: line });
    if (scroll && line) ed.reveal(line);
  }
  function simMsg(s, cls) { $('simMsg').textContent = s; $('simMsg').className = 'status ' + (cls || ''); }

  // ------------------------------------------------------------------ running
  function ready() {
    if (S.hexMode) return !!S.image;
    if (!upToDate()) { if (!assemble()) { simMsg('Fix the errors first (see Messages).', 'bad'); return false; } }
    return !!S.image;
  }
  function bpAddrs() {
    const set = new Set();
    if (!S.result || S.hexMode) return set;
    for (const l of S.result.lines) if (S.breakpoints.has(l.line)) set.add(l.addr);
    return set;
  }
  let last = 0, owe = 0, lastPanel = 0;
  function frame(now) {
    if (!S.running) return;
    const dt = Math.min(100, now - last); last = now;
    owe += dt / 1000 * CPS * speed();
    const budget = Math.min(owe, CPS * 0.15);
    const ran = board.run(budget, bpAddrs());
    owe = Math.max(0, owe - ran);
    if (owe > CPS * 0.15) owe = 0;                  // the computer cannot keep up: drop the backlog, keep going
    paintBoard(board.frame(), dt);
    buzzer.flush();
    if (speed() <= 0.01 || now - lastPanel > 120) { paintRegs(); lastPanel = now; }
    if (board.stop) {
      const why = board.stop.why;
      stopRun();
      simMsg(why === 'breakpoint' ? 'Stopped at the breakpoint on line ' + lineOfPC() + '.' : 'Stopped: ' + why + '.', why === 'breakpoint' ? '' : 'bad');
      markPC(true);
      board.stop = null;
      return;
    }
    S.raf = requestAnimationFrame(frame);
  }
  function startRun() {
    if (S.running || !ready()) return;
    S.running = true; last = performance.now(); owe = 0;
    board.stop = null;
    buzzer.prime(((board.cpu.p3 & board.cpu.pins[3]) >> 6) & 1);
    $('bRun').textContent = 'Pause';
    markPC(false);
    simMsg('Running at ' + $('speed').selectedOptions[0].text.toLowerCase() + '.');
    S.raf = requestAnimationFrame(frame);
  }
  function stopRun() {
    if (!S.running) return;
    S.running = false; cancelAnimationFrame(S.raf);
    $('bRun').textContent = 'Run';
    buzzer.quiet();
    paintAll();
    simMsg('Paused. Step goes one instruction at a time.');
  }
  function step() {
    if (!ready()) return;
    stopRun();
    board.stop = null;
    board.step();
    if (board.stop) simMsg('Stopped: ' + board.stop.why + '.', 'bad');
    else simMsg('Ran one instruction.');
    paintBoard(board.frame(), 0);
    paintRegs();
    markPC(true);
  }
  $('bRun').onclick = () => (S.running ? stopRun() : startRun());
  $('bStep').onclick = step;
  $('bReset').onclick = () => { const was = S.running; stopRun(); if (!ready()) return; board.reset(); paintAll(); simMsg('Reset: the program starts again from 0000H.'); if (was) startRun(); };
  $('speed').onchange = () => { if (S.running) simMsg('Running at ' + $('speed').selectedOptions[0].text.toLowerCase() + '.'); };
  $('bSound').onclick = async () => {
    const on = $('bSound').getAttribute('aria-pressed') !== 'true';
    const okSound = await buzzer.enable(on);
    $('bSound').setAttribute('aria-pressed', String(on && okSound));
    $('bSound').textContent = on && okSound ? 'Sound on' : 'Sound off';
    if (on && !okSound) simMsg('This browser gives the page no sound.', 'bad');
  };

  // ------------------------------------------------------------------ serial: the simulated board or the real one
  // The Serial tab and the Digit pad talk to one of them ("Talk to"); what the other one sends is not shown.
  const serTo = () => $('serTo').value;
  const lineBuf = { sim: '', board: '' };
  function serialShow(b, from) {
    if (from !== serTo()) return;
    const out = $('serOut');
    out.textContent = (out.textContent + (b === 13 ? '' : String.fromCharCode(b))).slice(-20000);
    out.scrollTop = out.scrollHeight;
    if (b === 10) { padAnswer(lineBuf[from]); lineBuf[from] = ''; }
    else if (b !== 13) lineBuf[from] = (lineBuf[from] + String.fromCharCode(b)).slice(-200);
  }
  board.onSerial = b => serialShow(b, 'sim');
  async function serialSend(text) {
    const bytes = Array.from(new TextEncoder().encode(text));
    if (serTo() === 'sim') { board.serialIn(bytes); return S.running; }
    if (flashing) return false;
    await openPort();
    await transport.write(Uint8Array.from(bytes));
    startListen();
    return true;
  }
  $('serIn').addEventListener('keydown', async e => {
    if (e.key !== 'Enter') return;
    const t = $('serIn').value + '\r';
    $('serIn').value = '';
    try { await serialSend(t); } catch (err) { fmsg('Nothing sent: ' + err.message + '.', 'warn'); }
  });
  $('serTo').onchange = async () => {
    const real = serTo() === 'board';
    $('serIn').placeholder = 'Text for the ' + (real ? 'real' : 'simulated') + " board's serial port (Enter sends it)";
    $('serOut').textContent = '';
    if (!real) { await stopListen(); return; }
    try { await openPort(); startListen(); padMsg('Talking to the real board at 19200 baud.'); }
    catch (err) { $('serTo').value = 'sim'; padMsg(err && err.name === 'NotFoundError' ? 'No port chosen.' : 'The port did not open: ' + err.message, 'warn'); }
  };

  // ------------------------------------------------------------------ digit pad (for the Digit reader example)
  // 5 x 7 squares; Send writes D and 35 characters (1 = lit), row by row from the top left.
  // An answer line "=7 FFFFE2 000134 ..." (the digit and 10 scores in hex) is drawn as bars.
  const pad = new Array(35).fill(0);
  let padPaint = -1, padTimer = 0, padWait = 0;
  const padMsg = (t, cls) => { $('padMsg').textContent = t; $('padMsg').className = 'status ' + (cls || ''); };
  for (let i = 0; i < 35; i++) { const c = document.createElement('div'); c.dataset.i = i; $('pad').appendChild(c); }
  const padCell = e => { const el = document.elementFromPoint(e.clientX, e.clientY); return el && el.parentNode === $('pad') ? +el.dataset.i : -1; };
  function padSet(i, v) {
    if (i < 0 || pad[i] === v) return;
    pad[i] = v; $('pad').children[i].classList.toggle('on', !!v);
    if ($('padAuto').checked) { clearTimeout(padTimer); padTimer = setTimeout(padSend, 120); }
  }
  let padLast = null;
  $('pad').addEventListener('pointerdown', e => {
    const i = padCell(e); if (i < 0) return;
    e.preventDefault(); padPaint = pad[i] ? 0 : 1; padSet(i, padPaint); $('pad').setPointerCapture(e.pointerId);
    padLast = { clientX: e.clientX, clientY: e.clientY };
  });
  // a quick stroke jumps over squares between two mouse events: paint every square along the way
  $('pad').addEventListener('pointermove', e => {
    if (padPaint < 0) return;
    const n = Math.max(1, Math.ceil(Math.hypot(e.clientX - padLast.clientX, e.clientY - padLast.clientY) / 4));
    for (let k = 1; k <= n; k++) padSet(padCell({ clientX: padLast.clientX + (e.clientX - padLast.clientX) * k / n, clientY: padLast.clientY + (e.clientY - padLast.clientY) * k / n }), padPaint);
    padLast = { clientX: e.clientX, clientY: e.clientY };
  });
  const padUp = () => { padPaint = -1; };
  $('pad').addEventListener('pointerup', padUp);
  $('pad').addEventListener('pointercancel', padUp);
  async function padSend() {
    clearTimeout(padTimer);
    let ok;
    try { ok = await serialSend('D' + pad.join('')); } catch (err) { padMsg('Nothing sent: ' + err.message + '.', 'warn'); return false; }
    if (!ok) { padMsg(serTo() === 'sim' ? 'The simulated board is not running: press Run (F5).' : 'The board is being written; try again in a moment.', 'warn'); return false; }
    clearTimeout(padWait);
    padWait = setTimeout(() => padMsg('No answer yet. Is the Digit reader example running on the ' + (serTo() === 'sim' ? 'simulated' : 'real') + ' board?', 'warn'), 1500);
    return true;
  }
  function padAnswer(line) {
    const m = /^=(\d)((?: [0-9A-F]{6}){10})$/.exec(line.trim());
    if (!m) return;
    clearTimeout(padWait);
    const sc = m[2].trim().split(' ').map(h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; });
    const lo = Math.min(...sc), hi = Math.max(...sc), d = +m[1];
    $('padAns').textContent = d;
    $('padBars').innerHTML = sc.map((v, k) => '<b>' + k + '</b><i class="' + (k === d ? 'win' : '') + '" style="width:' +
      (hi > lo ? 4 + 96 * (v - lo) / (hi - lo) : 100).toFixed(0) + '%"></i><span>' + v + '</span>').join('');
    padMsg('The ' + (serTo() === 'sim' ? 'simulated' : 'real') + ' board reads ' + d + '. The bars are its 10 scores; the longest wins.', 'ok');
  }
  $('padSend').onclick = padSend;
  $('padClear').onclick = () => {
    for (let i = 0; i < 35; i++) { pad[i] = 0; $('pad').children[i].classList.remove('on'); }
    $('padAns').textContent = '?'; $('padBars').innerHTML = '';
  };

  // ------------------------------------------------------------------ files
  $('bNew').onclick = () => { if (S.dirty && !confirmLose()) return; loadSource(START, 'untitled.a51'); };
  $('bOpen').onclick = () => $('fileIn').click();
  $('fileIn').onchange = async () => {
    const f = $('fileIn').files[0]; $('fileIn').value = '';
    if (!f) return;
    if (S.dirty && !confirmLose()) return;
    const t = await f.text();
    if (/\.(hex|ihx)$/i.test(f.name)) loadHex(t, f.name); else loadSource(t.replace(/\r\n?/g, '\n'), f.name);
  };
  function confirmLose() { return window.confirm('The program has changes that are not saved. Leave them?'); }
  function download(name, text, type) {
    const a = document.createElement('a');
    a.href = URL.createObjectURL(new Blob([text], { type }));
    a.download = name; document.body.appendChild(a); a.click(); a.remove();
    setTimeout(() => URL.revokeObjectURL(a.href), 2000);
  }
  $('bSave').onclick = () => { if (S.hexMode) return; download(S.name, ed.value.replace(/\n/g, '\r\n'), 'text/plain'); setDirty(false); };
  $('bHex').onclick = () => { if (S.result && S.result.hex) download(S.name.replace(/\.[^.]*$/, '') + '.hex', S.result.hex, 'text/plain'); };
  // examples
  const exSel = $('examples');
  for (const g of window.STC_EXAMPLES) {
    const og = document.createElement('optgroup'); og.label = g.group;
    for (const it of g.items) { const o = document.createElement('option'); o.value = it.id; o.textContent = it.title; og.appendChild(o); }
    exSel.appendChild(og);
  }
  exSel.onchange = () => {
    const id = exSel.value; exSel.value = '';
    if (!id) return;
    if (S.dirty && !confirmLose()) return;
    for (const g of window.STC_EXAMPLES) for (const it of g.items) if (it.id === id) loadSource(it.source, it.file);
  };
  $('bAsm').onclick = assemble;
  $('bTheme').onclick = () => {
    const dark = document.documentElement.getAttribute('data-theme') === 'dark' ||
      (!document.documentElement.getAttribute('data-theme') && matchMedia('(prefers-color-scheme: dark)').matches);
    document.documentElement.setAttribute('data-theme', dark ? 'light' : 'dark');
    store.set('theme', dark ? 'light' : 'dark');
  };

  // ------------------------------------------------------------------ the real board
  let port = null, transport = null, flashing = false;
  const flog = s => { const p = $('flashLog'); p.textContent = (p.textContent + new Date().toISOString().slice(11, 23) + '  ' + s + '\n').slice(-30000); p.scrollTop = p.scrollHeight; };
  const fmsg = (s, cls) => { $('flashMsg').textContent = s; $('flashMsg').className = 'status ' + (cls || ''); };
  function showPort() {
    if (!port) { $('portInfo').textContent = 'USB: not chosen'; return; }
    const i = port.getInfo();
    $('portInfo').textContent = 'USB ' + hex4(i.usbVendorId || 0).toLowerCase() + ':' + hex4(i.usbProductId || 0).toLowerCase() + (transport ? ', open' : '');
    $('bRelease').disabled = !transport;
  }
  async function choosePort() {
    port = await navigator.serial.requestPort({ filters: [{ usbVendorId: 0x1A86 }, { usbVendorId: 0x10C4 }, { usbVendorId: 0x0403 }, { usbVendorId: 0x067B }] });
    if (transport) { try { await transport.close(); } catch (e) { /* the old port is gone */ } transport = null; }
    showPort();
    return port;
  }
  if ('serial' in navigator) {
    navigator.serial.getPorts().then(ps => { if (ps.length && !port) { port = ps[0]; showPort(); } });
    navigator.serial.addEventListener('disconnect', e => { if (e.target === port) { port = null; transport = null; showPort(); fmsg('The board was unplugged.', 'warn'); } });
  }
  $('bPort').onclick = async () => {
    if (!('serial' in navigator)) { fmsg('This browser cannot reach USB serial ports. Use Chrome or Edge on a computer.', 'bad'); return; }
    try { await choosePort(); fmsg('Port chosen. Flash to board writes the program.'); } catch (e) { fmsg('No port chosen.', 'warn'); }
  };
  $('bRelease').onclick = async () => {
    if (!transport) return;
    await stopListen();
    if (serTo() === 'board') $('serTo').value = 'sim';
    try { await transport.close(); flog('port closed'); } catch (e) { flog('close: ' + e.message); }
    transport = null; showPort(); fmsg('Port released. AiCube-ISP or another program can use it now.');
  };
  // open the chosen port at 19200 baud and keep it open (the bootloader and the Digit reader both use 19200)
  async function openPort() {
    if (!('serial' in navigator)) throw new Error('this browser cannot reach USB serial ports; use Chrome or Edge on a computer');
    if (!port) await choosePort();
    if (transport) return;
    transport = new StcIsp.WebSerialTransport(port, 19200);
    try { await transport.open(); }
    catch (e) { transport = null; throw new Error('the port is busy or gone (close AiCube-ISP if it is open): ' + e.message); }
    flog('port open at 19200 baud');
    showPort();
  }
  // while the page talks to the real board, a loop reads what the board sends; Flash stops it first
  let listenOn = false, listening = null;
  function startListen() {
    if (listenOn || !transport || flashing) return;
    listenOn = true;
    listening = (async () => {
      try { while (listenOn && transport) { const d = await transport.read(120); for (const b of d) serialShow(b, 'board'); } }
      catch (e) { if (listenOn) fmsg('Reading from the board stopped: ' + e.message + '.', 'warn'); }
      listenOn = false;
    })();
  }
  async function stopListen() { listenOn = false; if (listening) await listening; listening = null; }
  async function flash() {
    if (flashing) return 'busy';
    if (!('serial' in navigator)) { fmsg('This browser cannot reach USB serial ports. Use Chrome or Edge on a computer.', 'bad'); return 'no serial'; }
    if (!S.hexMode && !upToDate() && !assemble()) { fmsg('The program has errors (see Messages). Nothing was written.', 'bad'); return 'errors'; }
    if (!S.image) { fmsg('There is no program to write yet.', 'bad'); return 'empty'; }
    flashing = true; $('bFlash').disabled = true;
    await stopListen();
    const t0 = performance.now();
    let hint = null, done = false;
    try {
      await openPort();
      const isp = new StcIsp(transport, { log: flog, progress: (n, total) => { $('flashBar').max = total; $('flashBar').value = n; } });
      $('flashBar').value = 0;
      fmsg('Restarting the chip...');
      hint = setTimeout(() => fmsg('No answer yet. If the board does not restart by itself, switch it off and on now.', 'warn'), 2500);
      const info = await isp.connect({ timeoutMs: 15000 });
      clearTimeout(hint);
      fmsg('Writing ' + S.name + ' to the ' + info.model + '...');
      const r = await isp.program(S.image, S.used);
      const secs = ((performance.now() - t0) / 1000).toFixed(1);
      fmsg('Done: ' + r.bytes + ' bytes written and checked in ' + secs + ' s. The board runs ' + S.name + ' now; the Serial tab and the Digit pad talk to it.', 'ok');
      flog('done in ' + secs + ' s');
      done = true;
      return 'ok ' + secs;
    } catch (e) {
      clearTimeout(hint);
      if (e && e.name === 'NotFoundError') { fmsg('No port chosen.', 'warn'); return 'no port'; }
      fmsg('Stopped: ' + e.message + '.', 'bad');
      flog('ERROR ' + e.message);
      return 'error ' + e.message;
    } finally {
      flashing = false; $('bFlash').disabled = false;
      if (done && serTo() !== 'board') { $('serTo').value = 'board'; $('serOut').textContent = ''; $('serIn').placeholder = "Text for the real board's serial port (Enter sends it)"; }
      if (serTo() === 'board') startListen();
    }
  }
  $('bFlash').onclick = flash;
  window.STC = { flash, assemble, board, ed, state: S, loadSource, loadHex, startRun, stopRun, step, padSend, pad };   // for tests

  // ------------------------------------------------------------------ keys
  const HOLD = { '5': 'S5', '4': 'S4', '3': 'S3', '2': 'S2' };
  document.addEventListener('keydown', e => {
    if (e.key === 'F7') { e.preventDefault(); assemble(); }
    else if (e.key === 'F5') { e.preventDefault(); S.running ? stopRun() : startRun(); }
    else if (e.key === 'F10') { e.preventDefault(); step(); }
    else if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 's') { e.preventDefault(); $('bSave').click(); }
    else if (HOLD[e.key] && !e.repeat && !/TEXTAREA|INPUT|SELECT/.test(document.activeElement.tagName)) P.btn[HOLD[e.key]].press(true);
  });
  document.addEventListener('keyup', e => { if (HOLD[e.key] && P.btn[HOLD[e.key]].down) P.btn[HOLD[e.key]].press(false); });

  // ------------------------------------------------------------------ start
  const theme = store.get('theme');
  if (theme) document.documentElement.setAttribute('data-theme', theme);
  buildBoard();
  const saved = store.get('src');
  if (saved !== null) { ed.value = saved; setName(store.get('name') || 'untitled.a51'); setDirty(false); assemble(); }
  else loadSource(START, 'untitled.a51');
})();
