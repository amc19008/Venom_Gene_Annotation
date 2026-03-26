#!/bin/bash

SEQ=$1

tblastx -db Scorpiones_db -evalue 1e-20 \
 -outfmt "6 qseqid sseqid pident length evalue mismatch gapopen qstart qend sstart send qlen slen" -query $SEQ \
 -max_target_seqs 1 -num_threads 1 -out $SEQ\.tblastn.Scorpiones_db.out
 
