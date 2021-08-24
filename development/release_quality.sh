#!/bin/bash

print_quality () {
    echo "Converting $1 to print quality"
    BN=$(basename "$1")
    gs -q \
    -dNOPAUSE \
    -dBATCH -dSAFER \
    -sDEVICE=pdfwrite \
    -dCompatabilityLevel=1.5 \
    -dPDFSETTINGS=/printer \
    -dEmbedAllFonts=true \
    -dSubsetFonts=true \
    -sOutputFile="output/print_quality/$BN.pdf" \
    "$1"
}

ebook_quality () {
    echo "Converting $1 to ebook quality"
    BN=$(basename "$1")
    gs -q \
    -dNOPAUSE \
    -dBATCH -dSAFER \
    -sDEVICE=pdfwrite \
    -dCompatabilityLevel=1.5 \
    -dPDFSETTINGS=/ebook \
    -dEmbedAllFonts=true \
    -dSubsetFonts=true \
    -sOutputFile="output/ebook_quality/$BN.pdf" \
    "$1"
}

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in $(find output/build -iname "*.pdf"); do
    print_quality "$f"
    #ebook_quality "$f"
done
IFS=$SAVEIFS