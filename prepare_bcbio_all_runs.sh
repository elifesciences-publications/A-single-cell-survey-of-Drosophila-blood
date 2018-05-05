project_dir="$PWD"
project_name="$(basename $PWD)"
echo "$project_name"

# Lanepool the inDrop FASTQ files for each run
cd data-raw/fastq/

# Run 1
run1="170201_NB501807_0021_AHWCYVBGXY"
cat ${run1}/Undetermined_S0_L00[1-4]_R1_001.fastq.gz > ${run1}_R1.fastq.gz
cat ${run1}/Undetermined_S0_L00[1-4]_R2_001.fastq.gz > ${run1}_R2.fastq.gz
cat ${run1}/Undetermined_S0_L00[1-4]_R3_001.fastq.gz > ${run1}_R3.fastq.gz
cat ${run1}/Undetermined_S0_L00[1-4]_R4_001.fastq.gz > ${run1}_R4.fastq.gz

# Run 2
run2="170620_NB501673_0150_AH2W2CBGX3"
cat ${run2}/Undetermined_S0_L00[1-4]_R1_001.fastq.gz > ${run2}_R1.fastq.gz
cat ${run2}/Undetermined_S0_L00[1-4]_R2_001.fastq.gz > ${run2}_R2.fastq.gz
cat ${run2}/Undetermined_S0_L00[1-4]_R3_001.fastq.gz > ${run2}_R3.fastq.gz
cat ${run2}/Undetermined_S0_L00[1-4]_R4_001.fastq.gz > ${run2}_R4.fastq.gz

# [Run 3 is in a separate script]

# Set up scratch directory
cd ~/scratch
mkdir "$project_name"
cd "$project_name"/

# Copy configuration files
cp $project_dir/indrop_rnaseq.csv $project_dir/indrop_rnaseq.yaml .

# Configure bcbio
bcbio_nextgen.py -w template $project_dir/indrop_rnaseq.yaml $project_dir/indrop_rnaseq.csv $project_dir/data-raw/fastq/*.fastq.gz
# There should be 8 files (10/2/17)

# Fix the run1_index_revcomp and run2_index_revcomp settings in the YAML config


# Set up the work directory and start the run
cd surecell_rnaseq/work
cp "$project_dir"/submit_bcbio.sh .
sbatch submit_bcbio.sh
squeue -u mjs65
