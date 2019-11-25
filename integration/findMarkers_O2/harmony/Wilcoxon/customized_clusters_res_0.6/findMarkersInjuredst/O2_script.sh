#!/bin/bash

#SBATCH -p short             # partition name
#SBATCH -t 0-11:00              # hours:minutes runlimit after which job will be killed
#SBATCH --job-name Markers           # Job name
#SBATCH -o %j.out                       # File to which standard out will be written
#SBATCH -e %j.err               # File to which standard err will be written

module load gcc/6.2.0 R/3.5.1 hdf5/1.10.1



clusterFile="./all_data.Rda"
for resolution in  0.6 

do

outputDir="report_"${resolution}

sbatch -p short -t 0-11:00 -c 2 --mem 64G --job-name Markers --wrap="xvfb-run --server-args=\"-screen 0 1024x768x24 -noreset\" R -e \"rmarkdown::render('sc_wilcoxFindMarkers.Rmd', output_dir = '$outputDir')\" --args $resolution $clusterFile"

sleep 1 # wait 1 second between each job submission

done
