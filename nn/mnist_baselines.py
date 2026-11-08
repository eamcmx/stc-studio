"""Floating-point reference networks for MNIST trained longer than in nn/train_mnist.py (20 epochs there), to check
that the paper's reference models are not under-trained. Seed 1, the same NumPy Adam training.

    python nn/mnist_baselines.py [model ...]     models: g128 (784-128-10, 28 x 28 grey), g256 (784-256-10),
                                                 b32 (196-32-10, the chip's network on 14 x 14 binary squares)
Each run is added to ref/nn/results/mnist_baselines.json (a run of the same model and epochs is replaced).

The run of 8 Nov 2026 gave 784-128-10: 97.62 % (20 epochs), 97.71 % (60); 784-256-10: 97.68 % (20). It was stopped
before 784-256-10 at 60 epochs (over an hour more), since 60 epochs and twice the width each changed the result by
about 0.1 point; those three results were carried into the JSON from its log.
"""
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import train_mnist as TM  # noqa: E402
import train_uci as TU  # noqa: E402

MODELS = {'g128': ('784-128-10, 28 x 28 grey', 'grey', 128, (20, 60)),
          'g256': ('784-256-10, 28 x 28 grey', 'grey', 256, (20, 60)),
          'b32': ('196-32-10, 14 x 14 binary', 'bin', 32, (20, 60))}
OUT = ROOT / 'ref' / 'nn' / 'results' / 'mnist_baselines.json'

if __name__ == '__main__':
    want = sys.argv[1:] or list(MODELS)
    Xtr, Ytr, Xte, Yte = TM.load()
    data = {'grey': (Xtr.reshape(-1, 784) / 255, Xte.reshape(-1, 784) / 255),
            'bin': (TM.binary14(Xtr).astype(float), TM.binary14(Xte).astype(float))}
    res = json.loads(OUT.read_text(encoding='utf-8')) if OUT.exists() else {'by': 'nn/mnist_baselines.py', 'seed': 1, 'runs': []}
    for key in want:
        name, kind, H, epochs = MODELS[key]
        Tr, Te = data[kind]
        for ep in epochs:
            P = TU.train(Tr, Ytr, hidden=H, epochs=ep, seed=1)
            acc = round(100 * float(((np.maximum(Te @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean()), 2)
            res['runs'] = [r for r in res['runs'] if not (r['model'] == name and r['epochs'] == ep)]
            res['runs'].append({'model': name, 'epochs': ep, 'test_pct': acc})
            print(name, ep, 'epochs:', acc, '%', flush=True)
            OUT.write_text(json.dumps(res, indent=1), encoding='utf-8')
