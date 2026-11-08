"""The assembly partner of the tuned MNIST C build: the MNIST reader with 32-bit layer-2 sums (shortcuts b, r, m on,
s off), the arithmetic of ref/nn/c/mnist/digit_mnist.c compiled with TUNED. From the seed-1 model of nn/train_mnist.py.

    python nn/mnist_partner.py      writes ref/nn/mnist/brm/digit_mnist_brm.a51 (timed by test/nn_mnist.js)

The C build as written has no partner: it reads the packed inputs without the row pointer, and the generator writes
packed inputs only for the binary-input loop with the row pointer.
"""
import json
from pathlib import Path

import gen51

ROOT = Path(__file__).resolve().parent.parent
HEAD = ('; MNIST reader with 32-bit layer-2 sums (shortcuts b, r, m on, s off): the arithmetic of the tuned C build.\n'
        '; Written by nn/gen51.py for the matched comparison; otherwise as ref/nn/mnist/digit_mnist.a51.\n')

if __name__ == '__main__':
    Q = json.load(open(ROOT / 'nn' / 'mnist_model.json'))
    out = ROOT / 'ref' / 'nn' / 'mnist' / 'brm' / 'digit_mnist_brm.a51'
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(gen51.generate(Q, 196, 'packed', shortcuts=(True, True, True, False), header=HEAD),
                   encoding='utf-8', newline='\n')
    print(out.relative_to(ROOT))
