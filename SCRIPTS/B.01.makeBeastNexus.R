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

dat.dating <- read.xlsx('../DATA/Cerris_dating3_Dec2021.xlsx', sheet = 'beast.table')
dat.meta[[singleSpCol]] <- as.logical(dat.meta[[singleSpCol]])
dat.meta[[singleSpCol]][is.na(dat.meta[[singleSpCol]])] <- FALSE
message('... writing RADseq nexus matrix ...')
 radInds.cerrisDating <- dat.meta$fastQ.file.name[dat.meta[[singleSpCol]] %>% which]
 radLoc.cerrisTots <- apply(rads$radSummary$inds.mat[radInds.cerrisDating, ], 2, sum) %>% sort
 radLoc.cerris <- which(radLoc.cerrisTots >= minInds) %>% names
 radInds.cerrisNames <-
    gsub(" | ssp. ", "_",
      make.unique(
        dat.meta$tipName[match(radInds.cerrisDating, dat.meta$fastQ.file.name)], sep = '_'
      ) # close make.unique
    ) # close gsub
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
