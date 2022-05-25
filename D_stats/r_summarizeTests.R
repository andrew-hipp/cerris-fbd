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
  p = sapply(dStats, function(x) mean_quantile(x$p))
)

write.csv(out, '../OUT/dStats_test_summary.csv')
