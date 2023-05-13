clear all
close all
clc

fid = fopen('Cutclimat_boya.sh','wt');

path1='D:\CIO\Kelvin-cromwell\boyas\boyas_202109004';
hdir=dir(fullfile(path1,'*.cdf'));
iter=0;
for iboya=1:1:size(hdir,1)
    fns=hdir(iboya).name;
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
platform_code=ncreadatt(fns,'/','platform_code');
creation_day=ncreadatt(fns,'time','units');
yy=str2num(creation_day(12:15)); mm=str2num(creation_day(17:18)); dd=str2num(creation_day(20:21)); hr=str2num(creation_day(23:24));
time0=double(time)+datenum(yy,mm,dd,hr,0,0);

yst=1994; yrend=2019; most=1; moen=12; dast=1; daen=31;
timecut=[datenum(yst,most,dast,0,0,0), datenum(yrend,moen,daen,0,0,0)];

indx_clim=find(time0>=timecut(1) & time0<=timecut(2));
boyain=['t',platform_code,'_dy','.cdf'];
boyaout=['climatology_timerange_',boyain];

iter=iter+1;
nco_code=['ncks ', '-d time',',',num2str(indx_clim(1)),',',num2str(indx_clim(end)),' ', boyain,' ', boyaout,';'];
fprintf(fid,'%s\n',nco_code);
end

fclose(fid);

%% run bash code
!chmod u+rwx Cutclimat_boya.sh
!./Cutclimat_boya.sh

%% Daniel Lizarbe Barreto
%Climatologia boyas version 1.0 
%30/jun/2020
