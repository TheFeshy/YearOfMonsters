#!/bin/bash

PRINT_DIR="output/print_quality"
EBOOK_DIR="output/ebook_quality"

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
    -sOutputFile="$PRINT_DIR/$BN" \
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
    -sOutputFile="$EBOOK_DIR/$BN" \
    "$1"
}

mkdir -p "$PRINT_DIR"
mkdir -p "$EBOOK_DIR"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in $(find output/build -iname "*.pdf"); do
    print_quality "$f" &
    ebook_quality "$f" &
done
wait
IFS=$SAVEIFS