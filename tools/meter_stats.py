"""Mean meter readings per phase of the test/energy_run.js runs and the energy of one reading of each build
(11 Nov 2026, docs/m7-energy-plan.md). Writes ref/nn/energy/stats.json.

    python tools/meter_stats.py dark display nochip nochip2 ucibin ...   (runs named nochip* are the chip-out baseline)

Frames closer than MARGIN seconds to a phase boundary are left out (the video and the phase clock agree to about 1 s);
a frame whose fifth field is 'skip' (caught while the meter redrew its digits) is left out too. The meter shows the
current in steps of about 4 mA but the power with three decimals, so the current is taken as watts / volts; where the
volts were off the frame (null), the run's mean volts are used.

The energy of one reading: the program never sleeps, so the chip draws the same current waiting as reading (checked
per build: the reading phase against the two waiting phases). The chip's current is the board's current with the
display-off build running (all three phases) minus the board's current with the chip out of its socket; one reading
costs V x I x t, with t the build's reading time on the simulated board (ref/nn/results/energy_sim.json).
"""
import json
import os
import statistics as st
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
E = os.path.join(ROOT, 'ref', 'nn', 'energy')
MARGIN = 2.0
BUILD = {'dark': '5x7, assembly', 'ucibin': 'UCI binary, assembly', 'ucigray': 'UCI 16 grey levels, assembly',
         'mnist': 'MNIST, assembly', 'sdcc57': '5x7, C as written, SDCC', 'mnistsdcc': 'MNIST, C as written, SDCC',
         'mnistsdcct': 'MNIST, C tuned, SDCC'}
J = lambda p: json.load(open(p, encoding='utf-8'))
se = lambda xs: st.stdev(xs) / len(xs) ** 0.5


def frames(label, names=None):
    """(time, volts, mA as W/V, watts) of every usable frame inside the named phases (all phases if None)."""
    run = J(os.path.join(E, 'run_%s.json' % label))
    fr = [f for f in J(os.path.join(E, 'readings_%s.json' % label))['frames'] if f[4:5] != ['skip']]
    vmean = st.mean(f[1] for f in fr if f[1] is not None)
    rows = []
    for p in run['phases']:
        if names is None or p['name'] in names:
            for f in fr:
                if p['from_s'] + MARGIN <= f[0] <= p['to_s'] - MARGIN:
                    v = f[1] if f[1] is not None else vmean
                    rows.append((f[0], v, f[3] / v * 1000, f[3]))
    return rows, run


labels = sys.argv[1:]
out = {'runs': {}}
for label in labels:
    _, run = frames(label)
    res = {}
    for p in run['phases']:
        rows, _ = frames(label, (p['name'],))
        i = [r[2] for r in rows]
        res[p['name']] = {'frames': len(rows), 'V_mean': round(st.mean(r[1] for r in rows), 4),
                          'I_mA': round(st.mean(i), 2), 'I_sd_mA': round(st.stdev(i), 2),
                          'W_mean': round(st.mean(r[3] for r in rows), 4)}
        if 'readings' in p:
            res[p['name']].update(readings_per_s=p['readings_per_s'], answers_equal='%d of %d' % (p['equal'], p['readings']))
    out['runs'][label] = res
    for k, v in res.items():
        print('%-10s %-12s %s' % (label, k, v))

if 'nochip' in labels and 'dark' in labels:
    sim = {}
    for f in ('energy_sim_part.json', 'energy_sim.json'):     # the full run, where it exists, wins
        if os.path.exists(os.path.join(ROOT, 'ref', 'nn', 'results', f)):
            sim.update({r['name']: r for r in J(os.path.join(ROOT, 'ref', 'nn', 'results', f))['rows']})
    chipout = [l for l in labels if l.startswith('nochip')]        # every chip-out run, pooled
    nI = [r[2] for l in chipout for r in frames(l)[0]]
    base, base_se = st.mean(nI), se(nI)
    builds = []
    for label in [l for l in labels if l in BUILD]:
        rows, run = frames(label)
        I = [r[2] for r in rows]
        wait = [r[2] for r in frames(label, ('idle before', 'idle after'))[0]]
        read = [r[2] for r in frames(label, ('reading',))[0]]
        s = sim[BUILD[label]]
        assert s['answers_unlike_python'] == 0 and s['display_interrupts'] == 0, label
        V = st.mean(r[1] for r in rows)
        chip = st.mean(I) - base
        chip_se = (se(I) ** 2 + base_se ** 2) ** 0.5
        rp = [p for p in run['phases'] if p['name'] == 'reading'][0]
        builds.append({'run': label, 'build': BUILD[label], 'frames': len(I), 'V': round(V, 3),
                       'board_mA': round(st.mean(I), 2), 'board_se_mA': round(se(I), 2),
                       'reading_minus_waiting_mA': round(st.mean(read) - st.mean(wait), 2),
                       'chip_mA': round(chip, 2), 'chip_se_mA': round(chip_se, 2),
                       'reading_ms': s['avg_ms'], 'reading_cycles': s['avg_cycles'],
                       'readings_on_chip': rp['readings'], 'answers_equal_on_chip': rp['equal'],
                       'compute_share_of_reading_phase': round(rp['readings_per_s'] * s['avg_ms'] / 1000, 3),
                       'chip_mJ_per_reading': round(V * chip * s['avg_ms'] / 1000, 3),
                       'board_mJ_per_reading': round(V * st.mean(I) * s['avg_ms'] / 1000, 2)})
    allI = [r[2] for l in labels if l in BUILD for r in frames(l)[0]]
    allV = st.mean(r[1] for l in labels if l in BUILD for r in frames(l)[0])
    chip = st.mean(allI) - base
    chip_se = (se(allI) ** 2 + base_se ** 2) ** 0.5
    for b in builds:                                  # with the chip current of all display-off runs together
        b['chip_mJ_pooled'] = round(allV * chip * b['reading_ms'] / 1000, 3)
    summ = {'chip_out_runs': chipout, 'board_nochip_mA': round(base, 2), 'board_nochip_se_mA': round(base_se, 2),
            'frames_nochip': len(nI),
            'board_display_off_mA': round(st.mean(allI), 2), 'frames_display_off': len(allI), 'V': round(allV, 3),
            'chip_mA': round(chip, 2), 'chip_se_mA': round(chip_se, 2), 'chip_mW': round(allV * chip, 1),
            'chip_mW_low_2se': round(allV * (chip - 2 * chip_se), 1), 'chip_mW_high_2se': round(allV * (chip + 2 * chip_se), 1)}
    if 'display' in labels:
        dw = [r[2] for r in frames('display', ('idle before', 'idle after'))[0]]
        dr = frames('display', ('reading',))[0]
        t_disp = J(os.path.join(ROOT, 'ref', 'nn', 'results', 'marker_digit_nn_marker.json'))['avg_pulse_ms']
        summ.update(display_waiting_mA=round(st.mean(dw), 2), display_reading_mA=round(st.mean(r[2] for r in dr), 2),
                    display_cost_mA=round(st.mean(dw) - st.mean(r[2] for r in frames('dark', ('idle before', 'idle after'))[0]), 2),
                    display_reading_ms=t_disp,
                    board_mJ_per_reading_display=round(st.mean(r[3] for r in dr) * t_disp, 2))
    out['summary'], out['builds'] = summ, builds
    print()
    for k, v in summ.items():
        print('%-30s %s' % (k, v))
    for b in builds:
        print(b)
json.dump(out, open(os.path.join(E, 'stats.json'), 'w', encoding='utf-8'), indent=1)
