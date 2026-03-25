#!/bin/bash
#SBATCH --job-name=new_try
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=asher.coello@uconn.edu
#SBATCH --mail-type=END
#SBATCH -o %x_%a.out
#SBATCH -e %x_%a.err  

module load biopython

while read line
	do
        file="/home/FCAM/acoello/scorpion/BLAST/$line-blastx.Scorpiones_db_Column1.txt" #This is now the list of files
        Fasta="/home/FCAM/acoello/scorpion/BLAST/$line.fasta"
#Step 2: Make a list of battle types to be analyzed
#Reads the input file one line at a time
#pulls colony type (e.g., AB), by cutting (cut) at commas (-d ,) and keeping the first field (-f1)
#pulls caste type following similar principles......
#directs output to a new file: temp3-$colonies-$castes.txt (note that this will overwrite any previous file by that name)
while read line
	do
		SeqID=$(echo "$line" | cut -d , -f1)
		geneName="temp"
        python getSeq.py $Fasta $SeqID $geneName  
		
        wait
        
     done <$file
cat *.temp.fasta >> Toxin_output.fasta
rm *.temp.fasta

done <new_list2.txt
