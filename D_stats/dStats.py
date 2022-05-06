# executes d-stats in ipyrad

import ipyrad.analysis as ipa
import ipyparallel as ipp
import toytree
import toyplot

# Before running, execute:
# `ipcluster start -n 40 --cluster-id="baba" --daemonize`
# ... replacing `-n 40` with the number of cores you want to use.
ipyclient = ipp.Client(cluster_id="baba")

locifile = '../DATA/oaksall_v1_2.m15.loci.gz'
newick = '../PHY.NEW/RAxML_bestTree.cerris.2022-01-04.m15.rax'

bb = ipa.baba(data = locifile, newick = newick)

# Q. suber - Q. ilex test constraints:
#  p4 - sect. Cyclobalanopsis og
#  p3 - Q. ilex potential introgressor 1
#  p2 - Q. suber potential introgressor 2

bb.generate_tests_from_tree(
    constraint_dict={
        # "p4": ["DM5", "DM20", "DM18", "DM56"],
        "p4": ["DM5"],
        # "p3": ["OAK-MOR-589.fq.barcodeStripped", "OAK-MOR-980", "OAK-MOR-1146"],
        "p3": ["OAK-MOR-589.fq.barcodeStripped"],
        # "p2": ["OAK-MOR-1144", "OAK-MOR-588.fq.barcodeStripped", "OAK-MOR-985"]
        "p2": ["OAK-MOR-1144"]
    })
