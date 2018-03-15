cd /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/data-raw/run3/FC_03491/n/scratch2/bpf/171219_NB501673_0219_AH3NT7BGX5
module load bcl2fastq/2.19.1.403
which bcl2fastq
cp SampleSheet_FC003491_1234_PF_mm1.csv SampleSheet.csv
bcl2fastq --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 > bcl2fastq.log
