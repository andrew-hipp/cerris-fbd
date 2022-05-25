## check what values of p3 are implicated in introgression
library(openxlsx)
library(magrittr)
source('r_functions.R')

if(!exists('dat.meta')) {
  dat.meta <- read.xlsx('../DATA/oakAccessions_cerrisRevision_2021-08-06.xlsx')
  dat.meta$LABEL_taxonOnly <- as.character(dat.meta$LABEL_taxonOnly)
  dat.meta$"Cleaned_NAMES-USE-THIS" <- as.character(dat.meta$"Cleaned_NAMES-USE-THIS")
  dat.meta$tipName <- ifelse(is.na(dat.meta$"Cleaned_NAMES-USE-THIS"),
                       dat.meta$LABEL_taxonOnly,
                       dat.meta$"Cleaned_NAMES-USE-THIS")
                     }

inds = list(
  cerrisAfares = c("OAK-MOR-591.fq.barcodeStripped","OAK-MOR-736.fq.barcodeStripped","OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped","OAK-MOR-728.fq.barcodeStripped"),
  cerrisCrenata = c("OAK-MOR-736.fq.barcodeStripped", "OAK-MOR-591.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-1060", "OAK-MOR-1061"),
  crenata_v_crenata = c("OAK-MOR-659.fq.barcodeStripped","OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped","OAK-MOR-599.fq.barcodeStripped", "OAK-MOR-191", "OAK-MOR-983",  "OAK-MOR-628.fq.barcodeStripped", "OAKS-MOR-585", "OAK-MOR-727.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped", "OAK-MOR-1040", "OAK-MOR-591.fq.barcodeStripped", "OAK-MOR-736.fq.barcodeStripped"),
  libaniCrenata = c("OAK-MOR-191", "OAK-MOR-983",  "OAK-MOR-628.fq.barcodeStripped", "OAKS-MOR-585"),
  aegilopsCrenata = c("OAK-MOR-659.fq.barcodeStripped", "OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped", "OAK-MOR-599.fq.barcodeStripped"),
  suberIlex = c("OAK-MOR-589.fq.barcodeStripped", "OAK-MOR-980", "OAK-MOR-1146")
) # close list
sets <- names(inds)

dat.taxa <- lapply(sets, function(x) read.csv(paste('bb.dstat.taxa_', x, '_full.csv', sep = '')))
dat.stat <- lapply(sets, function(x) read.csv(paste('bb.dstat.sorted_', x, '_full.csv', sep = '')))
names(dat.stat) <- names(dat.taxa) <- sets

out.tab <- matrix('', 0, 7, dimnames = list(NULL, c('test', 'individual', 'n', 'D', 'Z', 'p', 'sign. level')))

for(i in sets) {
  message(paste('doing', i))
  out <- list(
    D = lapply(inds[[i]], function(x) {dat.stat[[i]]$dstat[grep(x, dat.taxa[[i]]$p3)]}),
    Z = lapply(inds[[i]], function(x) {dat.stat[[i]]$Z[grep(x, dat.taxa[[i]]$p3)]})
  )
  out$p <- lapply(out$Z, z2holm)

  names(out$D) <- names(out$Z) <- names(out$p) <- styleIt(inds[[i]], style='simple')

  pdf(paste('../OUT/P3boxplot_', i, '.pdf', sep = ''), 8.5, 11)
  layout(matrix(1:3, 3))
  boxplot(out$D, cex.axis = 0.5, main = 'D-statistic')
  boxplot(out$Z, cex.axis = 0.5, main = 'Z')
  boxplot(out$p, cex.axis = 0.5, main = 'p-value (Holm-Bonferroni corrected)', ylim = c(0, 0.2))
  abline(h = 0.01, lty = 'dashed')
  dev.off()

  names(out$D) <- names(out$Z) <- names(out$p) <- styleIt(inds[[i]], style='full')
  for(j in names(out$D)) {
    temp <- c(i, j,  length(out$D[[j]]), mq(out$D[[j]]), mq(out$Z[[j]]), mq(out$p[[j]]), '')
    if(mean(out$p[[j]]) <= 0.01) temp[6] = '*'
    if(mean(out$p[[j]]) <= 0.001) temp[6] = '**'
    if(mean(out$p[[j]]) <= 0.0001) temp[6] = '***'
    out.tab <- rbind(out.tab, temp)
    rm(temp)
  } # close j
  out.tab <- rbind(out.tab, rep('-', dim(out.tab[2]))) # add empty lines
}

row.names(out.tab) <- NULL
write.csv(out.tab, '../OUT/P3summaries.csv')
