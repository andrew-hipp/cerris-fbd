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

# Q. crenata593 vs 986 test constraints:
#  p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
#  p3 - Q. libani, Q. trojana, or Q. afares potential introgressor 1
#  p2 - Q. crenata potential introgressor 2
#  p1 - Q. suber as sister species to Q. crenata

bb.generate_tests_from_tree(
    constraint_dict={
        "p4": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
        "p3": ["OAK-MOR-659.fq.barcodeStripped","OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped","OAK-MOR-599.fq.barcodeStripped", "OAK-MOR-191", "OAK-MOR-983",  "OAK-MOR-628.fq.barcodeStripped", "OAKS-MOR-585", "OAK-MOR-727.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped", "OAK-MOR-1040", "OAK-MOR-591.fq.barcodeStripped", "OAK-MOR-736.fq.barcodeStripped"],
        "p2": ["OAK-MOR-593.fq.barcodeStripped"],
        "p1": ["OAK-MOR-986"]
    })

bb.run(ipyclient)

out_crenataVsCrenata = bb.results_table.sort_values(by="Z", ascending=False)
taxa_crenataVsCrenata = bb.taxon_table.iloc[out_crenataVsCrenata.index]

out_crenataVsCrenata.to_csv('bb.dstat.sorted_crenataVsCrenata_full.csv', sep = ',')
taxa_crenataVsCrenata.to_csv('bb.dstat.taxa_crenataVsCrenata_full.csv', sep = ',')
