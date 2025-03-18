#!/bin/bash
#PBS -N downloadNCEP
#PBS -A CESM0020
#PBS -l select=1:ncpus=1:mem=10GB
#PBS -l walltime=01:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m e
#PBS -M sglanvil@ucar.edu

# location of this file: /glade/work/ssfcst/realtimeNew
# use splanl.gdas or pgbhnl.gdas

for ifile in /glade/campaign/collections/rda/data/ds093.0/${iyear}/splanl.gdas*; do
        imonth=$(basename "$ifile" | sed -E 's/.*([0-9]{4})([0-9]{2})([0-9]{2})-([0-9]{4})([0-9]{2})([0-9]{2})\.tar/\2/')
        first_day=$(basename "$ifile" | sed -E 's/.*([0-9]{4})([0-9]{2})([0-9]{2})-([0-9]{4})([0-9]{2})([0-9]{2})\.tar/\3/')
        second_day=$(basename "$ifile" | sed -E 's/.*([0-9]{4})([0-9]{2})([0-9]{2})-([0-9]{4})([0-9]{2})([0-9]{2})\.tar/\6/')
        echo $ifile
        echo $imonth
        echo $first_day
        echo $second_day
        for iday in $(seq -w $first_day $second_day); do
                destDir=/glade/derecho/scratch/ssfcst/analyses_NCEP_094.0_CDAS/cdas1.${iyear}${imonth}${iday}.pgrbh.tar_file_dir/
                echo ${destDir}
                mkdir -p ${destDir}
                cd ${destDir}
                tar -xvf $ifile --wildcards splanl.gdas.${iyear}${imonth}${iday}00.grb2
                #mv pgbhnl.gdas.${iyear}${imonth}${iday}00.grb2 cdas1.t00z.pgrbhanl.grib2
        done
        echo
done

exit
