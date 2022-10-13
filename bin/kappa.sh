#!/bin/bash

#set -x

# Cohen's Kappa over user-chosen columns from files

if [ "$#" -ne "2" ] ; then
    #             0   1          2          3
    echo "usage: "$0" file1:col1 file2:col2"
    echo "LINES STARTING WITH # IN DATA FILES ARE SKIPPED"
    exit 1
fi

f1=`echo $1 | cut -d':' -f1`
c1=`echo $1 | cut -d':' -f2`
f2=`echo $2 | cut -d':' -f1`
c2=`echo $2 | cut -d':' -f2`

TMPDIR=`mktemp -d`
trap "rm -rf $TMPDIR" EXIT

F1=$TMPDIR"/f1"
F2=$TMPDIR"/f2"

egrep -v '^#' $f1 | awk -v c=$c1 '{print $c}' > $F1
egrep -v '^#' $f2 | awk -v c=$c2 '{print $c}' > $F2

Rscript <(
cat <<EOF
#!/usr/bin/Rscript

library(psych)

args <- commandArgs(TRUE)

# vector of ratings for both raters
fr  <- read.table(args[1])
fr2 <- read.table(args[2])
x=cbind(fr,fr2)
cohen.kappa(x)
EOF
) $F1 $F2
