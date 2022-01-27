## clean up the beast trees
library(ape)
library(magrittr)

datePrecision <- 1
dopdf = T

trFile <- c(
  r1 = '../BEAST.FILES/comboRuns.noBurn.annotated_r1.tre',
  r2 = '../BEAST.FILES/comboRuns.noBurn.annotated_r2.tre',
  r3 = '../BEAST.FILES/comboRuns.noBurn.annotated_r3.tre'
)

tr.beast <- lapply(trFile, read.nexus)

tr.beast.extant <- structure(vector('list', length(trFile)), .Names = names(tr.beast))

for(i in names(tr.beast)) {
  taxa.fossils <-
    which(round(node.depth.edgelength(tr.beast[[i]])[1:Ntip(tr.beast[[i]])], 1) <
          round(max(node.depth.edgelength(tr.beast[[i]])),1)
          )
  tr.beast.extant[[i]] <- drop.tip(tr.beast[[i]], taxa.fossils)
  if(dopdf) pdf(paste('../OUT/tr.beast', i, 'pdf', sep = '.'), 11.5, 8)
    layout(matrix(1:2, 1))
    tr.beast[[i]] %>% ladderize(right = FALSE) %>% plot(cex = 0.5)
    tr.beast.extant[[i]] %>% ladderize(right = FALSE) %>% plot(cex = 0.7)
  if(dopdf) dev.off()
  write.tree(tr.beast.extant[[i]],
              paste('../OUT/tr.beast.pruned', i, 'tre', sep = '.')
            )
}
