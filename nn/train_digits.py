"""Trains the 35-24-10 digit reader for the STC89C52RC board and writes its weight tables into
ref/nn/digit_nn.a51 (between the WEIGHTS markers).

    python nn/train_digits.py            (also writes ref/nn/c/weights.h for the C version)
    python nn/train_digits.py --c-only   (only the C header, from nn/model.json)

Input: a 5x7 grid of pixels (35 inputs, 0 or 1), row by row from the top left.
Hidden layer: 24 neurons with ReLU. Output: 10 scores, the largest one is the digit.

The board does the sums with whole numbers, so after training the weights are rounded to 8-bit integers.
int_forward() below does exactly what the 8051 program does, step by step, and test/nn_test.js checks the
simulated board against the vectors this script writes (nn/test_vectors.json).
"""
import json
import os
import re
import sys

import numpy as np

HIDDEN = 24
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASM = os.path.join(ROOT, 'ref', 'nn', 'digit_nn.a51')

# ---------------------------------------------------------------- the shapes people draw on a 5x7 grid
BIG = {  # full-size digits, 5 wide and 7 tall; several ways of writing each
    0: ['.###.|#...#|#...#|#...#|#...#|#...#|.###.', '.###.|#...#|#..##|#.#.#|##..#|#...#|.###.',
        '#####|#...#|#...#|#...#|#...#|#...#|#####'],
    1: ['..#..|.##..|..#..|..#..|..#..|..#..|.###.', '..#..|.##..|#.#..|..#..|..#..|..#..|..#..',
        '..#..|..#..|..#..|..#..|..#..|..#..|..#..', '....#|....#|....#|....#|....#|....#|....#',
        '#....|#....|#....|#....|#....|#....|#....'],
    2: ['.###.|#...#|....#|...#.|..#..|.#...|#####', '.###.|#...#|....#|..##.|.#...|#....|#####',
        '#####|....#|....#|#####|#....|#....|#####'],
    3: ['#####|...#.|..#..|...#.|....#|#...#|.###.', '.###.|#...#|....#|..##.|....#|#...#|.###.',
        '#####|....#|....#|#####|....#|....#|#####', '####.|....#|....#|.###.|....#|....#|####.'],
    4: ['...#.|..##.|.#.#.|#..#.|#####|...#.|...#.', '#...#|#...#|#...#|#####|....#|....#|....#',
        '#..#.|#..#.|#..#.|#####|...#.|...#.|...#.'],
    5: ['#####|#....|####.|....#|....#|#...#|.###.', '#####|#....|#....|####.|....#|....#|####.',
        '#####|#....|#....|#####|....#|....#|#####'],
    6: ['..##.|.#...|#....|####.|#...#|#...#|.###.', '.###.|#....|#....|####.|#...#|#...#|.###.',
        '#####|#....|#....|#####|#...#|#...#|#####', '#....|#....|#....|#####|#...#|#...#|#####'],
    7: ['#####|....#|...#.|..#..|.#...|.#...|.#...', '#####|....#|....#|...#.|..#..|..#..|..#..',
        '#####|....#|....#|....#|....#|....#|....#'],
    8: ['.###.|#...#|#...#|.###.|#...#|#...#|.###.', '#####|#...#|#...#|#####|#...#|#...#|#####'],
    9: ['.###.|#...#|#...#|.####|....#|...#.|.##..', '.###.|#...#|#...#|.####|....#|....#|.###.',
        '#####|#...#|#...#|#####|....#|....#|#####', '#####|#...#|#...#|#####|....#|....#|....#'],
}
SMALL = {  # 3 wide and 5 tall, drawn somewhere on the grid
    0: ['###|#.#|#.#|#.#|###'], 1: ['.#.|##.|.#.|.#.|###', '.#.|.#.|.#.|.#.|.#.'],
    2: ['###|..#|###|#..|###'], 3: ['###|..#|###|..#|###'], 4: ['#.#|#.#|###|..#|..#'],
    5: ['###|#..|###|..#|###'], 6: ['###|#..|###|#.#|###'], 7: ['###|..#|..#|..#|..#'],
    8: ['###|#.#|###|#.#|###'], 9: ['###|#.#|###|..#|###'],
}


def grid(rows, w=5, h=7, dx=0, dy=0):
    g = np.zeros((h, w), dtype=np.int8)
    for y, row in enumerate(rows.split('|')):
        for x, c in enumerate(row):
            if c == '#':
                g[y + dy, x + dx] = 1
    return g


# narrower and shorter copies of a full-size digit: columns or rows merged (a pixel is lit if either was)
COLS = {5: [[0], [1], [2], [3], [4]], 4: [[0], [1, 2], [3], [4]], 3: [[0], [1, 2, 3], [4]]}
ROWS = {7: [[0], [1], [2], [3], [4], [5], [6]], 6: [[0], [1], [2], [3, 4], [5], [6]], 5: [[0], [1, 2], [3], [4, 5], [6]]}


def squeeze(g, w, h):
    m = np.array([g[rows, :].max(0) for rows in ROWS[h]])            # h x 5
    return np.array([[m[y, cols].max() for cols in COLS[w]] for y in range(h)], dtype=np.int8)


def templates():
    out = []  # (digit, 7x5 array)
    for d, shapes in BIG.items():
        for s in shapes:
            g = grid(s)
            for w in (5, 4, 3):
                for h in (7, 6, 5):
                    small = squeeze(g, w, h)
                    for dx in range(6 - w):
                        for dy in range(8 - h):
                            p = np.zeros((7, 5), dtype=np.int8)
                            p[dy:dy + h, dx:dx + w] = small
                            out.append((d, p))
            for dx in (-1, 1):  # a full-size digit moved sideways when a column is empty
                if (dx < 0 and not g[:, 0].any()) or (dx > 0 and not g[:, 4].any()):
                    out.append((d, np.roll(g, dx, axis=1)))
    for d, shapes in SMALL.items():
        for s in shapes:
            for dx in range(3):
                for dy in range(3):
                    out.append((d, grid(s, dx=dx, dy=dy)))
    # some squeezed shapes come out the same for two digits (a narrow 3 and a narrow 8): leave those out
    seen = {}
    for d, g in out:
        seen.setdefault(g.tobytes(), set()).add(d)
    return [(d, g) for d, g in out if len(seen[g.tobytes()]) == 1]


def stairs(g, rng):
    # a diagonal stroke drawn by dragging the mouse comes out as a staircase: for two squares that touch only at
    # a corner, one of the two squares between them is lit too
    g = g.copy()
    for y in range(6):
        for x in range(5):
            for dx in (-1, 1):
                x2 = x + dx
                if 0 <= x2 < 5 and g[y, x] and g[y + 1, x2] and not g[y, x2] and not g[y + 1, x] and rng.random() < 0.8:
                    if rng.random() < 0.5:
                        g[y, x2] = 1
                    else:
                        g[y + 1, x] = 1
    return g


def noisy(g, rng):
    g = stairs(g, rng) if rng.random() < 0.5 else g.copy()
    on = np.argwhere(g == 1)
    r = rng.random()
    if r < 0.25 and len(on) > 4:                       # a gap in a stroke
        y, x = on[rng.integers(len(on))]
        g[y, x] = 0
    elif r < 0.5:                                       # a pixel too many next to a stroke
        y, x = on[rng.integers(len(on))]
        y2, x2 = y + rng.integers(-1, 2), x + rng.integers(-1, 2)
        if 0 <= y2 < 7 and 0 <= x2 < 5:
            g[y2, x2] = 1
    if rng.random() < 0.3:                              # one stray pixel anywhere
        g[rng.integers(7), rng.integers(5)] ^= 1
    return g


def dataset(n_per, seed):
    rng = np.random.default_rng(seed)
    X, Y = [], []
    for d, g in templates():
        X.append(g.ravel()); Y.append(d)                # every clean template once
        for _ in range(n_per):
            X.append(noisy(g, rng).ravel()); Y.append(d)
    return np.array(X, dtype=np.float64), np.array(Y)


# ---------------------------------------------------------------- training (plain numpy, Adam)
def train(X, Y, hidden=HIDDEN, epochs=60, seed=1):
    rng = np.random.default_rng(seed)
    W1 = rng.normal(0, np.sqrt(2 / 35), (35, hidden)); b1 = np.zeros(hidden)
    W2 = rng.normal(0, np.sqrt(2 / hidden), (hidden, 10)); b2 = np.zeros(10)
    P = [W1, b1, W2, b2]
    M = [np.zeros_like(p) for p in P]; V = [np.zeros_like(p) for p in P]
    lr, t = 0.01, 0
    for ep in range(epochs):
        idx = rng.permutation(len(X))
        for k in range(0, len(X), 128):
            b = idx[k:k + 128]
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


def float_predict(P, X):
    W1, b1, W2, b2 = P
    return (np.maximum(X @ W1 + b1, 0) @ W2 + b2).argmax(1)


# ---------------------------------------------------------------- 8-bit weights and the board's arithmetic
def quantize(P, X):
    W1, b1, W2, b2 = P
    s1 = np.abs(W1).max() / 127
    W1q = np.round(W1 / s1).astype(int); b1q = np.round(b1 / s1).astype(int)
    acc = X.astype(int) @ W1q + b1q
    top = np.percentile(np.maximum(acc, 0), 99.9)
    sh1 = max(0, int(np.ceil(np.log2(max(top, 1) / 255))))
    s2 = np.abs(W2).max() / 127
    W2q = np.round(W2 / s2).astype(int)
    b2q = np.round(b2 / (s1 * 2 ** sh1 * s2)).astype(int)
    # the board's accumulators: 16 bits in layer 1, 24 bits in layer 2. Make sure no input can overflow them.
    assert np.abs(W1q).sum(0).max() + np.abs(b1q).max() <= 32767
    assert HIDDEN * 255 * 128 + np.abs(b2q).max() < 2 ** 23
    return dict(W1=W1q, b1=b1q, sh1=sh1, W2=W2q, b2=b2q)


def int_forward(Q, x):
    """Exactly what digit_nn.a51 does for one 35-pixel input; returns (digit, 10 scores, the hidden values)."""
    hid = []
    for j in range(HIDDEN):
        a = int(Q['b1'][j]) + sum(int(Q['W1'][i][j]) for i in range(35) if x[i])
        hid.append(0 if a < 0 else min(255, a >> Q['sh1']))
    scores = [int(Q['b2'][k]) + sum(hid[j] * int(Q['W2'][j][k]) for j in range(HIDDEN)) for k in range(10)]
    best = 0
    for k in range(1, 10):
        if scores[k] > scores[best]:
            best = k
    return best, scores, hid


def int_predict(Q, X):
    W1, b1, W2, b2, sh1 = Q['W1'], Q['b1'], Q['W2'], Q['b2'], Q['sh1']
    h = np.minimum(np.maximum(X.astype(int) @ W1 + b1, 0) >> sh1, 255)
    return (h @ W2 + b2).argmax(1)


# ---------------------------------------------------------------- tables for the 8051 program
def db_lines(values, per=16):
    vals = ['%03XH' % (v & 0xFF) for v in values]
    return ['        DB      ' + ','.join(vals[i:i + per]) for i in range(0, len(vals), per)]


def asm_tables(Q):
    L = ['NH      EQU     %d              ; hidden neurons' % HIDDEN,
         'SH1     EQU     %d               ; hidden values are (sum >> SH1), 0 to 255' % Q['sh1'], '']
    L.append('; B1: one 16-bit bias for each hidden neuron, low byte first')
    b1 = []
    for v in Q['b1']:
        b1 += [v & 0xFF, (v >> 8) & 0xFF]
    L += ['B1:'] + db_lines(b1)
    L.append('; W1: one row of NH weights (8-bit, signed) for each of the 35 pixels')
    L.append('W1:')
    for i in range(35):
        L += db_lines(Q['W1'][i])
    L.append('; W2: one row for each digit 0-9: 24-bit bias (low byte first), then NH weights')
    L.append('W2:')
    for k in range(10):
        v = int(Q['b2'][k])
        L += db_lines([v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF] + [int(Q['W2'][j][k]) for j in range(HIDDEN)], per=HIDDEN + 3)
    return L


def write_asm(Q):
    src = open(ASM, encoding='utf-8').read()
    a = src.index('; ---- WEIGHTS START')
    a = src.index('\n', a) + 1
    b = src.index('; ---- WEIGHTS END')
    src = src[:a] + '\n'.join(asm_tables(Q)) + '\n' + src[b:]
    open(ASM, 'w', encoding='utf-8', newline='\n').write(src)


def write_c(Q):
    # the same tables for the C version, ref/nn/c/weights.h (C51 keeps them in code memory)
    rows = lambda vals: ', '.join(str(int(v)) for v in vals)
    L = ['/* Made by nn/train_digits.py from the same weights as ref/nn/digit_nn.a51. Do not edit by hand. */',
         '#define NH  %d' % HIDDEN, '#define SH1 %d' % Q['sh1'], '',
         'int code B1[NH] = { %s };' % rows(Q['b1']),
         'signed char code W1[35][NH] = {']
    L += ['    { %s },' % rows(Q['W1'][i]) for i in range(35)]
    L += ['};', 'long code B2[10] = { %s };' % rows(Q['b2']), 'signed char code W2[10][NH] = {']
    L += ['    { %s },' % rows([Q['W2'][j][k] for j in range(HIDDEN)]) for k in range(10)]
    L += ['};', '']
    os.makedirs(os.path.join(ROOT, 'ref', 'nn', 'c'), exist_ok=True)
    open(os.path.join(ROOT, 'ref', 'nn', 'c', 'weights.h'), 'w', encoding='utf-8', newline='\n').write('\n'.join(L))


def load_model():
    m = json.load(open(os.path.join(ROOT, 'nn', 'model.json')))
    return {'W1': np.array(m['W1']), 'b1': np.array(m['b1']), 'W2': np.array(m['W2']), 'b2': np.array(m['b2']), 'sh1': m['sh1']}


# ---------------------------------------------------------------- my own drawings, never used in training
HANDMADE = [
    (0, '.###.|#...#|#...#|#...#|#...#|#...#|.###.'), (0, '.##..|#..#.|#..#.|#..#.|#..#.|#..#.|.##..'),
    (1, '.#...|##...|.#...|.#...|.#...|.#...|###..'), (1, '...#.|...#.|...#.|...#.|...#.|...#.|...#.'),
    (2, '####.|....#|....#|.###.|#....|#....|#####'), (2, '.##..|#..#.|...#.|..#..|.#...|#....|####.'),
    (3, '####.|....#|....#|####.|....#|....#|####.'), (3, '.##..|#..#.|...#.|.##..|...#.|#..#.|.##..'),
    (4, '#....|#..#.|#..#.|#####|...#.|...#.|...#.'), (4, '..#..|.##..|#.#..|####.|..#..|..#..|.....'),
    (5, '####.|#....|#....|###..|...#.|...#.|###..'), (5, '#####|#....|####.|....#|....#|....#|####.'),
    (6, '.##..|#....|#....|###..|#..#.|#..#.|.##..'), (6, '#....|#....|#....|####.|#...#|#...#|####.'),
    (7, '####.|...#.|...#.|..#..|..#..|..#..|..#..'), (7, '#####|....#|...#.|...#.|..#..|..#..|..#..'),
    (8, '.##..|#..#.|#..#.|.##..|#..#.|#..#.|.##..'), (8, '#####|#...#|.#.#.|..#..|.#.#.|#...#|#####'),
    (9, '.##..|#..#.|#..#.|.###.|...#.|...#.|.##..'), (9, '####.|#..#.|#..#.|####.|...#.|...#.|...#.'),
]


# a second set, drawn after the first training run showed that 4-wide digits were misread; also never trained on
HANDMADE2 = [
    (0, '.....|.##..|#..#.|#..#.|#..#.|.##..|.....'), (0, '####.|#..#.|#..#.|#..#.|#..#.|#..#.|####.'),
    (1, '..#..|.##..|..#..|..#..|..#..|.....|.....'), (1, '.#...|.#...|.#...|.#...|.#...|.#...|.#...'),
    (2, '###..|..#..|###..|#....|###..|.....|.....'), (2, '.###.|#...#|...#.|..#..|.#...|#####|.....'),
    (3, '.###.|....#|..##.|....#|.###.|.....|.....'), (3, '###..|..#..|.##..|..#..|###..|.....|.....'),
    (4, '.....|#.#..|#.#..|###..|..#..|..#..|.....'), (4, '...#.|..##.|.#.#.|#####|...#.|...#.|.....'),
    (5, '.###.|.#...|.###.|...#.|.###.|.....|.....'), (5, '####.|#....|###..|...#.|...#.|###..|.....'),
    (6, '.###.|.#...|.###.|.#.#.|.###.|.....|.....'), (6, '..#..|.#...|#....|####.|#...#|.###.|.....'),
    (7, '####.|...#.|..#..|.#...|.#...|.....|.....'), (7, '.....|.###.|...#.|...#.|...#.|...#.|.....'),
    (8, '.###.|.#.#.|.###.|.#.#.|.###.|.....|.....'), (8, '.##..|#..#.|.##..|#..#.|.##..|.....|.....'),
    (9, '.###.|.#.#.|.###.|...#.|.###.|.....|.....'), (9, '.##..|#..#.|.###.|...#.|..#..|.#...|.....'),
]

# a third set: digits drawn the way a mouse drag draws them, diagonals as staircases (the first one is a 7 drawn on
# the Digit pad that the second training run read as 3); written before the staircase noise was added
STAIRS = [
    (7, '#####|....#|...##|...#.|..#..|.##..|.#...'), (0, '.###.|##.##|#...#|#...#|#...#|##.##|.###.'),
    (1, '..#..|.##..|..#..|..#..|..#..|..#..|..#..'), (2, '.##..|#..##|...#.|..##.|.##..|##...|#####'),
    (3, '####.|...##|..##.|...#.|....#|...##|####.'), (4, '...#.|..##.|.##..|##.#.|#####|...#.|...#.'),
    (5, '#####|#....|####.|...##|....#|...##|####.'), (6, '...##|..##.|.##..|####.|#...#|##..#|.###.'),
    (8, '.###.|##.##|.###.|##.##|#...#|##.##|.###.'), (9, '.###.|#...#|##..#|.####|...##|..##.|.##..'),
]


def main():
    Xtr, Ytr = dataset(40, seed=11)
    Xte, Yte = dataset(10, seed=99)
    Xh = np.array([grid(s).ravel() for _, s in HANDMADE], dtype=np.float64)
    Yh = np.array([d for d, _ in HANDMADE])
    Xh2 = np.array([grid(s).ravel() for _, s in HANDMADE2], dtype=np.float64)
    Yh2 = np.array([d for d, _ in HANDMADE2])
    Xh3 = np.array([grid(s).ravel() for _, s in STAIRS], dtype=np.float64)
    Yh3 = np.array([d for d, _ in STAIRS])
    P = train(Xtr, Ytr)
    Q = quantize(P, Xtr)
    acc = lambda pred, y: float((pred == y).mean())
    report = {
        'train_examples': len(Xtr), 'test_examples': len(Xte), 'handmade_examples': len(Xh),
        'float': {'train': acc(float_predict(P, Xtr), Ytr), 'test': acc(float_predict(P, Xte), Yte),
                  'handmade': acc(float_predict(P, Xh), Yh), 'handmade2': acc(float_predict(P, Xh2), Yh2),
                  'stairs': acc(float_predict(P, Xh3), Yh3)},
        'int8': {'train': acc(int_predict(Q, Xtr), Ytr), 'test': acc(int_predict(Q, Xte), Yte),
                 'handmade': acc(int_predict(Q, Xh), Yh), 'handmade2': acc(int_predict(Q, Xh2), Yh2),
                 'stairs': acc(int_predict(Q, Xh3), Yh3)},
        'sh1': Q['sh1'],
        'handmade_misread': [[int(d), s, int(p)] for (d, s), p in zip(HANDMADE + HANDMADE2 + STAIRS, int_predict(Q, np.vstack([Xh, Xh2, Xh3]))) if p != d],
    }
    # int_forward (the 8051's arithmetic, one input at a time) must agree with the vectorised version
    for x in np.vstack([Xh, Xh2, Xh3, Xte[::37]]):
        assert int_forward(Q, x.astype(int))[0] == int_predict(Q, x[None, :])[0]
    # test vectors for the simulated board: the handmade set, every clean template, some noisy ones
    vecs = []
    rows = [x for x in Xh] + [x for x in Xh2] + [x for x in Xh3] + [g.ravel() for _, g in templates()][::7] + list(Xte[::131])
    for x in rows:
        x = [int(v) for v in x]
        d, scores, hid = int_forward(Q, x)
        vecs.append({'pixels': ''.join(map(str, x)), 'digit': d, 'scores': scores, 'hidden': hid})
    json.dump(vecs, open(os.path.join(ROOT, 'nn', 'test_vectors.json'), 'w'), indent=0)
    json.dump({'report': report, 'sh1': Q['sh1'], 'W1': Q['W1'].tolist(), 'b1': Q['b1'].tolist(),
               'W2': Q['W2'].tolist(), 'b2': Q['b2'].tolist()},
              open(os.path.join(ROOT, 'nn', 'model.json'), 'w'), indent=1)
    write_asm(Q)
    write_c(Q)
    print(json.dumps(report, indent=1))
    print('test vectors:', len(vecs))


if __name__ == '__main__':
    if '--c-only' in sys.argv:          # write ref/nn/c/weights.h from nn/model.json without training again
        write_c(load_model())
    else:
        main()
