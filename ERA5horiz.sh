#!/bin/bash
#PBS -N regrid_horiz
#PBS -A CESM0021 
#PBS -l select=1:ncpus=1:mem=100GB
#PBS -l walltime=12:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

iyear=2020

module load nco
module load ncl

for ifile0 in /glade/scratch/sglanvil/ERA5regridded/ERA5_$iyear*; do
        idate0=`echo $ifile0 | rev | cut -c 4-19 | rev`
        echo $idate0
        export ifile0
        export idate0
        ncl -Q 'ifile="'$ifile0'"' 'idate="'$idate0'"' /glade/work/sglanvil/CCR/regrid/ERA5horiz.ncl
done

exit
