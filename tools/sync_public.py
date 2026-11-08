"""Brings the public release up to date: builds a fresh public copy with tools/make_public.py in a scratch folder and
makes the public repository's working tree match it (new and changed files copied, files that are gone removed;
its .git is left alone). Then review `git status` there, commit and push.

    python tools/sync_public.py <public repo folder> <scratch folder>
"""
import filecmp
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
pub, tmp = Path(sys.argv[1]).resolve(), Path(sys.argv[2]).resolve()
if not (pub / '.git').is_dir():
    sys.exit(str(pub) + ' is not a git repository')
if tmp.exists():
    shutil.rmtree(tmp)
subprocess.run([sys.executable, str(ROOT / 'tools' / 'make_public.py'), str(tmp)], check=True)
new = {p.relative_to(tmp).as_posix() for p in tmp.rglob('*') if p.is_file()}
old = {p.relative_to(pub).as_posix() for p in pub.rglob('*') if p.is_file() and '.git' not in p.relative_to(pub).parts}
ignored = set(subprocess.run(['git', 'ls-files', '--others', '--ignored', '--exclude-standard'], cwd=pub, capture_output=True,
                             text=True).stdout.split())
changed = added = removed = 0
for f in sorted(new):
    if f not in old:
        added += 1
    elif filecmp.cmp(tmp / f, pub / f, shallow=False):
        continue
    else:
        changed += 1
    (pub / f).parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(tmp / f, pub / f)
for f in sorted(old - new - ignored):
    (pub / f).unlink()
    removed += 1
print('%d added, %d changed, %d removed' % (added, changed, removed))
