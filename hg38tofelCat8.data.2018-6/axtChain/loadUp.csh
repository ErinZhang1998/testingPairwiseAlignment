#!/bin/csh -efx
# This script was automatically generated by /home/xiaoyuz1/data/scripts/doBlastzChainNet.pl
# from /home/xiaoyuz1/data/genomes/DEF_hc
# It is to be executed on xiaoyuz1@lanec1.compbio.cs.cmu.edu in /home/xiaoyuz1/data/genomes/hg38tofelCat8.data.2018-6/axtChain .
# It loads the chain tables into hg38-chr17, adds gap/repeat stats to the .net file,
# and loads the net table.
# This script will fail if any of its commands fail.

cd /home/xiaoyuz1/data/genomes/hg38tofelCat8.data.2018-6/axtChain

# Load chains:
cd /home/xiaoyuz1/data/genomes/hg38tofelCat8.data.2018-6/axtChain
hgLoadChain -test -noBin -tIndex hg38-chr17 chainFelCat8-chrE1 hg38-chr17.felCat8-chrE1.all.chain.gz
wget -O bigChain.as 'http://genome-source.soe.ucsc.edu/gitweb/?p=kent.git;a=blob_plain;f=src/hg/lib/bigChain.as'
wget -O bigLink.as 'http://genome-source.soe.ucsc.edu/gitweb/?p=kent.git;a=blob_plain;f=src/hg/lib/bigLink.as'
sed 's/.000000//' chain.tab | awk 'BEGIN {OFS="\t"} {print $2, $4, $5, $11, 1000, $8, $3, $6, $7, $9, $10, $1}' > chainFelCat8-chrE1.tab
bedToBigBed -type=bed6+6 -as=bigChain.as -tab chainFelCat8-chrE1.tab /home/xiaoyuz1/data/genomes/hg38/hg38-chr17.chrom.sizes chainFelCat8-chrE1.bb
awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $5, $4}' link.tab | sort -k1,1 -k2,2n > chainFelCat8-chrE1Link.tab
bedToBigBed -type=bed4+1 -as=bigLink.as -tab chainFelCat8-chrE1Link.tab /home/xiaoyuz1/data/genomes/hg38/hg38-chr17.chrom.sizes chainFelCat8-chrE1Link.bb
set totalBases = `ave -col=2 /home/xiaoyuz1/data/genomes/hg38/hg38-chr17.chrom.sizes | grep "^total" | awk '{printf "%d", $2}'`
set basesCovered = `bedSingleCover.pl chainFelCat8-chrE1Link.tab | ave -col=4 stdin | grep "^total" | awk '{printf "%d", $2}'`
set percentCovered = `echo $basesCovered $totalBases | awk '{printf "%.3f", 100.0*$1/$2}'`
printf "%d bases of %d (%s%%) in intersection\n" "$basesCovered" "$totalBases" "$percentCovered" > ../fb.hg38-chr17.chain.FelCat8-chrE1Link.txt
rm -f link.tab
rm -f chain.tab
cp -p noClass.net hg38-chr17.felCat8-chrE1.net
netFilter -minGap=10 noClass.net \
  | hgLoadNet -test -noBin -warn -verbose=0 hg38-chr17 netFelCat8-chrE1 stdin
mv align.tab netFelCat8-chrE1.tab
