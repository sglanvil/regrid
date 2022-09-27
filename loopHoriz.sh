# run on casper
set -e

iyear=1979
imonth=01

#for iyear in {1979..1980}; do
#       for imonth in {01..12}; do
                for ifile0 in /glade/scratch/sglanvil/ERA5regridded/ERA5_$iyear-$imonth-*.nc; do
                        idate0=`echo $ifile0 | rev | cut -c 4-19 | rev`
                        export ifile0
                        export idate0
                        qsub -v ifile0,idate0 /glade/work/sglanvil/CCR/regrid/ERA5horiz.sh
                done
#       done
#done


