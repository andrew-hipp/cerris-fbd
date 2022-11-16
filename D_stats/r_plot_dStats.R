## plot dStat tests
library(magrittr)
dStats <- lapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- dir(patt = 'bb.dstat.sorted')
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))

dStats.d <- lapply(dStats, '[[', 'dstat')
dStats.d <- dStats.d[sapply(dStats.d, mean) %>% order]

dStats.Z <- lapply(dStats, '[[', 'Z')[names(dStats.d)]

dStats.p <- lapply(dStats.Z, function(x) {
  out <- pnorm(-sapply(x, abs)) * 2
  out <- p.adjust(out, 'holm')
  return(out)
})

pdf('../OUT/dStats-3panel.pdf', 8, 11.5)
layout(matrix(1:3, 3))
boxplot(dStats.d, main = 'D-stat', cex.axis = 0.5)
boxplot(dStats.Z, main = 'Z', cex.axis = 0.5)
boxplot(dStats.p, main = 'p, Holm correction', cex.axis = 0.5, ylim = c(0,0.2))
abline(h = 0.01, lty = 'dashed')
dev.off()
