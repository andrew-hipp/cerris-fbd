library(openxlsx)
library(magrittr)
library(ape)
library(RADami)

read.meta <- TRUE

if(read.meta) {
  message('... reading metadata ...')
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2020-11-23.xlsx', 1)
}

fossilAge <- 'min' # exported once as min, once as max...
  ### ... still to do: runif (2018-10-20 note)
today <- format(Sys.time(), "%Y-%m-%d")
minInds <- 10 # minimum number of inds / locus
singleSpCol <- 'cerrisSingleSpV2' # old one was 'cerrisSingleSp'
# source('https://raw.githubusercontent.com/andrew-hipp/RADami/master/R/rad2nex.R')
dat.dating <- read.xlsx('../DATA/cerrisDating2.xlsx', 1)
dat.meta[[singleSpCol]] <- as.logical(dat.meta[[singleSpCol]])
dat.meta[[singleSpCol]][is.na(dat.meta[[singleSpCol]])] <- FALSE
message('... writing RADseq nexus matrix ...')
 radInds.cerrisDating <- dat.meta$fastQ.file.name[dat.meta[[singleSpCol]] %>% which]
 radLoc.cerrisTots <- apply(rads$radSummary$inds.mat[radInds.cerrisDating, ], 2, sum) %>% sort
 radLoc.cerris <- which(radLoc.cerrisTots >= minInds) %>% names
 radInds.cerrisNames <-
  paste(
    gsub(" | ssp. ", "_", make.unique(dat.meta$tipName[match(radInds.cerrisDating, dat.meta$fastQ.file.name)], sep = '_')),
    '0.0', sep = '_'
  )
 if(fossilAge == 'max') fossilAge.vector <- dat.dating$ageMax
 if(fossilAge == 'min') fossilAge.vector <- dat.dating$ageMin
 radInds.cerrisFossils <-
  paste(gsub(' ', '_', dat.dating$cleanLabel),
        fossilAge.vector,
        sep = '_')
 fileBase <- paste(
   '../../BEAST/', today, '/cerris.',
   today, '.',
   fossilAge,
   '.nex', sep = '')
 rad2nex(rad.mat, inds = radInds.cerrisDating,
         indNames = radInds.cerrisNames, fillBlanks = radInds.cerrisFossils,
         fillChar = '?',
         loci = radLoc.cerris,
         outfile = fileBase,
         logfile = paste(fileBase, 'log', sep = '.'),
         verbose = TRUE)
