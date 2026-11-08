"""The network-to-assembly generator: writes the 8051 program for a trained, 8-bit multilayer perceptron with N inputs,
H hidden neurons and 10 outputs, from the hand-written digit reader (ref/nn/digit_nn.a51) as its template.

    import gen51
    text = gen51.generate(Q, nin=196, coding='packed', header='...')

Only the parts that depend on the network are rewritten; the rest is the hand-written code, unchanged:
  memory map   the inputs from 30H, then 2H bytes of layer-1 sums, H hidden values and 30 bytes of scores; the stack
               starts at the next multiple of 8 and needs 13 bytes (checked)
  input        'bytes'  one character per input, 1 or 0, kept as a byte (the 5 x 7 reader, the UCI binary program)
               'hex'    one hex digit per input, the grey level 0-15, kept as a byte (the UCI 16-level program)
               'packed' one character per input, 1 or 0, kept as a bit, 8 inputs to a byte, first input in bit 7
               (for many binary inputs: 196 inputs take 25 bytes of RAM instead of 196)
  layer 1      additions only for binary inputs ('bytes', 'packed'); the multiplying loop of nn/ablation.py for 'hex'
  shortcuts    the four switches of nn/ablation.py (binary inputs, row pointer, MUL AB with the sign split, 24-bit
               sums), all on by default; 'packed' needs the binary-input loop
  tables       B1 (16-bit), W1 (one row of H weights per input), W2 (per digit a 24-bit bias and H weights)

generate(Q of the shipped 5 x 7 network, 35, 'bytes', style='5x7') returns ref/nn/digit_nn.a51 character for
character (checked in __main__), and the UCI programs it writes assemble to the same bytes as nn/train_uci.py's.
Every program it writes must still be checked against the Python reference (gen51.int_forward) in the simulator.
"""
import math
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import ablation  # noqa: E402  (the template and the loop builders)

SRC = ablation.src
I = ' ' * 8
ins = ablation.ins

MAP_5X7 = SRC[SRC.index('PIX     EQU'):SRC.index('DBUF    EQU')]
READ_BYTES = """        MOV     R0,#PIX
        MOV     R2,#35
RDPIX:  ACALL   GETC
        CJNE    A,#'1',DARK
        MOV     @R0,#1
        SJMP    NEXTPX
DARK:   MOV     @R0,#0
NEXTPX: INC     R0
        DJNZ    R2,RDPIX
"""
READ_HEX = """        MOV     R0,#PIX
        MOV     R2,#NIN
RDPIX:  ACALL   GETC            ; a hex digit, 0-9 or A-F
        CLR     C
        SUBB    A,#'0'
        CJNE    A,#10,HEX1
HEX1:   JC      HEX2            ; 0-9
        SUBB    A,#7            ; A-F become 10-15
HEX2:   MOV     @R0,A
        INC     R0
        DJNZ    R2,RDPIX
"""
READ_PACKED = """        MOV     R0,#PIX
        MOV     R3,#NIN
        MOV     R2,#8           ; bits left in the byte being filled
RDPIX:  ACALL   GETC
        CJNE    A,#'1',RDBIT    ; C = 1 for '0' (below '1'), 0 for '1'
RDBIT:  CPL     C               ; the input as a bit
        MOV     A,R7
        RLC     A               ; into the byte, first input ends in bit 7
        MOV     R7,A
        DJNZ    R2,RDNEXT
        MOV     @R0,A           ; 8 inputs: store the byte
        INC     R0
        MOV     R2,#8
RDNEXT: DJNZ    R3,RDPIX
        CJNE    R2,#8,RDLAST    ; inputs left over in a part-filled byte?
        SJMP    RDDONE
RDLAST: MOV     A,R7
RDALGN: CLR     C               ; shift them up to bit 7
        RLC     A
        DJNZ    R2,RDALGN
        MOV     @R0,A
RDDONE:
"""


def layer1_packed():
    """The binary-input layer 1 with the inputs as bits: R7 holds the current byte, R2 counts its bits."""
    L = ['; for every lit input (a 1 bit), add its row of NH weights to the NH sums',
         ins('', 'MOV', 'DPTR,#W1'), ins('', 'MOV', 'R1,#PIX'), ins('', 'MOV', 'R3,#NIN'),
         ins('', 'MOV', 'R2,#1', 'a new byte at the first input'),
         ins('L1P:', 'DJNZ', 'R2,L1BIT'), ins('', 'MOV', 'A,@R1', 'the next 8 inputs'), ins('', 'INC', 'R1'),
         ins('', 'MOV', 'R7,A'), ins('', 'MOV', 'R2,#8'),
         ins('L1BIT:', 'MOV', 'A,R7'), ins('', 'RLC', 'A', 'the input to C'), ins('', 'MOV', 'R7,A'),
         ins('', 'JNC', 'L1NEXT'), ins('', 'MOV', 'R0,#ACC1'), ins('', 'MOV', 'R4,#0')]
    L += ablation.fetch_weight(True)
    L += [ins('', 'MOV', 'R5,A'),
          ins('', 'ADD', 'A,@R0', 'low byte of the sum'),
          ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0'), ins('', 'MOV', 'A,R5'), ins('', 'JB', 'ACC.7,L1NEG'),
          ins('', 'CLR', 'A', 'a positive weight adds 00H to the high byte, with the carry'),
          ins('', 'SJMP', 'L1HI'),
          ins('L1NEG:', 'MOV', 'A,#0FFH', 'a negative one adds FFH'),
          ins('L1HI:', 'ADDC', 'A,@R0'), ins('', 'MOV', '@R0,A'), ins('', 'INC', 'R0'),
          ins('', 'INC', 'R4'), ins('', 'CJNE', 'R4,#NH,L1J'),
          ins('L1NEXT:', 'MOV', 'A,DPL', "on to the next input's row"), ins('', 'ADD', 'A,#NH'),
          ins('', 'MOV', 'DPL,A'), ins('', 'JNC', 'L1N2'), ins('', 'INC', 'DPH'),
          ins('L1N2:', 'DJNZ', 'R3,L1P')]
    return L


STACK = 13


def memory(nin, H, coding):
    """Addresses of the memory map, and a check that the stack still fits under 100H: 13 bytes at the deepest, the
    display interrupt (6) while PUTHEX, NIBBLE and PUTC are called (7), measured in the simulator."""
    pix = math.ceil(nin / 8) if coding == 'packed' else nin
    acc1 = 0x30 + pix
    score_end = acc1 + 3 * H + 30                 # first byte above the scores
    stack = (score_end + 7) & ~7
    if stack + STACK > 0x100:
        raise ValueError('no room: %d inputs (%s) and %d hidden neurons need RAM up to %02XH' % (nin, coding, H, stack + STACK))
    return dict(pix_bytes=pix, acc1=acc1, hid=acc1 + 2 * H, score=acc1 + 3 * H, score_end=score_end, sp=stack - 1)


def map_text(m, nin, H, coding):
    what = {'bytes': 'the inputs, one byte each', 'hex': 'the inputs, 0-15, one byte each',
            'packed': 'the inputs, 8 to a byte, first input in bit 7'}[coding]
    return ('PIX     EQU     30H             ; %d bytes: %s (30H-%02XH)\n' % (m['pix_bytes'], what, 0x2F + m['pix_bytes']) +
            'ACC1    EQU     %03XH            ; NH x 16-bit sums of the hidden layer    (%02XH-%02XH)\n' % (m['acc1'], m['acc1'], m['hid'] - 1) +
            'HID     EQU     ACC1+2*NH       ; NH hidden values, 0 to 255               (%02XH-%02XH; above 7FH only @R0/@R1 reach)\n' % (m['hid'], m['score'] - 1) +
            'SCORE   EQU     HID+NH          ; 10 x 24-bit scores, low byte first       (%02XH-%02XH)\n' % (m['score'], m['score_end'] - 1))


def db(values, per=16):
    vals = ['%03XH' % (int(v) & 0xFF) for v in values]
    return ['        DB      ' + ','.join(vals[i:i + per]) for i in range(0, len(vals), per)]


def tables(Q, nin):
    H = len(Q['b1'])
    L = ['NIN     EQU     %d              ; inputs' % nin, 'NH      EQU     %d              ; hidden neurons' % H,
         'SH1     EQU     %d               ; hidden values are (sum >> SH1), 0 to 255' % Q['sh1'], '', 'B1:']
    b1 = []
    for v in Q['b1']:
        b1 += [int(v) & 0xFF, (int(v) >> 8) & 0xFF]
    L += db(b1)
    L.append('W1:')
    for i in range(nin):
        L += db(Q['W1'][i])
    L.append('W2:')
    for k in range(10):
        v = int(Q['b2'][k])
        L += db([v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF] + [int(Q['W2'][j][k]) for j in range(H)], per=H + 3)
    return '\n'.join(L) + '\n'


def check_bounds(Q, nin, kmax):
    """The accumulators: 16 bits in layer 1 for any input (inputs up to kmax), 24 bits in layer 2."""
    W1, b1, W2, b2 = (np.asarray(Q[k]) for k in ('W1', 'b1', 'W2', 'b2'))
    H = len(b1)
    assert W1.shape == (nin, H) and W2.shape == (H, 10)
    assert np.abs(W1).max() <= 127 and np.abs(W2).max() <= 128
    assert (kmax * np.abs(W1).sum(0) + np.abs(b1)).max() <= 32767, 'a layer-1 sum could overflow 16 bits'
    assert H * 255 * 128 + np.abs(b2).max() < 2 ** 23, 'a layer-2 sum could overflow 24 bits'


def generate(Q, nin, coding='bytes', shortcuts=(True, True, True, True), header=None, style=None):
    """The 8051 program for the 8-bit network Q (W1 nin x H, b1, W2 H x 10, b2, sh1)."""
    H = len(Q['b1'])
    binary, rowptr, mulab, sum24 = shortcuts
    if coding == 'packed' and not (binary and rowptr):
        raise ValueError("'packed' inputs are written for the binary-input loop with the row pointer")
    if coding == 'hex' and binary:
        raise ValueError("'hex' inputs (0-15) need the multiplying layer 1: shortcuts[0] = False")
    check_bounds(Q, nin, 15 if coding == 'hex' else 1)
    if style == '5x7':            # the template itself: its header, map and table format
        import train_digits as TD
        assert nin == 35 and coding == 'bytes' and H == TD.HIDDEN
        out = ablation.build(*shortcuts)
        a = out.index('; ---- WEIGHTS START')
        a = out.index('\n', a) + 1
        b = out.index('; ---- WEIGHTS END')
        return out[:a] + '\n'.join(TD.asm_tables(Q)) + '\n' + out[b:]
    m = memory(nin, H, coding)
    body = SRC[SRC.index('PIX     EQU'):SRC.index('; ---- WEIGHTS START')]
    body = body.replace(MAP_5X7, map_text(m, nin, H, coding))
    assert body.count(READ_BYTES) == 1
    body = body.replace(READ_BYTES, {'bytes': READ_BYTES.replace('#35', '#NIN'), 'hex': READ_HEX, 'packed': READ_PACKED}[coding])
    sp_old = "MAIN:   MOV     SP,#0BFH        ; stack from C0H, in the upper 128 bytes of the 8052's RAM"
    assert body.count(sp_old) == 1
    body = body.replace(sp_old, "MAIN:   MOV     SP,#0%02XH        ; stack from %02XH" % (m['sp'], m['sp'] + 1))
    a, b = body.index(ablation.L1_START), body.index(ablation.L1_END) + len(ablation.L1_END)
    l1 = layer1_packed() if coding == 'packed' else ablation.layer1(binary, rowptr)
    body = body[:a] + '\n'.join(l1) + '\n' + body[b:]
    c, d = body.index(ablation.L2_START), body.index(ablation.L2_END) + len(ablation.L2_END)
    body = body[:c] + '\n'.join(ablation.layer2(mulab, sum24)) + '\n' + body[d:]
    if not sum24:            # as nn/ablation.py: the fourth byte of the 32-bit sums
        anchor = '        MOV     R7,A\n        MOV     R0,#HID\n'
        body = body.replace(anchor, '        MOV     R7,A\n' + '\n'.join([
            ins('', 'RLC', 'A', 'the sign of the bias fills the fourth byte'), ins('', 'SUBB', 'A,ACC'), ins('', 'MOV', 'X3,A'),
            ins('', 'MOV', 'R0,#HID')]) + '\n')
        body = body.replace('; ---- serial port\n', ins('X3', 'EQU', '27H', 'the fourth byte of the 32-bit sum') + '\n\n; ---- serial port\n')
    if not mulab:
        body = body.replace('; ---- serial port\n', ablation.IMUL16 + '\n; ---- serial port\n')
    body = body.replace('        MOV     R3,#35\n', '        MOV     R3,#NIN\n')
    assert '#35' not in body
    head = header or ('; Neural network on the STC89C52RC: %d inputs (%s), %d hidden neurons, 10 outputs.\n'
                      '; Written by nn/gen51.py from ref/nn/digit_nn.a51. Do not edit by hand.\n' % (nin, coding, H))
    return head + '\n' + body + '; ---- WEIGHTS (written by nn/gen51.py)\n' + tables(Q, nin) + '        END\n'


def int_forward(Q, u):
    """What every generated program computes for one input u (nin integers): (digit, 10 scores)."""
    W1, b1, W2, b2, sh1 = (np.asarray(Q[k]) for k in ('W1', 'b1', 'W2', 'b2', 'sh1'))
    a = b1.astype(int) + np.asarray(u, int) @ W1.astype(int)
    assert (a >= -32768).all() and (a <= 32767).all()
    h = np.minimum(np.maximum(a, 0) >> int(sh1), 255)
    s = b2.astype(int) + h @ W2.astype(int)
    best = 0
    for k in range(1, 10):
        if s[k] > s[best]:
            best = k
    return best, [int(v) for v in s]


if __name__ == '__main__':
    # 1. the shipped 5 x 7 network: the template, character for character
    import train_digits as TD
    Q = TD.load_model()
    assert generate(Q, 35, 'bytes', style='5x7') == SRC, 'the generator must return the hand-written program'
    print('5 x 7 network: generate() returns ref/nn/digit_nn.a51 unchanged')
    # 2. the UCI networks, trained again with seed 1 (as nn/train_uci.py does): written to ref/nn/gen/ for
    #    test/gen51_check.js, which assembles them and compares the bytes with ref/nn/uci/digit_uci_*.a51
    import train_uci as TU
    out = ROOT / 'ref' / 'nn' / 'gen'
    out.mkdir(parents=True, exist_ok=True)
    Xtr, Ytr = TU.load('optdigits.tra')
    for kind, coding, sc, K in (('bin', 'bytes', (True, True, True, True), 1), ('gray', 'hex', (False, True, True, True), 15)):
        U = TU.encode(Xtr, kind)
        Qu = TU.quantize(TU.train(U / K, Ytr), U, K)
        (out / ('uci_%s.a51' % kind)).write_text(generate(Qu, 64, coding, sc), encoding='utf-8', newline='\n')
        print('UCI', kind, '-> ref/nn/gen/uci_%s.a51 (node test/gen51_check.js compares its bytes)' % kind)
