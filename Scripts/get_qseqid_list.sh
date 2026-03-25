#!/bin/bash

for file in /home/FCAM/acoello/scorpion/BLAST/qseq/*.out; do
  awk '{print $1}' "$file"            # Print the first column
done > all_qseqid_column.txt
