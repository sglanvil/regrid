#!/bin/bash
#PBS -N downloadNCEP 
#PBS -A CESM0020 
#PBS -l select=1:ncpus=1:mem=10GB
#PBS -l walltime=02:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe
#PBS -M sglanvil@ucar.edu

# location of this file: /glade/work/ssfcst/realtimeNew

for iday in {01..31}; do # yes, 31 for every month; it works; see break below
        echo ${iday}
        destDir=/glade/derecho/scratch/ssfcst/analyses_NCEP_094.0_CDAS/cdas1.${iyear}${imonth}${iday}.pgrbh.tar_file_dir/
        if [ ! -e /glade/campaign/collections/rda/data/ds094.0/${iyear}/cdas1.${iyear}${imonth}${iday}.pgrbh.tar ]; then
                break
        fi
        mkdir -p ${destDir}
        cd ${destDir}
        tar -xvf /glade/campaign/collections/rda/data/ds094.0/${iyear}/cdas1.${iyear}${imonth}${iday}.pgrbh.tar cdas1.t00z.pgrbhanl.grib2
done

exit
