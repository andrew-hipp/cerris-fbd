#!/bin/bash

R CMD BATCH r_getTips.R

ipcluster start -n 32 --cluster-id="baba" --daemonize

gunzip -k ../DATA/cerrisdstat.loci.gz

# python dStats_suberIlex.py
# python dStats_cerrisCrenata.py
# python dStats_libaniCrenata.py
# python dStats_aegilopsCrenata.py
# python dStats_cerrisAfares.py
# python dStats_crenata_v_crenata.py
# python dStats_partitionedCrenata.py
# python dStats_cerrisAfares_libani.py
# python dStats_cerrisAfares_trojana.py
python dStats_cerrisTrojana.py

rm ../DATA/cerrisdstat.loci

ipcluster stop --cluster-id="baba"

R CMD BATCH r_plot_dStats.R
R CMD BATCH r_checkP3.R
R CMD BATCH r_summarizeTests.R
