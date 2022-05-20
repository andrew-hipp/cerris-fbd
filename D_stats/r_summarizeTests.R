# summarize tests conducted

roundTo = 3 # how many digits to round to
rt <- function(x, figs = roundTo) round(x, figs)
mean_quantile <- function(x, lo = 0.025, hi = 0.975) {
  out <- paste(rt(mean(x)), ' [', rt(quantile(x, lo)), ',', rt(quantile(x, hi)),']', sep  = '')
}

library(magrittr)
dStats <- lapply(dir(patt = 'bb.dstat.sorted'), read.csv)
names(dStats) <- dir(patt = 'bb.dstat.sorted')
names(dStats) <- gsub('bb.dstat.sorted_|_full.csv', '', names(dStats))
for(i in seq(length(dStats))) {
  dStats[[i]]$p <-
    lapply(dStats[[i]]$Z, function(x) {
      out <- pnorm(-sapply(x, abs)) * 2
      out <- p.adjust(out, 'holm')
      return(out)
  })
}

out <- data.frame(
  numTests = sapply(dStats, dim)[1, ],
  p = sapply(dStats, function(x) mean_quantile(x$p)),
  Z = sapply(dStats, function(x) mean_quantile(x$Z))
)

write.csv(out, '../OUT/dStats_test_summary.csv')
