#!/bin/bash

COMPILEDIR="./build/"
LATEXFLAGS=" -halt-on-error -file-line-error -output-directory $COMPILEDIR "

pdflatex $LATEXFLAGS Physics.tex
if [ $? != "0" ] ; then
    echo "Encountered error. Bailing"
    exit
fi

while egrep -q 'LaTeX Warning:.*Rerun|Rerun to get|rerun to get' "$COMPILEDIR"*.log ; do
    pdflatex $LATEXFLAGS Physics.tex
    if [ $? != "0" ] ; then
        echo "Encountered error. Bailing"
        exit
    fi
done

echo "Compiled document is at '${COMPILEDIR}/Physics.pdf"

