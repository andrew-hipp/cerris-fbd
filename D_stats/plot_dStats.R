## plot dStat tests
library(magrittr)
dStats <- sapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))
