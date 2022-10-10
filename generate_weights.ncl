load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

in=addfile("/gpfs/fs1/collections/rda/data/ds633.0/e5.oper.an.pl/197901/e5.oper.an.pl.128_130_t.ll025sc.1979010100_1979010123.nc","r")
lat=in->latitude
lon=in->longitude
temp=in->T

out=addfile("/glade/scratch/nanr/SMYLE-ERA5-L83/inputdata/cesm2_init/b.e21.SMYLE_ERA5_L83_IC.f09_g17.1980-11.01/1980-11-01/b.e21.SMYLE_ERA5_L83_IC.f09_g17.1980-11.01.cam.i.1980-11-01-00000.nc","r")
destlat=out->lat
destlon=out->lon

Opt=True
Opt@WgtFileName="weights_ERA5.nc"
Opt@SrcGridLat=lat
Opt@SrcGridLon=lon
Opt@DstGridLat=destlat
Opt@DstGridLon=destlon
Opt@InterpMethod="patch"

t_regrid=ESMF_regrid(temp,Opt)
