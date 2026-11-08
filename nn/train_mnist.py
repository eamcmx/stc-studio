"""MNIST on the STC89C52RC: a 196-32-10 network on 14 x 14 binary images, written to 8051 assembly by nn/gen51.py.

    python nn/train_mnist.py     trains (seeds 1 to 5), rounds to 8 bits, writes ref/nn/mnist/digit_mnist.a51,
                                 nn/mnist_vectors.json (all 10 000 test digits) and ref/nn/results/mnist.json
    node test/nn_mnist.js        runs the program on the simulated board against the vectors

Data: the MNIST files in nn/data/mnist/ (from https://ossci-datasets.s3.amazonaws.com/mnist/, the mirror torchvision
uses; MD5 checked below). Each 28 x 28 image is reduced to 14 x 14 by the mean of every 2 x 2 block, and a square
is lit when that mean is 96 or more (out of 255). The threshold and the 32 hidden neurons were chosen on the last
10 000 training images (validation, 20 epochs): thresholds 64, 96, 128 and 24 or 32 neurons gave 94.9 to 96.0 %,
96 and 32 the best. 196 x 32 weights fill 6272 of the chip's 8192 bytes of flash; the inputs are kept as bits.
The page sends D and 196 characters, 1 or 0, row by row from the top left.
"""
import gzip
import hashlib
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import gen51  # noqa: E402
import train_uci as TU  # noqa: E402  (the same NumPy training and 8-bit rounding as for the UCI digits)

D = ROOT / 'nn' / 'data' / 'mnist'
MD5 = {'train-images-idx3-ubyte.gz': 'f68b3c2dcbeaaa9fbdd348bbdeb94873', 'train-labels-idx1-ubyte.gz': 'd53e105ee54ea40749a09fcbcd1e9432',
       't10k-images-idx3-ubyte.gz': '9fb629c4189551a2d022fa330f9573f3', 't10k-labels-idx1-ubyte.gz': 'ec29112dd5afa0611ce80d1b7f02629c'}
H, THR, EPOCHS, SEEDS = 32, 96, 20, [1, 2, 3, 4, 5]


def load():
    for f, m in MD5.items():
        assert hashlib.md5((D / f).read_bytes()).hexdigest() == m, f + ': not the MNIST file'
    img = lambda f: np.frombuffer(gzip.open(D / f).read(), np.uint8, offset=16).reshape(-1, 28, 28)
    lab = lambda f: np.frombuffer(gzip.open(D / f).read(), np.uint8, offset=8).astype(int)
    return img('train-images-idx3-ubyte.gz'), lab('train-labels-idx1-ubyte.gz'), img('t10k-images-idx3-ubyte.gz'), lab('t10k-labels-idx1-ubyte.gz')


def binary14(X):
    return (X.reshape(-1, 14, 2, 14, 2).mean((2, 4)) >= THR).reshape(-1, 196).astype(int)


def knn1(Xtr, Ytr, Xte, chunk=500):
    """1-nearest neighbour (Euclidean), in chunks of test digits."""
    Xtr = Xtr.astype(np.float32); n2 = (Xtr ** 2).sum(1)
    out = []
    for i in range(0, len(Xte), chunk):
        q = Xte[i:i + chunk].astype(np.float32)
        out.append(Ytr[np.argmin(n2[None, :] - 2 * q @ Xtr.T, axis=1)])
    return np.concatenate(out)


def main():
    Xtr, Ytr, Xte, Yte = load()
    Btr, Bte = binary14(Xtr), binary14(Xte)
    TU.HIDDEN, TU.NIN = H, 196
    rep = {'train': len(Ytr), 'test': len(Yte), 'H': H, 'threshold': THR, 'epochs': EPOCHS,
           'lit_per_image_test': round(float(Bte.sum(1).mean()), 1), 'seeds': []}
    Q1 = None
    for seed in SEEDS:
        P = TU.train(Btr.astype(float), Ytr, hidden=H, epochs=EPOCHS, seed=seed)
        f_acc = float(((np.maximum(Bte @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean())
        Q = TU.quantize(P, Btr, 1)
        i_acc = float((TU.int_predict(Q, Bte) == Yte).mean())
        rep['seeds'].append({'seed': seed, 'float_pct': round(100 * f_acc, 2), 'int8_pct': round(100 * i_acc, 2), 'sh1': Q['sh1']})
        print('seed', seed, 'float %.2f %%' % (100 * f_acc), 'int8 %.2f %%' % (100 * i_acc))
        if seed == 1:
            Q1 = Q
    a = np.array([s['int8_pct'] for s in rep['seeds']])
    rep['int8_mean'], rep['int8_sd'] = round(float(a.mean()), 2), round(float(a.std(ddof=1)), 2)
    # the program and the vectors, from the seed-1 network
    out = ROOT / 'ref' / 'nn' / 'mnist'
    out.mkdir(parents=True, exist_ok=True)
    head = ('; MNIST digit reader: 14 x 14 binary images (2 x 2 mean >= 96), a 196-32-10 network on the STC89C52RC.\n'
            '; Written by nn/train_mnist.py with nn/gen51.py from ref/nn/digit_nn.a51; the inputs are kept as bits.\n'
            '; The page sends D and 196 characters, 1 or 0, row by row from the top left; the board answers "=", the\n'
            '; digit and its 10 scores in hex, and shows the digit. Serial: 19200 baud. Do not edit by hand.\n')
    (out / 'digit_mnist.a51').write_text(gen51.generate(Q1, 196, 'packed', header=head), encoding='utf-8', newline='\n')
    vecs, right = [], 0
    pred = TU.int_predict(Q1, Bte)
    for u, y, p in zip(Bte, Yte, pred):
        d, scores = gen51.int_forward(Q1, u)
        assert d == p
        right += d == y
        vecs.append({'pixels': ''.join(map(str, u)), 'label': int(y), 'digit': d, 'scores': scores})
    (ROOT / 'nn' / 'mnist_vectors.json').write_text(json.dumps(vecs), encoding='utf-8')
    rep['shipped_int8_pct'] = round(100 * right / len(Yte), 2)
    json.dump({k: (v.tolist() if hasattr(v, 'tolist') else v) for k, v in Q1.items() if k in ('W1', 'b1', 'W2', 'b2', 'sh1')},
              open(ROOT / 'nn' / 'mnist_model.json', 'w'))
    # reference models on the same split
    rep['baselines'] = {'1-NN, 14 x 14 binary': round(100 * float((knn1(Btr, Ytr, Bte) == Yte).mean()), 2),
                        '1-NN, 28 x 28, 256 grey levels': round(100 * float((knn1(Xtr.reshape(-1, 784) / 255, Ytr, Xte.reshape(-1, 784) / 255) == Yte).mean()), 2)}
    G = Xtr.reshape(-1, 784) / 255, Xte.reshape(-1, 784) / 255
    P = TU.train(G[0], Ytr, hidden=128, epochs=EPOCHS, seed=1)
    rep['baselines']['float MLP 784-128-10, 28 x 28 grey'] = round(100 * float(((np.maximum(G[1] @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean()), 2)
    print(json.dumps(rep, indent=1))
    (ROOT / 'ref' / 'nn' / 'results').mkdir(parents=True, exist_ok=True)
    (ROOT / 'ref' / 'nn' / 'results' / 'mnist.json').write_text(json.dumps(rep, indent=1), encoding='utf-8')


if __name__ == '__main__':
    main()
