# Step 4: from an empty file to a running board (7 Nov 2026)

The gate: write a program in STC Studio, assemble it and put it on the board, with no Keil and no AiCube. I did
it in Emmanuel's Chrome (through Claude in Chrome) on `http://localhost:8833/app/index.html`, after he had given
the page the port once (Choose port, USB-SERIAL CH340). Chrome then lists the port to the page without asking
again (USB 1a86:7523).

## What was done

1. **New**, then Ctrl+A and Delete: the editor holds one empty line.
2. The program `ref/m4/gate.a51` typed in with the keyboard (32 lines, 702 characters; the editor's text has the
   same length and hash as the file). It shows `5tC` on digits 1 to 3 and counts 0 to 9 on digit 4.
3. **Assemble**: "Assembled: 66 bytes of code, 0000H to 0041H (1 % of the 8 KB flash). No errors." The page's
   Intel HEX is the same file as Keil's build of the same source (`ref/m4/gate_keil.hex`, made with A51, BL51 and
   OH51 through `tools/keil.sh`).
4. **Flash to board**: "Done: 512 bytes written and checked in 2.4 s. The board runs untitled.a51". The page's
   log is `ref/m1/chrome_gate.log`: port opened at 19200 baud, RTS restart, status packet (STC89C52RC, bootloader
   6.6C, 12T, option byte FDH), baud check, four pings, erase of 2 blocks, four 128-byte blocks, option byte FDH
   written back, run. The chip's sum of the first block, CAH, is the sum of Keil's 66 bytes and the FFH fill.
5. The camera (`rec/gate_flash.mp4`, not in git; strip `docs/img/m4_chrome_gate_board.jpg`): the display is dark
   until 12.0 s; Flash to board was clicked at 10.0 s; at 12.5 s the board shows `5tC0`, then `5tC1`, `5tC2`,
   `5tC3` half a second apart, and `5tC0` again at 21.5 s, 26.0 s and 35.0 s.

The count rate is the one the program asks for. One pass over the four digits takes 2088 machine cycles; 200
passes and 4 cycles of loop make one count: 417 604 cycles (the simulator counts the same), 0.453 s at 921 600
cycles a second, 4.53 s for ten counts. On the camera ten counts take 4.5 s, as far as frames sampled every 0.5 s
can tell.

Screenshot of the page after the flash: `docs/img/m4_chrome_gate_page.jpg`.

## Every course program from the page

Right after the gate, the page wrote all 41 course programs to the board one after another, from Chrome, with
the same Flash to board code (`STC.flash()` called from the page for each program in turn, 4 s apart): the 38
in the Examples menu, then his own versions of P12, P13 and P24 from `ref/corpus`, then demo2 again so that the
board keeps his demo. Every one ended "Done", which means the chip summed every 128-byte block it received to
the same value as the page. Table: `ref/m4/chrome_all.tsv` (2.4 to 2.5 s for each lab program and practical,
3.9 s for each demo). The byte counts are the same as Keil's builds in `ref/keil/` for all 42 rows; the page
runs the same `src/asm51.js` that `test/corpus.js` checks against Keil byte for byte.

So the chip now gets what Keil and AiCube would have given it, for every course program.

The camera filmed the whole run (`rec/all_examples.mp4`, not in git). One still per program, about 2.4 s after it
started: `docs/img/m4_all_programs.jpg` (the camera's clock is known to about half a second). Against the
simulator, run from reset for the same time:

| Program | Simulator | Camera |
|---|---|---|
| Ex 2 | 2 on digit 1 | 2 on digit 1 |
| m1 | 1234 | 1234 |
| c1 | 0 on digit 4 | 0 on digit 4 |
| Your turn A | 0 on digit 4 | digit 4 lit, too bright in the still to read |
| Your turn B | 00 on digits 3 and 4 | 00 |
| v1, the AI's "0" | `-.` on digit 1, D7 and D8 on | the same |
| E1 | D1, D3, D5, D7 | every other LED |
| l1 | one LED at a time | one LED |
| P12 and his P12, P14, P15, P25 | D1 (P14 and P25 blink it) | the top LED |
| P21 | all eight LEDs | all eight |
| P22, P23 | D1 blinking every 50 ms, D1 dim | D1 dim in the still |
| Demo 1 | HELLO scrolls in, then P1A, 1Ano | the same letters in the same order (`docs/img/m4_demo1_scroll.jpg`) |
| Practicals with no output on the pins | dark | dark |

Close-ups: `docs/img/m4_spot_checks.jpg`, `docs/img/m4_d1_programs.jpg`. The display also goes dark each time the
page cuts RTS to restart the chip for the next program, which the camera shows between programs.

Emmanuel watched the board as well: "saw it running, demo2 is on the board" (7 Nov 2026).
