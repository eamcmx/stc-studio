/* sound.js: the buzzer LS1 on P3.6, heard through WebAudio. The method is the one in the course simulator
 * (_i8051/sim.html): each instruction's cycles are spent at the P3.6 level it ran under; that level is box-sampled at
 * 4x the audio rate, low-passed (two biquads at 6 kHz), decimated and DC-blocked, so a pin toggled every few cycles
 * sounds the way a buzzer hears it. Below board speed the waveform is stretched, so the pitch drops with it.
 * The pitch readout uses YIN on the last 31 ms (0 = silent, -1 = clicks without a steady pitch).
 */
(function () {
  'use strict';
  class Buzzer {
    constructor(cyclesPerSecond) {
      this.cps = cyclesPerSecond;
      this.rate = 48000; this.os = 4;
      this.ctx = null; this.on = false; this.volume = 0.5;
      this.ring = new Float32Array(4096); this.rp = 0; this.filled = 0;
      this.next = 0; this.env = 1e-4; this.act = 0; this.hz = 0; this.lastHz = 0; this.lastT = 0; this.tDetect = 0;
      this.setup(48000);
    }
    setup(rate) {
      this.rate = rate;
      const fs = rate * this.os, w = 2 * Math.PI * 6000 / fs, al = Math.sin(w) / (2 * Math.SQRT1_2), c = Math.cos(w), a0 = 1 + al;
      this.bq = { b0: (1 - c) / 2 / a0, b1: (1 - c) / a0, b2: (1 - c) / 2 / a0, a1: -2 * c / a0, a2: (1 - al) / a0 };
      this.prime(1);
    }
    prime(level) {
      const L = level;
      this.s1 = [L, L, L, L]; this.s2 = [L, L, L, L]; this.dcx = L; this.dcy = 0; this.acc = 0; this.pos = 0; this.dec = 0; this.frame = [];
    }
    // the user turned the sound on: an AudioContext may only start after a click
    async enable(on) {
      this.on = on;
      if (!on) return true;
      try {
        if (!this.ctx) { this.ctx = new (window.AudioContext || window.webkitAudioContext)(); this.setup(this.ctx.sampleRate); }
        if (this.ctx.state === 'suspended') await this.ctx.resume();
        return true;
      } catch (e) { this.on = false; return false; }
    }
    filt(st, x) { const q = this.bq; const y = q.b0 * x + q.b1 * st[0] + q.b2 * st[1] - q.a1 * st[2] - q.a2 * st[3]; st[1] = st[0]; st[0] = x; st[3] = st[2]; st[2] = y; return y; }
    feed(level, cyc, speed) {
      const cps = this.cps * speed / (this.rate * this.os);   // machine cycles per oversampled sample
      while (cyc > 0) {
        const take = Math.min(cyc, cps - this.pos);
        this.acc += level * take; this.pos += take; cyc -= take;
        if (this.pos >= cps - 1e-9) {
          const x = this.filt(this.s2, this.filt(this.s1, this.acc / cps)); this.acc = 0; this.pos = 0;
          if (++this.dec === this.os) {
            this.dec = 0;
            const y = x - this.dcx + 0.995 * this.dcy; this.dcx = x; this.dcy = y;
            this.frame.push(y); this.ring[this.rp] = y; this.rp = (this.rp + 1) & 4095; if (this.filled < 4096) this.filled++;
          }
        }
      }
    }
    pitch() {
      const W = 512, tmax = 600, N = W + tmax + 1;
      if (this.filled < N) return 0;
      const x = new Float32Array(N); let e = 0;
      for (let i = 0; i < N; i++) { x[i] = this.ring[(this.rp - N + i + 4096) & 4095]; e += x[i] * x[i]; }
      if (e / N < 1e-9) return 0;
      let e1 = 0; for (let h = 0; h < N / 2; h++) e1 += x[h] * x[h];
      const e2 = e - e1; if (Math.min(e1, e2) < 0.25 * Math.max(e1, e2)) return -1;
      const d = new Float32Array(tmax + 1);
      for (let tau = 1; tau <= tmax; tau++) { let s = 0; for (let j = 0; j < W; j++) { const q = x[j] - x[j + tau]; s += q * q; } d[tau] = s; }
      const cm = new Float32Array(tmax + 1); cm[0] = 1; let run = 0, best = -1;
      for (let t = 1; t <= tmax; t++) { run += d[t]; cm[t] = run > 0 ? d[t] * t / run : 1; }
      for (let t = 4; t < tmax; t++) { if (cm[t] < 0.15) { while (t + 1 < tmax && cm[t + 1] < cm[t]) t++; best = t; break; } }
      if (best < 0) return -1;
      const a = cm[best - 1], b = cm[best], c = cm[best + 1], den = a - 2 * b + c, off = den !== 0 ? 0.5 * (a - c) / den : 0;
      return this.rate / (best + off);
    }
    // once per screen frame: play what was made, measure the pitch
    flush() {
      const f = this.frame; this.frame = [];
      const rel = Math.exp(-1 / (this.rate * 0.012)); let ss = 0;
      const out = new Float32Array(f.length);
      for (let i = 0; i < f.length; i++) {
        const v = Math.abs(f[i]); this.env = Math.max(v, this.env * rel, 1e-6);
        const g = Math.min(60, Math.max(0.5, 0.3 / this.env)); out[i] = f[i] * g; ss += out[i] * out[i];
      }
      this.act = f.length ? Math.sqrt(ss / f.length) : 0;
      if (this.ctx && this.on && f.length) {
        const buf = this.ctx.createBuffer(1, f.length, this.rate), dd = buf.getChannelData(0);
        for (let k = 0; k < f.length; k++) dd[k] = Math.tanh(out[k] * this.volume * 1.4) / 1.4;
        const now = this.ctx.currentTime;
        if (this.next < now + 0.02 || this.next > now + 0.4) this.next = now + 0.08;
        const src = this.ctx.createBufferSource(); src.buffer = buf; src.connect(this.ctx.destination); src.start(this.next);
        this.next += f.length / this.rate;
      }
      const t = performance.now();
      if (t - this.tDetect > 30) { this.tDetect = t; this.hz = this.act > 0.01 ? this.pitch() : 0; if (this.hz > 0) { this.lastHz = this.hz; this.lastT = t; } }
    }
    quiet() { this.frame = []; this.act = 0; this.hz = 0; this.lastHz = 0; this.filled = 0; }
    // what to show next to the buzzer
    label() {
      const on = this.act > 0.01, t = performance.now();
      if (on) return this.hz > 0 ? '≈ ' + Math.round(this.hz) + ' Hz' : 'clicks';
      if (this.lastHz > 0 && t - this.lastT < 900) return '≈ ' + Math.round(this.lastHz) + ' Hz';
      return '';
    }
  }
  window.Buzzer = Buzzer;
})();
