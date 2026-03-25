#!/bin/bash

for file in /home/FCAM/acoello/scorpion/BLAST/*.out; do
  awk '{print $2}' "$file"            # Print the first column
done > all_sseqid_column.txt
