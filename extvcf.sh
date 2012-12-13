#!/bin/bash
sed '1,14d' $1 | \
awk -F '\t' '\
{
printf("chr%s\t%s\t%s\t%s\t%s\t%s\n", $1, $2, int($2)+length($4), $4, $5, $8)
}'> ../results/${2}

intersectBed -f 0.5 -wa -u -a ../results/${2} -b ../DHS/publicDHS/human_union_s150_c10_modified.bed.trim > ../results/${2}.trimDHSunion
intersectBed -f 0.5 -wa -u -a ../results/${2} -b ../DHS/publicDHS/human_union_s150_c10_modified.bed > ../results/${2}.DHSunion
