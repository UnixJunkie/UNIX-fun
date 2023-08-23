#!/bin/bash

#set -x # DEBUG

# Kolmogorov-Smirnov test

# usage:
# 0     1  2    3  4
# ks.sh f1 col1 f2 col2

(R -q --no-save << EOF
a <- scan(pipe("cut -d' ' -f$2 $1"), what="", sep="\n")
b <- scan(pipe("cut -d' ' -f$4 $3"), what="", sep="\n")
x <- as.numeric(a)
y <- as.numeric(b)
ks.test(x, y)
EOF
) 2>&1 | egrep '^D = '
