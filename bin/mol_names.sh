#!/bin/bash

# output molecule names for various molecular file formats

for f in "$@"; do
    filename=`basename "$f"`
    extension="${filename##*.}"
    case "$extension" in
        mol2) grep -F -w -A1 '@<TRIPOS>MOLECULE' $f | grep -v '@<TRIPOS>MOLECULE' | grep -v '\-\-'
              ;;
        xyz) grep '\t' $f | cut -f2
              ;;
        *) echo ${0}" unsupported file format: ."$f
           ;;
    esac
done
