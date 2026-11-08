// Drives the app (app/index.html) in a separate Chrome over the DevTools protocol and checks what the page shows.
//   start Chrome with --remote-debugging-port=9333 on http://localhost:8833/app/index.html, then
//   node test/ui_test.js [9333] [part of the page URL, default /app/]
// The display is read back from the SVG the page paints (lit segments), not from the model.
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
const dport = process.argv[2] || '9333';
let fails = 0;
const ok = (c, what) => { console.log((c ? 'ok    ' : 'FAIL  ') + what); if (!c) fails++; };
const sleep = ms => new Promise(r => setTimeout(r, ms));

(async () => {
  const targets = await (await fetch('http://127.0.0.1:' + dport + '/json')).json();
  const want = process.argv[3] || '/app/';
  const t = targets.find(x => x.type === 'page' && x.url.includes(want));
  const ws = new WebSocket(t.webSocketDebuggerUrl);
  await new Promise(r => { ws.onopen = r; });
  let id = 0; const pending = new Map(); const logs = [];
  let dialogs = 0;
  ws.onmessage = m => { const d = JSON.parse(m.data); if (d.id && pending.has(d.id)) { pending.get(d.id)(d); pending.delete(d.id); }
    else if (d.method === 'Page.javascriptDialogOpening') { dialogs++; ws.send(JSON.stringify({ id: ++id, method: 'Page.handleJavaScriptDialog', params: { accept: true } })); } else if (d.method === 'Runtime.exceptionThrown') logs.push(d.params.exceptionDetails.text + ' ' + JSON.stringify(d.params.exceptionDetails.exception && d.params.exceptionDetails.exception.description)); else if (d.method === 'Runtime.consoleAPICalled' && d.params.type === 'error') logs.push(JSON.stringify(d.params.args)); };
  const send = (method, params) => new Promise(r => { const i = ++id; pending.set(i, r); ws.send(JSON.stringify({ id: i, method, params: params || {} })); });
  const js = async (expr) => {
    const r = await send('Runtime.evaluate', { expression: '(async () => { ' + expr + ' })()', awaitPromise: true, userGesture: true, returnByValue: true });
    if (r.result.exceptionDetails) throw new Error(JSON.stringify(r.result.exceptionDetails).slice(0, 500));
    return r.result.result.value;
  };
  await send('Runtime.enable');
  await send('Page.enable');
  await js("localStorage.clear(); return 1");
  await send('Page.reload', { ignoreCache: true });
  await sleep(1500);

  // helpers inside the page: read the four digits off the SVG; load an example by its menu id; fast-forward
  await js(`
    window.T = {
      digits() {
        const G = { 0xC0:'0',0xF9:'1',0xA4:'2',0xB0:'3',0x99:'4',0x92:'5',0x82:'6',0xF8:'7',0x80:'8',0x90:'9',0x88:'A',0x83:'b',0xC6:'C',
          0x86:'E',0xC2:'G',0x89:'H',0xC7:'L',0xAB:'n',0xA3:'o',0x8C:'P',0xAF:'r',0x87:'t',0xBF:'-',0xFF:' ' };
        const polys = [...document.querySelectorAll('#board svg g:not(.btn-cap)')].filter(g => g.children.length === 8);
        return polys.map(g => { let code = 0xFF; [...g.children].forEach((n, k) => { if (n.getAttribute('fill') === '#ff4a12' && +n.getAttribute('opacity') > 0.5) code &= ~(1 << k); });
          const ch = G[code | 0x80]; return (ch === undefined ? '?' : ch) + (code & 0x80 ? '' : '.'); }).join('');
      },
      example(id) { const s = document.getElementById('examples'); s.value = id; s.dispatchEvent(new Event('change')); },
      // run the board in JS for ms of board time, then let the page paint a few real frames at real time
      async ff(ms) { STC.stopRun(); STC.board.run(Math.round(ms * 921.6)); STC.startRun(); await new Promise(r => setTimeout(r, 400)); },
      text: id => document.getElementById(id).innerText,
    };
    return 1`);

  // the course programs (Lab 6, the practicals) are not in the public release: the checks that load them are skipped
  const exIds = await js("return window.STC_EXAMPLES.flatMap(g => g.items.map(i => i.id)).join(',')");
  const hasEx = id => exIds.split(',').includes(id);
  const skip = what => console.log('skip  ' + what + ' (that example is not in this copy of the repository)');

  // 1. Ex 2 from the menu: assembled, runs, the first digit counts
  if (!hasEx('ex2')) skip('Ex 2 from the Examples menu');
  else {
  await js("T.example('ex2'); return 1");
  const asmMsg = await js("return T.text('tab-msg')");
  ok(/Assembled: 74 bytes/.test(asmMsg), 'Ex 2 loads from Examples and assembles: ' + asmMsg.split('\n')[0]);
  await js("STC.startRun(); return 1");
  const seen = [];
  for (let k = 0; k < 14; k++) { await sleep(250); seen.push(await js('return T.digits()')); }
  await js("STC.stopRun(); return 1");
  const firsts = [...new Set(seen.map(s => s[0]))].join('');
  ok(/^0+1+2?/.test(seen.map(s => s[0]).join('')) || /012/.test(firsts), 'Ex 2 at real time, digit 1 read off the page every 0.25 s: ' + seen.map(s => s[0]).join(''));
  }

  // 2. a mistake: error listed, the line marked, a click on the message goes to the line
  await js(`STC.ed.value = '        ORG 0\\n        MOV A,#5\\n        MOV R0,UNDEF\\n        SJMP $\\n        END\\n'; STC.ed.ta.dispatchEvent(new Event('input')); document.getElementById('bAsm').click(); return 1`);
  const errText = await js("return T.text('tab-msg')");
  ok(/1 error/.test(errText) && /Line 3/.test(errText) && /A45/.test(errText), 'an undefined symbol: ' + errText.replace(/\n/g, ' | ').slice(0, 120));
  await js("document.querySelector('#tab-msg .msg').click(); return 1");
  const caretLine = await js("const ta = STC.ed.ta; return ta.value.slice(0, ta.selectionStart).split('\\n').length");
  const gutterErr = await js("return !!document.querySelector('.ed-gin div.ge[data-line=\"3\"]')");
  ok(caretLine === 3 && gutterErr, 'clicking the message puts the caret on line ' + caretLine + '; gutter marks line 3: ' + gutterErr);
  const flashRefused = await js("return await STC.flash()");
  ok(/errors|no serial/.test(flashRefused), 'Flash refuses a program with errors: ' + flashRefused);

  // 3. Step: practical 1, two steps, A = 25H. The edited program above makes the page ask before it is replaced.
  if (!hasEx('p01')) skip('practical 1, step by step');
  else {
  await js("T.example('p01'); return 1");
  ok(dialogs === 1, 'loading an example over unsaved changes asks first (' + dialogs + ' dialog)');
  for (let k = 0; k < 2; k++) await js("document.getElementById('bStep').click(); return 1");
  const regs = await js("return T.text('regs').replace(/\\s+/g,' ')");
  const pcInfo = await js("return T.text('pcInfo')");
  ok(/A 25/.test(regs) && /R0 10/.test(regs), 'P1 after two steps: ' + regs.slice(0, 60) + ' / ' + pcInfo);
  const pcLine = await js("const l = document.querySelector('.ed-l.pc'); return l ? [...document.querySelectorAll('.ed-l')].indexOf(l) + 1 : 0");
  ok(pcLine > 0 && new RegExp('line ' + pcLine).test(pcInfo), 'the editor marks the PC line (' + pcLine + ')');
  }

  // 4. a breakpoint on INC R0 of Ex 2 stops the run there
  if (!hasEx('ex2')) skip('a breakpoint in Ex 2');
  else {
  await js("T.example('ex2'); return 1");
  const incLine = await js("return STC.ed.value.split('\\n').findIndex(l => /^\\s*INC\\s+R0/i.test(l)) + 1");
  await js(`document.querySelector('.ed-gin div[data-line="${incLine}"]').click(); STC.startRun(); return 1`);
  await sleep(1600);
  const bpMsg = await js("return T.text('simMsg')");
  ok(new RegExp('breakpoint on line ' + incLine).test(bpMsg), 'breakpoint on line ' + incLine + ': ' + bpMsg);
  await js(`document.querySelector('.ed-gin div[data-line="${incLine}"]').click(); return 1`);
  }

  // 5. demo2: the menu, then S5 pressed with the pointer on the drawn button opens Chrono
  await js("T.example('demo2'); return 1");
  await js("await T.ff(14000); return 1");
  const menu = await js('return T.digits()');
  ok(menu === 'CrLP', 'demo2 after 14 s of board time shows ' + JSON.stringify(menu));
  await js(`const g = document.querySelector('[aria-label^="S5"]'); g.dispatchEvent(new PointerEvent('pointerdown', { bubbles: true, pointerId: 1 })); await new Promise(r => setTimeout(r, 150)); g.dispatchEvent(new PointerEvent('pointerup', { bubbles: true, pointerId: 1 })); return 1`);
  await sleep(300);
  await js("await T.ff(2000); return 1");
  const chrono = await js('return T.digits()');
  ok(chrono.replace(/ /g, '') === '0.00', 'S5 clicked on the board picture opens Chrono: ' + JSON.stringify(chrono));
  await js("STC.stopRun(); return 1");

  // 6. a Keil .hex opened as a file runs the same way
  const hex = fs.readFileSync(path.join(ROOT, 'ref/m1/demo2_keil.hex'), 'utf8');
  await js('STC.loadHex(' + JSON.stringify(hex) + ', "demo2.hex"); return 1');
  const hexMsg = await js("return T.text('tab-msg')");
  await js("await T.ff(14000); return 1");
  const hexMenu = await js('return T.digits()');
  await js("STC.stopRun(); return 1");
  ok(/1753 bytes/.test(hexMsg) && hexMenu === 'CrLP', 'demo2.hex (Keil build) opened: ' + hexMsg.slice(0, 50) + ', shows ' + JSON.stringify(hexMenu));

  // 7. demo 1 with the buzzer: the pin moves and the page shows a pitch
  await js("T.example('demo'); return 1");
  await js("STC.startRun(); return 1");
  let hz = '';
  for (let k = 0; k < 30 && !/Hz/.test(hz); k++) { await sleep(200); hz = await js("return document.querySelector('#board svg').textContent.match(/≈ \\d+ Hz|clicks/) ? document.querySelector('#board svg').textContent.match(/≈ \\d+ Hz|clicks/)[0] : ''"); }
  await js("STC.stopRun(); return 1");
  ok(/Hz/.test(hz), 'demo 1: the buzzer shows a pitch while it plays: ' + hz);

  // 8. the digit reader on the simulated board: a 7 drawn on the Digit pad with the pointer comes back as 7
  await js("T.example('nn'); STC.startRun(); document.querySelector('[data-tab=pad]').click(); return 1");
  await sleep(600);
  const ready = await js("return document.getElementById('serOut').textContent");
  const cells = await js("return [...document.getElementById('pad').children].map(c => { const r = c.getBoundingClientRect(); return [r.x + r.width / 2, r.y + r.height / 2]; })");
  const drag = async (a, b) => {
    await send('Input.dispatchMouseEvent', { type: 'mousePressed', x: cells[a][0], y: cells[a][1], button: 'left', buttons: 1, clickCount: 1 });
    await send('Input.dispatchMouseEvent', { type: 'mouseMoved', x: cells[b][0], y: cells[b][1], button: 'left', buttons: 1 });
    await send('Input.dispatchMouseEvent', { type: 'mouseReleased', x: cells[b][0], y: cells[b][1], button: 'left', buttons: 0, clickCount: 1 });
  };
  await drag(0, 4);            // the top bar, in one quick move
  await drag(9, 31);           // the diagonal down to the bottom row
  await sleep(1500);
  const padState = await js("return STC.pad.join('').match(/.{5}/g).join('|')");
  const ans = await js("return document.getElementById('padAns').textContent");
  const shown = await js("return T.digits()");
  await js("STC.stopRun(); return 1");
  ok(/NN READY/.test(ready) && ans === '7' && shown === 'nn 7' && padState.startsWith('11111'),
    'digit reader: a 7 dragged on the pad (' + padState + ') reads ' + ans + ', the board shows ' + JSON.stringify(shown));

  ok(logs.length === 0, 'no script errors in the page' + (logs.length ? ': ' + logs.slice(0, 3).join(' | ') : ''));
  console.log(fails ? fails + ' FAILED' : 'all UI checks passed');
  ws.close();
  process.exit(fails ? 1 : 0);
})().catch(e => { console.log('FAIL ' + e.message); process.exit(1); });
