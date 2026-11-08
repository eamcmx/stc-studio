# Measuring the energy of one reading (plan, 7 Nov 2026)

Edge-AI papers report the energy of one inference. Nothing has been measured yet; this is the plan and the
firmware for it.

Postponed on 7 Nov 2026: Emmanuel has no USB power meter at hand. The firmware stays ready.

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
