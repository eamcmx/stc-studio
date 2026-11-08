# Step 2: an A51-compatible assembler in JavaScript (7 Nov 2026)

`src/asm51.js` is a new module, written for STC Studio. It runs in the browser and in node. The course engine
`_i8051/i8051.js` is not changed (published 3981 pages use it).

```js
const r = ASM51.assemble(text, { name: 'prog.a51' });
r.ok, r.messages, r.hex, r.listing, r.image, r.used, r.size, r.lines, r.addrLine, r.symbols
```

## The gate: the same code as Keil

Reference files come from Keil C51 9.61 itself: `tools/keil.sh <file> <dir>` runs A51, BL51 and OH51 the way
uVision does on F7 and keeps the .hex, the .lst and the error lines. The tests compare byte images (which
addresses hold a byte, and its value), not the record layout of the hex files.

| Test | What it checks | Result 7 Nov |
|---|---|---|
| `node test/corpus.js` | Both demos, the 14 lab programs in `pilot-t4lab-v2/asm/`, his 25 practicals (from `_i8051/fixtures.json`) | 41 of 41 images identical to Keil; demo 1668 bytes, demo2 1753 |
| `node test/probes.js` | 58 probe files written to pin down A51's rules, line by line against Keil's listing: same bytes, and each line flagged the same way (error, warning or clean) | 0 lines differ; 20 differ on purpose (below) |
| `ref/probes/allops.a51` (made by `node test/gen_allops.js`) | Every instruction form with every register and a spread of operands, all AJMP/ACALL page bits; 986 bytes | identical to Keil |
| `node test/probes.js ref/random ref/keil-random` | 300 random programs (`node test/gen_random.js 300`), most with a planted mistake | the 39 Keil could build: same image; all 13780 lines flagged the same way as Keil |
| `node test/probes.js ref/random-clean ref/keil-random-clean` | 200 random programs without planted mistakes (`node test/gen_random.js 200 4242 --clean`) | the 62 Keil could build: same image; all 8950 lines flagged the same way (the others have real faults the random choices made: register pairs with no instruction, AR2 before USING, jumps out of reach) |
| `node test/fuzz.js` | 5000 programs of random A51 words: the assembler never throws, and clean ones assemble the same twice | no crash |

A negative control was run once: one flipped byte in a Keil hex file is caught by the image comparison.

## What A51 does, as measured (ref/probes)

* Numbers: `10`, `10D`, `0AH`, `1010B`, `12O`, `12Q`, and also `0x10`. A digit that does not fit the base is error
  A1 (`2B`). Every number is kept to 16 bits.
* Strings: `'A'` and `"A"`; a doubled quote stands for itself. In DB a string gives its bytes; in an expression
  it may have 1 or 2 characters (A11 otherwise). `DB 'AB'+1` is A34.
* Precedence, tightest first: `HIGH LOW`, `* / MOD`, `+ -`, `SHL SHR`, comparisons, `NOT`, `AND`, `OR XOR`.
  So `NOT 1 + 1` = FFFDH and `1 + 2 SHL 1` = 6. A minus sign may only start a sum: `2 * -3` is a syntax error,
  `-1 / 2` is 0 (it means -(1/2)). A comparison that holds is 1, not FFFFH. Comparisons and division are unsigned.
* The bit selector `.` binds tightest: `P3.2+1` is bit 0B3H. The byte must be 20H-2FH or an SFR at a multiple of
  8 (A17); the bit 0-7 (A18).
* 8-bit values: if the high byte is 00H or FFH the low byte is used without a word (`#-1`, `#-256`, `DB -129` =
  7FH); otherwise warning A52 and the low byte.
* Symbols have types. A code label is not a data address (A48) and a DATA symbol is not a jump target (A46).
  `X EQU P3.6` makes a bit symbol. A difference of two labels is a plain number. EQU takes forward references.
* A51 knows only the 8051 SFRs and bits: P0-P3, SP, DPL, DPH, PCON, TCON, TMOD, TL0/1, TH0/1, SCON, SBUF, IE, IP,
  PSW, ACC, B and their 43 bit names. Nothing of Timer 2, so `T2CON DATA 0C8H` in demo2 is allowed, and
  defining `P0` again is A10. `T0` and `T1` are bit names (P3.4, P3.5) and cannot be labels.
  AR0-AR7 need `USING` first (A53).
* Generic `JMP` and `CALL`: SJMP if the target is in reach, else AJMP/ACALL in the same 2 KB page, else
  LJMP/LCALL. A target further down starts as LJMP/LCALL and shrinks until no address moves; the probe files
  `ref/probes/gj/*.a51` match Keil this way, including a run of seven CALLs that straddles 1000H.
* AJMP/ACALL compare the page of the next instruction with the target's page (A51). Relative jumps reach -128 to
  +127 from the next instruction.
* `ORG` may go backwards in the default code segment (the later byte wins); below a `CSEG AT` base it is A27.
  A label before `ORG` or `END` is A9 and the directive is then ignored (so `L: END` also gives A41).

## Where STC Studio is stricter than A51

A51 writes these without an error; STC Studio stops (each is in `EXPECTED` in `test/probes.js`):

| Input | A51 | STC Studio |
|---|---|---|
| `MOV A,100H` | warning A52, writes E5 00 | error S1 (data address above 0FFH) |
| `MOV A,-1`, `MOV A,0FFFFH`, `MOV A,-D1`, `MOV A,NOT D1` | E5 6FH, E5 40H, E5 3FH, nothing said | error S1 |
| `SETB 100H` | "D2 G0" in its listing | error S2 |
| `DW PC`, `DW DPTR` | 0000H | error A9 |
| `DSEG` without AT when another `DSEG AT` follows later | places it at the later segment's base | error S10: give it an AT address |
| code written twice by `ORG` | nothing said | same image, warning S4 |

## Not covered

Relocatable segments (SEGMENT, RSEG, PUBLIC, EXTRN), macros and IF/ELSE give error S3, so nothing is silently
ignored. `$INCLUDE (REG51.INC)` and `$INCLUDE (REG52.INC)` work after `$NOMOD51` (checked against Keil); other
include files give S9.

Where both reject a line, the error number agrees with A51's except for two lines in the probes (`SETB P3.-1`:
A51 A18, here A9; `MOV A,@R0+1`: A51 A38, here A4) and one line in the random runs.
