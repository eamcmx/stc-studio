// Every test input on the real board: flashes each build through tools/serial_bridge.py (the page's own programmer,
// src/stcisp.js), waits for its greeting, sends every input of its test set and compares each answer line (digit and
// all ten scores) with the Python reference. Writes ref/nn/results/board_full.json and ref/nn/board_full.txt.
//   node test/board_run.js COM13 [build names separated by |]
// Builds: the 5 x 7 reader in assembly and its four C builds (346 drawings each), the two UCI programs (1797 test
// digits each); at the end the 5 x 7 reader in assembly is flashed again and left on the board.
'use strict';
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const A = require('../src/asm51.js');
const StcIsp = require('../src/stcisp.js');

const ROOT = path.join(__dirname, '..');
const [, , port, onlyArg] = process.argv;
const PY = path.join(ROOT, '.venv', 'Scripts', 'python.exe');
const J = f => JSON.parse(fs.readFileSync(path.join(ROOT, f), 'utf8'));
const V57 = J('nn/test_vectors.json'), VBIN = J('nn/uci_vectors_bin.json'), VGRAY = J('nn/uci_vectors_gray.json');
const VMNIST = fs.existsSync(path.join(ROOT, 'nn/mnist_vectors.json')) ? J('nn/mnist_vectors.json') : [];
const BUILDS = [
  ['asm 5x7', 'ref/nn/digit_nn.a51', V57],
  ['C as written', 'ref/nn/c/digit_nn_c.hex', V57],
  ['C, 32-bit multiply', 'ref/nn/c/digit_nn_c_long.hex', V57],
  ['C, optimized for size', 'ref/nn/c/digit_nn_c_size.hex', V57],
  ['C tuned', 'ref/nn/c/digit_nn_c_tuned.hex', V57],
  ['UCI binary', 'ref/nn/uci/digit_uci_bin.a51', VBIN],
  ['UCI 16 grey levels', 'ref/nn/uci/digit_uci_gray.a51', VGRAY],
  ['SDCC as written', 'ref/nn/c/sdcc/digit_nn.hex', V57],
  ['SDCC, 32-bit multiply', 'ref/nn/c/sdcc_long/digit_nn.hex', V57],
  ['SDCC tuned', 'ref/nn/c/sdcc_tuned/digit_nn.hex', V57],
  ['MNIST 14x14', 'ref/nn/mnist/digit_mnist.a51', VMNIST],
  ['MNIST SDCC as written', 'ref/nn/c/mnist/sdcc/digit_mnist.hex', VMNIST],
  ['MNIST SDCC tuned', 'ref/nn/c/mnist/sdcc_tuned/digit_mnist.hex', VMNIST],
  ['asm 5x7 (put back)', 'ref/nn/digit_nn.a51', V57.slice(0, 4)],
].filter(b => !onlyArg || onlyArg.split('|').includes(b[0]));
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };
const sleep = ms => new Promise(r => setTimeout(r, ms));

class BridgeTransport {                    // as in test/board_node.js
  constructor(port, baud) {
    this.rx = []; this.waiters = []; this.dataWaiter = null;
    this.p = spawn(PY, [path.join(ROOT, 'tools', 'serial_bridge.py'), port, String(baud)]);
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

async function readLine(t, ms) {           // text up to and including the first \n, or null after ms
  let s = '';
  const end = Date.now() + ms;
  while (Date.now() < end) {
    const d = await t.read(Math.max(1, end - Date.now()));
    s += Buffer.from(d).toString('latin1');
    const i = s.indexOf('\n');
    if (i >= 0) { const rest = s.slice(i + 1); if (rest) t.rx.unshift(...Buffer.from(rest, 'latin1')); return s.slice(0, i + 1); }
  }
  return null;
}

(async () => {
  const t = new BridgeTransport(port, 19200);
  await t.ready;
  const report = { made: new Date().toISOString(), by: 'test/board_run.js', port, baud: 19200, builds: [] };
  const log = ['# Every test input on the real board, ' + report.made.slice(0, 10) + ', from node through tools/serial_bridge.py (' + port + ', 19200 baud).',
    '# Each answer line (digit and ten scores) is compared with the Python reference; time = host round trip (send to end of line).',
    '# build                   inputs  equal  differ  no answer  read correctly  median ms  flash s'];
  for (const [name, file, vecs] of BUILDS) {
    const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
    let image, used;
    if (file.endsWith('.hex')) ({ image, used } = A.readHex(text));
    else { const r = A.assemble(text); if (!r.ok) throw new Error(file + ' does not assemble'); ({ image, used } = r); }
    const t0 = Date.now();
    const isp = new StcIsp(t, { log: () => {}, progress: () => {} });
    await isp.connect();
    await isp.program(image, used);
    const flashS = (Date.now() - t0) / 1000;
    let greet = await readLine(t, 3000);
    if (greet !== 'NN READY\r\n') {        // not started by the run command: restart it with the RTS line
      await t.setRTS(false); await sleep(500); await t.setRTS(true);
      greet = await readLine(t, 4000);
    }
    if (greet !== 'NN READY\r\n') { console.log(name + ': no greeting (' + JSON.stringify(greet) + ')'); process.exitCode = 1; break; }
    let equal = 0, differ = 0, none = 0, right = 0;
    const times = [], diffs = [];
    for (let n = 0; n < vecs.length; n++) {
      const v = vecs[n];
      t.rx.length = 0;
      const s0 = process.hrtime.bigint();
      await t.write(Buffer.from('D' + v.pixels, 'latin1'));
      const line = await readLine(t, 3000);
      const ms = Number(process.hrtime.bigint() - s0) / 1e6;
      if (line === null) { none++; diffs.push({ n, got: null }); await sleep(300); continue; }
      times.push(ms);
      const m = /^=(\d)((?: [0-9A-F]{6}){10})\r\n$/.exec(line);
      const ok = m && +m[1] === v.digit && JSON.stringify(m[2].trim().split(' ').map(s24)) === JSON.stringify(v.scores);
      if (ok) equal++; else { differ++; if (diffs.length < 20) diffs.push({ n, got: line.trim() }); }
      const label = v.label !== undefined ? v.label : null;
      if (m && label !== null && +m[1] === label) right++;
      if (n % 200 === 199) console.log('  ' + name + ': ' + (n + 1) + ' of ' + vecs.length + ', ' + equal + ' equal');
    }
    times.sort((a, b) => a - b);
    const med = times.length ? times[times.length >> 1] : null;
    const row = { name, file, inputs: vecs.length, equal, differ, no_answer: none, read_correctly: vecs[0].label !== undefined ? right : null,
      median_round_trip_ms: med && +med.toFixed(1), flash_s: +flashS.toFixed(1), first_differences: diffs };
    report.builds.push(row);
    console.log(name + ': ' + equal + ' of ' + vecs.length + ' equal to Python' + (differ ? ', ' + differ + ' differ' : '') + (none ? ', ' + none + ' no answer' : '') +
      (row.read_correctly !== null ? ', ' + right + ' read correctly' : '') + ', median round trip ' + (med && med.toFixed(1)) + ' ms, flashed in ' + flashS.toFixed(1) + ' s');
    log.push((name.padEnd(25) + String(vecs.length).padStart(6) + String(equal).padStart(7) + String(differ).padStart(8) + String(none).padStart(11) +
      String(row.read_correctly === null ? '-' : right).padStart(16) + String(med && med.toFixed(1)).padStart(11) + String(flashS.toFixed(1)).padStart(9)));
  }
  await t.close();
  const tag = onlyArg ? '_' + (process.env.BOARD_TAG || 'part') : '';     // a partial run does not overwrite the full one
  fs.writeFileSync(path.join(ROOT, 'ref/nn/results/board_full' + tag + '.json'), JSON.stringify(report, null, 1));
  fs.writeFileSync(path.join(ROOT, 'ref/nn/board_full' + tag + '.txt'), log.join('\n') + '\n');
  console.log(log.join('\n'));
})().catch(e => { console.log('FAILED: ' + e.message); process.exit(1); });
