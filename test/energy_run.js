// The board current while the digit reader waits and while it reads, on the USB power meter between the laptop and the
// board, filmed by the S25 phone (11 Nov 2026, docs/m7-energy-plan.md). Flashes one build through tools/serial_bridge.py,
// starts the phone recording, then: idle, test drawings back to back, idle. Every answer is checked against Python.
// Writes ref/nn/energy/run_<label>.json with the phase times counted from the start of the video.
//   node test/energy_run.js COM16 ref/nn/energy/digit_nn_marker_dark.a51 dark [idle s] [reading s] [video folder]
//   node test/energy_run.js COM16 - nochip 30        (chip out of its socket: no flash, the port open, one phase)
'use strict';
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const A = require('../src/asm51.js');
const StcIsp = require('../src/stcisp.js');

const ROOT = path.join(__dirname, '..');
const [, , port, file, label, idleArg, readArg, videoArg] = process.argv;
const IDLE = +(idleArg || 30), READ = +(readArg || 30);
const VIDEO_DIR = videoArg || 'C:\\Users\\eamer\\Documents\\Claude\\prechin-a2\\raw\\energy';
const PY = path.join(ROOT, '.venv', 'Scripts', 'python.exe');
const SCRCPY = path.join(process.env.LOCALAPPDATA, 'Microsoft', 'WinGet', 'Packages',
  'Genymobile.scrcpy_Microsoft.Winget.Source_8wekyb3d8bbwe', 'scrcpy-win64-v5.0.1', 'scrcpy.exe');
const J = f => JSON.parse(fs.readFileSync(path.join(ROOT, f), 'utf8'));
// each build answers its own test inputs: MNIST, the two UCI sets, or the 346 5 x 7 drawings
const V57 = !file || file === '-' ? [] : J(/mnist/.test(file) ? 'nn/mnist_vectors.json' : /uci_bin/.test(file) ? 'nn/uci_vectors_bin.json'
  : /uci_gray/.test(file) ? 'nn/uci_vectors_gray.json' : 'nn/test_vectors.json');
const s24 = h => { const v = parseInt(h, 16); return v & 0x800000 ? v - 0x1000000 : v; };
const sleep = ms => new Promise(r => setTimeout(r, ms));

class BridgeTransport {                    // as in test/board_run.js
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

async function readLine(t, ms) {
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

async function ask(t, v) {                 // one drawing; true when the answer line equals Python's
  t.rx.length = 0;
  await t.write(Buffer.from('D' + v.pixels, 'latin1'));
  const line = await readLine(t, 3000);
  const m = line && /^=(\d)((?: [0-9A-F]{6}){10})\r\n$/.exec(line);
  return !!(m && +m[1] === v.digit && JSON.stringify(m[2].trim().split(' ').map(s24)) === JSON.stringify(v.scores));
}

(async () => {
  const t = new BridgeTransport(port, 19200);
  await t.ready;
  if (file === '-') return baseline(t);    // chip out of its socket: the port open as in the runs, film only
  const text = fs.readFileSync(path.join(ROOT, file), 'utf8');
  const r = file.endsWith('.hex') ? A.readHex(text) : A.assemble(text);
  if (file.endsWith('.a51') && !r.ok) throw new Error(file + ' does not assemble');
  const isp = new StcIsp(t, { log: () => {}, progress: () => {} });
  await isp.connect();
  await isp.program(r.image, r.used);
  let greet = await readLine(t, 3000);
  if (greet !== 'NN READY\r\n') { await t.setRTS(false); await sleep(500); await t.setRTS(true); greet = await readLine(t, 4000); }
  if (greet !== 'NN READY\r\n') throw new Error('no greeting: ' + JSON.stringify(greet));
  let ok = 0;
  for (const v of V57.slice(0, 4)) ok += await ask(t, v);
  console.log(label + ': flashed, greeting seen, ' + ok + ' of 4 first answers equal to Python');
  if (ok !== 4) throw new Error('answers differ before the measurement');

  await measure(t, 2 * IDLE + READ + 10, async (phases, rel) => {
    phases.push({ name: 'idle before', from_s: rel() });
    await sleep(IDLE * 1000);
    phases[0].to_s = rel();
    const rd = { name: 'reading', from_s: rel(), readings: 0, equal: 0 };
    phases.push(rd);
    const end = Date.now() + READ * 1000;
    for (let n = 0; Date.now() < end; n++) { rd.readings++; rd.equal += await ask(t, V57[n % V57.length]); }
    rd.to_s = rel();
    rd.readings_per_s = +(rd.readings / (rd.to_s - rd.from_s)).toFixed(2);
    phases.push({ name: 'idle after', from_s: rel() });
    await sleep(IDLE * 1000);
    phases[2].to_s = rel();
  });
})().catch(e => { console.log('FAILED: ' + e.message); process.exit(1); });

async function baseline(t) {               // node test/energy_run.js COM16 - nochip 30
  console.log(label + ': no flash, port open with RTS on');
  await measure(t, IDLE + 10, async (phases, rel) => {
    phases.push({ name: 'no chip', from_s: rel() });
    await sleep(IDLE * 1000);
    phases[0].to_s = rel();
  });
}

async function measure(t, total, body) {   // films the meter while body() runs its phases, then writes the run file
  fs.mkdirSync(VIDEO_DIR, { recursive: true });
  const video = path.join(VIDEO_DIR, 'meter_' + label + '.mkv');
  const cam = spawn(SCRCPY, ['--serial=RFCY10K4QHD', '--port=27250:27260', '--no-control', '--no-window', '--no-audio',
    '--video-source=camera', '--camera-id=0', '--camera-size=4080x3060', '--camera-fps=30', '--video-codec=h265',
    '--video-bit-rate=20M', '--record=' + video, '--time-limit=' + total]);
  const camLog = [];
  const spawned = Date.now();
  let recStart = null;
  const onCam = d => {
    for (const line of d.toString().split(/\r?\n/)) {
      if (!line.trim()) continue;
      camLog.push(((Date.now() - spawned) / 1000).toFixed(2) + ' ' + line.trim());
      if (recStart === null && /Recording started|Camera opened|Texture/i.test(line)) recStart = Date.now();
    }
  };
  cam.stdout.on('data', onCam); cam.stderr.on('data', onCam);
  const camDone = new Promise(res => cam.on('exit', res));
  await sleep(5000);                       // camera open, focus settled
  const t0 = recStart || spawned;
  const rel = () => +((Date.now() - t0) / 1000).toFixed(2);
  const phases = [];
  await body(phases, rel);
  await camDone;
  await t.close();
  if (!fs.existsSync(video) || fs.statSync(video).size < 100000) throw new Error('the phone recorded nothing:\n' + camLog.join('\n'));

  const out = { made: new Date().toISOString(), by: 'test/energy_run.js', port, file, label, video,
    time_zero: recStart ? 'scrcpy reported the camera stream' : 'scrcpy started (no stream line seen)', phases, scrcpy: camLog };
  fs.writeFileSync(path.join(ROOT, 'ref/nn/energy/run_' + label + '.json'), JSON.stringify(out, null, 1));
  console.log(JSON.stringify(phases));
  console.log(camLog.join('\n'));
}
