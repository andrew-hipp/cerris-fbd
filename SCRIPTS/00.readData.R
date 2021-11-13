## read in Cerris data
library(ape)
library(MCMCtreeR)
library(ips)
dat.sum <- read.table('../DATA/runs1.2.3.5.7.8.9.10.logSummary.txt',
                      header = T, as.is = T, row.names = 1)
if(!exists('tr.full')) {
  tr.full <- list(
    r1 = read.nexus('../DATA/runs1.2.3.5.7.8.9.10.trees.thinned')
    )
  tr <- list(
    # r1 = read.nexus('../DATA/runs1.2.3.5.7.8.9.10.median.annot.tre')
    r1 = readMCMCtree('../DATA/runs1.2.3.5.7.8.9.10.median.annot.tre')
  ) # close tr


cleanTree <- function(x, keepGrp = '_0.0', strip = '_0.0', ladder = T) {
  x <- drop.tip(x, grep(keepGrp, x$tip.label, invert = TRUE))
  x$tip.label <- gsub(strip, '', x$tip.label)
  if(ladder) x <- ladderize(x)
  return(x)
}

tr.clean <- lapply(tr, cleanTree)
tr.full <- lapply(tr.full, function(x) lapply(x, cleanTree))
}
# plot(tr.clean$r1)

MCMC.tree.plot(tr$r1, analysis.type = "MCMCtree", cex.tips = 0.2,
    time.correction = 100, plot.type = "phylogram", lwd.bar = 2,
    scale.res = c("Eon", "Period"), node.method = "node.length",
    col.age = "#008b0040", no.margin = TRUE, label.offset = 4)
