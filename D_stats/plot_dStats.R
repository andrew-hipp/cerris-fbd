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

pdf('../OUT/dStats-2panel.pdf', 8, 11.5)
layout(matrix(1:2, 2))
boxplot(dStats.d, main = 'D-stat', cex.axis = 0.5)
boxplot(dStats.Z, main = 'Z', cex.axis = 0.5)
dev.off()
