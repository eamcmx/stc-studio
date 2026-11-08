// Runs the programmer code of the web page (src/stcisp.js) against the real board from node, through
// tools/serial_bridge.py (pyserial). Same protocol code as the page; only the transport differs.
//   node test/board_node.js COM13 <file.hex|file.a51> [baud]
// An .a51/.asm file is assembled first with src/asm51.js.
'use strict';
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const A = require('../src/asm51.js');
const StcIsp = require('../src/stcisp.js');

const [, , port, file, baudArg] = process.argv;
const baud = +baudArg || 19200;
const PY = path.join(__dirname, '..', '.venv', 'Scripts', 'python.exe');

class BridgeTransport {
  constructor(port, baud) {
    this.baud = baud;
    this.rx = [];
    this.waiters = [];
    this.p = spawn(PY, [path.join(__dirname, '..', 'tools', 'serial_bridge.py'), port, String(baud)]);
    let acc = '';
    this.p.stdout.on('data', d => {
      acc += d.toString();
      let i;
      while ((i = acc.indexOf('\n')) >= 0) {
        const line = acc.slice(0, i).trim(); acc = acc.slice(i + 1);
        if (line.startsWith('R ')) { for (const b of Buffer.from(line.slice(2), 'hex')) this.rx.push(b); this.wake(); }
        else if (line === 'OK' || line === 'READY') { const w = this.waiters.shift(); if (w) w(); }
        else if (line.startsWith('ERR')) { console.log('bridge: ' + line); const w = this.waiters.shift(); if (w) w(); }
      }
    });
    this.p.stderr.on('data', d => process.stderr.write(d));
    this.ready = new Promise(r => this.waiters.push(r));
    this.dataWaiter = null;
  }
  wake() { if (this.dataWaiter) { const w = this.dataWaiter; this.dataWaiter = null; w(); } }
  cmd(s) { return new Promise(r => { this.waiters.push(r); this.p.stdin.write(s + '\n'); }); }
  async write(bytes) { await this.cmd('W ' + Buffer.from(bytes).toString('hex')); }
  async setRTS(on) { await this.cmd('RTS ' + (on ? 1 : 0)); }
  async read(timeoutMs) {
    if (!this.rx.length) await new Promise(r => { this.dataWaiter = r; setTimeout(r, timeoutMs); });
    return Uint8Array.from(this.rx.splice(0, this.rx.length));
  }
  async close() { this.p.stdin.write('QUIT\n'); await new Promise(r => this.p.on('exit', r)); }
}

(async () => {
  let image, used, what;
  const text = fs.readFileSync(file, 'utf8');
  if (/\.hex$/i.test(file)) { const h = A.readHex(text); image = h.image; used = h.used; what = h.size + ' bytes from ' + path.basename(file); }
  else {
    const r = A.assemble(text, { name: path.basename(file) });
    if (!r.ok) { for (const m of r.messages) console.log('line ' + m.line + ' ' + m.code + ' ' + m.text); process.exit(1); }
    image = r.image; used = r.used; what = r.size + ' bytes assembled from ' + path.basename(file);
  }
  console.log(what);
  const t = new BridgeTransport(port, baud);
  await t.ready;
  const t0 = Date.now();
  const isp = new StcIsp(t, { log: s => console.log('  ' + s.slice(0, 110)), progress: () => {} });
  try {
    const info = await isp.connect();
    const r = await isp.program(image, used);
    console.log('DONE: ' + r.bytes + ' bytes written to ' + info.model + ' in ' + ((Date.now() - t0) / 1000).toFixed(1) + ' s at ' + baud + ' baud');
  } catch (e) { console.log('FAILED: ' + e.message); process.exitCode = 1; }
  await t.close();
})();
