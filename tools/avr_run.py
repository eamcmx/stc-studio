"""The digit readers in C on an 8-bit AVR (ATmega328P, 16 MHz), simulated cycle by cycle with simavr, against the same
Python reference as the 8051 programs. Runs in WSL (Ubuntu with gcc-avr, avr-libc, simavr, libsimavr-dev).

    python tools/avr_run.py         writes ref/nn/results/avr.json

For the 5 x 7 network (346 test drawings) and MNIST (10 000 test digits), each compiled with avr-gcc -O2 and -Os (the
Arduino default): every answer (digit and ten scores) must equal the reference; the cycles of one reading are those
between the two edges of PB0 (layer 1 to the answer), so the 8051's display interrupt and serial port are not in them.
"""
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
W = '/mnt/' + ROOT.as_posix()[0].lower() + ROOT.as_posix()[2:]       # the same folder seen from WSL
B = ROOT / 'ref' / 'nn' / 'avr' / 'build'
B.mkdir(parents=True, exist_ok=True)


def wsl(cmd):
    r = subprocess.run(['wsl.exe', '-d', 'Ubuntu-24.04', '--', 'bash', '-lc', cmd], capture_output=True, text=True)
    if r.returncode:
        raise SystemExit('WSL: ' + cmd + '\n' + r.stdout + r.stderr)
    return r.stdout


wsl('cd %s/tools && gcc -O2 -o %s/ref/nn/avr/build/avr_bench avr_bench.c $(pkg-config --cflags --libs simavr) -lelf' % (W, W))
version = wsl('avr-gcc --version | head -1').strip() + '; ' + wsl('dpkg -s simavr | grep ^Version').strip()
results = {'by': 'tools/avr_run.py', 'mcu': 'ATmega328P', 'clock_hz': 16000000, 'tools': version, 'runs': []}
for net, vec_file, flag, packed in (('5x7', 'nn/test_vectors.json', '', 0), ('MNIST', 'nn/mnist_vectors.json', '-DMNIST', 1)):
    vecs = json.loads((ROOT / vec_file).read_text(encoding='utf-8'))
    (B / ('inputs_%s.txt' % net)).write_text('\n'.join(v['pixels'] for v in vecs) + '\n', encoding='utf-8', newline='\n')
    for opt in ('-O2', '-Os'):
        elf = 'digit_%s%s.elf' % (net, opt.replace('-', '_'))
        wsl('cd %s/ref/nn/avr && avr-gcc -mmcu=atmega328p %s %s -o build/%s digit_avr.c' % (W, opt, flag, elf))
        syms = {}
        for line in wsl('avr-nm %s/ref/nn/avr/build/%s' % (W, elf)).split('\n'):
            p = line.split()
            if len(p) == 3:
                syms[p[2]] = int(p[0], 16) & 0xFFFF
        size = wsl('avr-size -A %s/ref/nn/avr/build/%s' % (W, elf))
        sec = {l.split()[0]: int(l.split()[1]) for l in size.split('\n') if l.startswith('.')}
        out = wsl('%s/ref/nn/avr/build/avr_bench %s/ref/nn/avr/build/%s %s/ref/nn/avr/build/inputs_%s.txt %d %d %d %d %d'
                  % (W, W, elf, W, net, syms['pix'], syms['go'], syms['digit'], syms['out'], packed))
        # simavr prints "Loaded ... .text" lines of its own; the bench's lines are 12 integers
        lines = [l.split() for l in out.strip().split('\n') if len(l.split()) == 12 and l.split()[0].isdigit()]
        assert len(lines) == len(vecs), (len(lines), len(vecs))
        equal = right = 0
        cyc = []
        for l, v in zip(lines, vecs):
            d, sc, c = int(l[0]), [int(x) for x in l[1:11]], int(l[11])
            equal += d == v['digit'] and sc == v['scores']
            right += 'label' in v and d == v['label']
            cyc.append(c)
        avg = sum(cyc) / len(cyc)
        row = {'network': net, 'opt': opt, 'inputs': len(vecs), 'equal_to_reference': equal,
               'read_correctly': right if 'label' in vecs[0] else None, 'flash_bytes': sec.get('.text', 0) + sec.get('.data', 0),
               'avg_cycles': round(avg), 'avg_ms': round(avg / 16000, 3), 'min_ms': round(min(cyc) / 16000, 3),
               'max_ms': round(max(cyc) / 16000, 3)}
        results['runs'].append(row)
        print(row, flush=True)
(ROOT / 'ref' / 'nn' / 'results' / 'avr.json').write_text(json.dumps(results, indent=1), encoding='utf-8')
