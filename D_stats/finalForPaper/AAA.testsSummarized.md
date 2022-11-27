---
title: D-statistic tests conducted for
author: Andrew Hipp, ahipp@mortonarb.org
update: 25 May 2022: main tests
update: 26 Nov 2022: tests reordered for clarity following numbering in paper
---

# Tests in main body of paper

## A1 -- cerris-crenata (n = 500): *Q. cerris* with *Q. crenata*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. cerris potential introgressor 1
-   p2 - Q. crenata potential introgressor 2
-   p1 - Q. suber as sister species to Q. crenata

Script: D_stats\dStats_cerrisCrenata.py

## A2 -- crenata-cerris (n = 2560): *Q. crenata* with *Q. cerris*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. crenata potential introgressor 1
-   p2 - Q. cerris potential introgressor 2
-   p1 - undefined --- anyone who fits the topology

Script: D_stats\dStats_crenataCerris.py

## B1 -- canariensis-afares (n = 16): *Q. canariensis* with *Q. afares*

-   p4 - Notholithocarpus as outgroup
-   p3 - Q. canariensis potential introgressor 1
-   p2 - Q. afares potential introgressor 2
-   p1 - Q. libani [sister to Q. afares]

Script: D_stats\dStats_canariensisAfares.py

## B2 -- suber - afares (n = 700): *Q. suber* with *Q. afares*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. suber potential introgressor 1
-   p2 - Q. afares potential introgressor 2
-   p1 - undefined --- anyone who fits the topology

Script: D_stats\dStats_suberAfares.py

## C1 -- Aegilops-crenata (n = 450 tests): introgression of subsect. *Aegilops* with *Q. crenata*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Aegilops oaks - Q. macrolepis, Q. brantii, Q. ithaburensis
    potential introgressor 1
-   p2 - Q. crenata potential introgressor 2
-   p1 - Q. suber as sister species to Q. crenata

Script: D_stats\dStats_aegilopsCrenata.py

## C2 -- crenata - afares (n = 280 tests): *Q. crenata* and *Q. afares*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. crenata potential introgressor 1
-   p2 - Q. afares potential introgressor 2
-   p1 - undefined --- anyone who fits the topology

Script: D_stats\dStats_crenataAfares.py

## C3 -- suber-cerris (n = 6400 tests): *Q. suber* and *Q. cerris*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. suber potential introgressor 1
-   p2 - Q. cerris potential introgressor 2
-   p1 - undefined --- anyone who fits the topology

Script: D_stats\dStats_suberCerris.py

## D -- Libani-crenata (n = 350): subsect. *Libani* with *Q. crenata*

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - Q. libani, Q. trojana, or Q. afares potential introgressor 1
-   p2 - Q. crenata potential introgressor 2
-   p1 - Q. suber as sister species to Q. crenata

Script: D_stats\finalForPaper\bb.dstat.taxa_libaniCrenata_full.csv

## E1 -- cerris-afares (n = 270): *Q. cerris* with *Q. afares*

-   p4 - Aegilops oaks as outgroups - Q. macrolepis, Q. brantii, Q.
    ithaburensis
-   p3 - Q. cerris potential introgressor 1
-   p2 - Q. afares potential introgressor 2
-   p1 - Q. libani 628 - Q. trojana 585

Script: D_stats\dStats_cerrisAfares.py

## E2 -- cerris-afares | libani (n = 90): *Q. cerris* with *Q. afares*, *Q. libani* as p1

  -   p4 - Aegilops oaks as outgroups - Q. macrolepis, Q. brantii, Q. ithaburensis
  -   p3 - Q. cerris potential introgressor 1
  -   p2 - Q. afares potential introgressor 2
  -   p1 - Q. libani 628

Script: D_stats\dStats_cerrisAfares_libani.py

## E3 -- cerris-afares | trojana (n = 90): *Q. cerris* with *Q. afares*, *Q. trojana* as p1

  -   p4 - Aegilops oaks as outgroups - Q. macrolepis, Q. brantii, Q. ithaburensis
  -   p3 - Q. cerris potential introgressor 1
  -   p2 - Q. afares potential introgressor 2
  -   p1 - Q. trojana 585

Script: D_stats\dStats_cerrisAfares_trojana.py

## E4 -- cerris-trojana (n = 90): *Q. cerris* with *Q. trojana*, *Q. libani* as p1

  -   p4 - Aegilops oaks as outgroups - Q. macrolepis, Q. brantii, Q. ithaburensis
  -   p3 - Q. cerris potential introgressor 1
  -   p2 - Q. trojana 585
  -   p1 - Q. libani 628

Script: D_stats\dStats_cerrisTrojana.py

## F -- suber-ilex (n = 6,240): *Q. suber* with *Q. ilex*

-   p4 - sect. Cyclobalanopsis og
-   p3 - Q. ilex potential introgressor 1
-   p2 - Q. suber potential introgressor 2
-   p1 - any species sister to p2 w/ respect in context of p4 and p3 used

Script: D_stats\dStats_suberIlex.py

# Tests discussed only in supplement
Two tests were excluded from the main paper for clarity. Results are present in the output files in this repository and discussed in supplemental data 1; tests performed are summarized here:

## Supplemental test 1 -- crenata vs. crenata (n = 165): all species potentially introgressing with *Q. crenata* as tested above with each of the *Q. crenata* individuals as sister species

Reported in Supplemental Table S6, as "Supplemental Test 1"

-   p4 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3 - sect. Aegilops, Q. cerris, and sect. Libani as possible introgressors
-   p2 - Q. crenata 593
-   p1 - Q. crenata 986

Script: D_stats\dStats_crenata_v_crenata.py

## Supplemental test 2 -- partitioned crenata (n = 3): 5-taxon (partitioned) *D*-statistic test

Reported in Supplemental Table S7 (only test reported in that table)

-   p5 - Q. chenii, Q. variabilis, and Q. acutissima as outgroups
-   p3_1 = p4 - varies (see below)
-   p3_2 = p3 - varies (see below)
-   p2 - Q. crenata potential introgressor 2
-   p1 - Q. suber as sister species to Q. crenata

**INDIVIDUALS USED**

-   Test 0 : p4 = aegilops, p3 = libani et al
    -   p5: OAK-MOR-982, OAK-MOR-981,
        OAK-MOR-578.fq.barcodeStripped
    -   p4:
        OAK-MOR-659.fq.barcodeStripped,OAK-MOR-662.fq.barcodeStripped,
        OAK-MOR-1055,
        OAK-MOR-735.fq.barcodeStripped,OAK-MOR-599.fq.barcodeStripped
    -   p3: OAK-MOR-191, OAK-MOR-983,
        OAK-MOR-628.fq.barcodeStripped, OAKS-MOR-585
    -   p2: OAK-MOR-593.fq.barcodeStripped,
        OAK-MOR-986,
    -   p1: OAK-MOR-985, OAK-MOR-1144,
        OAK-MOR-588.fq.barcodeStripped

-   Test 1 : p4 = aegilops, p3 = cerris et al

    -   p5: OAK-MOR-982, OAK-MOR-981,
        OAK-MOR-578.fq.barcodeStripped
    -   p4:
        OAK-MOR-659.fq.barcodeStripped,OAK-MOR-662.fq.barcodeStripped,
        OAK-MOR-1055,
        OAK-MOR-735.fq.barcodeStripped,OAK-MOR-599.fq.barcodeStripped
    -   p3: OAK-MOR-727.fq.barcodeStripped,
        OAK-MOR-1061, OAK-MOR-1060,
        OAK-MOR-729.fq.barcodeStripped,
        OAK-MOR-728.fq.barcodeStripped, OAK-MOR-1040,
        OAK-MOR-591.fq.barcodeStripped,
        OAK-MOR-736.fq.barcodeStripped
    -   p2: OAK-MOR-593.fq.barcodeStripped,
        OAK-MOR-986
    -   p1: OAK-MOR-985, OAK-MOR-1144,
        OAK-MOR-588.fq.barcodeStripped

-   Test 2 : p4 = libani et al, p3 = cerris et al
    -   p5: OAK-MOR-982, OAK-MOR-981,
        OAK-MOR-578.fq.barcodeStripped
    -   p4: OAK-MOR-191, OAK-MOR-983,
        OAK-MOR-628.fq.barcodeStripped, OAKS-MOR-585
    -   p3: OAK-MOR-727.fq.barcodeStripped,
        OAK-MOR-1061,
        OAK-MOR-1060,OAK-MOR-729.fq.barcodeStripped,
        OAK-MOR-728.fq.barcodeStripped, OAK-MOR-1040,
        OAK-MOR-591.fq.barcodeStripped,
        OAK-MOR-736.fq.barcodeStripped
    -   p2: OAK-MOR-593.fq.barcodeStripped,
        OAK-MOR-986
    -   p1: OAK-MOR-985, OAK-MOR-1144,
        OAK-MOR-588.fq.barcodeStripped

Script: D_stats\dStats_partitionedCrenata.py