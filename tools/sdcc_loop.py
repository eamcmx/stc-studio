"""The layer-1 inner loops that SDCC generates, from its .rst listings, with machine cycles per instruction (the
listing gives clock periods; a machine cycle of the 12T core is 12 of them), and the cycles of one pass of the loop.

    python tools/sdcc_loop.py      writes ref/nn/results/listings/sdcc_layer1_{written,tuned}.txt and prints the costs

The loop is the code from the label that the loop jumps back to, to that jump.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / 'ref' / 'nn' / 'results' / 'listings'
INS = re.compile(r'^\s+[0-9A-F]{6}\s+(?:[0-9A-F]{2} ?)+\s+\[(\d+)\]\s+\d+\s+(.*)$')
LAB = re.compile(r'^\s+[0-9A-F]{6}\s+\d+\s+(\S+\$):')


def loop(rst, src_line):
    lines = rst.read_text(encoding='latin1').split('\n')
    a = next(i for i, l in enumerate(lines) if re.search(r';\s*digit_nn\.c:%d:' % src_line, l))
    code = []                                            # (label or None, instruction, cycles)
    for l in lines[a + 1:]:
        if re.search(r';\s*digit_nn\.c:\d+:', l) and code:
            break
        m, k = INS.match(l), LAB.match(l)
        if k:
            code.append((k.group(1), None, 0))
        elif m:
            code.append((None, re.sub(r'\s+', ' ', m.group(2).replace('\t', ' ')).strip(), int(m.group(1)) // 12))
    # the backward jump: an instruction whose target is a label defined earlier in the block
    labels = [c[0] for c in code if c[0]]
    for i in range(len(code) - 1, -1, -1):
        ins = code[i][1]
        if ins and any(ins.endswith(' ' + lb) or ins.endswith(',' + lb) for lb in labels):
            target = next(lb for lb in labels if ins.endswith(' ' + lb) or ins.endswith(',' + lb))
            start = next(j for j, c in enumerate(code) if c[0] == target)
            body = code[start:i + 1]
            return body, sum(c[2] for c in body)
    raise ValueError('no loop found')


def text(body):
    out = []
    for lab, ins, cyc in body:
        if lab:
            out.append(lab + ':')
        else:
            op, _, args = ins.partition(' ')
            out.append(('       ' + op.upper().ljust(5) + args).ljust(34) + str(cyc).rjust(2))
    return '\n'.join(out) + '\n'


if __name__ == '__main__':
    OUT.mkdir(parents=True, exist_ok=True)
    for name, d, line in (('written', 'sdcc', 80), ('tuned', 'sdcc_tuned', 75)):
        body, cyc = loop(ROOT / 'ref' / 'nn' / 'c' / d / 'digit_nn.rst', line)
        (OUT / ('sdcc_layer1_%s.txt' % name)).write_text(text(body), encoding='utf-8')
        print('SDCC %-8s layer-1 inner loop: %d instructions, %d machine cycles a pass' % (name, sum(1 for b in body if b[1]), cyc))
