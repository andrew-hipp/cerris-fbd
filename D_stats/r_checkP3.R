## check what values of p3 are implicated in introgression
inds = c(
  "OAK-MOR-591.fq.barcodeStripped","OAK-MOR-736.fq.barcodeStripped",
  "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped",
  "OAK-MOR-728.fq.barcodeStripped")

dat.taxa <- read.csv('bb.dstat.taxa_aegilopsAfares_full.csv')
dat.stat <- read.csv('bb.dstat.sorted_aegilopsAfares_full.csv')

out <- list(
  D = lapply(inds, function(x) {dat.stat$dstat[grep(x, dat.taxa$p3)]}),
  Z = lapply(inds, function(x) {dat.stat$dstat[grep(x, dat.taxa$Z)]})
)
names(out$D) <- names(out$Z) <-
  strsplit(inds, '.', fixed = T) %>% sapply(FUN = '[', 1)

pdf('../OUT/dstat_aegilopsAfares.boxPlot.pdf', 8.5, 11)
matrix(1:2, 2)
boxplot(out$D, cex.axis = 0.5, main = 'D-statistic')
boxplot(out$Z, cex.axis = 0.5, main = 'Z')
dev.off()
