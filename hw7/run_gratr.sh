#!/bin/bash

GRATRDIR=${GRATRDIR:-~/gratr2}

#args+=" --short-state-labels "
#args+=" --debug-treeify "
#args+=" --debug-treeify-micro "
#args+=" --debug-check-unambiguity "
#args+=" --debug-gen-aut "
#args+=" --debug-gen-aut-micro "
args+=" --debug-compilation-to-agda "
#args+=" --debug-grammar-to-ast "
#args+=" --debug-convert-grammar "
#args+=" --no-debug-parsing "
#args+=" --debug-local-confluence "
#args+=" --debug-local-confluence-micro "
#args+=" --debug-cps "
#args+=" --print-raw "
#args+=" --debug-rewriting "
#args+=" --debug-run-rewriting "
#args+=" --debug-run-rewriting-micro "

#ulimit -S unlimited
#export OCAMLRUNPARAM="l=500M"

${GRATRDIR}/src/gratr $args $*


#--complete
#  --contextualize-cps
#--debug-contextualize-rules 
#--filter-before-after-by-cps  
