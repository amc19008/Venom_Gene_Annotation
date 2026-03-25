This directory contains blast database for Scorpiones:
-- Scorpiones_db -- toxin gene set from ToxCodAn, about 2,244 transcripts

Before BLASTing:
Ensure that the .fasta, Column1.txt, list.txt, etc files necessary are in the BLAST/ directory.
The relevant *.err and *.out files should be moved into the /outfiles directory

BLAST part I:
There are two *.sh files for the first part of BLAST, where the transcript file/s are BLASTed against the db
These take only one argument:
        sbatch BLASTI_tblastn_Scorpiones_db.sh <fasta file here>.fasta
or
        sbatch BLASTI_tblastn_Scorpiones_db_array.sh
or
        sbatch BLASTI_blastn_Scorpiones_db.sh
                (If you are using a nucleotide fasta)
The submit files will result in a blast output file in a tab delimited format with no headers. Columns are as follows,
for parsing:
                qseqid sseqid pident length evalue mismatch gapopen qstart qend sstart send qlen slen
___
BLAST part II:
Use final_py_all.sh to retrieve the hits/sequences from first BLAST out file, using the sequence ID.
If working, it will output a temp fasta file named <HeaderID>.<GeneName>.temp.fasta with the matching sequence, then
 this outputs a file called Toxin_output.fasta
You could run one or many taxa, depending on the list you give it, as it contains the python script within it:
        sbatch BLASTII_py_for_one.sh
        sbatch BLASTII_py_for_all.sh
Make sure that the list in the script matches the list you are intending to use, containing the tax/a/on you wish to us$        new_list1.txt
        new_list1.txt
        new_list.txt
Also make sure .fasta files and Column1.txt files are in the directory
___
Important files:
        -getSeq.py = The python script to run the second part of BLAST, sequence recovery
        -aa_toxin_sequences.fasta = contains some calcins, etc seq Carlos sent, proteins
        -nt_toxin_sequences.fasta = contains some calcins, etc seq Carlos sent, nucleotides

Directories:
-diamond_blast = diamond db for Scorpiones_db
-FASTAs = I moved all .fasta files containing transcripts (protein) here after use
-outfiles = Place for all relevant .out files

Disclaimer: some names involve "blastx" but this is an artifact of misnaming in an initial step, these are all tblastn, not tblastx
