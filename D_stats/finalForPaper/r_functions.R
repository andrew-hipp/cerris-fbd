# unique r functions for this project -- updating

roundTo = 3 # how many digits to round to

styleIt = function(x, dat = dat.meta, style = c('simple', 'full'),
            fullCols = c('tipName', 'P', 'label.noDots')) {
  sampleNum <-
    strsplit(x, '.', fixed = T) %>% sapply(FUN = '[', 1) %>%
    gsub(pattern = "OAK-MOR-|OAKS-MOR-", replacement = "")
  if(style[1] == 'simple') out <- sampleNum %>% as.character
  if(style[1] == 'full') {
    rows <- match(x, dat$fastQ.file.name)
    out <- apply(dat[rows, fullCols], 1, paste, collapse = '|') %>% as.character
  }
  return(out)
} # numbers or taxa for labels

rt <- function(x, figs = roundTo) round(x, figs)

mean_quantile <- mq <-
  function(x, lo = 0.025, hi = 0.975) {
    paste(rt(mean(x)), ' [', rt(quantile(x, lo)), ',', rt(quantile(x, hi)),']', sep  = '')
  }

z2holm <- function(z) {
  out <- pnorm(-sapply(z, abs)) * 2
  out <- p.adjust(out, 'holm')
  return(out)
}
