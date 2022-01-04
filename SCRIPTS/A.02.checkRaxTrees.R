## reading global oaks data

library(ape)
library(magrittr)
library(openxlsx)
library(phytools)

source('https://raw.githubusercontent.com/andrew-hipp/morton/master/R/label.elements.R')

read.tr <- TRUE
read.meta <- TRUE
make.singletons <- TRUE
#fig.fileName <- 'tr.trial.v7-gtr.tre.export-withDeletions.pdf'
#fig.nPages <- 8
fig.tip.cex <- 0.7
fig.node.cex <- 0.5
fig.delim <- ' | '
tr.dir <- '../PHY.NEW/'
OG <- 'densifl' # rooting with Notholithocarpus
singleSpCol <- 'cerrisSingleSpV2' # old one was 'cerrisSingleSp'

if(read.tr) {
  message('... reading trees ...')
  tr.files <- dir(tr.dir, patt = 'bipartitions.cerris')
  tr.orig <- lapply(tr.files, function(x) read.tree(paste(tr.dir, x, sep = '')))
  names(tr.orig) <- gsub('RAxML_bipartitions.', '', tr.files, fixed = T)
} else message('** DID NOT READ A NEW TREE; used tree in workspace **')

if(read.meta) {
  message('... reading metadata ...')
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2020-11-23.xlsx', 1)
} else message('** DID NOT READ NEW METADATA; used metadata in workspace **')

#tr$tip.label <- label.elements(tr, '.', fixed = T)

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
	tr[[i]] <- root(tr[[i]], grep(OG, tr[[i]]$tip.label, value = T)) %>% ladderize

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

	message('... plotting tree to file ...')
	pdf(paste('../OUT/', i, '.pdf', sep = ''), 8.5, 11)
	plot(tr[[i]], cex = fig.tip.cex, show.node.label = FALSE)
	nodelabels(text= tr[[i]]$node.label,
             node = seq(length(tr[[i]]$node.label)) +
                    length(tr[[i]]$tip.label),
              cex = fig.node.cex, frame="n", adj = c(1.5,-0.5)
            ) # close nodelabels
	dev.off()

  if(make.singletons) {
    pdf(paste('../OUT/singletons', i, 'pdf', sep = '.'), 8.5, 11)
  	plot(tr.singletons[[i]], cex = fig.tip.cex, show.node.label = FALSE)
  	nodelabels(text= tr.singletons[[i]]$node.label,
               node = seq(length(tr.singletons[[i]]$node.label)) +
                      length(tr.singletons[[i]]$tip.label),
                cex = fig.node.cex, frame="n", adj = c(1.5,-0.5)
              ) # close nodelabels
  	dev.off()

  }
} # close i
