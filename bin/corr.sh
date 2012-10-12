#!/bin/bash

#set -x

# compute a correlation score over user-chosen columns from files

if [ "$#" -ne "3" ] ; then
    #             0    1                 2          3
    echo "usage: "$0" {spearman|pearson} file1:col1 file2:col2"
    echo "LINES STARTING WITH # IN DATA FILES ARE SKIPPED"
    exit 1
fi

if [ "$1" != "spearman" ] && [ "$1" != "pearson" ] ; then
    echo "only 'spearman' or 'pearson' is supported"
    exit 1
fi

f1=`echo $2 | cut -d':' -f1`
c1=`echo $2 | cut -d':' -f2`
f2=`echo $3 | cut -d':' -f1`
c2=`echo $3 | cut -d':' -f2`

TMPDIR=`mktemp -d`
trap "rm -rf $TMPDIR" EXIT

F1=$TMPDIR"/f1"
F2=$TMPDIR"/f2"

egrep -v '^#' $f1 | awk -v c=$c1 '{print $c}' > $F1
egrep -v '^#' $f2 | awk -v c=$c2 '{print $c}' > $F2

Rscript <(
cat <<EOF
#!/usr/bin/Rscript

args <- commandArgs(TRUE)

fr <- read.table(args[1])
fr2 <- read.table(args[2])

cor.test(fr[,1],fr2[,1],method="$1")
EOF
) $F1 $F2
