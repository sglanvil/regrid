#!/bin/bash
#PBS -N fake_12
#PBS -A CESM0021 
#PBS -l select=1:ncpus=1:mem=100GB
#PBS -l walltime=06:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

module load nco
srcDir=/glade/scratch/sglanvil/ERA5regridded/
climDir=/glade/scratch/sglanvil/ERA5regridded_clim/
destDir=/glade/scratch/sglanvil/ERA5regridded_clim_rep/ # see "Make fake files" sed command
mkdir -p $climDir
mkdir -p $destDir

# ---------------------------- SPECIFY imonth for "Calculate climatology" and "Make fake files" steps
#imonth=12

# ---------------------------- Calculate climatology (specify imonth above)
#for iday in {01..31}; do
#       echo ${imonth} ${iday}
#       for ihour in 00000 21600 43200 64800; do
#               ncrcat -O ${srcDir}ERA5vert_????-${imonth}-${iday}-${ihour}.nc ${climDir}ERA5vert_ALL-${imonth}-${iday}-${ihour}.nc
#               ncra -O -F -d time,1,,1 ${climDir}ERA5vert_ALL-${imonth}-${iday}-${ihour}.nc ${climDir}ERA5vert_CLIM-${imonth}-${iday}-${ihour}.nc
#               rm ${climDir}ERA5vert_ALL-${imonth}-${iday}-${ihour}.nc
#       done
#done

# ---------------------------- Make the 'fake' 1979-2020 files (repeat same climatology every year)
#for ifile in ${climDir}ERA5vert_CLIM-${imonth}-*; do
#       for iyear in {1979..2020}; do
#               echo ${iyear}
#               ifile_new=$(sed -e 's/CLIM/'${iyear}'/' <<< ${ifile} | sed -e 's/ERA5regridded_clim/ERA5regridded_clim_rep/')
#               echo ${ifile}
#               echo ${ifile_new}
#               cp ${ifile} ${ifile_new}
#       done
#done

# ---------------------------- Remove the extra Feb 29 values (made in the 'fake' files step)
# Leap Years = 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012, 2016, 2020
rm ${destDir}ERA5vert_1979-02-29-?????.nc

rm ${destDir}ERA5vert_1981-02-29-?????.nc
rm ${destDir}ERA5vert_1982-02-29-?????.nc
rm ${destDir}ERA5vert_1983-02-29-?????.nc

rm ${destDir}ERA5vert_1985-02-29-?????.nc
rm ${destDir}ERA5vert_1986-02-29-?????.nc
rm ${destDir}ERA5vert_1987-02-29-?????.nc

rm ${destDir}ERA5vert_1989-02-29-?????.nc
rm ${destDir}ERA5vert_1990-02-29-?????.nc
rm ${destDir}ERA5vert_1991-02-29-?????.nc

rm ${destDir}ERA5vert_1993-02-29-?????.nc
rm ${destDir}ERA5vert_1994-02-29-?????.nc
rm ${destDir}ERA5vert_1995-02-29-?????.nc

rm ${destDir}ERA5vert_1997-02-29-?????.nc
rm ${destDir}ERA5vert_1998-02-29-?????.nc
rm ${destDir}ERA5vert_1999-02-29-?????.nc

rm ${destDir}ERA5vert_2001-02-29-?????.nc
rm ${destDir}ERA5vert_2002-02-29-?????.nc
rm ${destDir}ERA5vert_2003-02-29-?????.nc

rm ${destDir}ERA5vert_2005-02-29-?????.nc
rm ${destDir}ERA5vert_2006-02-29-?????.nc
rm ${destDir}ERA5vert_2007-02-29-?????.nc

rm ${destDir}ERA5vert_2009-02-29-?????.nc
rm ${destDir}ERA5vert_2010-02-29-?????.nc
rm ${destDir}ERA5vert_2011-02-29-?????.nc

rm ${destDir}ERA5vert_2013-02-29-?????.nc
rm ${destDir}ERA5vert_2014-02-29-?????.nc
rm ${destDir}ERA5vert_2015-02-29-?????.nc

rm ${destDir}ERA5vert_2017-02-29-?????.nc
rm ${destDir}ERA5vert_2018-02-29-?????.nc
rm ${destDir}ERA5vert_2019-02-29-?????.nc

