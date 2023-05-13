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

yrst=1996
yren=1996
most=6
moen=9
da=30

fnbase='mercatorglorys12v1_gl12_mean'
#fnend='_*.nc'

savedir = 'D:\CIO\Kelvin-cromwell\download_ftpexample'
os.chdir(savedir)

for iy in range (yrst, yren+1):
    for im in range(most, moen+1):
        # ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
        # print(ftp.cwd)
        # dir_list = []
        # ftp.dir(dir_list.append)

        # dir_list_end=dir_list [-1]
        # fnend=dir_list_end[95:]
        if im == 7:
            da=31
            fnmid='_%d/%02d/%d' % (iy,im,da)
            ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
            print(ftp.cwd)
            dir_list = []
            ftp.dir(dir_list.append)
            dir_list_end=dir_list [-1]
            fnend=dir_list_end[95:]
            fn=fnbase + fnmid + fnend
            # file = open(fn, 'wb')
            # ftp.retrbinary('RETR ' + fn, file.write)
            # file.close()
            # os.remove(fn)
            # ftp.cwd('../')
            print(fn)
        elif im == 8:
            da=31
            fnmid='_%d/%02d/%d' % (iy,im,da)
            ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
            print(ftp.cwd)
            dir_list = []
            ftp.dir(dir_list.append)
            dir_list_end=dir_list [-1]
            fnend=dir_list_end[95:]
            fn=fnbase + fnmid + fnend
            # file = open(fn, 'wb')
            # ftp.retrbinary('RETR ' + fn, file.write)
            # file.close()
            # os.remove(fn)
            # ftp.cwd('../')
            print(fn)
        elif im == 10:
            da=31
            fnmid='_%d/%02d/%d' % (iy,im,da)
            ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
            print(ftp.cwd)
            dir_list = []
            ftp.dir(dir_list.append)
            dir_list_end=dir_list [-1]
            fnend=dir_list_end[95:]
            fn=fnbase + fnmid + fnend
            # file = open(fn, 'wb')
            # ftp.retrbinary('RETR ' + fn, file.write)
            # file.close()
            # os.remove(fn)
            # ftp.cwd('../')
            print(fn)
        elif im==12:
            da=31
            fnmid='_%d/%02d/%d' % (iy,im,da)
            ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
            print(ftp.cwd)
            dir_list = []
            ftp.dir(dir_list.append)
            dir_list_end=dir_list [-1]
            fnend=dir_list_end[95:]
            fn=fnbase + fnmid + fnend
            # file = open(fn, 'wb')
            # ftp.retrbinary('RETR ' + fn, file.write)
            # file.close()
            # os.remove(fn)
            # ftp.cwd('../')
            print(fn)
        else:
            da=30
            fnmid='_%d/%02d/%d' % (iy,im,da)
            ftp.cwd ('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))
            print(ftp.cwd)
            dir_list = []
            ftp.dir(dir_list.append)
            dir_list_end=dir_list [-1]
            fnend=dir_list_end[95:]
            fn=fnbase + fnmid + fnend

            # file = open(fn, 'wb')
            # ftp.retrbinary('RETR ' + fn, file.write)
            # file.close()
            # os.remove(fn)
            # ftp.cwd('../')
            print(fn)
            
    
    
#ftp.cwd('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/1996/06')
#fnbase = 'mercatorglorys12v1_gl12_mean'
#fnmid = '_19960630_R19960703.nc'
