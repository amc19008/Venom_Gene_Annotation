#!/bin/bash
#
#SBATCH --partition=general                # partition (queue)
#SBATCH -N 1                                # number of nodes
#SBATCH -J BLASTX                           # job name
#SBATCH -n 1                                # number of cores
#SBATCH --mem=1G                            # memory per node
#SBATCH -o /home/FCAM/acoello/scorpion/BLAST/%x_%A_%a.out # STDOUT with job array indices
#SBATCH -e /home/FCAM/acoello/scorpion/BLAST/%x_%A_%a.err # STDERR with job array indices
#SBATCH --qos=general                       # QoS
#SBATCH --array=0-40%10                     # array job with max 10 concurrent jobs (adjust the range 0-40 as needed)

module load blast

# Directory containing the FASTA files
FASTA_DIR="/home/FCAM/acoello/scorpion/BLAST/FASTAs"

# Create an array of fasta files
lst=($(ls $FASTA_DIR/*.fasta))

# Get the input file for this array job
input=${lst[$SLURM_ARRAY_TASK_ID]}

sampleID=$(cut -d"." -f1 <<< $input)       #

# Print the sample ID (for debugging purposes)
echo "Processing $sampleID"

# Run BLAST
tblastn -db /core/globus/cgi/RAMP/gene_fam/BLAST/Scorpiones_db -evalue 1e-20 \
 -outfmt "6 qseqid sseqid pident length evalue mismatch gapopen qstart qend sstart send qlen slen" \
 -query "$input" \
 -max_target_seqs 1 -num_threads 1 -out ${sampleID}-blastx.Scorpiones_db.out
