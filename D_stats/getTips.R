# get tips for Cerris tree

library(ape)
library(phytools)
library(magrittr)

# og taxa, indls selected based on number of loci recovered:
#  - Q. calliprinos
#  - Q. ilex
#  - Q. monimotricha - DM68
#  - Q. phillyreoides - OAK-MOR-994
og <- c('OAK-MOR-1145', 'OAK-MOR-1146', 'DM68', 'OAK-MOR-994')

# read tree
tr <- read.tree('../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax')

tipsKeep <-
  getMRCA(tr, c('OAK-MOR-981', 'OAK-MOR-986')) %>%
  phangorn::Descendants(x = tr, type = 'tips') %>%
  '[['(1) %>%
tipsKeep <- c(og, tr$tip.label[tipsKeep])

tr.cerris <- drop.tip(tr, setdiff(tr$tip.label, tipsKeep))
write.tree(tr.cerris, '../D_stats/tr.cerris.tre')
