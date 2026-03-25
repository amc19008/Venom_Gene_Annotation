#!/bin/bash

for file in /home/FCAM/acoello/scorpion/BLAST/combined_H_ariz_toxin_sequences.fasta.tblastn.Scorpiones_db.out; do
    # Extract the first column and save it with the new filename
    awk '{print $1}' "$file" > "H_arizonensis_telson_centroids-blastx.Scorpiones_db_Column1.txt"
done


