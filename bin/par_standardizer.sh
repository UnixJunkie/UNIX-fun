#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage: "$0" input.smi output_std.smi"
    exit 1
fi

INPUT=$1
OUTPUT=$2

pardi -i $INPUT -o $OUTPUT -c 400 -d l -ie '.smi' -oe '.smi' \
      -w 'standardiser -i %IN -o %OUT 2>/dev/null'
