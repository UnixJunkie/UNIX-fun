#!/bin/bash

# given a score-labels file, compute its AUROC and 95% confidence interval

#set -x
set -u

if [ "$#" -ne "1" ] ; then
    #             0   1
    echo "usage: "$0" score_labels.tsv"
    exit 1
fi

INPUT=$1

TMPDIR=`mktemp -d`
trap "rm -rf $TMPDIR" EXIT

SCORES=$TMPDIR"/scores"
LABELS=$TMPDIR"/labels"

awk '{print $1}' $INPUT > $SCORES
awk '{print $2}' $INPUT > $LABELS

Rscript <(
cat <<EOF
#!/usr/bin/Rscript

library(pROC, quietly=TRUE)

args <- commandArgs(TRUE)

# create numerical vectors
scores <- read.table(args[1])
labels <- read.table(args[2])
# the roc function requires a data frame
df <- data.frame(scores, labels)
colnames(df) <- c("scores", "labels")
roc_curve <- roc(df, "labels", "scores")
auc(roc_curve)
ci.auc(roc_curve)
EOF
) $SCORES $LABELS
