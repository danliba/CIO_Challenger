%%ftp download TAO buoys %% t0n95w_dy.cdf
clear all
close all
clc; 
cd D:\CIO\Kelvin-cromwell\boyas
%hoy
fecha=datevec(today); yy=fecha(1,1);mm=fecha(1,2);dd=fecha(1,3);
%ftp
ftpobj1=ftp('ftp.pmel.noaa.gov','taopmelftp','G10b@LCh@Ng3');
%IMPORTANTE: cambiar a la latitud deseada
lat=0;

if lat==0
%north-west
folder_nw=sprintf('/cdf/sites/daily/t%dn*w_dy.cdf',lat);
%folder_nw=sprintf('/cdf/sites/daily');
hdirnw=dir(ftpobj1,folder_nw);
path0=cd(ftpobj1,folder_nw(1:17));

boya_nw=[4,5,6,8,9,10,15];
for i=1:1:length(boya_nw)
fname=hdirnw(boya_nw(i)).name;
mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
float_get=mget(ftpobj1,fname,mfile);
 formatSpec= ['The buoy ',fname,' was successfully downloaded'];
  disp(formatSpec)
end

%north-east
folder_ne=sprintf('/cdf/sites/daily/t%dn*e_dy.cdf',lat);
hdirne=dir(ftpobj1,folder_ne);
boya_ne=[6,9];
for j=1:1:length(boya_ne)
fname=hdirne(boya_ne(j)).name;
mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
float_get=mget(ftpobj1,fname,mfile);
formatSpec= ['The buoy ',fname,' was successfully downloaded'];
  disp(formatSpec)
end
%else
end
%% >=2 N y >= 2S

if lat>0
% %south-west
 folder_sw=sprintf('/cdf/sites/daily/t%ds*w_dy.cdf',lat);
 hdirsw=dir(ftpobj1,folder_sw);
 path0=cd(ftpobj1,folder_sw(1:17));
 boya_sw=[2:8];
 for k=1:1:length(boya_sw)
     fname=hdirsw(boya_sw(k)).name;
     mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
     float_get=mget(ftpobj1,fname,mfile);
     formatSpec= ['The buoy ',fname,' has been successfully downloaded'];
     disp(formatSpec)
end
% %south-east
 folder_se=sprintf('/cdf/sites/daily/t%ds*e_dy.cdf',lat);
  hdirse=dir(ftpobj1,folder_se);
 boya_se=[1,2];
 for jj=1:1:length(boya_se)
     fname=hdirse(jj).name;
     mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
     float_get=mget(ftpobj1,fname,mfile);
     formatSpec= ['The buoy ',fname,' has been successfully downloaded'];
     disp(formatSpec)
 end

 %north-west
folder_nw=sprintf('/cdf/sites/daily/t%dn*w_dy.cdf',lat);
hdirnw=dir(ftpobj1,folder_nw);
if lat==2
boya_nw=[2:8];
else 
    boya_nw=[1:7];
end

for i=1:1:length(boya_nw)
fname=hdirnw(boya_nw(i)).name;
mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
float_get=mget(ftpobj1,fname,mfile);
 formatSpec= ['The buoy ',fname,' has been successfully downloaded'];
  disp(formatSpec)
end


%north-east
 folder_ne=sprintf('/cdf/sites/daily/t%dn*e_dy.cdf',lat);
 hdirne=dir(ftpobj1,folder_ne);
boya_ne=[4,5];
for j=1:1:length(boya_ne)
fname=hdirne(boya_ne(j)).name;
mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
float_get=mget(ftpobj1,fname,mfile);
formatSpec= ['The buoy ',fname,' has been successfully downloaded'];
  disp(formatSpec)
end

end

%% Daniel Lizarbe Barreto
%FTP boyas version 1.0 
%30/jun/2020
