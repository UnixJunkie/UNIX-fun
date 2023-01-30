#!/bin/bash
#
# make (any?) pdf printable

# one mandatory pdf input file
if [ "$#" -ne "1" ] ; then
    #             0    1
    echo "usage: "$0" input.pdf"
    exit 1
fi

PS_TMP=`mktemp --suffix='.ps'`
PDF_OUT=`mktemp --suffix='.pdf'`

trap 'rm -f ${PS_TMP}' EXIT

pdf2ps $1 ${PS_TMP} && ps2pdf ${PS_TMP} ${PDF_OUT} && echo ${PDF_OUT}
