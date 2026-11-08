"""Weight headers for the C versions, from the trained 8-bit models (nn/model.json for the 5 x 7 network, the one in
the chip's assembly; nn/mnist_model.json for MNIST):

    python nn/write_c_headers.py
      ref/nn/c/mnist/weights.h      the MNIST network for the 8051 C version (Keil/SDCC keyword 'code', see compat51.h)
      ref/nn/avr/weights_5x7.h      the 5 x 7 network for the AVR version (avr-libc PROGMEM)
      ref/nn/avr/weights_mnist.h    the MNIST network for the AVR version

The tables are the same numbers as in the assembly programs: W1 one row of NH weights per input, B1 16-bit, W2 one row
of NH weights per digit, B2 a 24-bit value kept in 32 bits.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def load(f):
    m = json.load(open(ROOT / 'nn' / f))
    return m['W1'], m['b1'], m['W2'], m['b2'], m['sh1']


def rows(vals):
    return ', '.join(str(int(v)) for v in vals)


def header(model, nin, avr, title):
    W1, b1, W2, b2, sh1 = model
    nh = len(b1)
    assert len(W1) == nin and len(W2) == nh
    if avr:
        q = lambda t: 'const %s' % t
        sfx = ' PROGMEM'
        L = ['#include <avr/pgmspace.h>', '#include <stdint.h>']
        t16, t8, t32 = 'int16_t', 'int8_t', 'int32_t'
    else:
        q = lambda t: t
        sfx = ''
        L = []
        t16, t8, t32 = 'int code', 'signed char code', 'long code'
    L = ['/* %s. Made by nn/write_c_headers.py from the trained 8-bit model. Do not edit by hand. */' % title] + L
    L += ['#define NIN %d' % nin, '#define NH  %d' % nh, '#define SH1 %d' % sh1, '']
    L.append('%s B1[NH]%s = { %s };' % (q(t16), sfx, rows(b1)))
    L.append('%s W1[NIN][NH]%s = {' % (q(t8), sfx))
    L += ['    { %s },' % rows(W1[i]) for i in range(nin)]
    L += ['};', '%s B2[10]%s = { %s };' % (q(t32), sfx, rows(b2)), '%s W2[10][NH]%s = {' % (q(t8), sfx)]
    L += ['    { %s },' % rows([W2[j][k] for j in range(nh)]) for k in range(10)]
    L += ['};', '']
    return '\n'.join(L)


if __name__ == '__main__':
    five, mnist = load('model.json'), load('mnist_model.json')
    out = [(ROOT / 'ref/nn/c/mnist/weights.h', header(mnist, 196, False, 'MNIST 196-32-10 for the 8051 C version')),
           (ROOT / 'ref/nn/avr/weights_5x7.h', header(five, 35, True, 'The 5 x 7 network 35-24-10 for the AVR')),
           (ROOT / 'ref/nn/avr/weights_mnist.h', header(mnist, 196, True, 'MNIST 196-32-10 for the AVR'))]
    for path, text in out:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text, encoding='utf-8', newline='\n')
        print(path.relative_to(ROOT), len(text), 'characters')
