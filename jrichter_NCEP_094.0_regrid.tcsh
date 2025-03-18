#!/bin/tcsh
#PBS -N regridNCEP 
#PBS -A CESM0020 
#PBS -l select=1:ncpus=1:mem=10GB
#PBS -l walltime=00:10:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m a
#PBS -M sglanvil@ucar.edu

# location of this file: /glade/work/ssfcst/realtimeNew

source /etc/profile.d/z00_modules.csh
source ~/.cshrc
module load ncl nco

echo "Running for YEAR=$YEAR, MONTH=$MONTH, DAY=$DAY"

setenv SCRATCH     /glade/derecho/scratch/ssfcst/
setenv WORK        /glade/work/ssfcst/
setenv CASE        CESM2_NCEP_0.9x1.25_L32
setenv MYTMPDIR    $SCRATCH/inputIC_NCEP_094.0_CDAS/$YEAR$MONTH$DAY/
setenv MYTMPDIRO   $SCRATCH/inputIC_NCEP_094.0_CDAS/$YEAR$MONTH$DAY/
setenv ARCHIVE_DIR /glade/derecho/scratch/ssfcst/atm_IC_daily_S2S/

rm -r $MYTMPDIR
rm -r $MYTMPDIRO
mkdir              -p $MYTMPDIR
mkdir              -p $MYTMPDIRO
mkdir              -p $ARCHIVE_DIR
cd                    $MYTMPDIRO
/bin/rm $MYTMPDIR/cdas1.*

/bin/cp -p $WORK/realtime/regrid_scripts/* .
WRAPIT MAKEIC.stub MAKEIC.f90

setenv FILES_MAX    1
setenv REF_DATE     19790101
echo "$YEAR"
echo "$MONTH"
echo "$DAY"
setenv HOUR           0
setenv HOUR_INC   86400
echo $YEAR  >! YY
echo $MONTH >! MM
echo $DAY   >! DD
echo $HOUR  >! HH
@ i     = 0
while($i < $FILES_MAX)
  @ i = $i + 1
  ./name_construct              $HOUR_INC
  setenv MYDATE                 `cat date`
  setenv DATE2                  `cat date2`
  setenv DATE3                  `cat date3`
  setenv DATE4                  `cat date4`
  setenv DATE5                  `cat date5`
  setenv DATE6                  `cat date6`
  setenv DATE7                  `cat date7`
  setenv DATE8                  `cat date8`
  setenv DATE9                  `cat date9`
  setenv DATE10                 `cat date10`
  setenv DATE11                 `cat date11`
  setenv DATE12                 `cat date12`
  setenv DATE13                 `cat date13`
  setenv DYCORE                  fv       # Dycore ("eul", "fv", or "se" are the current choices)
  setenv PRECISION            float       # "double" or "float" are the current choices of output precision
  setenv PTRM                    -1       # "M" spectral truncation (for "eul" dycore only; ignored for other dycores; "-1" = no trunc)
  setenv PTRN                    -1       # "N" spectral truncation (for "eul" dycore only; ignored for other dycores; "-1" = no trunc)
  setenv PTRK                    -1       # "K" spectral truncation (for "eul" dycore only; ignored for other dycores; "-1" = no trunc)
  setenv PLAT                   192       # Number of latitudes  on output IC file (ignored for unstructured grids)
  setenv PLON                   288       # Number of longitudes on output IC file (ignored for unstructured grids)
  setenv CAM_UNSTRUCT_NCOLS 3110402       # CAM-SE output resolution (1/8 deg; Ignored for lat/lon grids)
  setenv CAM_UNSTRUCT_NCOLS  777602       # CAM-SE output resolution (1/4 deg; Ignored for lat/lon grids)
  setenv CAM_UNSTRUCT_NCOLS  194402       # CAM-SE output resolution (1/2 deg; Ignored for lat/lon grids)
  setenv CAM_UNSTRUCT_NCOLS   48602       # CAM-SE output resolution (1   deg; Ignored for lat/lon grids)
  setenv PLEV                    32       # Number of vert levs on output IC file
                                          # (if PLEV = 0, no vertical dimension in output file)
  setenv BIN_FACTOR_SMOOTHING    64       # Smoothed by way of expanded bin boxes (> 1 ==> level of smoothing (typical range: 4-100))
  setenv BIN_FACTOR_SMOOTHING     1       # Smoothed by way of expanded bin boxes (= 1 ==> no smoothing)
  setenv BIN_FACTOR_SMOOTHING    -1       # Smoothed by way of expanded bin boxes (< 1 ==> automatic smoothing (recommended - only done
                                          # when regridding from coarse to fine grids))

# Full input file pathname  (disk or HPSS) from which to pull hyai, hybi, hyam, hybm info to define OUTPUT levels
setenv FNAME_lev_info           /glade/campaign/cesm/development/cross-wg/S2S/CESM2/CAMI/CFSv2/CESM2_NCEP_0.9x1.25_L32.cam2.i.2021-01-04-00000.nc

# Full input file pathnames (disk or HPSS) from which to pull fields to be regridded
  setenv FNAME0                 $SCRATCH/analyses_NCEP_094.0_CDAS/cdas1.${DATE2}.pgrbh.tar_file_dir/cdas1.t00z.pgrbhanl.grib2
  setenv FNAME1                 $WORK/realtime/regrid_scripts/PHIS_0.9x1.25_cam3_6_71.nc
  setenv FNAME2                 none
  setenv FNAME3                 none
  setenv FNAME4                 none
  setenv FNAME5                 none

# Regrid ALL fields from FNAME0, if it is a CAM file (otherwise, just regrid the fields listed below)
  setenv REGRID_ALL             False

# Time slice to pull from each file (YYYYMMDDSSSSS or time index (0, 1, 2, 3, etc.))
  setenv FDATE                  `cat date1`,0

# List of fields to be regridded (must contain, at minimum, U, V [or US and VS, if fv dycore], T, Q, and PS)
# PHIS from the native analysis and PHIS from the output grid must be read in to adjust the state variables based on
# topography differences.
  setenv FIELDS                 U,V,US,VS,T,Q,PS,PHIS_analysis,PHIS

# Input analysis file index in which each field can be found (0, 1, 2, 3, 4, or 5)
  setenv SOURCE_FILES           0,0,0,0,0,0,0,0,1

# Input file type (The "FTYPE" list maps to the above list of filenames)
  setenv FTYPE                  NCEP_094.0_CDAS,CAM # was NCEP_094.0_CDAS for 2011-2020

# Processing options
  setenv VORT_DIV_TO_UV         False     # U/V determined from vort/div input
  setenv OUTPUT_PHIS            True      # Copy output PHIS to the output initial file.
  setenv ATM_FILE_OUT           $CASE.cam2.i.$MYDATE.nc
  setenv FNAME                  $FNAME0,$FNAME1,$FNAME2,$FNAME3,$FNAME4,$FNAME5
  /bin/rm done
  ncl ./makeIC.ncl
  if ( !(-e done) ) goto end0

  /bin/mv $MYTMPDIRO/$ATM_FILE_OUT $ARCHIVE_DIR
  /bin/rm $MYTMPDIR/cdas1.*

end

end0:

exit
