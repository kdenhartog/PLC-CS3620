#!/bin/bash

render() {
if [ -f $1.gv ] ; then
    echo "generating $1.pdf";
    dot -Tpdf -o $1.pdf $1.gv

    #weird, but more compact:
    #neato -Tpdf -o $1.pdf -Goverlap=false $1.gv
fi
}

base=$1

for d in Orig Cyc Diam Tree ; do
  render ${base}${d}
done

render ${base}


