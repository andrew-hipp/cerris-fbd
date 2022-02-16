library(RADami)
library(openxlsx)
library(magrittr)

read.meta <- TRUE
today <- format(Sys.time(), '%Y-%m-%d')

if(!exists('rads')) {
  message('... reading RAD data ...')
  if(!'oaksall_v1_2.m15.loci' %in% dir('../DATA')) stop('Unzip locus file!')
  rads <- read.pyRAD('../DATA/oaksall_v1_2.m15.loci') # May require unzipping first!
  rad.mat <- rad2mat(rads)
}

if(read.meta) {
  message('... reading metadata ...')
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2021-08-06.xlsx', 1)
}

dat.inds <- dat.meta$fastQ.file.name[which(dat.meta$cerrisProject == 'cerris')] %>%
            na.omit

loc.m <- list(
  m15 = which(colSums(rads$radSummary$inds.mat[dat.inds, ]) >= 15) %>% names,
  m20 = which(colSums(rads$radSummary$inds.mat[dat.inds, ]) >= 20) %>% names,
  m25 = which(colSums(rads$radSummary$inds.mat[dat.inds, ]) >= 25) %>% names
)

cerris.sh <- character(0)
for(i in names(loc.m)) {
  message(paste('writing files for', i))
  rad2phy(rad.mat, dat.inds, loc.m[[i]],
          outfile = paste('../PHY.NEW/cerris', today, i, 'phy', sep = '.'),
          logfile = paste('../LOGFILES/cerris', today, i, 'log', sep = '.'))
  cerris.sh <- c(
    cerris.sh,
    paste(
      'raxmlHPC-PTHREADS-SSE3 -f a -T 7 -m GTRGAMMA -x 12345 -p 12345 -# 200 -s ',
      'cerris.', today, '.', i, '.phy ',
      '-n ', 'cerris.', today, '.', i, '.rax',
      sep = '')
    ) # close cerris.sh
  } # close i
writeLines(cerris.sh, paste('../PHY.NEW/cerris', today, 'sh', sep = '.'))

## summarize log files
loc.logs <- lapply(dir('../LOGFILES', patt = '.log', full = T), readLines)
names(loc.logs) <- dir('../LOGFILES', patt = '.log', full = F) %>%
  gsub(pattern = '.log|cerris.2022-01-04.', replacement = '')
loc.counts <-
  sapply(loc.logs, grep, pattern = 'locus') %>%
  sapply(FUN = length)
write.csv(loc.counts, '../LOGFILES/locus.counts.txt')

phy.counts <-
  sapply(dir('../PHY.NEW/', patt = '.phy', full = T), readLines, n = 1) %>%
  strsplit(split = ' ', fixed = T) %>%
  sapply(FUN = '[', 2)
names(phy.counts) <-
  gsub('../PHY.NEW/cerris.2022-01-04.|.phy', '', names(phy.counts))
write.csv(phy.counts, '../LOGFILES/nucleotide.counts.txt')

loc.cov <- sapply(c('m15', 'm20', 'm25'), function(x) {
  sum(rads$radSummary$inds.mat[dat.inds, loc.m[[x]]]) /
    prod(dim(rads$radSummary$inds.mat[dat.inds, loc.m[[x]]]))
  })
write.csv(loc.cov, '../LOGFILES/locus.coverage.txt')
