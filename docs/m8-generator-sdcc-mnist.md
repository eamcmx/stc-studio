# Generator, SDCC and MNIST (8 Nov 2026)

For a Q1 journal (the Journal of Systems Architecture), Emmanuel asked for MNIST on the chip, a second C compiler,
the generator as a contribution of its own, and energy when he has a meter. This records the first three.

## The generator

`nn/gen51.py` writes the 8051 program for any 8-bit multilayer perceptron with N inputs, H hidden neurons and 10
outputs, from `ref/nn/digit_nn.a51` as its template. It rewrites only what depends on the network: the memory map
(inputs from 30H, then 2H bytes of sums, H hidden values, 30 bytes of scores, the stack from the next multiple of 8,
with a check that it fits), the input loop (bytes, hex digits for 16 grey levels, or bits packed 8 to a byte), the
layer loops for any combination of the four shortcuts of `nn/ablation.py`, and the tables, after checking the 16-bit
and 24-bit bounds for any input.

`python nn/gen51.py && node test/gen51_check.js`:

- for the shipped 5 x 7 network it returns `ref/nn/digit_nn.a51` character for character;
- for the UCI networks (trained again with seed 1) its programs assemble to the same bytes as those of
  `nn/train_uci.py` (2350 and 2363 bytes).

## SDCC

`ref/nn/c/compat51.h` maps Keil's keywords (`code`, `idata`, `data`, `interrupt 1 using 1`, `reg52.h`) to SDCC's;
`digit_nn.c` keeps its line numbers, and the four Keil hex files are byte-identical after the change. SDCC 4.6.0
(sdcc-4.6.0-x64-setup.exe from SourceForge, installed in C:\Program Files\SDCC) compiles it with
`tools/sdcc_c.ps1` (PowerShell: under Git Bash, sdcpp cannot start its cc1).

| Build | Bytes | Without the tables | Average reading | Full grid |
|---|---|---|---|---|
| SDCC, as written | 2207 | 997 | 47.0 ms | 77.0 ms |
| SDCC, 32-bit multiply | 2299 | 1089 | 78.1 ms | 108.1 ms |
| SDCC, tuned for the 8051 | 2206 | 996 | 39.0 ms | 77.6 ms |

`--opt-code-speed` and `--opt-code-size` give the same code as the default. Every build answers the 346 drawings
like Python, in the simulator and on the chip. With the arithmetic matched (`ref/nn/ablation/factorial`), SDCC as
written is 1.37 times slower than the assembly with binary inputs only (34.4 ms), and SDCC tuned 2.19 times slower
than the assembly with the row pointer and MUL AB (17.8 ms); for Keil C51 the factors are 1.24 and 1.84 (C times from the corrected
simulator, see docs/m6).

## MNIST

`nn/train_mnist.py` reads the four MNIST files from `nn/data/mnist/` (downloaded from
https://ossci-datasets.s3.amazonaws.com/mnist/, the mirror torchvision uses; the script checks their MD5 sums; the
files are not in git). Each 28 x 28 image becomes 14 x 14 squares, lit when the mean of the 2 x 2 block is 96 or
more. On the last 10 000 training images, held out, thresholds 64, 96 and 128 with 24 or 32 hidden neurons gave
94.9 to 96.0 % after 20 epochs; 96 and 32 were the best.

The 196-32-10 network, trained on all 60 000 images (20 epochs), is written by the generator with the inputs packed
8 to a byte: 25 bytes of RAM for the inputs, 6272 bytes of layer-1 weights, 7208 bytes in all (ends at 1C52H).

| | Result |
|---|---|
| 8-bit, seed 1 (on the chip) | 95.91 % (float 95.96 %) |
| 8-bit, seeds 1 to 5 | 95.92 +- 0.19 % |
| 1-NN, 14 x 14 binary | 94.31 % |
| 1-NN, 28 x 28 | 96.91 % |
| float MLP 784-128-10 | 97.62 % |
| time of one reading (simulated, all 10 000) | 39.5 ms on average, 20.5 to 69.6 ms |

`node test/nn_mnist.js`: all 10 000 test digits equal to the reference in the simulator. `test/board_run.js` ran all
10 000 on the chip (`ref/nn/board_full_mnist.txt`).

## Every program on the chip

| Program | Inputs | Equal to Python |
|---|---|---|
| 5 x 7 network, assembly | 346 | 346 |
| four Keil C51 builds | 4 x 346 | 1384 |
| three SDCC builds | 3 x 346 | 1038 |
| UCI, binary and 16 grey levels | 2 x 1797 | 3594 |
| MNIST 14 x 14 | 10 000 | 10 000 (9591 read correctly) |
