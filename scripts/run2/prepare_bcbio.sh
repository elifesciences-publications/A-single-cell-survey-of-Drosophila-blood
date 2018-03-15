# Demultiplex the Illumina run
cd /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/run2/data-raw/n/scratch2/bpf/170620_NB501673_0150_AH2W2CBGX3
cp SampleSheet_FC003003_1234_PF_mm1.csv SampleSheet.csv
module load seq/bcl2fastq/2.17.1.14
bcl2fastq --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0



# Prepare transcriptome FASTA
cd /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/run2
mkdir annotations
cd annotations
# Prepare transcriptome
seqcloud fasta dmelanogaster cdna
cat dmel-all-transcript-r6.16.fasta egfp.fasta gal4.fasta > transcriptome_plus_transgenes.fasta
# Check to make sure cat worked
tail transcriptome_plus_transgenes.fasta



# Set up run on scratch disk
cd ~/scratch
mkdir blood_scrnaseq
cd blood_scrnaseq
mkdir fastq
cd fastq
cp /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/run2/data-raw/n/scratch2/bpf/170620_NB501673_0150_AH2W2CBGX3/Data/Intensities/BaseCalls/*.fastq.gz .
chmod 664 *.fastq.gz
cd ../



# Lanepool the FASTQ files
cat *_L00[1-4]_R1_001.fastq.gz > lanepool_R1.fastq.gz
cat *_L00[1-4]_R2_001.fastq.gz > lanepool_R2.fastq.gz
cat *_L00[1-4]_R3_001.fastq.gz > lanepool_R3.fastq.gz
cat *_L00[1-4]_R4_001.fastq.gz > lanepool_R4.fastq.gz
cd ../



# Configure bcbio
bcbio_nextgen.py -w template indrop_rnaseq.yaml indrop_rnaseq.csv fastq/lanepool_*.fastq.gz



# Rerun 2017-10-13
