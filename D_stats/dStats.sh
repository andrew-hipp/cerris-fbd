#!/bin/bash

import ipyrad.analysis as ipa
import ipyparallel as ipp
import toytree
import toyplot

# Before running, execute:
# `ipcluster start -n 40 --cluster-id="baba" --daemonize`
# ... replacing `-n 40` with the number of cores you want to use.
ipyclient = ipp.Client(cluster_id="baba")

locifile = '../DATA/oaksall_v1_2.m15.loci.gz'
newick = '../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax'
