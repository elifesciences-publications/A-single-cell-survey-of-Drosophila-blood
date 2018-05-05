# Ensure that BCL files have been demultiplexed, using bcl2fastq.sh script

run_id="171219_NB501673_0219_AH3NT7BGX5"
fastq_dir="$PWD/FC_03491/n/scratch2/bpf/171219_NB501673_0219_AH3NT7BGX5/Data/Intensities/BaseCalls/Project_tsudhirg"

# Copy the demultiplexed FASTQ files
cd /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/data-raw/run3
mkdir -p fastq
cd fastq
mkdir $run_id
cd $run_id
cp "$fastq_dir"/*.fastq.gz .
chmod 664 *.fastq.gz

cd ../

# Lanepool the FASTQ files
cat $run_id/*_L00[1-4]_R1_001.fastq.gz > ${run_id}_R1.fastq.gz
cat $run_id/*_L00[1-4]_R2_001.fastq.gz > ${run_id}_R2.fastq.gz
cat $run_id/*_L00[1-4]_R3_001.fastq.gz > ${run_id}_R3.fastq.gz
cat $run_id/*_L00[1-4]_R4_001.fastq.gz > ${run_id}_R4.fastq.gz

# Now it's safe to delete the extracted BCL data directory
cd ../
cd FC_03491
rm -rf n
cd ../

# Set up the run on the scratch disk
scratch_dir="/n/scratch2/mjs65/flyblood_run3"
mkdir -p "scratch_dir"
cd "$scratch_dir"

# Prepare and copy the required files to the scratch disk
cp /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/bcbio_config/run3_2018-01-09/* .
mv indrop_rnaseq-template.yaml indrop_rnaseq.yaml

# Configure bcbio
bcbio_nextgen.py -w template indrop_rnaseq.yaml indrop_rnaseq.csv /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/data-raw/run3/fastq/*.fastq.gz

cd indrop_rnaseq/work
cp /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/scripts/run3/submit_bcbio.sh .
chmod 775 *.sh
less submit_bcbio.sh

# Submit from the login node
sbatch submit_bcbio.sh
squeue -u $USER
