#!/bin/bash

# count number of molecules for various molecular file formats

for f in "$@"; do
    filename=`basename "$f"`
    extension="${filename##*.}"
    case "$extension" in
        mol2) egrep -c MOLECULE $f
              ;;
        plr) egrep -c '^END$' $f # position and contrib per atom to cLogP
             ;;
        pqr) egrep -c ^COMPND $f
             ;;
        sdf) grep -c '$$$$' $f
             ;;
        mol) grep -c '$$$$' $f
             ;;
        phar) grep -c '$$$$' $f # Pharao DB
             ;;
        smi) cat $f | wc -l
             ;;
        *) echo "molcount: unsupported file format: ."$f
           ;;
    esac
done
