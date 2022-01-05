library(openxlsx)
library(magrittr)
library(ape)
library(RADami)

read.meta <- TRUE
today <- format(Sys.time(), "%Y-%m-%d")
minInds <- 10 # minimum number of inds / locus
singleSpCol <- 'cerrisSingleSpV2' # old one was 'cerrisSingleSp'

if(read.meta) {
  message('... reading metadata ...')
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2021-08-06.xlsx', 1)
  dat.meta$LABEL_taxonOnly <- as.character(dat.meta$LABEL_taxonOnly)
	dat.meta$"Cleaned_NAMES-USE-THIS" <- as.character(dat.meta$"Cleaned_NAMES-USE-THIS")
	dat.meta$tipName <- ifelse(is.na(dat.meta$"Cleaned_NAMES-USE-THIS"),
		                   dat.meta$LABEL_taxonOnly,
		                   dat.meta$"Cleaned_NAMES-USE-THIS")
}

dat.dating <-
  read.xlsx('../DATA/Cerris_dating3_Dec2021.xlsx', sheet = 'beast.table')
dates.mat <-
  apply(dat.dating[c('min', 'max')], 1, function(x) runif(3, x[1], x[2])) %>%
  t %>% round(2)
dimnames(dates.mat) <- list(dat.dating$analysisName, c('r1', 'r2', 'r3'))

dat.meta[[singleSpCol]] <- as.logical(dat.meta[[singleSpCol]])
dat.meta[[singleSpCol]][is.na(dat.meta[[singleSpCol]])] <- FALSE

message('... writing RADseq nexus matrix and agesBlocks...')
radInds.cerrisDating <- dat.meta$fastQ.file.name[dat.meta[[singleSpCol]] %>% which]
radLoc.cerrisTots <- apply(rads$radSummary$inds.mat[radInds.cerrisDating, ], 2, sum) %>% sort
radLoc.cerris <- which(radLoc.cerrisTots >= minInds) %>% names
radInds.cerrisNames <-
  gsub(" | ssp. ", "_",
    make.unique(
      dat.meta$tipName[match(radInds.cerrisDating, dat.meta$fastQ.file.name)], sep = '_'
    ) # close make.unique
  ) # close gsub

dates.mat <-
  rbind(dates.mat, matrix(
    0, length(radInds.cerrisNames), 3, dimnames = list(radInds.cerrisNames, NULL)
  )) # close rbind
write.csv(dates.mat, '../OUT/beastDatesMat.csv')

for(i in colnames(dates.mat)) {
  temp <- paste(row.names(dates.mat), '=', dates.mat[, i], ',', sep = '')
  temp[length(temp)] <- gsub(',', '', temp[length(temp)], fixed = T)
  writeLines(temp, paste('../OUT/agesBlock', i, 'txt', sep = '.'))
} # close for loop
rm(temp)

fileBase <- paste('../BEAST.FILES/cerris.', today, '.r0.nex', sep = '')

rad2nex(rad.mat, inds = radInds.cerrisDating,
       indNames = radInds.cerrisNames, fillBlanks = dat.dating$analysisName,
       fillChar = '?',
       loci = radLoc.cerris,
       outfile = fileBase,
       logfile = paste(fileBase, 'log', sep = '.'),
       verbose = TRUE)
