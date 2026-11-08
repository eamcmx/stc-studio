"""Floating-point reference networks for MNIST trained longer than in nn/train_mnist.py (20 epochs there), so that the
paper's reference models are not under-trained: 784-128-10 and 784-256-10 on the full 28 x 28 grey images, and the
chip's 196-32-10 on the 14 x 14 binary squares, for 20 and 60 epochs, seed 1 (the same NumPy Adam training).

    python nn/mnist_baselines.py     writes ref/nn/results/mnist_baselines.json
"""
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import train_mnist as TM  # noqa: E402
import train_uci as TU  # noqa: E402

Xtr, Ytr, Xte, Yte = TM.load()
G = Xtr.reshape(-1, 784) / 255, Xte.reshape(-1, 784) / 255
B = TM.binary14(Xtr).astype(float), TM.binary14(Xte).astype(float)
acc = lambda P, X, Y: round(100 * float(((np.maximum(X @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Y).mean()), 2)
out = {'by': 'nn/mnist_baselines.py', 'seed': 1, 'runs': []}
for name, (Tr, Te), H in (('784-128-10, 28 x 28 grey', G, 128), ('784-256-10, 28 x 28 grey', G, 256), ('196-32-10, 14 x 14 binary', B, 32)):
    for epochs in (20, 60):
        P = TU.train(Tr, Ytr, hidden=H, epochs=epochs, seed=1)
        r = {'model': name, 'epochs': epochs, 'test_pct': acc(P, Te, Yte)}
        out['runs'].append(r)
        print(r, flush=True)
(ROOT / 'ref' / 'nn' / 'results' / 'mnist_baselines.json').write_text(json.dumps(out, indent=1), encoding='utf-8')
