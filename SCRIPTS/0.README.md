# Analyses for _Quercus_ sect. _Cerris_ FBD analyses
ahipp@mortonarb.org

## A. RAxML configuration scripts
These scripts begin with iPyrad output (described in the ms), read in using the `RADami` package.
* A.01 formats fasta files, writes them to the PHY.NEW folder, and write a batch file for analysis in RAxML. The batch file is written for my system (Andrew Hipp), so you may need to edit lines 37-42 in script A.01 to work with your system. But with a standard RAxML installation, you shouldn't need to.  
* A.02 reads the RAxML files in, relabels them using the metadata provided, and writes cleaned up trees to the OUT folder.

## B. BEAST2 configuration scripts
After you run this, you will need to configure the BEAST2 xml files in beauti.
Note that you also have to edit the NEXUS file that is exported so that it has the correct number of characters. That's a bother, and I apologize.
Read in the nexus file provided, configure thus:

Save that XML file, copy it twice, and substitute into each of the three duplicate
xml files the exported beast age blocks.

## C. Tree reading and post-phylogeny analysis scripts
This script prunes BEAST2 trees down to extant species only and prints both the original FBD summary tree (from `treeannotator`) and the pruned tree, post FBD. You have to run `BEAST2`, `logcombiner`, and `treeannotator` on your own and save files thus prior to running:
* '../BEAST.FILES/comboRuns.noBurn.annotated_r1.tre'
* '../BEAST.FILES/comboRuns.noBurn.annotated_r2.tre'
* '../BEAST.FILES/comboRuns.noBurn.annotated_r3.tre'
