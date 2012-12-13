#!/bin/bash
## author: qinqian
## Date:   2012.11.29
## cosmic data tidy workflow for hg19
## 1. Download from sanger.
## 2. convert tsv, csv to bed files in batch for newest coding,
#noncoding and fusion mutation data.
## 3. separate mutation data into coding, noncoding and fusion ones
## 4. intersect with DHS hg19 sites and output annotated mutation data


workdir=`pwd`

DataGet()
{
    # $1 for cosmic ftp root directory
    url=$1
    wget -c -np -nd -r $url # -b 
}

ConvertFormat()
{
    # convert tsv or csv files to BED files
    # $1 original csv file list
    removeEmp=`basename ${1}.tmp`
    sed '/^$/d' $1 > ../temp/$removeEmp
    ls ../temp/$removeEmp
    ./extractCosmic.py ../temp/$removeEmp
    # python -c ""
}

intersectDHS()
{
    # intersect with DHS sites provided by Huse
    # 1 DHS sites  # 2 Cosmic mutation BED files
    printf $1" is intersecting with "$2
    intersectBed -f 0.95 -wa -u -a $1 -b $2 > ../results/${2}.DHS

}

TrimDHS()
{
 awk -F '\t' -v percent=$1 '\
{
average=int(($2+$3)/2)
step=int(($3-$2)*(percent/200))
printf("%s\t%s\t%s\n", $1, average-step, average+step)
}' $2  > ${2}.trim
}

colonf()
{
    grep colon ../cosmic_data/data_export/CosmicMutantExportCensus_v61_260912.tsv | grep TCGA > $1
}

main()
{
    # update
    #DataGet ftp://ftp.sanger.ac.uk/pub/CGP/cosmic
    colonf ../results/colon_TCGA_cosmic.tsv

    # noncoding variants overlap with DHS sites
     csvlist=`ls ../cosmic_data/non_coding_variants/complete_non_coding_variants_v61_260912.csv`
     ConvertFormat $csvlist

    # trim DHS regions
    percent=10
    TrimDHS  $percent ../DHS/publicDHS/DHS_hg19.bed
    bash extvcf.sh ../cosmic_data/data_export/CosmicCodingMuts_v61_260912.vcf codingmutsvcf.bed

    # get DHS sites that overlapped with noncoding mutations sites
    intersectDHS ../DHS/publicDHS/DHS_hg19${percent}p.bed ../temp/cosmic_noncodingMut.txt
    # # noncoding with DHS union sites referred from Huse


    # coding mutations overlap with DHS sites

    # coding with DHS union sites referred from Huse

}

#main
