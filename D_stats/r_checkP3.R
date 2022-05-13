## check what values of p3 are implicated in introgression
inds = c(
  "OAK-MOR-591.fq.barcodeStripped","OAK-MOR-736.fq.barcodeStripped",
  "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped",
  "OAK-MOR-728.fq.barcodeStripped")

dat.taxa <- read.csv('bb.dstat.taxa_aegilopsAfares_full.csv')
dat.stat <- read.csv('bb.dstat.sorted_aegilopsAfares_full.csv')

out <- lapply(inds, function(x) {
  dat.stat$dstat[grep(x, dat.taxa$p3)]
})
names(out) <- strsplit(inds, '.', fixed = T) %>% sapply(FUN = '[', 1)

pdf('../OUT/dstat_aegilopsAfares.boxPlot.pdf', 11, 8.5)
boxplot(out, cex.axis = 0.5)
dev.off()
