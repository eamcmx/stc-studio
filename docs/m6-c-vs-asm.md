# The digit reader in C against assembly (7 Nov 2026)

Emmanuel asked whether a neural network gains anything from being written in assembly, then: "build the C version
and compare them". `ref/nn/c/digit_nn.c` does exactly what `ref/nn/digit_nn.a51` does: the same 35-24-10
network, the same 8-bit weights (`ref/nn/c/weights.h`, written by `python nn/train_digits.py --c-only` from
`nn/model.json`), the same serial protocol and the same display. It is compiled with Keil C51 9.60 (evaluation
version, 2 KB limit), the compiler the course already uses.

**Corrected 8 Nov 2026.** Until then the simulator charged `MOV Rn,direct` (A8H-AFH) one machine cycle instead
of two, and did not run `ORL C,/bit` and `ANL C,/bit` (A0H, B0H). The assembly programs use none of them, so
their times did not change; the C builds use `MOV Rn,direct` and every C time below is from the corrected
simulator. With the fix, the round trips on the chip are 0.1 to 1.2 ms longer than the simulated ones (before:
0.5 to 1.8 ms), which is how the chip confirmed the 2 cycles.

## Four C builds

| Build | Command | What it is |
|---|---|---|
| C as written | `tools/keil_c.sh ref/nn/c/digit_nn.c <dir>` | what a careful C programmer writes: byte loop counters, arrays in `idata`, layer 1 as additions only, a 16-bit product in layer 2 |
| 32-bit multiply | `... "DEFINE(LONGMUL)"` | the same, but `(long)hid[j] * W2[k][j]`, as plain C would write it |
| optimized for size | `... "OPTIMIZE(9,SIZE)"` | C as written, with the compiler set to make it small |
| tuned for the 8051 | `... "DEFINE(TUNED)"` | pointers through the tables, and the sign of each weight split off so that the compiler can use `MUL AB` (8 × 8 bits) |

The linker needs `RAMSIZE(256)`: the arrays take 147 bytes of internal RAM, more than a plain 8051's 128. The
STC89C52RC has 256. The hex files are in `ref/nn/c/`, with the compiler's listings of the first and last build.

## Results

`node test/nn_compare.js`: every build answers all 346 test drawings exactly like the Python reference (digit and
all ten scores). Times are from the program's read of the last square from SBUF to its write of the first character
of the answer to SBUF, on the simulated board (`test/nn_timing.js`, the same for every build; until 8 Nov 2026 the
clock stopped when the first character had been sent, 0.5 ms later, so the old table read 17.3, 42.7, 67.2, 49.4 and
32.3 ms):

| Version | Bytes | Without the tables | Average reading | Empty grid | Per lit square | Full grid |
|---|---|---|---|---|---|---|
| Assembly | 1654 | 471 | 16.8 ms | 10.3 ms | 0.57 ms | 30.1 ms |
| C as written | 1974 | 764 | 42.6 ms | 28.9 ms | 1.21 ms | 71.2 ms |
| C, 32-bit multiply | 2058 | 848 | 67.4 ms | 53.3 ms | 1.24 ms | 96.7 ms |
| C, optimized for size | 1959 | 749 | 49.3 ms | 32.1 ms | 1.52 ms | 85.2 ms |
| C tuned for the 8051 | 2049 | 839 | 32.7 ms | 21.8 ms | 0.96 ms | 55.5 ms |

The tables are almost the same size in both (1183 bytes in assembly, 1210 in C). The difference is the program
around them: 471 bytes of hand-written code against 764 to 848 from the compiler.

So, for this network on this chip:

* C as written is 2.5 times slower than the assembly and its program is 1.6 times bigger.
* Multiplying in 32 bits, the obvious way to write it, makes it 4.0 times slower.
* Asking the compiler for a small program saves 15 bytes and costs 16 % more time.
* C written by someone who knows the 8051 closes 38 % of the gap: still 1.9 times slower than the assembly.
* The C version is 73 lines; the assembly is about 280 instructions. Changing the number of hidden neurons is
  one `#define` in C; in assembly it meant changing the loops (now an `NH` constant).

## The same arithmetic in both (8 Nov 2026)

`nn/ablation.py` now also builds all 16 combinations of the four shortcuts (`ref/nn/ablation/factorial/`, named by
the shortcuts that are on: b binary inputs, r row pointer, m MUL AB with the sign split, s 24-bit sums), and
`node test/nn_ablation.js` measures them (`ref/nn/results/ablation_factorial.json`). Two of them have the arithmetic
of a C build:

| C build | Its arithmetic | Assembly with that arithmetic | C | C is slower by |
|---|---|---|---|---|
| C as written | b (16-bit multiply routine, 32-bit sums) | 34.4 ms | 42.6 ms | 1.24 times |
| C tuned for the 8051 | brm (32-bit sums) | 17.8 ms | 32.7 ms | 1.84 times |

So against C as written most of the 2.5 times is the arithmetic (2.04 times) and the compiled code adds 1.24 times;
against the tuned C the arithmetic is almost the same (1.06 times) and the compiled code costs 1.84 times, because
C51 rebuilds DPTR from a pointer and an index for every weight. Switched on in the order b, m, r, s, the shortcuts
make the assembly 1.95, 1.44, 1.34 and 1.06 times faster, 3.98 times in all.

## On the real board

The same builds were flashed from Chrome and timed over USB (15 round trips each: send `D` and 35 squares, wait
for the end of the answer):

| Version | The 7 from `ref/nn/board_answers.txt` | Full grid | Simulator (same round trip) |
|---|---|---|---|
| Assembly | 80.1 ms | 91.7 ms | 79.1 / 90.5 ms |
| C as written | 111.5 ms | 135.7 ms | 111.4 / 135.4 ms |
| C tuned | 101.0 ms | 120.1 ms | 100.7 / 119.9 ms |

The 15 round trips of each set lay within 1.4 ms of each other. Every real round trip is 0.1 to 1.2 ms longer than the simulated
one, which is the USB link; so the simulator's cycle counts hold on the real chip, and the times in the table above
can be trusted. All three gave the same answer lines on the board as in the simulator. The assembly version was
put back on the board afterwards.

The C builds took about 7 s to flash against 4 s: Keil's evaluation linker places C code from 0800H upwards, so the
board gets 4 KB with a gap filled in. That is the free version of Keil, not the C language.

## Why C51 is slower here

**Layer 1, one weight added to one sum.** The hand-written loop keeps DPTR at the start of the pixel's row and
reads the weight with `MOVC A,@A+DPTR`, the index in R4: 17 to 19 machine cycles per weight. C51, for
`acc[j] += W1[i][j]`, works out the address W1 + 24·i + j again for every weight, with a `MUL AB` inside the
inner loop: 39 cycles. With a pointer (`w[j]`), the tuned build still rebuilds DPTR from the pointer and `j` each
time and keeps `j` in RAM: 31 cycles.

**Layer 2, one product.** The assembly multiplies the hidden value by the size of the weight with one
`MUL AB` (4 cycles) and adds or subtracts. C as written calls the library routine `?C?IMUL` (16-bit multiply);
the 32-bit build calls `?C?LMUL`, which explains most of its extra 25 ms (24.8 ms). Only the tuned build, where both
factors are `unsigned char`, gets `MUL AB`. Writing `(unsigned int)hid[j] * m`, or casting either factor alone, is enough to lose it: C51 then calls
`?C?IMUL` (checked 8 Nov 2026 with the CODE listing).

**Where C51 did better than me:** it sign-extends a byte in two instructions, `RLC A` then `SUBB A,ACC`. The
hand-written loop uses a bit test, a jump and a load for the same job.

## What it means for the course

On the 8051, hand-written assembly runs this network 1.9 to 3.9 times faster than compiled C, with a program 38 %
smaller, because the chip has one accumulator, one data pointer and a slow general multiply, and the
compiler does not know that the inputs are 0 or 1 or that a byte times a byte is enough. On a modern 32-bit
microcontroller with many registers and a fast multiplier, the compiler's code would be much closer (general
knowledge, not measured here). Either way the training stays in Python; only the finished weights run on the chip.

## Every test input on the real board (8 Nov 2026)

`node test/board_run.js COM13` flashes each build through `tools/serial_bridge.py` with the page's own programmer,
sends its whole test set and compares every answer line with the Python reference (`ref/nn/board_full.txt`,
`ref/nn/results/board_full.json`): the assembly program and the four C builds, 346 drawings each; the two UCI programs,
1797 test digits each (1658 and 1724 read correctly, as in the simulator). All 5324 lines are equal to the reference;
none differs and none is missing. The 5 x 7 reader in assembly is flashed again at the end and left on the board. The
round trips in that file go through the Python bridge and are not used as timings.
