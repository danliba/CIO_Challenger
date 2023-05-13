# -*- coding: utf-8 -*-
"""
Created on Thu Jul  2 23:44:50 2020

@author: danli
"""
import os
import ftplib
import zipfile

ftp = ftplib.FTP('prism.nacse.org')
ftp.login('anonymous', 'email@email.com')

ftp.cwd('monthly/ppt')
fnbase = 'PRISM_ppt_stable_4kmM'
fnmid = '2_' #years before 1981
fnend = '_all_bil.zip'

savedir = 'D:\CIO\Kelvin-cromwell\download_ftpexample'
os.chdir(savedir)

startyear = 1979
endyear = 1982

for year in range(startyear, endyear):
    if year > 1980:
        fnmid = '3_'
    ftp.cwd(str(year))
    fn = fnbase + fnmid + str(year) + fnend
    file = open(fn, 'wb')
    ftp.retrbinary('RETR ' + fn, file.write)
    file.close()
    zfile = zipfile.ZipFile(fn)
    zfile.extractall()
    zfile.close()
    os.remove(fn)
    ftp.cwd('../')
    print(str(year)), 'done'