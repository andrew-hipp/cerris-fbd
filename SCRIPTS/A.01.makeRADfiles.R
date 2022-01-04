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
