fn='mayo.nc';
%% promediar los 15 ultimos dias del mes
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
sal=double(ncread(fn,'so'));
temp=double(ncread(fn,'thetao'));