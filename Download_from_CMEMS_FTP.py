# -*- coding: utf-8 -*-
"""
Created on Fri Jul  3 18:06:24 2020

@author: danli
"""


# -*- coding: utf-8 -*-
#'STRAtocaster_12', 'landrew'
#ftp://my.cmems-du.eu/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/1996/06/mercatorglorys12v1_gl12_mean_19960630_R19960703.nc
"""
Created on Fri Jul  3 15:11:58 2020

@author: danli
"""
import os
import ftplib

ftp = ftplib.FTP('my.cmems-du.eu')
ftp.login('landrew', 'STRAtocaster_12')

yrst=1997
yren=1997
most=6
moen=6

savedir = '/mnt/d/CIO/Kelvin-cromwell/download_ftpexample'
os.chdir(savedir)

for iy in range (yrst, yren+1):
    for im in range(most, moen+1):
        ftp.cwd('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
        print(ftp.cwd)
        dir_list = []
        ftp.dir(dir_list.append)
        dir_list_end=dir_list [-1]
        fn=dir_list_end[58:]
        file = open(fn, 'wb')
        ftp.retrbinary('RETR ' + fn, file.write)
        file.close()
        print(fn)
os.system('cdo sellonlatbox,140,-80,5,-5 fn out_1.nc')
os.system('cdo select,name=longitude,latitude,depth,time,thetao,so out_1.nc out_cut.nc')
