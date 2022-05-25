# d-stat tests
2022-05-06, ahipp@mortonarb.org

## what it is
Runs 4-taxon ABBA-BABA (d-statistic) tests for _Cerris_ data  
Follows: https://ipyrad.readthedocs.io/en/master/API-analysis/cookbook-abba-baba.html  

## steps
### 1. subset tree and write
Execute `getTips.R` within R to subset the RAD-seq tree and write the subsetted tree. This will be needed by ipyrad.

`R CMD BATCH getTips.R`

### 2. launch cluster
`dStats.sh` should be executed in an environment with ipyrad, toytree, and other dependencies listed in the above tutorial all installed. You'll also need R installed with ape, tidyverse, and phytools. Before running, execute:

`ipcluster start -n 32 --cluster-id="baba" --daemonize`

... replacing `-n 40` with the number of cores you want to use.  

### 3. run d-stats

### 4. stop cluster

`ipcluster stop --cluster-id="baba"`
