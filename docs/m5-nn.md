# The digit reader: a neural network on the board (7 Nov 2026)

Emmanuel asked for "the NN we were discussing earlier" and chose the digit reader. Draw a digit on a 5×7 grid in
STC Studio's Digit pad; the page sends it to the board over the USB cable; the STC89C52RC runs a small neural
network on it and shows the digit on its display ("nn 7"). The same program runs on the simulated board.

## The network

35 inputs (the squares of the grid, 0 or 1) → 24 hidden neurons with ReLU → 10 outputs, one per digit. The
largest output is the answer. This morning's offer said 35-16-10; 24 hidden neurons read the noisy test shapes
2 points better (92 % against 90 %) and the second hand-drawn set 1 drawing better, for 376 more bytes of tables.

The board works only with whole numbers. After training, the weights are rounded to 8 bits:

* layer 1: hidden *j* = B1[*j*] + the sum of W1[*i*][*j*] over the lit squares *i*. The inputs are 0 or 1, so
  this layer needs no multiplications, only additions into a 16-bit sum. Then ReLU (a negative sum gives 0), and
  the sum is halved (SH1 = 1) and capped at 255, so each hidden value fits in a byte.
* layer 2: score *k* = B2[*k*] + the sum over *j* of hidden *j* × W2[*k*][*j*], with `MUL AB` and a 24-bit sum.
  A negative weight is multiplied by its size and subtracted.
* the answer: the largest score, compared as signed 24-bit numbers.

Rounding to 8 bits costs nothing measurable: 90.38 % against 90.42 % with the full-precision weights on the noisy
test shapes.

## Training data

`nn/train_digits.py` (numpy only) draws its own data. It has 34 full-size ways of writing the ten digits and
11 small 3×5 ones. Each full-size shape is also squeezed to 4 and 3 squares wide and 6 and 5 tall (columns or
rows merged), and every shape is placed at every position on the grid. Where two different digits squeeze into
the same shape, that shape is left out (30 of 1330 templates; 1300 stay). Each template then gets 40 noisy copies: a gap in a stroke, an extra square next
to a stroke, a stray square, and, for half of them, diagonal strokes turned into staircases, the way a mouse drag
draws them. 53 300 training examples, 60 passes with Adam.

## How well it reads

| Set | Read correctly |
|---|---|
| noisy test shapes (14 300, never trained on) | 90.4 % |
| my first 20 drawings, made before the first training run | 19 of 20 |
| 20 more drawings, made after the first run showed that 4-wide digits failed | 19 of 20 |
| 10 staircase drawings, made after the pad read a dragged 7 as 3 | 9 of 10 |

Every drawing it gets wrong is an 8, read as 2 or 3. The noisy test set holds many tiny shapes that are
ambiguous even to a person (a 3-wide 3 with a stray square can look like an 8), which is why it stays near 90 %.
The second and third sets were drawn after I had seen where the network failed, so they are honest tests of the
version they were made for, not of later fixes.

## The program

`ref/nn/digit_nn.a51` is written by hand; the training script fills in only the tables between the WEIGHTS
markers (NH, SH1, B1, W1, W2). 1654 bytes. Keil's A51, BL51 and OH51 give the same 1654 bytes
(`ref/nn/digit_nn_keil.hex`) with no warnings, so it also fits Keil's 2 KB evaluation limit.

* Serial port at 19200 baud (Timer 1 auto-reload FDH, SMOD = 1), the same rate the page uses for flashing, so the
  page keeps the port open after Flash and talks to the program straight away.
* Timer 0 interrupt every 256 machine cycles multiplexes the display, so the display stays lit while the network
  works.
* Protocol: the page sends `D` and 35 characters (`1` for a lit square), row by row from the top left. The board
  answers `=7` and the ten scores as 24-bit hex, then CR LF. The greeting after a restart is `NN READY`.
* RAM: pixels 30H-52H, layer-1 sums 53H-82H, hidden values 83H-9AH, scores 9BH-B8H (above 7FH only through
  `@R0`/`@R1`), stack from C0H.

## Checks

| Check | Result |
|---|---|
| `node test/nn_test.js`: 346 drawings through the simulated board's serial port | every digit, all ten scores and the display the same as `int_forward()` in Python; at most 23.9 ms from the last square to the first character of the answer |
| Keil build of the same file | 1654 bytes, the same at every address |
| `node test/ui_test.js` (Chrome over DevTools) | 15 of 15, including a 7 dragged on the pad: read as 7, the simulated board shows "nn 7"; also on the one-file build |
| On the board, from Emmanuel's Chrome | Flash to board 3.9 s; `NN READY` came back over USB; a 7, a box 0, a 4 and a 2 drawn on the pad were read correctly, and all 40 scores equal Python's (`ref/nn/board_answers.txt`) |
| Camera (`docs/img/m5_nn_board.jpg`) | "nn--" after the flash, then "nn 7", "nn 2" as drawn |

While I tested, the page's serial log filled with 111 answers, more than I sent: Emmanuel was drawing on the pad
at the same time ("yes, I was drawing on it, works well"). The board answered every one.

## The app

* **Digit pad** tab: a 5×7 grid. Click or drag to paint (a drag paints every square along its path), click a lit
  square to start erasing. With "send while I draw" on, every change is sent 120 ms after the last stroke. The
  answer and the ten scores appear as bars; the longest bar wins.
* **Talk to**: the Serial tab and the Digit pad talk to the simulated board or to the real one. After a
  successful Flash it switches to the real board by itself; a loop then reads what the board sends until the next
  Flash or Release port.
