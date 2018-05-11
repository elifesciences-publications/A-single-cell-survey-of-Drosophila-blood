cd ~/scratch
mkdir -p flyblood_runs_2_3_combined
cd flyblood_runs_2_3_combined

consult_dir="/n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq"
bcbio_config_dir=$consult_dir/bcbio_config/runs_2_3_combined_2018-01-25

# Link the configuration files
ln -s "$bcbio_config_dir"/indrop_rnaseq.csv .
ln -s "$bcbio_config_dir"/indrop_rnaseq-template.yaml indrop_rnaseq.yaml

# Copy the FASTQs to the scratch disk
mkdir -p fastq/
cp $consult_dir/data-raw/run2/fastq/*.fastq.gz \
    $consult_dir/data-raw/run3/fastq/*.fastq.gz \
    fastq/.
ls -lh fastq/
# total 52G
# -rw-rw-r-- 1 mjs65 bcbio  17G Jan 25 11:10 170620_NB501673_0150_AH2W2CBGX3_R1.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 4.0G Jan 25 11:10 170620_NB501673_0150_AH2W2CBGX3_R2.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 3.4G Jan 25 11:11 170620_NB501673_0150_AH2W2CBGX3_R3.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 5.4G Jan 25 11:12 170620_NB501673_0150_AH2W2CBGX3_R4.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio  13G Jan 25 11:14 171219_NB501673_0219_AH3NT7BGX5_R1.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 3.1G Jan 25 11:14 171219_NB501673_0219_AH3NT7BGX5_R2.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 2.8G Jan 25 11:15 171219_NB501673_0219_AH3NT7BGX5_R3.fastq.gz
# -rw-rw-r-- 1 mjs65 bcbio 4.1G Jan 25 11:16 171219_NB501673_0219_AH3NT7BGX5_R4.fastq.gz
    
# Configure bcbio
bcbio_nextgen.py -w template indrop_rnaseq.yaml indrop_rnaseq.csv fastq/

cd indrop_rnaseq/config

# Edit the sample barcodes (revcomp) in the YAML config manually for runs 2
# and 3, since they are multiplexed. Just have to do this for each file.

vi /n/scratch2/mjs65/flyblood_runs_2_3_combined/indrop_rnaseq/config/indrop_rnaseq.yaml
# Copy this modified configuration back to the consult directory
cp indrop_rnaseq/config/indrop_rnaseq.yaml $bcbio_config_dir/.

# Run 2: /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/meta/run2/sample_barcodes_revcomp.txt
# 5 samples
# TCTTACGC
# CTTAATAG
# ATAGCCTT
# TAAGGCTC
# TCGCATAA
#
# Run 3:
# 4 samples
# CTTAATAG
# ATAGCCTT
# TAAGGCTC
# TCGCATAA

cd indrop_rnaseq/work

# Copy the slurm sbatch script
cp $consult_dir/scripts/submit_bcbio.sh .
less submit_bcbio.sh
sbatch submit_bcbio.sh
