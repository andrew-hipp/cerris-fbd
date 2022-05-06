#!/bin/bash

R CMD BATCH getTips.R

ipcluster start -n 64 --cluster-id="baba" --daemonize

gunzip -k ../DATA/cerrisdstat.loci.gz
python dStats.py
rm ../DATA/cerrisdstat.loci

ipcluster stop --cluster-id="baba"
