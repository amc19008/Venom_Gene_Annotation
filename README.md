# Venom_Gene_Annotation
This workflow for venom gene annotation uses venome gland (in this case telson) transcriptomes, a venom database (ToxCodAn_Genome), and BLAST for venom gene annotation. Original Python script (getSeq.py) credit goes to Dr Abbey Hayes. 

# Tutorial using scorpions and ToxCodAn DB
## Before begining ensure you have conda and blast installed:
To download it, if you don'tt have it:

    conda create -n blast -c bioconda -c conda-forge blast

To ensure it worked:

    blastn -version

## Step 1. Indexing

    wget https://raw.githubusercontent.com/pedronachtigall/ToxCodAn-Genome/main/Databases/Scorpiones_db.fasta
*

        conda activate blast 
*

        makeblastdb -in Scorpiones_db.fasta -parse_seqids -input_type fasta -dbtype nucl -out Scorpiones_db
This should make 10 db files ending in .nog, .nin, etc... 

## Step 2. Import off NCBI, git, or move .fasta files from a specialized direcory right into working directory
You can import your own assembled transcriptomes to the working directory, or browse for transcriptomes here: 

    https://www.ncbi.nlm.nih.gov/Traces/wgs/?page=1&view=tsa 

For this example we will use a combination of the two types (diy and ncbi) for two scorpion species (Chaerilus stockmannorum and Tityus serrulatus), in both nucleotide and amino acid formats. 
        (You can also import one or all of these from the '/fastas' folder on this git to follow along using wget and the raw URL:
        
                wget https://raw.githubusercontent.com/amc19008/Venom_Gene_Annotation/refs/heads/main/Fastas/T_serru_aa_dl.fasta])

Three of these are NCBI downloads, renamed:

    mv GKVP01.1.fsa_nt C_stock_nt_dl.fasta.gz
    mv GEUW01.1.fsa_aa T_serru_aa_dl.fasta
    mv GEUW01.1.fsa_nt T_serru_nt_dl.fasta 
Total telson fasta files in the working dir now (if you downloaded all. You can choose a single one, or multiple):

        C_stock_nt_dl.fasta
        C_stock_telson_ORP_centroids.fasta
        Scorpiones_db.fasta
        T_serru_aa_dl.fasta
        T_serru_nt_dl.fasta
        Tserrulatus_withid_withid_centroids.fasta
        
## Step 3. BLASTing one fasta sample:
### Use the correct script, according to fasta type. For amino acid ones, use BLASTI_tblastn_Scorpiones_db.sh
For example: 

    bash BLASTI_tblastn_Scorpiones_db.sh T_serru_aa_dl.fasta

The file that results will be renamed according to the file sample name and type of Blast run:

    T_serru_aa_dl.fasta.tblastn.Scorpiones_db.out
This file will have 13 columns that correspond with the following:

    qseqid sseqid pident length evalue mismatch gapopen qstart qend sstart send qlen slen

## Step 3b. BLASTing several fasta samples:
### If any fasta files are gzipped, unzip them first:

    gunzip C_stock_nt_dl.fasta.gz
Then, you can download the BLASTI_tblastx_multi script. Remember: Edit according to what data types you want to run 

    wget https://raw.githubusercontent.com/amc19008/Venom_Gene_Annotation/refs/heads/main/Scripts/BLASTI_tblastx_multi.sh
Next we can try this using nucleotide fastas in a new directory, copying over relevant files:

    mkdir nt_multi
*

        mv C_stock_nt_dl.fasta nt_multi
        mv T_serru_nt_dl.fasta nt_multi
*

        cp BLASTI_tblastx_array.sh nt_multi
*

        cd nt_multi
Edit the lines in the BLASTI_tblastx_multi script leading to the directory your fastas and databases are in:

    ...
    # Directory containing the FASTA files
    FASTA_DIR="/path/to/nt_multi"
    ...
    # Run BLAST
    tblastn -db /path/to/Scorpiones_db -evalue 1e-20 \
And finally, BLAST:

    bash BLASTI_tblastx_multi.sh
This will result in 2 output files in this case, ending with "-tblastx.Scorpiones_db.out":

    C_stock_nt_dl-tblastx.Scorpiones_db.out
    T_serru_nt_dl-tblastx.Scorpiones_db.out

## Step 4. Python script to retrieve the sequences for one
### You will need to first download the getSeq.py script from this git: 

    wget https://raw.githubusercontent.com/amc19008/Venom_Gene_Annotation/refs/heads/main/Scripts/getSeq.py 

Next, you need the BLASTII_py_for_one.sh script from this git:

    wget https://raw.githubusercontent.com/amc19008/Venom_Gene_Annotation/refs/heads/main/Scripts/BLASTII_py_for_one.sh
You also need to create a list.txt file that contains the names of the samples you intend to use:

    T_serru_aa_dl

Next you need a Column1.txt file that contains the contents of column 1 from your out file:

    awk '{print $1}' T_serru_aa_dl.fasta.tblastn.Scorpiones_db.out > T_serru_aa_dl_Column1.txt

Ensure you rename with the same naming format as the sample files. The resulting file contents will contain the sseqids which look like this:

    Scorpiones_Toxin_141_NDBS
    Scorpiones_Toxin_142_NDBS
    Scorpiones_Toxin_156_VMPA
    Scorpiones_Toxin_156_VMPA
    Scorpiones_Toxin_157_HYAL
    Scorpiones_Toxin_727_HYAL
    ...
Now you have the three parts you need to run the BLASTII_py_for_one.sh script. If you don't have biopython, you can download it before running:

    pip install biopython
You can check it installed properly by checking for the version:

        python -c "import Bio; print(Bio.__version__)"
To run the script, ensure that the proper paths to your Column1 and fasta file are substituted in the BLASTII_py_for_one.sh:

    ...
    file="/path/to/Column1file/${line}_Column1.txt" #This is now the list of files
    Fasta="/path/to/fastafile/T_serru_aa_dl.fasta"
    ...
And simply bash:

    bash BLASTII_py_for_one.sh
The output file will be called Toxin_output.fasta and look like this:

    >JAW06970.1 putative potassium channel toxin [Tityus serrulatus]
    MHSSVFILILFSLAVINPIFFDMKVEAGCMKEYCAGQCRGKVSQDYCLKHCKCIPRFI
    >JAW06971.1 putative sodium channel toxin [Tityus serrulatus]
    MNYFILLVVVCLLTAGTEGKKDGYPVEYDNCAYICWNYDNAYCDKLCKDKKADSGYCYWV
    HILCYCYGLPDSEPTKTNGKCKSGKK
    >JAW06972.1 putative metalloproteinase, partial [Tityus serrulatus]
    IPGHEKYVHYSKLTRNLGDYYCKKNEGLAKDADIIMLTTDRSLADISREGKLIADVAGGA
    ....

## Step 4b. Python script to retrieve the sequences for many fastas
### Working again with the data and directory (nt_multi) from 3b, we can apply similar steps as if we were running one fasta. 
First, download the BLASTII_py_for_all.sh 

    wget https://raw.githubusercontent.com/amc19008/Venom_Gene_Annotation/refs/heads/main/Scripts/BLASTII_py_for_all.sh
Ensure the getSeq.py file is also present in this directory:

    cp ../getSeq.py .
Next, use the awk command to create a Column1 file for each fasta

    awk '{print $1}' C_stock_nt_dl-tblastx.Scorpiones_db.out > C_stock_nt_dl_Column1.txt
    awk '{print $1}' T_serru_nt_dl-tblastx.Scorpiones_db.out > T_serru_nt_dl_Column1.txt
And create a new_list.txt with your sample names (without .fasta):

    C_stock_nt_dl
    T_serru_nt_dl
To run the script, ensure that the proper paths to your Column1 and fasta file are substituted in the BLASTII_py_for_all.sh:

    ...
    file="/path/to/nt_multi/${line}_Column1.txt" #This is now the list of files
    Fasta="/path/to/nt_multi/${line}.fasta"
Finally, bash the BLASTII_py_for_all script

    bash BLASTII_py_for_all.sh 
The resulting file will be called Multi_Toxin_output.fasta

## Remember:
### What BLAST you use depends on the fasta file you are using and the database, as well. Simply copy and edit the blast command in the BLASTI scripts to reflect which combinations are occuring. 
In the above tutorial, the ToxCodAn-Genome Scopriones_db uses a nucleotide fasta. If the venom gland fasta files are amino acids use tblastn, if they are nucleotides, use tblastx or blastn. 
### Alternately,
If you are using another kind of database that uses amino acids, you can use blastp with amino acid venom gland fastas, and blastx with nucleotide ones. 
