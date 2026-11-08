# STC Studio and neural networks in 8051 assembly

This repository holds two things that grew together:

- **STC Studio**, one web page for STC89C52RC boards: an 8051 assembler that produces the same bytes as Keil A51, a
  cycle-accurate simulator of the board (display, LEDs, buttons, buzzer, timers, serial port), and a programmer that
  writes the chip from Chrome or Edge over Web Serial, using the STC89 bootloader protocol of stcgal.
- **Digit readers in 8051 assembly**: multilayer perceptrons with 8-bit weights that read handwritten digits on the
  chip (12T, 11.0592 MHz, 256 bytes of internal RAM), the generator that writes them, the C versions for Keil C51 and
  SDCC, and every script behind the tables and figures of the paper *Extreme Edge AI: Neural Network Digit Recognition
  in 8051 Assembly* (E. Merchán-Cruz, submitted to the Journal of Systems Architecture).

## Use the app

Open `dist/stc-studio.html` in Chrome or Edge (it works from the file; Web Serial needs one of these two browsers).
Write or load a program, press Assemble, run it on the simulated board, and with the board on USB press Flash to
board. The Examples menu has the two board demos and the digit reader; the Digit pad sends a 5 x 7 drawing to the
simulated or the real board. The sources of the app are in `app/` and `src/`; `node tools/make_examples.js` and
`node tools/build.js` rebuild `dist/stc-studio.html`.

## Reproduce the paper

Needs Node.js and Python 3 with NumPy (and pyserial, in `.venv/`, for the scripts that talk to the board). Each line
writes its results to `ref/nn/results/` (JSON) and prints them.

| What | Command |
|---|---|
| The 5 x 7 network: training, 8-bit weights, test vectors | `python nn/train_digits.py` |
| The program against the reference (346 drawings) | `node test/nn_test.js` |
| Cycle budget by stage, listings with cycles per instruction | `node test/nn_profile.js` |
| Assembly against the C builds (Keil C51, SDCC) | `node test/nn_compare.js` |
| The 16 combinations of the four specializations | `python nn/ablation.py && node test/nn_ablation.js` |
| Time against lit squares | `node test/nn_time_lit.js` |
| Seeds, confusions, UCI hidden layer study, reference models | `python nn/study.py && node test/nn_sweep.js` |
| UCI handwritten digits (data included, CC BY 4.0) | `python nn/train_uci.py && node test/nn_uci.js` |
| MNIST 14 x 14 (download the four MNIST files into `nn/data/mnist/` first, see `nn/train_mnist.py`) | `python nn/train_mnist.py && node test/nn_mnist.js` |
| The generator against the earlier programs | `python nn/gen51.py && node test/gen51_check.js` |
| The marker builds (P2.0 low for one reading) | `python nn/energy_build.py && node test/nn_marker.js` |
| Every test input on the real board | `node test/board_run.js COM13` |

The C builds are in `ref/nn/c/`: `tools/keil_c.sh` compiles with Keil C51 (the evaluation version was used),
`tools/sdcc_c.ps1` with SDCC 4.6.0. `docs/` records each step of the work in order (m1 to m8).

## The assembler and the simulator

`node test/probes.js`, `node test/fuzz.js` and `node test/board_test.js` check the assembler and the board model; the
reference outputs of Keil are in `ref/`. `node test/cycles.js` checks the cycles the simulator charges for every opcode
against the 8051 table (until 8 Nov 2026 `MOV Rn,direct` cost 1 cycle instead of 2; the paper's times are from the
corrected simulator), and `node test/nn_keil.js` builds every assembly program of the paper with Keil (needs Keil C51). The 41 course programs that the assembler was also checked on belong to a
course that is running and are not in this repository; the tests that use them say so and skip.

## Licences

MIT for this repository (`LICENSE`); third-party notices in `NOTICE`. `src/stcisp.js` and two tools carry code from stcgal (MIT, its notice is kept in
the files). The UCI digits in `nn/data/optdigits/` are CC BY 4.0 (Alpaydin and Kaynak, 1998,
https://doi.org/10.24432/C50P49). MNIST is not included.

## Citation

See `CITATION.cff`.
