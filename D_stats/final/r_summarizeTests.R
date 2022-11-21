# summarize tests conducted
library(magrittr)
source('r_functions.R')

roundTo = 3 # how many digits to round to

dStats <- lapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- dir(patt = 'bb.dstat.sorted')
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))
for(i in seq(length(dStats))) {
  dStats[[i]]$p <-
    sapply(dStats[[i]]$Z, z2holm)
}

out <- data.frame(
  numTests = sapply(dStats, dim)[1, ],
  D = sapply(dStats, function(x) mean_quantile(x$dstat)),
  Z = sapply(dStats, function(x) mean_quantile(x$Z)),
  p = sapply(dStats, function(x) mean_quantile(x$p)),
  'prop. sign (0.01)' =
    sapply(dStats, function(x) sum(x$p <= 0.01) / length(x$p)) %>%
    round(roundTo)
)

write.csv(out, '../OUT/dStats_test_summary.csv')

dStats.partitioned <- read.csv('dstat_partitionedCrenata_full.csv')
dStats.partitioned$pHolm <- sapply(dStats.partitioned$Z, z2holm)
names(dStats.partitioned)[1:2] <- c('test', 'stat')
write.csv(dStats.partitioned, 'dstat_partitionedCrenata_pHolm.csv', row.names = F)
