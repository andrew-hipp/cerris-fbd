# d-stat tests
2022-05-06, ahipp@mortonarb.org

Runs 4-taxon ABBA-BABA (d-statistic) tests for _Cerris_ data  
Follows: https://ipyrad.readthedocs.io/en/master/API-analysis/cookbook-abba-baba.html  
`dStats.sh` should be executed in an environment with ipyrad, toytree, and other dependencies listed in the above tutorial all installed. You'll also need R installed with ape, tidyverse, and phytools. Before running, execute:

`ipcluster start -n 40 --cluster-id="baba" --daemonize`

... replacing `-n 40` with the number of cores you want to use.  
z
