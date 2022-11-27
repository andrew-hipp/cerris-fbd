# executes d-stats in ipyrad

import ipyrad.analysis as ipa
import ipyparallel as ipp
import toytree
import toyplot

# Before running, execute:
# `ipcluster start -n 40 --cluster-id="baba" --daemonize`
# ... replacing `-n 40` with the number of cores you want to use.
# this is already done in doitall.sh
ipyclient = ipp.Client(cluster_id="baba")

locifile = '../DATA/cerrisdstat.loci'
newick = '../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax'

bb = ipa.baba(data = locifile, newick = newick)

# partitionedD - cerris Q. crenata test constraints:
#  p5 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
#  p3_1 = p4 - varies (see below)
#  p3_2 = p3 - varies (see below)
#  p2 - Q. crenata potential introgressor 2
#  p1 - Q. suber as sister species to Q. crenata

# tests:
#  0 : p4 = aegilops, p3 = libani et al
#  1 : p4 = aegilops, p3 = cerris et al
#  2 : p4 = libani et al, p3 = cerris et al

bb.tests = [
    {"p5": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
    "p4": ["OAK-MOR-659.fq.barcodeStripped","OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped","OAK-MOR-599.fq.barcodeStripped"],
    "p3": ["OAK-MOR-191", "OAK-MOR-983",  "OAK-MOR-628.fq.barcodeStripped", "OAKS-MOR-585"],
    "p2": ["OAK-MOR-593.fq.barcodeStripped", "OAK-MOR-986"],
    "p1": ["OAK-MOR-985", "OAK-MOR-1144", "OAK-MOR-588.fq.barcodeStripped"]
    },
    {"p5": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
    "p4": ["OAK-MOR-659.fq.barcodeStripped","OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped","OAK-MOR-599.fq.barcodeStripped"],
    "p3": ["OAK-MOR-727.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped", "OAK-MOR-1040", "OAK-MOR-591.fq.barcodeStripped", "OAK-MOR-736.fq.barcodeStripped"],
    "p2": ["OAK-MOR-593.fq.barcodeStripped", "OAK-MOR-986"],
    "p1": ["OAK-MOR-985", "OAK-MOR-1144", "OAK-MOR-588.fq.barcodeStripped"]
    },
    {"p5": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
    "p4": ["OAK-MOR-191", "OAK-MOR-983",  "OAK-MOR-628.fq.barcodeStripped", "OAKS-MOR-585"],
    "p3": ["OAK-MOR-727.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060","OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped", "OAK-MOR-1040", "OAK-MOR-591.fq.barcodeStripped", "OAK-MOR-736.fq.barcodeStripped"],
    "p2": ["OAK-MOR-593.fq.barcodeStripped", "OAK-MOR-986"],
    "p1": ["OAK-MOR-985", "OAK-MOR-1144", "OAK-MOR-588.fq.barcodeStripped"]
    }
]

bb.run(ipyclient)

out_partitionedCrenata = bb.results_table
taxa_partitionedCrenata = bb.taxon_table

out_partitionedCrenata.to_csv('dstat_partitionedCrenata_full.csv', sep = ',')
taxa_partitionedCrenata.to_csv('dstat_partitionedCrenata_taxa.csv', sep = ',')
