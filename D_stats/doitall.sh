#!/bin/bash

R CMD BATCH getTips.R
ipcluster start -n 32 --cluster-id="baba" --daemonize
python dStats.py
ipcluster stop --cluster-id="baba"
