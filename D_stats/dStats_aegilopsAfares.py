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

# Q. afares hybrid origins test constraints:
#  p4 - Aegilops oaks as outgroups - Q. macrolepis, Q. brantii, Q. ithaburensis
#  p3 - Q. cerris potential introgressor 1
#  p2 - Q. afares potential introgressor 2
#  p1 - Q. libana 628 - Q. trojana 585

bb.generate_tests_from_tree(
    constraint_dict={
        "p4": ["OAK-MOR-659.fq.barcodeStripped","OAK-MOR-662.fq.barcodeStripped", "OAK-MOR-1055", "OAK-MOR-735.fq.barcodeStripped","OAK-MOR-599.fq.barcodeStripped"],
        "p3": ["OAK-MOR-591.fq.barcodeStripped","OAK-MOR-736.fq.barcodeStripped", "OAK-MOR-1061", "OAK-MOR-1060", "OAK-MOR-729.fq.barcodeStripped", "OAK-MOR-728.fq.barcodeStripped"],
        "p2": ["OAK-MOR-983"],
        "p1": ["OAKS-MOR-585", "OAK-MOR-628.fq.barcodeStripped"]
    })

bb.run(ipyclient)

out_aegilopsAfares = bb.results_table.sort_values(by="Z", ascending=False)
taxa_aegilopsAfares = bb.taxon_table.iloc[out_aegilopsAfares.index]

out_aegilopsAfares.to_csv('bb.dstat.sorted_aegilopsAfares_full.csv', sep = ',')
taxa_aegilopsAfares.to_csv('bb.dstat.taxa_aegilopsAfares_full.csv', sep = ',')
