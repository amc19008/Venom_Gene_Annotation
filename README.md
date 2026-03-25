# Venom_Gene_Annotation
This workflow for venom gene annotation uses venome gland transcriptomes, a venom database, and BLAST for venom gene annotation. Original Python script credit goes to Dr Abbey Hayes. 

Before begining ensure you have conda and blast installed
  conda create -n blast -c bioconda -c conda-forge blast
To ensure it worked:
  blastn -version

Step 1. Indexing
