#!/bin/bash

#For use with multiple nuclotide fastas 
# Directory containing the FASTA files
FASTA_DIR="/Path/to/nt_multi"

# Loop through every fasta file in the directory
for input in "$FASTA_DIR"/*.fasta; do

    # Strip the path and extension to get the sampleID
    # This uses 'basename' to ensure the output file doesn't 
    # try to write back into the input directory unless you want it to.
    filename=$(basename "$input")
    sampleID="${filename%.*}"

    # Print the sample ID (for debugging purposes)
    echo "Processing $sampleID from $input"

    # Run BLAST
    tblastx -db /Path/to/Scorpiones_db -evalue 1e-20 \
     -outfmt "6 qseqid sseqid pident length evalue mismatch gapopen qstart qend sstart send qlen slen" \
     -query "$input" \
     -max_target_seqs 1 -num_threads 1 -out "${sampleID}-tblastx.Scorpiones_db.out"

done

echo "All jobs complete!"
