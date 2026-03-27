#!/bin/bash

while read line
        do
        file="/path/to/nt_multi/${line}_Column1.txt" #This is now the list of files
        Fasta="/path/to/nt_multi/${line}.fasta"
#Step 2: Make a list of battle types to be analyzed
#Reads the input file one line at a time
#pulls colony type (e.g., AB), by cutting (cut) at commas (-d ,) and keeping the first field (-f1)
#pulls caste type following similar principles......
#directs output to a new file: temp3-$colonies-$castes.txt (note that this will overwrite any previous file by that name)
while read line
        do
                SeqID=$(echo "$line" | cut -d . -f1)
                geneName="temp"
        python getSeq.py $Fasta $SeqID $geneName  

        wait
        
     done <$file
cat *.temp.fasta >> Multi_Toxin_output.fasta
rm *.temp.fasta

done <new_list.txt
