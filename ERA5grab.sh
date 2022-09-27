#!/bin/bash
#PBS -N ERA5grab 
#PBS -A CESM0021 
#PBS -l select=1:ncpus=1:mem=200GB
#PBS -l walltime=12:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

# get all variables (single timestamp 6-hrly data) into separate files 

cd /glade/scratch/sglanvil/ERA5regridded/
module load nco
module load ncl

dir_pl=/gpfs/fs1/collections/rda/data/ds633.0/e5.oper.an.pl/$iyear$imonth/ # one file per day (hourly data)
dir_sfc=/gpfs/fs1/collections/rda/data/ds633.0/e5.oper.an.sfc/$iyear$imonth/ # one file per month (hourly data)

for ifile in $dir_pl/*_u.*.nc; do
        date=`echo $ifile | rev | cut -c 4-24 | rev`
        iday=`echo $ifile | rev | cut -c 6-7 | rev`
        echo $date
        Ufile=`ls $dir_pl/*_u.*$date.nc`
        Vfile=`ls $dir_pl/*_v.*$date.nc`
        Tfile=`ls $dir_pl/*_t.*$date.nc`
        Qfile=`ls $dir_pl/*_q.*$date.nc`
        PSfile=`ls $dir_sfc/*_sp.*.nc`
        for ihour in 0 6 12 18; do
                ihourPS=$(((10#$iday-1)*24+10#$ihour))
                ihourOUT=$(printf "%05d" $((10#$ihour*3600)))
                echo $ihour $ihourPS $ihourOUT
                rm ERA5_$iyear-$imonth-$iday-$ihourOUT.nc 2> /dev/null
                
                ncks -O -d time,$ihour $Ufile Uout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -O -d time,$ihour $Vfile Vout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -O -d time,$ihour $Tfile Tout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -O -d time,$ihour $Qfile Qout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -O -d time,$ihourPS $PSfile PSout_$iyear-$imonth-$iday-$ihourOUT.nc # NOTE: PS is a monthly file

                ncks -A Uout_$iyear-$imonth-$iday-$ihourOUT.nc Vout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -A Vout_$iyear-$imonth-$iday-$ihourOUT.nc Tout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -A Tout_$iyear-$imonth-$iday-$ihourOUT.nc Qout_$iyear-$imonth-$iday-$ihourOUT.nc
                ncks -A Qout_$iyear-$imonth-$iday-$ihourOUT.nc PSout_$iyear-$imonth-$iday-$ihourOUT.nc

                ncrename -v SP,PS PSout_$iyear-$imonth-$iday-$ihourOUT.nc # rename SP to PS
                mv PSout_$iyear-$imonth-$iday-$ihourOUT.nc ERA5_$iyear-$imonth-$iday-$ihourOUT.nc
        done
done

exit

