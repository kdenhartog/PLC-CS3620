#!/bin/bash

for f in *gv ; do dot -Tjpg $f > ${f%.gv}.jpg; done
