# Venom_Gene_Annotation
This workflow for venom gene annotation uses venome gland transcriptomes, a venom database, and BLAST for venom gene annotation. Original Python script credit goes to Dr Abbey Hayes. 

# Tutorial using scorpions and ToxCodAn DB
## Before begining ensure you have conda and blast installed:
    conda create -n blast -c bioconda -c conda-forge blast

To ensure it worked:

    blastn -version

## Step 1. Indexing

    wget https://raw.githubusercontent.com/pedronachtigall/ToxCodAn-Genome/main/Databases/Scorpiones_db.fasta

    conda activate blast 

    makeblastdb -in Scorpiones_db.fasta -parse_seqids -input_type fasta -dbtype nucl -out Scorpiones_db
This should make 10 db files ending in .nog, .nin, etc... 

## Step 2. Import off NCBI, git, or move .fasta files from a specialized direcory right into working directory
You can import your own assembled transcriptomes to the working directory, or browse for transcriptomes here: 

        https://www.ncbi.nlm.nih.gov/Traces/wgs/?page=1&view=tsa 

