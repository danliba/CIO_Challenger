import os
os.system('fn=(`ls ${mercator}*.nc`)')
os.system('cdo sellonlatbox,140,-80,5,-5 fn fn2')
os.system('cdo select,name=longitude,latitude,depth,time,thetao,so fn2 fn3')
