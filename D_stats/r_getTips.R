# get tips for Cerris tree

library(ape)
library(phytools)
library(magrittr)

# og taxa from sect. Cyclobalanopsis, indls selected based on number of loci recovered:
#  - Q. blakei - DM5
#  - Q. championii - DM20
#  - Q. lamellos - DM18
#  - Q. gilva - DM56


taxa.og <- c("DM5", "DM20", "DM18", "DM56")
taxa.ilex <- c("OAK-MOR-589.fq.barcodeStripped", "OAK-MOR-980", "OAK-MOR-1146")

# read tree
tr <- read.tree('../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax')

tipsKeep <-
  getMRCA(tr, c('OAK-MOR-981', 'OAK-MOR-986')) %>%
  phangorn::Descendants(x = tr, type = 'tips') %>%
  '[['(1)
tipsKeep <- c(taxa.og, taxa.ilex, tr$tip.label[tipsKeep])

tr.cerris <-
  drop.tip(tr, setdiff(tr$tip.label, tipsKeep)) %>%
  ladderize

write.tree(tr.cerris, '../D_stats/tr.cerris.tre')
