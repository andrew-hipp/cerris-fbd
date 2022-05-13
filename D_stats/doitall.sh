#!/bin/bash

R CMD BATCH getTips.R

ipcluster start -n 32 --cluster-id="baba" --daemonize

gunzip -k ../DATA/cerrisdstat.loci.gz

# python dStats_suberIlex.py
# python dStats_cerrisCrenata.py
# python dStats_libaniCrenata.py
# python dStats_aegilopsCrenata.py
# python dStats_aegilopsAfares.py
python dStats_crenata_v_crenata.py
python dStats_partitionedCrenata.py
python dStats_cerrisAfares.py

R CMD BATCH plot_dStats.R

rm ../DATA/cerrisdstat.loci

ipcluster stop --cluster-id="baba"
