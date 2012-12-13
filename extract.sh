#!/bin/bash

awk -F '\t' '\
{
printf("%s\t%s\n", $12,$9,$10,$6,$13)
} ' $1 | \
sed -e '1d' > output.bed
#sed -e '1d' -e 's/\(\d*\):\(\d*\)-\(\d*\)/\(1\)\t\(2\)\t\(3\)/g' > output.bed
