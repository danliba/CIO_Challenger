clear all
close all
clc

fn='adcp0n170w_dy.cdf';
ncdisp(fn)

depth=double(ncread(fn,'depth'));
lat=double(ncread(fn,'lat'));
lon=double(ncread(fn,'lon'));
uvel=double(ncread(fn,'u_1205'));
vvel=double(ncread(fn,'v_1206'));
time=double(ncread(fn,'time'));
time_boya=double(time)+datenum(1988,05,16,12,0,0);
[yr,mo,da,hr,mi,se]=datevec(time_boya);
%% nuevo
%TEMPs=permute(temp,[3 1 4 2]);
uvelu=permute(uvel,[4,3,1,2]);
vvelv=permute(vvel,[4,3,1,2]);
t = datetime(yr,mo,da);

xlswrite('datos_170w.xlsx',uvelu,1);
xlswrite('datos_170w.xlsx',exceltime(t),2);
xlswrite('datos_170w.xlsx',depth,3);

xlswrite('datos_170w.xlsx',vvelv,4);

%% plot

pcolor(time_boya,-depth,uvelu');shading flat; 
datetick('x', 'mm/yy');colorbar;
grid on
title('Uvel ADCP 170ºW');