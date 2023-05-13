

cdo select,name=time,lon,lat,analysed_sst,sst_anomaly 20201130090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur2.nc;
cdo sellonlatbox,-90,-65,-22,5 mur2.nc mur2_1.nc

cdo sellonlatbox,-90,-65,-22,5 20201201090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur3.nc
cdo sellonlatbox,-90,-65,-22,5 20201202090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur4.nc
cdo sellonlatbox,-90,-65,-22,5 20201203090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur5.nc
cdo sellonlatbox,-90,-65,-22,5 20201204090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur6.nc
cdo sellonlatbox,-90,-65,-22,5 20201205090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur7.nc
cdo sellonlatbox,-90,-65,-22,5 20201206090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc mur8.nc
