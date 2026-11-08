"""How the MNIST threshold and hidden layer were chosen: the first 50 000 training images train, the last 10 000 are
the validation set (the test set is not used). Thresholds 64, 96 and 128 on the 2 x 2 means, 24 or 32 hidden neurons,
20 epochs, seed 1, floating point.

    python nn/mnist_validation.py      writes ref/nn/results/mnist_validation.json
"""
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import train_mnist as TM  # noqa: E402
import train_uci as TU  # noqa: E402


def binary(X, thr):
    return (X.reshape(-1, 14, 2, 14, 2).mean((2, 4)) >= thr).reshape(-1, 196).astype(float)


if __name__ == '__main__':
    Xtr, Ytr, _, _ = TM.load()
    rows = []
    for thr in (64, 96, 128):
        B = binary(Xtr, thr)
        for H in (24, 32):
            P = TU.train(B[:50000], Ytr[:50000], hidden=H, epochs=TM.EPOCHS, seed=1)
            pred = (np.maximum(B[50000:] @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1)
            acc = round(100 * float((pred == Ytr[50000:]).mean()), 2)
            rows.append({'threshold': thr, 'H': H, 'validation_pct': acc})
            print(rows[-1], flush=True)
    res = {'by': 'nn/mnist_validation.py', 'train': 50000, 'validation': 10000, 'epochs': TM.EPOCHS, 'seed': 1, 'rows': rows}
    (ROOT / 'ref' / 'nn' / 'results' / 'mnist_validation.json').write_text(json.dumps(res, indent=1), encoding='utf-8')
