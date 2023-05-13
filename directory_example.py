# -*- coding: utf-8 -*-
"""
Created on Fri Jul  3 16:53:29 2020

@author: danli
"""
import os
import ftplib

ftp = ftplib.FTP('my.cmems-du.eu')
ftp.login('landrew', 'STRAtocaster_12')
iy=1996
im=6
ftp.cwd('/Core/GLOBAL_REANALYSIS_PHY_001_030/global-reanalysis-phy-001-030-daily/%d/%02d' % (iy,im))

dir_list = []
ftp.dir(dir_list.append)

B=dir_list [-1]
c=B[95:]
# main thing is identifing which char marks start of good stuff
# '-rw-r--r--   1 ppsrt    ppsrt      545498 Jul 23 12:07 FILENAME.FOO
#                               ^  (that is line[29])

for line in dir_list:
   print (line[58:].strip().split(' '))# got yerself an array there bud!
   a=line[58:].strip().split(' ')

   # EX ['545498', 'Jul', '23', '12:07', 'FILENAME.FOO']