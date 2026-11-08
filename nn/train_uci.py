"""The digit reader on a standard dataset: UCI Optical Recognition of Handwritten Digits (Alpaydin and Kaynak, 1998),
8 x 8 grids with 17 grey levels, 3823 training digits and 1797 test digits written by other people (the dataset's
writer-independent split). Files in nn/data/optdigits/ from archive.ics.uci.edu.

    python nn/train_uci.py     trains, rounds to 8 bits, writes ref/nn/uci/*.a51 and nn/uci_vectors_*.json
    node test/nn_uci.js        runs the two programs on the simulated board against these vectors

Two input codings, each with a 64-24-10 network:
  bin    a square is 1 when its grey level is 8 or more: layer 1 stays additions only, as on the 5 x 7 grid
  gray   the grey level 0 to 16, capped at 15 (4 bits): layer 1 multiplies every square by its weight (MUL AB)
The 8051 programs are made from ref/nn/digit_nn.a51 (same code, 64 inputs, a new memory map); the gray one takes its
layer-1 loop from nn/ablation.py (the variant without the binary shortcut) and reads hex digits.
"""
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import ablation  # noqa: E402  (the layer-1 loop without the binary shortcut)

DATA = ROOT / 'nn' / 'data' / 'optdigits'
OUT = ROOT / 'ref' / 'nn' / 'uci'
HIDDEN, NIN = 24, 64


def load(name):
    a = np.loadtxt(DATA / name, delimiter=',', dtype=int)
    return a[:, :64], a[:, 64]


def encode(v, kind):
    return (v >= 8).astype(int) if kind == 'bin' else np.minimum(v, 15)


def train(X, Y, hidden=HIDDEN, epochs=80, seed=1):
    rng = np.random.default_rng(seed)
    n_in = X.shape[1]
    W1 = rng.normal(0, np.sqrt(2 / n_in), (n_in, hidden)); b1 = np.zeros(hidden)
    W2 = rng.normal(0, np.sqrt(2 / hidden), (hidden, 10)); b2 = np.zeros(10)
    P = [W1, b1, W2, b2]
    M = [np.zeros_like(p) for p in P]; V = [np.zeros_like(p) for p in P]
    lr, t = 0.01, 0
    for ep in range(epochs):
        idx = rng.permutation(len(X))
        for k in range(0, len(X), 64):
            b = idx[k:k + 64]
            x, y = X[b], Y[b]
            z1 = x @ W1 + b1; h = np.maximum(z1, 0)
            z2 = h @ W2 + b2
            z2 = z2 - z2.max(1, keepdims=True)
            p = np.exp(z2); p /= p.sum(1, keepdims=True)
            g2 = p; g2[np.arange(len(y)), y] -= 1; g2 /= len(y)
            gW2 = h.T @ g2 + 1e-4 * W2; gb2 = g2.sum(0)
            gh = g2 @ W2.T; gh[z1 <= 0] = 0
            gW1 = x.T @ gh + 1e-4 * W1; gb1 = gh.sum(0)
            t += 1
            for i, g in enumerate([gW1, gb1, gW2, gb2]):
                M[i] = 0.9 * M[i] + 0.1 * g; V[i] = 0.999 * V[i] + 0.001 * g * g
                P[i] -= lr * (M[i] / (1 - 0.9 ** t)) / (np.sqrt(V[i] / (1 - 0.999 ** t)) + 1e-8)
        if ep == epochs * 2 // 3:
            lr /= 5
    return P


def quantize(P, U, K):
    """U: integer inputs (0/1 or 0-15); the float network saw U / K. Layer-1 sums must fit 16 bits for ANY input."""
    W1, b1, W2, b2 = P
    s1 = max(np.abs(W1).max() / 127, (K * np.abs(W1).sum(0) + K * np.abs(b1)).max() / 32000)
    W1q = np.round(W1 / s1).astype(int)
    b1q = np.round(K * b1 / s1).astype(int)
    assert np.abs(W1q).max() <= 127
    assert (K * np.abs(W1q).sum(0) + np.abs(b1q)).max() <= 32767, 'a layer-1 sum could overflow 16 bits'
    acc = U @ W1q + b1q
    top = np.percentile(np.maximum(acc, 0), 99.9)
    sh1 = max(0, int(np.ceil(np.log2(max(top, 1) / 255))))
    s2 = np.abs(W2).max() / 127
    W2q = np.round(W2 / s2).astype(int)
    b2q = np.round(b2 / ((s1 / K) * 2 ** sh1 * s2)).astype(int)
    assert HIDDEN * 255 * 128 + np.abs(b2q).max() < 2 ** 23
    return dict(W1=W1q, b1=b1q, sh1=sh1, W2=W2q, b2=b2q, s1=s1)


def int_forward(Q, u):
    """What the 8051 program does for one input (u: NIN integers)."""
    hid = []
    for j in range(HIDDEN):
        a = int(Q['b1'][j]) + sum(int(Q['W1'][i][j]) * int(u[i]) for i in range(NIN) if u[i])
        assert -32768 <= a <= 32767
        hid.append(0 if a < 0 else min(255, a >> Q['sh1']))
    scores = [int(Q['b2'][k]) + sum(hid[j] * int(Q['W2'][j][k]) for j in range(HIDDEN)) for k in range(10)]
    best = 0
    for k in range(1, 10):
        if scores[k] > scores[best]:
            best = k
    return best, scores


def int_predict(Q, U):
    h = np.minimum(np.maximum(U @ Q['W1'] + Q['b1'], 0) >> Q['sh1'], 255)
    return (h @ Q['W2'] + Q['b2']).argmax(1)


# ---------------------------------------------------------------- the 8051 programs
HEADER = """; Digit reader on the UCI handwritten digits (8 x 8, {what}): a 64-24-10 neural network on the STC89C52RC.
; Made by nn/train_uci.py from ref/nn/digit_nn.a51 (same code, 64 inputs, new memory map). Do not edit by hand.
; The page sends D and 64 characters ({chars}), row by row from the top left; the board answers "=", the
; digit and its 10 scores in hex, and shows the digit. Serial: 19200 baud. Board: as in digit_nn.a51.

"""
MAP_OLD = """PIX     EQU     30H             ; 35 bytes: the pixels, 0 or 1             (30H-52H)
ACC1    EQU     53H             ; NH x 16-bit sums of the hidden layer    (53H-82H for NH = 24)
HID     EQU     ACC1+2*NH       ; NH hidden values, 0 to 255               (83H-9AH; above 7FH only @R0/@R1 reach)
SCORE   EQU     HID+NH          ; 10 x 24-bit scores, low byte first       (9BH-B8H)
"""
MAP_NEW = """PIX     EQU     30H             ; NIN bytes: the pixels                    (30H-6FH)
ACC1    EQU     70H             ; NH x 16-bit sums of the hidden layer    (70H-9FH)
HID     EQU     ACC1+2*NH       ; NH hidden values, 0 to 255               (A0H-B7H; above 7FH only @R0/@R1 reach)
SCORE   EQU     HID+NH          ; 10 x 24-bit scores, low byte first       (B8H-D5H)
"""
READ_OLD = """        MOV     R0,#PIX
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


def tables(Q):
    L = ['NIN     EQU     %d              ; inputs' % NIN, 'NH      EQU     %d              ; hidden neurons' % HIDDEN,
         'SH1     EQU     %d               ; hidden values are (sum >> SH1), 0 to 255' % Q['sh1'], '', 'B1:']
    b1 = []
    for v in Q['b1']:
        b1 += [v & 0xFF, (v >> 8) & 0xFF]
    L += ablation_db(b1)
    L.append('W1:')
    for i in range(NIN):
        L += ablation_db(Q['W1'][i])
    L.append('W2:')
    for k in range(10):
        v = int(Q['b2'][k])
        L += ablation_db([v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF] + [int(Q['W2'][j][k]) for j in range(HIDDEN)], per=HIDDEN + 3)
    return '\n'.join(L) + '\n'


def ablation_db(values, per=16):
    vals = ['%03XH' % (int(v) & 0xFF) for v in values]
    return ['        DB      ' + ','.join(vals[i:i + per]) for i in range(0, len(vals), per)]


def program(Q, kind):
    src = ablation.src
    body = src[src.index('PIX     EQU'):src.index('; ---- WEIGHTS START')]
    assert body.count(MAP_OLD) == 1 and body.count(READ_OLD) == 1
    body = body.replace(MAP_OLD, MAP_NEW)
    body = body.replace('MAIN:   MOV     SP,#0BFH        ; stack from C0H, in the upper 128 bytes of the 8052\'s RAM',
                        'MAIN:   MOV     SP,#0D7H        ; stack from D8H, in the upper 128 bytes of the 8052\'s RAM')
    assert 'SP,#0D7H' in body
    if kind == 'bin':
        body = body.replace(READ_OLD, READ_OLD.replace('#35', '#NIN'))
        what, chars = 'squares on or off', '1 for a dark square, 0 for a light one'
    else:
        body = body.replace(READ_OLD, READ_HEX)
        a, b = body.index(ablation.L1_START), body.index(ablation.L1_END) + len(ablation.L1_END)
        body = body[:a] + '\n'.join(ablation.layer1(False, True)) + '\n' + body[b:]
        what, chars = '16 grey levels', 'hex digits 0-F, the grey level'
    body = body.replace('        MOV     R3,#35\n', '        MOV     R3,#NIN\n')
    assert '#35' not in body
    return HEADER.format(what=what, chars=chars) + body + '; ---- WEIGHTS (written by nn/train_uci.py)\n' + tables(Q) + '        END\n'


def main():
    Xtr, Ytr = load('optdigits.tra')
    Xte, Yte = load('optdigits.tes')
    OUT.mkdir(parents=True, exist_ok=True)
    report = {'train': len(Ytr), 'test': len(Yte), 'split': 'writer-independent (UCI optdigits.tra / optdigits.tes)'}
    for kind, K in (('bin', 1), ('gray', 15)):
        Utr, Ute = encode(Xtr, kind), encode(Xte, kind)
        P = train(Utr / K, Ytr)
        f_acc = float(((np.maximum(Ute / K @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean())
        Q = quantize(P, Utr, K)
        i_acc = float((int_predict(Q, Ute) == Yte).mean())
        vecs = []
        for u, y in zip(Ute, Yte):
            d, scores = int_forward(Q, u)
            chars = ''.join('0123456789ABCDEF'[v] for v in u)
            vecs.append({'pixels': chars, 'label': int(y), 'digit': d, 'scores': scores})
        assert all(v['digit'] == p for v, p in zip(vecs, int_predict(Q, Ute)))
        (ROOT / 'nn' / ('uci_vectors_%s.json' % kind)).write_text(json.dumps(vecs), encoding='utf-8')
        (OUT / ('digit_uci_%s.a51' % kind)).write_text(program(Q, kind), encoding='utf-8', newline='\n')
        report[kind] = {'float_test_accuracy': round(f_acc, 4), 'int8_test_accuracy': round(i_acc, 4), 'sh1': Q['sh1'],
                        'max_abs_W1q': int(np.abs(Q['W1']).max())}
        print(kind, json.dumps(report[kind]))
    (ROOT / 'nn' / 'uci_report.json').write_text(json.dumps(report, indent=1), encoding='utf-8')


if __name__ == '__main__':
    main()
