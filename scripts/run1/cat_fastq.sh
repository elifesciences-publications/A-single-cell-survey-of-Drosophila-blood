# Copy the demultiplexed FASTQ files generated from raw Illumina BCL
# InDrop v3: each FASTQ should contain `_R1` through `_R4`
cp --link "$illumina"/Data/Intensities/BaseCalls/*.fastq.gz .
cat *_R1_001.fastq.gz > combined_R1.fastq.gz
cat *_R2_001.fastq.gz > combined_R2.fastq.gz
cat *_R3_001.fastq.gz > combined_R3.fastq.gz
cat *_R4_001.fastq.gz > combined_R4.fastq.gz
rm *_R[1-4]_001.fastq.gz
