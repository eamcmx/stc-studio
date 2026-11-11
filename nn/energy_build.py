"""A measurement build of the digit reader: P2.0 goes low when the last square has arrived and high again when the
answer is ready, so a scope, logic analyser or current meter can see exactly one reading.

    python nn/energy_build.py     writes ref/nn/energy/digit_nn_marker.a51 (check: node test/nn_marker.js)

P2.0 is used because the program never writes P2 (P1.0-P1.2 are rewritten by the display interrupt). The code is
ref/nn/digit_nn.a51 with three instructions added; see docs/m7-energy-plan.md for how to measure with it.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
src = (ROOT / 'ref' / 'nn' / 'digit_nn.a51').read_text(encoding='utf-8')
SWAPS = [
    ('        SETB    EA\n', '        SETB    EA\n        SETB    P2.0            ; MARKER: high while waiting\n'),
    ('NEXTPX: INC     R0\n        DJNZ    R2,RDPIX\n',
     'NEXTPX: INC     R0\n        DJNZ    R2,RDPIX\n        CLR     P2.0            ; MARKER: low from the last square ...\n'),
    ('; ---- show it ("nn 7") and send "=7" and the 10 scores\n',
     '        SETB    P2.0            ; MARKER: ... to the answer\n; ---- show it ("nn 7") and send "=7" and the 10 scores\n'),
]
for a, b in SWAPS:
    assert src.count(a) == 1, a
    src = src.replace(a, b)
head = '; MEASUREMENT BUILD (nn/energy_build.py): P2.0 is low for exactly one reading. Otherwise ref/nn/digit_nn.a51.\n'
out = ROOT / 'ref' / 'nn' / 'energy'
out.mkdir(parents=True, exist_ok=True)
(out / 'digit_nn_marker.a51').write_text(head + src, encoding='utf-8', newline='\n')
# the same with the display off: Timer 0 never interrupts, P0 and P1 stay FFH, so LEDs and digits are dark and the
# current meter sees the chip (and the board's own parts) without the display
dark = src.replace('        SETB    ET0\n', '        NOP                     ; MARKER BUILD: display off (no SETB ET0)\n        NOP\n')
assert dark != src
head2 = '; MEASUREMENT BUILD, DISPLAY OFF (nn/energy_build.py): P2.0 low for one reading, no display interrupt.\n'
(out / 'digit_nn_marker_dark.a51').write_text(head2 + dark, encoding='utf-8', newline='\n')
print('ref/nn/energy/digit_nn_marker.a51 and digit_nn_marker_dark.a51 written')

# 11 Nov 2026, the other networks with the display off, for the energy of one reading of each (no marker: the reading
# is timed in the simulator by test/nn_energy_sim.js). SETB ET0 (2 bytes) becomes two NOPs, so no address moves.
for src_file, name in (('ref/nn/uci/digit_uci_bin.a51', 'digit_uci_bin_dark.a51'),
                       ('ref/nn/uci/digit_uci_gray.a51', 'digit_uci_gray_dark.a51'),
                       ('ref/nn/mnist/digit_mnist.a51', 'digit_mnist_dark.a51')):
    s = (ROOT / src_file).read_text(encoding='utf-8')
    assert s.count('        SETB    ET0\n') == 1, src_file
    s = s.replace('        SETB    ET0\n', '        NOP                     ; DISPLAY OFF BUILD (no SETB ET0)\n        NOP\n')
    (out / name).write_text('; DISPLAY OFF BUILD (nn/energy_build.py): ' + src_file + ' without the display interrupt.\n' + s,
                            encoding='utf-8', newline='\n')
    print('ref/nn/energy/' + name + ' written')
# the C sources of the SDCC builds with ET0 = 0, compiled with tools/sdcc_c.ps1 into <folder>/build with the options
# of the originals: none for sdcc/, -DTUNED for sdcc_tuned/ (an unchanged rebuild of each gives the committed hex)
for src_file in ('ref/nn/c/sdcc/digit_nn.c', 'ref/nn/c/mnist/sdcc/digit_mnist.c', 'ref/nn/c/mnist/sdcc_tuned/digit_mnist.c'):
    s = (ROOT / src_file).read_text(encoding='utf-8')
    assert s.count('ET0 = 1;') == 1, src_file
    d = out / 'c' / Path(src_file).parent.relative_to('ref/nn/c')
    d.mkdir(parents=True, exist_ok=True)
    (d / Path(src_file).name).write_text(s.replace('ET0 = 1;', 'ET0 = 0;   /* DISPLAY OFF BUILD (nn/energy_build.py) */'),
                                         encoding='utf-8', newline='\n')
    for h in (ROOT / src_file).parent.glob('*.h'):
        (d / h.name).write_bytes(h.read_bytes())
    print(str(d / Path(src_file).name) + ' written')
