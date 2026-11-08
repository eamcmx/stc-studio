"""Ablation of the digit reader: the hand-written program with its arithmetic shortcuts switched off one at a time.

    python nn/ablation.py      writes ref/nn/ablation/*.a51; then node test/nn_ablation.js measures them

The layer-1 and layer-2 loops of ref/nn/digit_nn.a51 are rebuilt here from four switches:
  binary   the inputs are 0 or 1, so layer 1 adds the weights of the lit squares (off: every square's value is
           multiplied by its weight with MUL AB, lit or not)
  rowptr   DPTR stays on the pixel's row of weights and MOVC A,@A+DPTR reads weight j (off: the address
           W1 + NH*i + j is worked out again for every weight, as C51 does for W1[i][j])
  mulab    layer 2 multiplies the hidden byte by the size of the weight with one MUL AB and adds or subtracts
           (off: a general 16 x 16-bit multiply routine, like a C compiler's int multiply)
  sum24    the layer-2 sums are 24 bits (off: 32 bits, as a C long)
With all four on, the code must be the shipped program, character for character (checked below).
VARIANTS are the shipped program, each switch off on its own, and all four off. FACTORIAL is every one of the
16 combinations, named by the switches that are on (b, r, m, s; 'none' for none), so that the matched partners of
the C builds and any order of switching on can be measured: "C as written" is binary only (b), "C tuned" has the
row pointer and MUL AB but 32-bit sums (brm). Files in ref/nn/ablation/factorial/.
"""
import itertools
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / 'ref' / 'nn' / 'digit_nn.a51'
OUT = ROOT / 'ref' / 'nn' / 'ablation'
src = SRC.read_text(encoding='utf-8')
I = ' ' * 8


def ins(label, op='', args='', comment=''):
    """One line in the program's column layout: label to column 8, opcode to 16, comment at 32."""
    line = (label.ljust(8) if label else I) + (op.ljust(8) + args if op else '')
    if comment:
        line = line.ljust(32) + '; ' + comment
    return line.rstrip()


def fetch_weight(rowptr):
    if rowptr:
        return [ins('L1J:', 'MOV', 'A,R4'), ins('', 'MOVC', 'A,@A+DPTR', 'the weight, -128 to 127')]
    return [ins('L1J:', 'MOV', 'A,R7', 'the address W1 + NH*i + j, worked out for every weight'),
            ins('', 'MOV', 'B,#NH'), ins('', 'MUL', 'AB'),
            ins('', 'ADD', 'A,#LOW W1'), ins('', 'MOV', 'DPL,A'),
            ins('', 'MOV', 'A,B'), ins('', 'ADDC', 'A,#HIGH W1'), ins('', 'MOV', 'DPH,A'),
            ins('', 'MOV', 'A,DPL'), ins('', 'ADD', 'A,R4'), ins('', 'MOV', 'DPL,A'),
            ins('', 'CLR', 'A'), ins('', 'ADDC', 'A,DPH'), ins('', 'MOV', 'DPH,A'),
            ins('', 'CLR', 'A'), ins('', 'MOVC', 'A,@A+DPTR', 'the weight, -128 to 127')]


def layer1(binary, rowptr):
    L = []
    if binary:
        L.append('; for every lit pixel, add its row of NH weights to the NH sums')
    else:
        L.append('; for every pixel, add pixel x weight to the NH sums (the 0/1 inputs are not used)')
    L += [ins('', 'MOV', 'DPTR,#W1'), ins('', 'MOV', 'R1,#PIX'), ins('', 'MOV', 'R3,#35')]
    if not rowptr:
        L.append(ins('', 'MOV', 'R7,#0', "the pixel's number i"))
    if binary:
        L += [ins('L1P:', 'MOV', 'A,@R1'), ins('', 'JZ', 'L1NEXT'), ins('', 'MOV', 'R0,#ACC1'), ins('', 'MOV', 'R4,#0')]
        L += fetch_weight(rowptr)
        L += [ins('', 'MOV', 'R5,A'),
              ins('', 'ADD', 'A,@R0', 'low byte of the sum'),
              ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0'), ins('', 'MOV', 'A,R5'), ins('', 'JB', 'ACC.7,L1NEG'),
              ins('', 'CLR', 'A', 'a positive weight adds 00H to the high byte, with the carry'),
              ins('', 'SJMP', 'L1HI'),
              ins('L1NEG:', 'MOV', 'A,#0FFH', 'a negative one adds FFH'),
              ins('L1HI:', 'ADDC', 'A,@R0'), ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0')]
    else:
        L += [ins('L1P:', 'MOV', 'R0,#ACC1'), ins('', 'MOV', 'R4,#0')]
        L += fetch_weight(rowptr)
        L += [ins('', 'JB', 'ACC.7,L1NEG'),
              ins('', 'MOV', 'B,@R1', 'the pixel, 0 or 1'),
              ins('', 'MUL', 'AB', 'pixel x weight'),
              ins('', 'ADD', 'A,@R0'), ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0'),
              ins('', 'MOV', 'A,B'), ins('', 'ADDC', 'A,@R0'), ins('', 'MOV', '@R0,A'), ins('', 'SJMP', 'L1HI'),
              ins('L1NEG:', 'CPL', 'A', 'a negative weight: pixel x its size, subtracted'), ins('', 'INC', 'A'),
              ins('', 'MOV', 'B,@R1'), ins('', 'MUL', 'AB'),
              ins('', 'XCH', 'A,@R0', 'A = the sum, @R0 = the product (low bytes)'),
              ins('', 'CLR', 'C'), ins('', 'SUBB', 'A,@R0'), ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0'),
              ins('', 'MOV', 'A,@R0'), ins('', 'SUBB', 'A,B'), ins('', 'MOV', '@R0,A'),
              ins('L1HI:', 'INC', 'R0')]
    L += [ins('', 'INC', 'R4'), ins('', 'CJNE', 'R4,#NH,L1J')]
    if rowptr:
        L += [ins('L1NEXT:', 'MOV', 'A,DPL', "on to the next pixel's row"), ins('', 'ADD', 'A,#NH'),
              ins('', 'MOV', 'DPL,A'), ins('', 'JNC', 'L1N2'), ins('', 'INC', 'DPH'),
              ins('L1N2:', 'INC', 'R1'), ins('', 'DJNZ', 'R3,L1P')]
    else:
        L += [ins('L1NEXT:', 'INC', 'R1'), ins('', 'INC', 'R7'), ins('', 'DJNZ', 'R3,L1P')]
    return L


def layer2(mulab, sum24):
    L = [ins('L2J:', 'MOV', 'A,R2'), ins('', 'MOVC', 'A,@A+DPTR', 'the weight')]
    if mulab:
        L += [ins('', 'JB', 'ACC.7,L2NEG'), ins('', 'MOV', 'B,@R0'),
              ins('', 'MUL', 'AB', 'hidden * weight: B = high byte, A = low byte'),
              ins('', 'ADD', 'A,R5'), ins('', 'MOV', 'R5,A'), ins('', 'MOV', 'A,B'), ins('', 'ADDC', 'A,R6'),
              ins('', 'MOV', 'R6,A'), ins('', 'CLR', 'A'), ins('', 'ADDC', 'A,R7'), ins('', 'MOV', 'R7,A')]
        if not sum24:
            L += [ins('', 'CLR', 'A'), ins('', 'ADDC', 'A,X3', 'the fourth byte of a 32-bit sum'), ins('', 'MOV', 'X3,A')]
        L += [ins('', 'SJMP', 'L2NEXT'),
              ins('L2NEG:', 'CPL', 'A', 'a negative weight: multiply by its size and subtract'), ins('', 'INC', 'A'),
              ins('', 'MOV', 'B,@R0'), ins('', 'MUL', 'AB'),
              ins('', 'XCH', 'A,R5', "A = the score's low byte, R5 = the product's low byte"),
              ins('', 'CLR', 'C'), ins('', 'SUBB', 'A,R5'), ins('', 'MOV', 'R5,A'), ins('', 'MOV', 'A,R6'),
              ins('', 'SUBB', 'A,B'), ins('', 'MOV', 'R6,A'), ins('', 'MOV', 'A,R7'), ins('', 'SUBB', 'A,#0'),
              ins('', 'MOV', 'R7,A')]
        if not sum24:
            L += [ins('', 'MOV', 'A,X3'), ins('', 'SUBB', 'A,#0'), ins('', 'MOV', 'X3,A')]
    else:
        L += [ins('', 'MOV', 'MB_LO,A', 'the weight as a 16-bit number'),
              ins('', 'RLC', 'A'), ins('', 'SUBB', 'A,ACC'), ins('', 'MOV', 'MB_HI,A'),
              ins('', 'MOV', 'MA_LO,@R0', 'the hidden value as a 16-bit number'), ins('', 'MOV', 'MA_HI,#0'),
              ins('', 'ACALL', 'IMUL16', 'PR = MA x MB, 16 bits'),
              ins('', 'MOV', 'A,PR_HI'), ins('', 'RLC', 'A'), ins('', 'SUBB', 'A,ACC'),
              ins('', 'MOV', 'PR_EX,A', 'the sign of the product, 00H or FFH'),
              ins('', 'MOV', 'A,PR_LO'), ins('', 'ADD', 'A,R5'), ins('', 'MOV', 'R5,A'),
              ins('', 'MOV', 'A,PR_HI'), ins('', 'ADDC', 'A,R6'), ins('', 'MOV', 'R6,A'),
              ins('', 'MOV', 'A,PR_EX'), ins('', 'ADDC', 'A,R7'), ins('', 'MOV', 'R7,A')]
        if not sum24:
            L += [ins('', 'MOV', 'A,PR_EX'), ins('', 'ADDC', 'A,X3', 'the fourth byte of a 32-bit sum'), ins('', 'MOV', 'X3,A')]
    L += [ins('L2NEXT:', 'INC', 'R0'), ins('', 'INC', 'R2'), ins('', 'CJNE', 'R2,#NH+3,L2J')]
    return L


IMUL16 = '\n'.join([
    '; ---- a general 16 x 16-bit multiply, low 16 bits of the product (only in the ablation variants)',
    ins('MA_LO', 'EQU', '20H'), ins('MA_HI', 'EQU', '21H'), ins('MB_LO', 'EQU', '22H'), ins('MB_HI', 'EQU', '23H'),
    ins('PR_LO', 'EQU', '24H'), ins('PR_HI', 'EQU', '25H'), ins('PR_EX', 'EQU', '26H'),
    ins('IMUL16:', 'MOV', 'A,MA_LO'), ins('', 'MOV', 'B,MB_LO'), ins('', 'MUL', 'AB'),
    ins('', 'MOV', 'PR_LO,A'), ins('', 'MOV', 'PR_HI,B'),
    ins('', 'MOV', 'A,MA_LO'), ins('', 'MOV', 'B,MB_HI'), ins('', 'MUL', 'AB'), ins('', 'ADD', 'A,PR_HI'), ins('', 'MOV', 'PR_HI,A'),
    ins('', 'MOV', 'A,MA_HI'), ins('', 'MOV', 'B,MB_LO'), ins('', 'MUL', 'AB'), ins('', 'ADD', 'A,PR_HI'), ins('', 'MOV', 'PR_HI,A'),
    ins('', 'RET'), ''])

# the two parts of the shipped program that are rebuilt
L1_START, L1_END = '; for every lit pixel, add its row of NH weights to the NH sums\n', '        DJNZ    R3,L1P\n'
L2_START, L2_END = 'L2J:    MOV     A,R2\n', '        CJNE    R2,#NH+3,L2J\n'
a, b = src.index(L1_START), src.index(L1_END) + len(L1_END)
c, d = src.index(L2_START), src.index(L2_END) + len(L2_END)
assert a < b < c < d


def build(binary, rowptr, mulab, sum24):
    out = src[:a] + '\n'.join(layer1(binary, rowptr)) + '\n' + src[b:c] + '\n'.join(layer2(mulab, sum24)) + '\n' + src[d:]
    if not sum24:   # the fourth byte starts as the sign of the 24-bit bias
        anchor = '        MOV     R7,A\n        MOV     R0,#HID\n'
        assert out.count(anchor) == 1
        out = out.replace(anchor, '        MOV     R7,A\n' + '\n'.join([
            ins('', 'RLC', 'A', 'the sign of the bias fills the fourth byte'), ins('', 'SUBB', 'A,ACC'), ins('', 'MOV', 'X3,A'),
            ins('', 'MOV', 'R0,#HID')]) + '\n')
        out = out.replace('; ---- serial port\n', ins('X3', 'EQU', '27H', 'the fourth byte of the 32-bit sum') + '\n\n; ---- serial port\n')
    if not mulab:
        out = out.replace('; ---- serial port\n', IMUL16 + '\n; ---- serial port\n')
    return out


assert build(True, True, True, True) == src, 'with every shortcut on, the generator must give the shipped program'

VARIANTS = [
    ('all_shortcuts', (True, True, True, True), 'the shipped program'),
    ('no_binary', (False, True, True, True), 'every square multiplied by its weight'),
    ('no_rowptr', (True, False, True, True), 'weight address worked out for every weight'),
    ('no_mulab', (True, True, False, True), 'general 16 x 16-bit multiply in layer 2'),
    ('sum32', (True, True, True, False), '32-bit sums in layer 2'),
    ('no_shortcuts', (False, False, False, False), 'all four off'),
]
FACTORIAL = [(''.join(k for k, on in zip('brms', f) if on) or 'none', f) for f in itertools.product((False, True), repeat=4)]

if __name__ == '__main__':
    OUT.mkdir(parents=True, exist_ok=True)
    for name, flags, what in VARIANTS:
        text = build(*flags)
        head = '; ABLATION VARIANT %s: %s (made by nn/ablation.py from ref/nn/digit_nn.a51)\n' % (name, what)
        (OUT / (name + '.a51')).write_text(head + text, encoding='utf-8', newline='\n')
        print('%-14s %s' % (name, what))
    (OUT / 'factorial').mkdir(exist_ok=True)
    for name, flags in FACTORIAL:
        what = ', '.join(w for w, on in zip(('binary inputs', 'row pointer', 'MUL AB with the sign split', '24-bit sums'), flags) if on) or 'no shortcut'
        head = '; ABLATION VARIANT %s: %s (made by nn/ablation.py from ref/nn/digit_nn.a51)\n' % (name, what)
        (OUT / 'factorial' / (name + '.a51')).write_text(head + build(*flags), encoding='utf-8', newline='\n')
    print(len(FACTORIAL), 'combinations in ref/nn/ablation/factorial')
