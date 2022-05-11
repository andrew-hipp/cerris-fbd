#!/bin/bash

R CMD BATCH getTips.R

ipcluster start -n 32 --cluster-id="baba" --daemonize

gunzip -k ../DATA/cerrisdstat.loci.gz

# python dStats_suberIlex.py
# python dStats_cerrisCrenata.py
# python dStats_libaniCrenata.py
python dStats_macrolepisCrenata.py

rm ../DATA/cerrisdstat.loci

ipcluster stop --cluster-id="baba"
