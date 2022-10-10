begin

fin = addfile(ifile,"r")
fout = "/glade/scratch/sglanvil/ERA5regridded/ERA5vert_"+idate+".nc"
flev=addfile("/glade/work/sglanvil/CCR/regrid/b.e21.SMYLE_ERA5_L83_IC.f09_g17.1980-11.01.cam.i.1980-11-01-00000.nc","r")

U=fin->U
V=fin->V
T=fin->T
Q=fin->Q
time=fin->time
lon=fin->lon
lat=fin->lat
plev=fin->level*100                     ; [Pa units]
PS=fin->PS                              ; [Pa units]
p0=100000                               ; [Pa units]

lev=flev->lev
ilev=flev->ilev
hyam=flev->hyam
hybm=flev->hybm
hyai=flev->hyai
hybi=flev->hybi
slat=flev->slat
slon=flev->slon

system("/bin/rm -f " + fout)            ; remove any pre-existing file
ncdf = addfile(fout ,"c")               ; open output netCDF file
fAtt               = True               ; assign file attributes
fAtt@title         = "ERA5 interpolated to L83 vertical grid (Sasha Glanville)"
fAtt@Conventions   = "None"
fAtt@creation_date = systemfunc ("date")
fileattdef(ncdf,fAtt)                   ; copy file attributes
filedimdef(ncdf,"time",-1,True)

vars = [/ U, V, T, Q /]
varsStrings = (/ "U", "V", "T", "Q" /)
do i = 0,ListCount(vars)-1
        val := (/vars[i]/)
        val!0 = "time"
        val!1 = "lev"
        val!2 = "lat"
        val!3 = "lon"
        val&time = time
        val&lev = plev
        val&lat = lat
        val&lon = lon
        copy_VarAtts(vars[i],val)
        val := pres2hybrid_Wrap(plev,PS,p0,val,hyam,hybm,4)
        ncdf->$varsStrings(i)$ = val
end do

ncdf->PS=PS
ncdf->hyam=hyam
ncdf->hybm=hybm
ncdf->hyai=hyai
ncdf->hybi=hybi
ncdf->slat=slat
ncdf->slon=slon
ncdf->ilev=ilev
ncdf->lev=lev

end

