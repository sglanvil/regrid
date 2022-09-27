load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

fil = addfile(ifile,"r")
fout = "/glade/scratch/sglanvil/ERA5regridded/ERA5horiz_"+idate+".nc"
weightsFile="/glade/work/sglanvil/CCR/regrid/weights_ERA5.nc"

system("/bin/rm -f " + fout)   ; remove any pre-existing file
ncdf = addfile(fout ,"c")  ; open output netCDF file
fAtt               = True            ; assign file attributes
fAtt@title         = "FPIT analysis, interpolated to CESM horizontal grid, Glanville"
fAtt@Conventions   = "None"
fAtt@creation_date = systemfunc ("date")
fileattdef( ncdf, fAtt )            ; copy file attributes
filedimdef(ncdf,"time",-1,True)

PS:=fil->PS
U:=fil->U
V:=fil->V
T:=fil->T
Q:=fil->Q
PS:=ESMF_regrid_with_weights(PS,weightsFile,False)
U:=ESMF_regrid_with_weights(U,weightsFile,False)
V:=ESMF_regrid_with_weights(V,weightsFile,False)
T:=ESMF_regrid_with_weights(T,weightsFile,False)
Q:=ESMF_regrid_with_weights(Q,weightsFile,False)
ncdf->PS=PS
ncdf->U=U
ncdf->V=V
ncdf->T=T
ncdf->Q=Q

end
