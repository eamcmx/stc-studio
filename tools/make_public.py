"""Builds the public release of this repository in a separate folder, with a history of its own.

    python tools/make_public.py <dest>      (dest must not exist; usually ../stc-studio-public)

What is left out, and why: the programs of the running course (the Lab 6 programs and their solutions in ref/corpus and
ref/keil, the 25 practicals) and a flash log that contains one of them as bytes. The board demos, the neural network
programs and every test that does not need the course programs stay. The Examples menu and dist/stc-studio.html are
rebuilt from what is left. LICENSE (MIT), CITATION.cff and the public README come from tools/public/.
After this script: run the tests in <dest> (see its README), then git init and the first commit there.
"""
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
KEEP_COURSE = {'demo', 'demo2'}          # the board demos are not course exercises


def left_out(f):
    p = Path(f)
    parts = p.parts
    if f.startswith('ref/practicals/'):
        return True
    if f.startswith('ref/corpus/'):
        return p.stem not in KEEP_COURSE
    if f.startswith('ref/keil/'):
        return parts[2] not in KEEP_COURSE
    if f == 'ref/m1/node_ex2.log':        # the packets that flashed Ex 2: the program's bytes
        return True
    if f == 'nn/mnist_vectors.json':      # the 10 000 MNIST test images, binarized: MNIST is not redistributed here;
        return True                       # nn/train_mnist.py writes the file again from the downloaded data
    if f.startswith('tools/public/') or f == 'README.md':
        return True                       # the public README replaces this one
    return False


def main():
    dest = Path(sys.argv[1]).resolve()
    if dest.exists():
        sys.exit(str(dest) + ' exists: remove it or choose another folder')
    files = subprocess.run(['git', 'ls-files'], cwd=ROOT, capture_output=True, text=True, check=True).stdout.split('\n')
    files = [f for f in files if f]
    kept = [f for f in files if not left_out(f)]
    for f in kept:
        (dest / f).parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / f, dest / f)
    for f in (ROOT / 'tools' / 'public').iterdir():
        shutil.copy2(f, dest / f.name)
    print('%d of %d tracked files copied; %d left out' % (len(kept), len(files), len(files) - len(kept)))
    for cmd in (['node', 'tools/make_examples.js'], ['node', 'tools/build.js']):
        r = subprocess.run(cmd, cwd=dest, capture_output=True, text=True)
        print(' '.join(cmd), '->', (r.stdout or r.stderr).strip().split('\n')[0])
        if r.returncode:
            sys.exit(r.stderr)


if __name__ == '__main__':
    main()
