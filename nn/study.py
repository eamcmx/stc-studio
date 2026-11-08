"""Studies for the paper that never touch the shipped program, its weights or its test vectors.

    python nn/study.py            writes ref/nn/results/study.json and the sweep programs in ref/nn/sweep/
    node test/nn_sweep.js         then runs the sweep programs on the simulated board (bit-exact check and time)

1. The 5 x 7 network trained with five seeds (seed 1 is the shipped one): float and 8-bit accuracy on the noisy test
   drawings (all 14 300, and the 13 000 noisy copies without the clean templates, which also occur in training) and
   on the 50 hand drawings.
2. The confusion of the shipped network on the noisy test drawings.
3. UCI handwritten digits: the 64-H-10 networks for H = 8 to 32 and both input codings, five seeds each (8-bit
   accuracy), with the seed-1 programs written for the simulator; and reference models on the same split:
   k-nearest neighbours, softmax regression and wider floating-point networks.
4. 95 % Wilson intervals for the accuracies the paper gives.
"""
import json
import math
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'nn'))
import train_digits as TD  # noqa: E402
import train_uci as TU  # noqa: E402

OUT = ROOT / 'ref' / 'nn' / 'results'
SWEEP = ROOT / 'ref' / 'nn' / 'sweep'
SEEDS = [1, 2, 3, 4, 5]
HS = [8, 12, 16, 20, 24, 28, 32]
N_SIM = 300                      # test digits run on the simulated board per sweep program


def wilson(k, n, z=1.96):
    p = k / n
    d = 1 + z * z / n
    c = (p + z * z / (2 * n)) / d
    h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / d
    return [round(100 * (c - h), 2), round(100 * (c + h), 2)]


def ms(values):
    a = np.array(values, dtype=float)
    return {'mean': round(float(a.mean()), 2), 'sd': round(float(a.std(ddof=1)), 2), 'min': round(float(a.min()), 2),
            'max': round(float(a.max()), 2), 'values': [round(float(v), 2) for v in a]}


def five_by_seven():
    Xtr, Ytr = TD.dataset(40, seed=11)
    Xte, Yte = TD.dataset(10, seed=99)
    clean = np.zeros(len(Xte), bool)
    clean[::11] = True                # dataset(): every template once, then its 10 noisy copies
    Th = [(TD.HANDMADE, 'hand1'), (TD.HANDMADE2, 'hand2'), (TD.STAIRS, 'stairs')]
    H = {name: (np.array([TD.grid(s).ravel() for _, s in S], float), np.array([d for d, _ in S])) for S, name in Th}
    shipped = TD.load_model()
    runs = []
    for seed in SEEDS:
        P = TD.train(Xtr, Ytr, seed=seed)
        Q = TD.quantize(P, Xtr)
        if seed == 1:                 # seed 1 must give the shipped weights, or the study is about another network
            same = all(np.array_equal(np.array(Q[k]), np.array(shipped[k])) for k in ('W1', 'b1', 'W2', 'b2')) and Q['sh1'] == shipped['sh1']
            assert same, 'seed 1 does not reproduce nn/model.json'
        fi, ii = TD.float_predict(P, Xte), TD.int_predict(Q, Xte)
        r = {'seed': seed, 'float_test': 100 * float((fi == Yte).mean()), 'int8_test': 100 * float((ii == Yte).mean()),
             'float_noisy': 100 * float((fi[~clean] == Yte[~clean]).mean()), 'int8_noisy': 100 * float((ii[~clean] == Yte[~clean]).mean())}
        for name, (X, Y) in H.items():
            r['int8_' + name] = int((TD.int_predict(Q, X) == Y).sum())
        runs.append(r)
        print('5x7 seed', seed, {k: round(v, 2) if isinstance(v, float) else v for k, v in r.items()})
    pred = TD.int_predict(shipped, Xte)
    conf = np.zeros((10, 10), int)
    for y, p in zip(Yte[~clean], pred[~clean]):
        conf[y, p] += 1
    off = [(int(conf[i, j]), i, j) for i in range(10) for j in range(10) if i != j]
    off.sort(reverse=True)
    n_noisy = int((~clean).sum())
    wrong = int(n_noisy - np.trace(conf))
    # how many noisy copies are identical to a template of ANOTHER digit (no reader can get those right)
    tmpl = {}
    for d, g in TD.templates():
        tmpl.setdefault(tuple(g.ravel().astype(int)), set()).add(d)
    clash = sum(1 for x, y in zip(Xte[~clean], Yte[~clean]) if any(dd != y for dd in tmpl.get(tuple(x.astype(int)), ())))
    k_ship = int((pred == Yte).sum())
    return {
        'train': len(Xtr), 'test': len(Xte), 'test_noisy_only': n_noisy,
        'runs': runs,
        'summary': {k: ms([r[k] for r in runs]) for k in ('float_test', 'int8_test', 'float_noisy', 'int8_noisy')},
        'hand_correct_by_seed': {n: [r['int8_' + n] for r in runs] for n in ('hand1', 'hand2', 'stairs')},
        'shipped': {'int8_test_pct': round(100 * k_ship / len(Yte), 2), 'int8_test_wilson95': wilson(k_ship, len(Yte)),
                    'int8_noisy_pct': round(100 * (n_noisy - wrong) / n_noisy, 2), 'int8_noisy_wilson95': wilson(n_noisy - wrong, n_noisy)},
        'confusion_noisy': conf.tolist(), 'noisy_wrong': wrong,
        'top_confusions': [{'true': i, 'read_as': j, 'count': c, 'share_of_errors_pct': round(100 * c / wrong, 1)} for c, i, j in off[:8]],
        'noisy_equal_to_another_digits_template': clash,
    }


def knn(Xtr, Ytr, Xte, k):
    d = (Xte ** 2).sum(1)[:, None] - 2 * Xte @ Xtr.T + (Xtr ** 2).sum(1)[None, :]
    idx = np.argsort(d, axis=1, kind='stable')[:, :k]
    votes = Ytr[idx]
    pred = []
    for row, drow in zip(votes, np.take_along_axis(d, idx, 1)):
        c = np.bincount(row, minlength=10)
        best = np.flatnonzero(c == c.max())
        pred.append(best[0] if len(best) == 1 else row[0])     # a tie goes to the nearest
    return np.array(pred)


def softmax_reg(X, Y, epochs=200, seed=1):
    rng = np.random.default_rng(seed)
    W = np.zeros((X.shape[1], 10)); b = np.zeros(10)
    P = [W, b]; M = [np.zeros_like(p) for p in P]; V = [np.zeros_like(p) for p in P]
    lr, t = 0.01, 0
    for ep in range(epochs):
        idx = rng.permutation(len(X))
        for k in range(0, len(X), 64):
            bb = idx[k:k + 64]
            z = X[bb] @ W + b; z -= z.max(1, keepdims=True)
            p = np.exp(z); p /= p.sum(1, keepdims=True)
            p[np.arange(len(bb)), Y[bb]] -= 1; p /= len(bb)
            g = [X[bb].T @ p + 1e-4 * W, p.sum(0)]
            t += 1
            for i in range(2):
                M[i] = 0.9 * M[i] + 0.1 * g[i]; V[i] = 0.999 * V[i] + 0.001 * g[i] ** 2
                P[i] -= lr * (M[i] / (1 - 0.9 ** t)) / (np.sqrt(V[i] / (1 - 0.999 ** t)) + 1e-8)
    return lambda Z: (Z @ W + b).argmax(1)


def uci():
    Xtr, Ytr = TU.load('optdigits.tra')
    Xte, Yte = TU.load('optdigits.tes')
    res = {'train': len(Ytr), 'test': len(Yte), 'sweep': {}, 'baselines': {}}
    SWEEP.mkdir(parents=True, exist_ok=True)
    for kind, K in (('bin', 1), ('gray', 15)):
        Utr, Ute = TU.encode(Xtr, kind), TU.encode(Xte, kind)
        rows = []
        for H in HS:
            TU.HIDDEN = H
            f_acc, i_acc = [], []
            for seed in SEEDS:
                P = TU.train(Utr / K, Ytr, hidden=H, seed=seed)
                f_acc.append(100 * float(((np.maximum(Ute / K @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean()))
                Q = TU.quantize(P, Utr, K)
                i_acc.append(100 * float((TU.int_predict(Q, Ute) == Yte).mean()))
                if seed == 1:
                    prog = TU.program(Q, kind)
                    sp = max(0xD7, 0x70 + 3 * H + 30 - 1)          # the stack right above the scores
                    assert sp + 12 <= 0xFF, 'no room for the stack'
                    prog = prog.replace('MAIN:   MOV     SP,#0D7H', 'MAIN:   MOV     SP,#0%02XH' % sp)
                    prog = prog.replace("; Digit reader on the UCI handwritten digits", "; SWEEP BUILD (nn/study.py), H = %d. Digit reader on the UCI handwritten digits" % H)
                    (SWEEP / ('uci_%s_h%d.a51' % (kind, H))).write_text(prog, encoding='utf-8', newline='\n')
                    vecs = []
                    for u, y in list(zip(Ute, Yte))[:N_SIM]:
                        d, scores = TU.int_forward(Q, u)
                        vecs.append({'pixels': ''.join('0123456789ABCDEF'[v] for v in u), 'label': int(y), 'digit': d, 'scores': scores})
                    (SWEEP / ('uci_%s_h%d.json' % (kind, H))).write_text(json.dumps(vecs), encoding='utf-8')
                    if H == 24:        # the paper's networks: the study must reproduce them
                        rep = json.loads((ROOT / 'nn' / 'uci_report.json').read_text(encoding='utf-8'))[kind]
                        assert abs(i_acc[-1] / 100 - rep['int8_test_accuracy']) < 1e-4, (kind, i_acc[-1], rep)
            rows.append({'H': H, 'float': ms(f_acc), 'int8': ms(i_acc)})
            print('uci', kind, 'H', H, 'int8', ms(i_acc)['mean'], '+-', ms(i_acc)['sd'], 'float', ms(f_acc)['mean'])
        res['sweep'][kind] = rows
    TU.HIDDEN = 24
    # reference models on the same split (floating point)
    G = TU.encode(Xtr, 'gray') / 15, TU.encode(Xte, 'gray') / 15
    Bn = TU.encode(Xtr, 'bin').astype(float), TU.encode(Xte, 'bin').astype(float)
    raw = Xtr / 16.0, Xte / 16.0
    for k in (1, 3):
        res['baselines']['%d-NN, 17 grey levels' % k] = round(100 * float((knn(raw[0], Ytr, raw[1], k) == Yte).mean()), 2)
        res['baselines']['%d-NN, binary' % k] = round(100 * float((knn(Bn[0], Ytr, Bn[1], k) == Yte).mean()), 2)
    res['baselines']['softmax regression, 16 grey levels'] = round(100 * float((softmax_reg(G[0], Ytr)(G[1]) == Yte).mean()), 2)
    res['baselines']['softmax regression, binary'] = round(100 * float((softmax_reg(Bn[0], Ytr)(Bn[1]) == Yte).mean()), 2)
    for H in (64, 128):
        accs = []
        for seed in SEEDS:
            P = TU.train(G[0], Ytr, hidden=H, seed=seed)
            accs.append(100 * float(((np.maximum(G[1] @ P[0] + P[1], 0) @ P[2] + P[3]).argmax(1) == Yte).mean()))
        res['baselines']['float MLP 64-%d-10, 16 grey levels (5 seeds)' % H] = ms(accs)
    rep = json.loads((ROOT / 'nn' / 'uci_report.json').read_text(encoding='utf-8'))
    n = len(Yte)
    res['wilson95_paper'] = {kind: wilson(round(rep[kind]['int8_test_accuracy'] * n), n) for kind in ('bin', 'gray')}
    print('baselines', json.dumps(res['baselines']))
    return res


if __name__ == '__main__':
    out = {'by': 'nn/study.py', 'seeds': SEEDS, 'five_by_seven': five_by_seven(), 'uci': uci()}
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / 'study.json').write_text(json.dumps(out, indent=1), encoding='utf-8')
    print('written', OUT / 'study.json')
