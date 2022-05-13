## check what values of p3 are implicated in introgression
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

for(i in sets) {
  message(paste('doing', i))
  out <- list(
    D = lapply(inds[[i]], function(x) {dat.stat[[i]]$dstat[grep(x, dat.taxa[[i]]$p3)]}),
    Z = lapply(inds[[i]], function(x) {dat.stat[[i]]$Z[grep(x, dat.taxa[[i]]$p3)]})
  )
  out$p <- lapply(out$Z, function(x) {
    out <- pnorm(-sapply(x, abs)) * 2
    out <- p.adjust(out, 'holm')
    return(out)
  })

  names(out$D) <- names(out$Z) <- names(out$p) <-
    strsplit(inds[[i]], '.', fixed = T) %>% sapply(FUN = '[', 1) %>%
    gsub(pattern = "OAK-MOR-|OAKS-MOR-", replacement = "")

  pdf(paste('../OUT/P3boxplot_', i, '.pdf', sep = ''), 8.5, 11)
  layout(matrix(1:3, 3))
  boxplot(out$D, cex.axis = 0.5, main = 'D-statistic')
  boxplot(out$Z, cex.axis = 0.5, main = 'Z')
  boxplot(out$p, cex.axis = 0.5, main = 'p-value (Holm-Bonferroni corrected)', ylim = c(0, 0.25))
  abline(h = 0.01, lty = 'dashed')
  dev.off()
}
