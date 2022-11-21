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

# Q. afares hybrid origin with suber test constraints:
#  p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
#  p3 - Q. crenata potential introgressor 1
#  p2 - Q. cerris potential introgressor 2
#  p1 - undefined --- anyone who fits the topology

bb.generate_tests_from_tree(
    constraint_dict={
        "p4": ["OAK-MOR-982", "OAK-MOR-981", "OAK-MOR-578.fq.barcodeStripped"],
        "p3": ["OAK-MOR-593.fq.barcodeStripped", "OAK-MOR-986"],
        "p2": ["OAK-MOR-591.fq.barcodeStripped","OAK-MOR-736.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped"],
    })

bb.run(ipyclient)

out_crenataCerris = bb.results_table.sort_values(by="Z", ascending=False)
taxa_crenataCerris = bb.taxon_table.iloc[out_crenataCerris.index]

out_crenataCerris.to_csv('bb.dstat.sorted_crenataCerris_full.csv', sep = ',')
taxa_crenataCerris.to_csv('bb.dstat.taxa_crenataCerris_full.csv', sep = ',')
