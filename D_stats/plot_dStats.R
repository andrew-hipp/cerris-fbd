## plot dStat tests
library(magrittr)
dStats <- lapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- dir(patt = 'bb.dstat.sorted')
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))

dStats.d <- lapply(dStats, '[[', 'dstat')
pdf('../OUT/dStats.pdf', 11.5, 8)
boxplot(dStats.d)
dev.off()

dStats.Z <- lapply(dStats, '[[', 'Z')
pdf('../OUT/dStats-Z.pdf', 11.5, 8)
boxplot(dStats.Z)
dev.off()
