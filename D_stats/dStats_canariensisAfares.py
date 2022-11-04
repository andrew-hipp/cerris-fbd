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

locifile = '../DATA/oaksall_v1_2.m15.loci'
newick = '../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax'

# bb = ipa.baba(data = locifile, newick = newick)
bb = ipa.baba(data = locifile)

# Q. afares hybrid origin with suber test constraints:
#  p4 - Notholithocarpus as outgroup
#  p3 - Q. canariensis potential introgressor 1
#  p2 - Q. afares potential introgressor 2
#  p1 - Q. libani [sister to Q. afares]
#### ORIG, but failed to make any constraints:  p1 - undefined --- anyone who fits the topology

bb.tests = [
    {"p4": ["PM_F7"],
    "p3": ["OAK-MOR-534"],
    "p2": ["OAK-MOR-983"],
    "p1": ["OAK-MOR-191"]}
    ]


# bb.generate_tests_from_tree(
#     constraint_dict={
#         "p4": ["PM_F7"],
#         "p3": ["OAK-MOR-534"],
#         "p2": ["OAK-MOR-983"],
#         "p1": ["OAK-MOR-191"]
#     })

bb.run(ipyclient)

out_canariensisAfares = bb.results_table.sort_values(by="Z", ascending=False)
taxa_canariensisAfares = bb.taxon_table.iloc[out_canariensisAfares.index]

out_canariensisAfares.to_csv('bb.dstat.sorted_canariensisAfares_full.csv', sep = ',')
taxa_canariensisAfares.to_csv('bb.dstat.taxa_canariensisAfares_full.csv', sep = ',')
