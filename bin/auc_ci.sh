#!/bin/bash

#set -x

# given a score-labels file, compute its AUC value and 95% confidence interval

if [ "$#" -ne "1" ] ; then
    #             0   1
    echo "usage: "$0" score_labels.tsv"
    exit 1
fi

INPUT=$1

TMPDIR=`mktemp -d`
trap "rm -rf $TMPDIR" EXIT

F1=$TMPDIR"/scores"
F2=$TMPDIR"/labels"

awk '{print $1}' $INPUT > $F1
awk '{print $2}' $INPUT > $F2

Rscript <(
cat <<EOF
#!/usr/bin/Rscript

library(pROC)

args <- commandArgs(TRUE)

# vector of ratings for both raters
scores <- read.table(args[1])
labels <- read.table(args[2])
roc_curve <- roc(labels, scores)
auc(roc_curve)
ci.auc(roc_curve)
EOF
) $F1 $F2
