#!/usr/bin/env python3

import sys
from sklearn.metrics import r2_score, root_mean_squared_error # type:ignore
from scipy.stats import spearmanr # type:ignore

input_fn = sys.argv[1]

xs = []
ys = []

for line in open(input_fn).readlines():
    s = line.strip()
    toks = line.split()
    assert(len(toks) == 2)
    x = float(toks[0])
    y = float(toks[1])
    xs.append(x)
    ys.append(y)

r2 = r2_score(xs, ys)
rmse = root_mean_squared_error(xs, ys)
res = spearmanr(xs, ys)
rho = res.statistic
_p = res.pvalue
print("N: %d R2: %.2f RMSE: %.2f rho: %.2f" % (len(xs), r2, rmse, rho))
