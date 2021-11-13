## read in Cerris data
library(ape)
library(phytools)
library(magrittr)
library(phangorn)densi
# library(MCMCtreeR)
# library(ips)
if(!exists('dat.sum')) dat.sum <- read.table('../DATA/runs1.2.3.5.7.8.9.10.logSummary.txt',
                      header = T, as.is = T, row.names = 1)
if(!exists('tr.full')) {
  tr.full <- list(
    r1 = read.nexus('../DATA/runs1.2.3.5.7.8.9.10.trees.thinned')
    )
  tr <- list(
    r1 = read.nexus('../DATA/runs1.2.3.5.7.8.9.10.median.annot.tre')
    # r1 = readMCMCtree('../DATA/runs1.2.3.5.7.8.9.10.median.annot.tre')
  ) # close tr


cleanTree <- function(x, keepGrp = '_0.0', strip = '_0.0', ladder = T) {
  x <- drop.tip(x, grep(keepGrp, x$tip.label, invert = TRUE))
  x$tip.label <- gsub(strip, '', x$tip.label)
  if(ladder) x <- ladderize(x)
  return(x)
}

set.seed(1)
tr.clean <- lapply(tr, cleanTree)
tr.full <- lapply(tr.full, function(x) lapply(x, cleanTree))
tree.subsample <- lapply(tr.full, function(x) sample(x, size = 500))
class(tree.subsample$r1) <- 'multiPhylo'
}

## problem: lines up at crown and tips
pdf('../OUT/densiTreeOut.v1.pdf', 8.5, 11)
densiTree(tree.subsample$r1, alpha = 0.01)
dev.off()
write.tree(tr.clean$r1, '../OUT/tree.cleaned.r1.tre')
