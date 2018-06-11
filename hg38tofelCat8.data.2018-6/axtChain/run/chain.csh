#!/bin/csh -ef
zcat ../../pslParts/$1*.psl.gz \
| axtChain -psl -verbose=0 -scoreScheme=/home/xiaoyuz1/data/genomes/human_cat.v2.q   -linearGap=loose stdin \
    /home/xiaoyuz1/data/genomes/hg38/hg38-chr17.2bit \
    /home/xiaoyuz1/data/genomes/felCat8/felCat8-chrE1.2bit \
    stdout \
| chainAntiRepeat /home/xiaoyuz1/data/genomes/hg38/hg38-chr17.2bit \
    /home/xiaoyuz1/data/genomes/felCat8/felCat8-chrE1.2bit \
    stdin $2
