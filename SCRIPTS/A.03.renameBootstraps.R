## renaming bootstrap trees

library(ape)
library(magrittr)
library(openxlsx)
library(phytools)

read.tr <- TRUE
read.meta <- TRUE
make.singletons <- TRUE
fig.tip.cex <- 0.7
fig.node.cex <- 0.5
fig.delim <- ' | '
OG <- 'densifl' # rooting with Notholithocarpus
singleSpCol <- 'cerrisSingleSpV2' # old one was 'cerrisSingleSp'

if(read.tr) {
  message('... reading trees ...')
  tr.orig <- read.tree('../PHY.NEW/RAxML_bootstrap.cerris.2022-01-04.m15.rax')
  class(tr.orig) <- 'list'
  names(tr.orig) <- paste('boot', seq(length(tr.orig)), sep = '_')
} else message('** DID NOT READ A NEW TREE; used tree in workspace **')

if(read.meta) {
  message('... reading metadata ...')
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2021-08-06.xlsx', 1)
} else message('** DID NOT READ NEW METADATA; used metadata in workspace **')

# assumes there are > 1 tree to work with; will fail otherwise
tr <- vector('list', length(tr.orig))
names(tr) <- names(tr.orig)
if(make.singletons) {
  tr.singletons <- tr.orig.singletons <- tr
  dat.meta[[singleSpCol]] <- as.logical(dat.meta[[singleSpCol]])
  dat.meta[[singleSpCol]][is.na(dat.meta[[singleSpCol]])] <- FALSE
}

for(i in names(tr.orig)) {
	tr[[i]] <- tr.orig[[i]] # keep tr.orig, so I can keep relabelling without rereading each time
	tip.drops <- which(tr[[i]]$tip.label %in% dat.meta$fastQ.file.name[!is.na(dat.meta$removeDat)])
	tips <- list(change = setdiff(which(tr[[i]]$tip.label %in% dat.meta$fastQ.file.name),
		                      tip.drops),
		     noChange = which(!tr[[i]]$tip.label %in% dat.meta$fastQ.file.name),
				       drops = tip.drops
		   )
	rm(tip.drops)
	dat.meta$LABEL_taxonOnly <- as.character(dat.meta$LABEL_taxonOnly)
	dat.meta$"Cleaned_NAMES-USE-THIS" <- as.character(dat.meta$"Cleaned_NAMES-USE-THIS")
	dat.meta$tipName <- ifelse(is.na(dat.meta$"Cleaned_NAMES-USE-THIS"),
		                   dat.meta$LABEL_taxonOnly,
		                   dat.meta$"Cleaned_NAMES-USE-THIS")

	tr[[i]]$tip.label[tips$change] <- apply(cbind(dat.meta[match(tr[[i]]$tip.label[tips$change],
		                                                dat.meta$fastQ.file.name),
		                                          c('tipName', 'OWNER', 'P','country')],
		                                 tr[[i]]$tip.label[tips$change]),
		                            1, paste, collapse = fig.delim)
	tr[[i]]$tip.label <- gsub('.gz|.fq|.barcodeStripped|.nameFixed|_2012.techRep', '', tr[[i]]$tip.label)
	tips <- lapply(tips, function(x) tr[[i]]$tip.label[x])
	tr[[i]] <- drop.tip(tr[[i]], c(tips$drops, tips$noChange))
	tr[[i]] <- root(tr[[i]], grep(OG, tr[[i]]$tip.label, value = T),
                  resolve.root = TRUE, edgelabel = TRUE) %>% ladderize

  if(make.singletons) {
    tips.temp <- tr[[i]]$tip.label %>%
      strsplit(split = ' | ', fixed = T) %>%
      sapply(FUN = tail, 1)
    tips.single <- which(tips.temp %in%
      gsub('.gz|.fq|.barcodeStripped|.nameFixed|_2012.techRep', '',
        dat.meta$fastQ.file.name[which(dat.meta[[singleSpCol]])])
      ) # close which
    tr.singletons[[i]] <-
      drop.tip(tr[[i]], tr[[i]]$tip.label[-c(tips.single)])
    rm(tips.single)
  } # close make.singletons
} # close i

message('... writing trees to file ...')
class(tr) <- class(tr.singletons) <- 'multiPhylo'
write.tree(tr, '../OUT/boots.m15.cleanedLabels.tre')
write.tree(tr.singletons, '../OUT/boots.singletons.m15.cleanedLabels.tre')
