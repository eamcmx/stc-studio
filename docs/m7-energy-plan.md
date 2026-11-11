# Measuring the energy of one reading (plan 7 Nov 2026, measured 11 Nov 2026)

Edge-AI papers report the energy of one inference. The plan below was written on 7 Nov and postponed (no meter at
hand); the measurement was made on 11 Nov 2026 with method 1 (a USB power meter). The results come first.

## Measured, 11 Nov 2026

**Set-up.** A USB power meter marked "USB DIGITAL TESTER" (Type-C in and out; not calibrated against a reference)
between the laptop's USB dock and the board, which is then COM16. It shows volts and watts to three decimals and the
current in steps of about 4 mA (0.063, 0.067, 0.070, 0.074 A ...), so the current is taken as watts / volts. Emmanuel's
Galaxy S25 filmed the meter's screen (4080 x 3060, `prechin-a2/s25_cam.py`; the videos stay in
`prechin-a2/raw/energy/`, outside the repository).

**Runs.** `node test/energy_run.js COM16 <build> <label>` flashes a build, checks its greeting and four answers,
starts the phone recording, then: 30 s waiting, 30 s of that build's test inputs sent back to back (every answer
compared with Python), 30 s waiting. `python tools/meter_frames.py ref/nn/energy/run_<label>.json x0 y0 x1 y1 2` cuts
one meter frame every 2 s into labelled sheets (`ref/nn/energy/sheets/`); the readings were read off by eye into
`ref/nn/energy/readings_<label>.json`, with a note on each frame caught while the meter redrew a line.
`python tools/meter_stats.py dark display nochip nochip2 ucibin ucigray sdcc57 mnist mnistsdcc mnistsdcct` gives
`ref/nn/energy/stats.json`. Frames within 2 s of a phase change are left out.

**Builds.** All with the display off except one: `nn/energy_build.py` writes the 5 x 7 marker builds and display-off
copies of the UCI and MNIST assembly programs (SETB ET0 becomes two NOPs, so no address moves), and C sources of three
SDCC builds with ET0 = 0, compiled into `ref/nn/energy/c/*/build/` with the originals' options (none, or -DTUNED for
the tuned build; an unchanged rebuild of each original gives its committed hex byte for byte).
`node test/nn_energy_sim.js` runs every test input through each build on the simulated board: every answer equals
Python's, the display interrupt never runs, and the average reading time is the t below
(`ref/nn/results/energy_sim.json`).

**Chip out.** The chip's own current is the board's current with a display-off build running minus the board's
current with the chip out of its ZIF socket (taken out and put back with the USB cable unplugged; port open with RTS
on, as in the runs): 13 frames in a first run, 82 in a 3-minute second run.

| Board state | Frames | Current (W / V) |
|---|---|---|
| chip out of its socket (two runs) | 95 | 69.43 mA (standard error 0.33) |
| display-off builds, all phases, all seven builds | 273 | 73.65 mA |
| display-on 5 x 7 build, waiting / reading | 25 / 13 | 84.88 / 87.68 mA |

Chip: 73.65 - 69.43 = **4.22 mA (standard error 0.35), 21.8 mW** at 5.167 V (18.2 to 25.4 mW for two standard errors).
Waiting and reading draw the same current in every display-off build (reading minus waiting -1.16 to +0.92 mA, no
sign in common): the program never sleeps. The display costs 11.4 mA while waiting; while reading it draws more, as the
digit shown changes with every answer.

| Build, display off | t (simulator) | on the chip | board | chip energy | board energy |
|---|---|---|---|---|---|
| 5 x 7, assembly | 14.21 ms | 318 of 318 equal | 73.50 mA | 0.31 mJ | 5.4 mJ |
| UCI binary, assembly | 19.13 ms | 274 of 274 | 73.88 mA | 0.42 mJ | 7.3 mJ |
| UCI 16 grey levels, assembly | 49.09 ms | 213 of 213 | 73.52 mA | 1.07 mJ | 18.6 mJ |
| MNIST, assembly | 33.32 ms | 156 of 156 | 73.65 mA | 0.73 mJ | 12.7 mJ |
| 5 x 7, C as written, SDCC | 39.32 ms | 257 of 257 | 73.89 mA | 0.86 mJ | 15.0 mJ |
| MNIST, C as written, SDCC | 92.90 ms | 120 of 120 | 73.40 mA | 2.02 mJ | 35.2 mJ |
| MNIST, C tuned, SDCC | 76.09 ms | 129 of 129 | 73.73 mA | 1.66 mJ | 29.0 mJ |

Chip energy = 21.8 mW x t; board energy = the build's own board power x t (what the USB port delivers per reading,
display off). With the display on, the 5 x 7 reading (16.81 ms) costs the board 7.6 mJ.

**Limits.** The meter is not calibrated and its current steps are coarse; the chip's current is a difference of two
averages taken at different times (the board drew 73.4 to 73.9 mA across the seven builds over 90 minutes). The
times are the simulator's, which matched the chip to 0.1 to 0.3 ms in the web page's round trips. Method 3 below (a
shunt at pin 40 and an oscilloscope on P2.0) would measure the chip alone and the time together.

## The plan (7 Nov 2026)

## What is measured

The program never sleeps: between readings it waits for the serial port in a loop, so the chip draws about the
same current while it computes as while it waits. The energy of one reading is therefore

  E = V × I × t

with V the chip's supply (5 V from USB), I the chip's current while running, and t the time of one reading.
For illustration only: at 10 mA, t = 16.8 ms gives 0.84 mJ. The real current has to come from the meter (and the
STC89C52RC datasheet's figure for 11.0592 MHz should be checked against it).

## The firmware

`python nn/energy_build.py` writes two measurement builds of the digit reader (`ref/nn/energy/`):

| Build | What it does | P2.0 low for (simulator, the 346 test drawings) |
|---|---|---|
| `digit_nn_marker.a51` | the digit reader; P2.0 goes low when the last square has arrived and high when the answer is ready | 16.81 ms on average |
| `digit_nn_marker_dark.a51` | the same with the display off (no display interrupt; P0 and P1 stay high, LEDs and digits dark) | 14.18 ms |

`node test/nn_marker.js [file]` checks that the answers are unchanged and that the pulse covers the reading. The
display refresh costs about 16 % of the processor's time (16.81 against 14.18 ms).

P2.0 is pin 21 of the chip (DIP-40); the program never writes port 2. On the board, take it from the P2 header if
there is one, or from the socket. Ground is pin 20, VCC pin 40.

## Three ways to measure, from simplest

1. **USB power meter** (a UM25C or similar) between the laptop and the board. It shows the whole board: chip,
   USB chip (CH340), power LED and, in the first build, the display. Run `digit_nn_marker_dark` and note the
   current while waiting and while the page sends drawings back to back. It gives an upper bound of the chip's
   current, good enough for the order of magnitude.
2. **Current sensor module** (INA219 or INA226) in series with the board's 5 V, read by a second board a few
   hundred times a second. The same quantity as 1, but with time resolution, so the 14 ms readings can be seen.
3. **Shunt and oscilloscope at the chip**: a 10 Ω resistor between the board's 5 V and pin 40 (through a DIP
   adapter or a lifted pin), channel 1 across the resistor, channel 2 on P2.0 as the trigger. This gives the chip
   alone and checks the time of a reading on the real chip with an instrument of its own (the simulator says
   14.18 ms for the dark build).

For the paper, 1 is enough for "about how much"; 3 is what a reviewer would trust.

## The measurement, step by step

1. Flash `digit_nn_marker_dark.a51` from STC Studio (Open, then Flash to board; or paste it into the editor).
2. Waiting: read the current for 10 s with no drawing sent. Write down V and I.
3. Reading: from the Digit pad or the Serial tab, send the test drawings in a loop (a small page script can send
   the 346 test drawings back to back). Read the current again; with a scope, read the pulse width on P2.0 for
   20 readings.
4. Repeat 2 and 3 with `digit_nn_marker.a51` (display on), to report what the display costs.
5. Put the numbers in the table below; E per reading = V × I × t.

| Build | V | I waiting | I reading | t (scope) | t (simulator) | E per reading |
|---|---|---|---|---|---|---|
| dark | | | | | 14.18 ms | |
| display on | | | | | 16.81 ms | |

## What is needed from Emmanuel

A USB power meter or an INA219 module, or the lab's oscilloscope and a 10 Ω resistor, and about half an hour at
the board. On this board the USB adapter's RTS line switches the chip's power (that is how the page restarts it),
so measure with the port open and RTS on, after a flash, never during one.
