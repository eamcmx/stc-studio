"""Contact sheets of the USB meter's screen from a test/energy_run.js video (11 Nov 2026): one frame every STEP seconds,
cropped to the meter, turned upright and labelled with its time and phase, so the readings can be read off and typed
into ref/nn/energy/readings_<label>.json.

    python tools/meter_frames.py ref/nn/energy/run_dark.json [x0 y0 x1 y1] [step s]
"""
import json
import os
import subprocess
import sys
import tempfile

from PIL import Image, ImageDraw, ImageFont

FF = r'C:\Users\eamer\AppData\Roaming\Python\Python314\site-packages\imageio_ffmpeg\binaries\ffmpeg-win-x86_64-v7.1.exe'
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

run_file = sys.argv[1]
run = json.load(open(os.path.join(ROOT, run_file), encoding='utf-8'))
box = tuple(int(v) for v in sys.argv[2:6]) if len(sys.argv) >= 6 else (420, 2340, 1100, 2800)
step = float(sys.argv[6]) if len(sys.argv) >= 7 else 2.0
tmp = tempfile.mkdtemp(prefix='meter_')
subprocess.run([FF, '-loglevel', 'error', '-y', '-i', run['video'], '-vf', 'fps=1/%g' % step,
                os.path.join(tmp, 'f%04d.png')], check=True)
frames = sorted(f for f in os.listdir(tmp) if f.endswith('.png'))


def phase(ts):
    for p in run['phases']:
        if p['from_s'] <= ts <= p['to_s']:
            return p['name']
    return '-'


W, H = 340, 230
cells = []
font = ImageFont.truetype('arial.ttf', 22)
for i, f in enumerate(frames):
    ts = (i + 0.5) * step          # the fps filter takes the frame in the middle of each step
    im = Image.open(os.path.join(tmp, f)).crop(box).rotate(180)
    im.thumbnail((W, H - 30))
    cell = Image.new('RGB', (W, H), 'white')
    cell.paste(im, (0, 30))
    ImageDraw.Draw(cell).text((6, 4), '%5.1f s  %s' % (ts, phase(ts)), fill='black', font=font)
    cells.append(cell)
out_dir = os.path.join(ROOT, 'ref', 'nn', 'energy', 'sheets')
os.makedirs(out_dir, exist_ok=True)
per = 24
for s in range(0, len(cells), per):
    part = cells[s:s + per]
    sheet = Image.new('RGB', (4 * W, ((len(part) + 3) // 4) * H), 'white')
    for k, c in enumerate(part):
        sheet.paste(c, ((k % 4) * W, (k // 4) * H))
    p = os.path.join(out_dir, '%s_%d.jpg' % (run['label'], s // per + 1))
    sheet.save(p, quality=85)
    print(p)
