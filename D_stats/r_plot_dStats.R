## plot dStat tests
library(magrittr)
dStats <- lapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- dir(patt = 'bb.dstat.sorted')
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))

dStats.d <- lapply(dStats, '[[', 'dstat')
dStats.d <- dStats.d[sapply(dStats.d, mean) %>% order]

pdf('../OUT/dStats.pdf', 11.5, 8)
boxplot(dStats.d)
dev.off()

dStats.Z <- lapply(dStats, '[[', 'Z')[names(dStats.d)]
pdf('../OUT/dStats-Z.pdf', 11.5, 8)
boxplot(dStats.Z)
dev.off()

dStats.p <- lapply(dStats.Z, function(x) {
  out <- pnorm(-sapply(x, abs)) * 2
  out <- p.adjust(out, 'holm')
  return(out)
})
pdf('../OUT/dStats-p.pdf', 11.5, 8)
boxplot(dStats.p)
abline(h = 0.01, lty = 'dashed')
dev.off()

pdf('../OUT/dStats-3panel.pdf', 8, 11.5)
layout(matrix(1:3, 3))
boxplot(dStats.d, main = 'D-stat', cex.axis = 0.5)
boxplot(dStats.Z, main = 'Z', cex.axis = 0.5)
boxplot(dStats.p, main = 'p, Holm correction', cex.axis = 0.5)
abline(h = 0.01, lty = 'dashed')
dev.off()
