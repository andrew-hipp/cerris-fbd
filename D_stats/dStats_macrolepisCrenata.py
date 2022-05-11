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

# Q. libani et al - Q. crenata test constraints:
#  p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
#  p3 - Q. macrolepis, Q. brantii, Q. ithaburensis potential introgressor 1
#  p2 - Q. crenata potential introgressor 2
#  p1 - Q. suber as sister species to Q. crenata

bb.generate_tests_from_tree(
    constraint_dict={
        "p4": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
        "p3": ["OAK-MOR-659.fq.barcodeStripped", "OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped", "OAK-MOR-599.fq.barcodeStripped"],
        "p2": ["OAK-MOR-593.fq.barcodeStripped", "OAK-MOR-986"],
        "p1": ["OAK-MOR-985", "OAK-MOR-1144", "OAK-MOR-588.fq.barcodeStripped"]
    })

bb.run(ipyclient)

out_macrolepisCrenata = bb.results_table.sort_values(by="Z", ascending=False)
taxa_macrolepisCrenata = bb.taxon_table.iloc[out_macrolepisCrenata.index]

out_macrolepisCrenata.to_csv('bb.dstat.sorted_macrolepisCrenata_full.csv', sep = ',')
taxa_macrolepisCrenata.to_csv('bb.dstat.taxa_macrolepisCrenata_full.csv', sep = ',')
