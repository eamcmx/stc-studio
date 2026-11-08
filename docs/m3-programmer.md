# Step 3: the programmer in the browser (7 Nov 2026)

`src/stcisp.js` is the STC89 bootloader protocol, ported from stcgal 1.10 (MIT licence, notice kept in the file),
with a Web Serial transport for Chrome and Edge. `tools/flash-test.html` is the test page
(`http://localhost:8833/tools/flash-test.html`, launch.json entry "stc-studio").

## Two changes from stcgal, both from the board

* Restart: RTS off for 500 ms, then on (the board's RTS line switches the chip's power; step 1).
* One baud rate for the whole session. Web Serial cannot change the rate of an open port, and closing and
  reopening it could drop RTS and with it the chip's power. The bootloader accepts a handshake at the transfer
  rate: checked with stcgal on the board at 9600, 19200, 38400 and 57600 baud (`ref/m1/flash_ex2_*.log`); at
  115200 it never answers. The page uses 19200 (the bootloader then measures the clock 2 % off; at 57600 it is
  6 % off).

stcgal fills the gaps between pieces of code with 00H and pads the end with FFH to a multiple of 512 bytes;
`StcIsp.flashImage` does the same, so the chip gets the bytes that worked in step 1.

## Checks

| Check | How | Result |
|---|---|---|
| Same packets as stcgal | `node test/isp_replay.js`: the chip's recorded answers from step 1 fed back, stcgal's settings (2400/115200) | demo2: 25 of 25 packets identical; Ex 2: 13 of 13 |
| One-rate session, faults | same test, a fake bootloader at 19200 | flash holds the program, option byte FDH kept; a wrong checksum stops the run |
| On the board, without the browser | `node test/board_node.js COM13 <file.a51>`: the same `stcisp.js`, the port reached through `tools/serial_bridge.py` (pyserial), the program assembled from source by `src/asm51.js` | his Ex 2 (74 bytes) in 2.7 s: the left digit counts on camera (`docs/img/m3_ex2_counts.png`); demo2 (1753 bytes) in 4.3 s: LED light, snake, HELLO AGAIN, mode names, CrLP menu on camera (`docs/img/m3_demo2_start.png`) |
| In Chrome | the app (`app/index.html`), Flash to board, after Emmanuel chose the port once | a program typed into an empty file: 512 bytes written and checked in 2.4 s, runs on camera (`docs/m4-app.md`, log `ref/m1/chrome_gate.log`) |

The built-in browser pane of the Claude app refuses `requestPort`. A separate Chrome driven over DevTools gives no
chooser event for serial ports (DeviceAccess covers Bluetooth only), so the first port permission has to come from
Emmanuel. After one grant, `navigator.serial.getPorts()` returns the port without asking.

The Web Serial transport (`WebSerialTransport` in `src/stcisp.js`: open at 19200, setSignals for RTS, the read
loop) worked the first time in Chrome on 7 Nov 2026: the RTS restart brought the chip up, and the packets in the
page's log follow the same order as stcgal's.
