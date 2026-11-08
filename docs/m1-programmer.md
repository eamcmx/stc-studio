# Step 1: can a free tool program the board? (7 Nov 2026)

Result: yes. stcgal 1.10 flashed two programs onto Emmanuel's TSI STC89C52RC board without AiCube-ISP and without
a manual power cycle. He watched the board and confirmed both ("yes, saw both, demo2 is running").

## The chip

Read from its status packet with `tools/probe_stc.py` and stcgal:

| Item | Value |
|---|---|
| Model magic | F002H = STC89C52RC/LE52RC (8 KB code flash, 6 KB EEPROM) |
| Bootloader | 6.6C |
| Protocol | stcgal `stc89` (the status payload starts with 00H; `stc89a` would start with 50H) |
| Option byte | FDH: 12T mode (cpu_6t_enabled=False), clock gain high, ALE on, XRAM on |
| Clock the bootloader measured | 11.03 MHz (probe) and 11.088 MHz (stcgal's average); the crystal is 11.0592 MHz |

## Restarting the chip from the cable

The STC89 bootloader only runs straight after power-on. On this board the USB cable's RTS line controls the
chip's power: RTS off for 500 ms and back on restarts it into the bootloader, and the first 7FH sync byte gets an
answer about 80 ms after RTS comes back on.

| Method (probe_stc.py) | What it does | Answer |
|---|---|---|
| `rts-inv` | RTS off 500 ms, then on | 4 of 4 tries, 0.58 s after the start |
| `rts` | RTS on 250 ms, then off (stcgal `-a -A rts`) | never |
| `dtr` | DTR on 250 ms, then off (stcgal `-a`) | never |
| `dtr-inv` | DTR off 500 ms, then on | never |

pyserial opens the port with DTR and RTS both on. stcgal's own `-a` pulses in the opposite order, so
`tools/flash_stcgal.py` swaps in the `rts-inv` pulse and otherwise runs stcgal's normal command line.

The CH340 came up as COM13 this time (COM12 before). A web page has to let the user pick the port.

## The command

```
.venv/Scripts/python tools/flash_stcgal.py -a -D -P stc89 -p COM13 file.hex
```

| Flash | File | Image | Time | Log |
|---|---|---|---|---|
| 13:30:38 | his Ex 2 counter, Keil build | 119 bytes, 4 blocks | 4 s | `ref/m1/flash_ex2.log` |
| 13:31:01 | `academy/board-demo-2/demo2.hex` | 1775 bytes to the last address (Keil counts 1753 code bytes), 16 blocks | 5 s | `ref/m1/flash_demo2.log` |

Ex 2 went first so that demo2 appearing afterwards proves a real write, not the program already in flash.

## The protocol as it ran (from the -D logs)

All packets: `46 B9`, direction (`6A` host to chip, `68` chip to host), 16-bit length counted from the
direction byte to the end byte, payload, 8-bit sum of everything from the direction byte, `16`. No parity.

1. At 2400 baud 8N1, send 7FH every 30 ms until the status packet arrives (payload 00H, eight 16-bit clock
   counts, BSL version at 17-18, option byte at 19, model magic at 20-21).
2. Baud check, still at 2400: `8F BRT_H BRT_L FF-BRT_H csum delay iap`. With 115200 baud and the clock above,
   BRT = FFFDH (65536 - 11.088e6 / (115200 * 32), rounded), delay A0H, IAP wait 81H. The answer comes at
   115200; then go back to 2400.
3. Set the baud: `8E` with the same bytes minus the IAP byte; the answer and everything after it is at 115200.
4. Ping four times: `80 00 00 36 01 F0 02` (model magic at the end); each answer starts with 80H.
5. Erase: `84 nblocks 33 33 33 33 33 33`, nblocks = 2 per 512 bytes of image (stcgal first pads the image with
   FFH to a multiple of 512 bytes: demo2 went out as 2048 bytes, nblocks 08). The answer is `80` and 8 more bytes
   (`F0 02 C3 B1 0C 5E E7 AC` on this board: the model magic, then what looks like a chip serial number; guess).
6. Write 128-byte blocks: `00 00 00 addr_H addr_L 00 80` + 128 data bytes. The answer is
   `80 sum`, where sum is the 8-bit sum of the 128 data bytes; stcgal checks it.
7. Option byte: `8D FD FF FF FF` (writes back the byte it read, so 12T mode stays).
8. `82`: leave the bootloader and run the new program.

## Licence

stcgal is MIT licensed (copyright header in `protocols.py`: Grigori Goronzy and others,
https://github.com/grigorig/stcgal). Any port of its protocol code keeps that notice.
