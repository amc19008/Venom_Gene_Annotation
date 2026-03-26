# Venom_Gene_Annotation
This workflow for venom gene annotation uses venome gland (in this case telson) transcriptomes, a venom database (ToxCodAn_Genome), and BLAST for venom gene annotation. Original Python script credit goes to Dr Abbey Hayes. 

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

For this example we will use a combination of the two types (diy and ncbi) for two scorpion species (Chaerilus stockmannorum and Tityus serrulatus), in both nucleotide and amino acid formats. (You can also import all of these from the '/fastas' folder on this git to follow along)

NCBI downloads renamed:

        mv GKVP01.1.fsa_nt C_stock_nt_dl.fasta
        mv GEUW01.1.fsa_aa T_serru_aa_dl.fasta
        mv GEUW01.1.fsa_nt T_serru_nt_dl.fasta 
Total telson fasta files in the working dir now:

        C_stock_nt_dl.fasta
        C_stock_telson_ORP_centroids.fasta
        Scorpiones_db.fasta
        T_serru_aa_dl.fasta
        T_serru_nt_dl.fasta
        Tserrulatus_withid_withid_centroids.fasta
        
## Step 3. To only process one sample:
###Use the correct script, according to fasta type. For amino acid ones, use BLASTI_tblastn_Scorpiones_db.sh
For example: 

        bash BLASTI_tblastn_Scorpiones_db.sh T_serru_aa_dl.fasta

