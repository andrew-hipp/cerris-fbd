# summarize tests conducted

rt <- function(x) round(x, 3) # how many digits to round to
mean_quantile <- function(x) paste(rt(mean(x)), ' [', rt(quantile(x, 0.025)), ',' rt(quantile(x, 0.975))']')

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
  numTests = sapply(dStats, dim, 1),
  p = sapply(dStats, function(x) mean_quantile(x$p)),
  Z = sapply(dStats, function(x) mean_quantile(Z$p))
)

write.csv(out, '../OUT/dStats_test_summary.csv')
