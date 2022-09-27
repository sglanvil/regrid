#!/bin/bash
#PBS -N ERA5horiz 
#PBS -A CESM0021 
#PBS -l select=1:ncpus=1:mem=200GB
#PBS -l walltime=12:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

module load nco
module load ncl

echo ${ifile0}
ncl -Q ifile=${ifile0} /glade/work/sglanvil/CCR/regrid/ERA5horiz.ncl

exit
