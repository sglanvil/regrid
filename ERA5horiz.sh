#!/bin/bash
#PBS -N regrid_horiz
#PBS -A CESM0021 
#PBS -l select=1:ncpus=1:mem=100GB
#PBS -l walltime=00:10:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

module load nco
module load ncl

ncl -Q 'ifile="'$ifile0'"' 'idate="'$idate0'"' /glade/work/sglanvil/CCR/regrid/ERA5horiz.ncl

exit

