file1='ts3z.nc'
ncdisp(file1)
latitud1=ncread(file1,'lat');
longitud1=ncread(file1,'lon');
temp1=ncread(file1,'water_temp');
time1=ncread(file1,'time');
longitud1=longitud1-360;
t1q=squeeze(temp1(:,:,1,1));
t2q=squeeze(temp1(:,:,1,2));
t3q=squeeze(temp1(:,:,1,3));
t4q=squeeze(temp1(:,:,1,4));
t5q=squeeze(temp1(:,:,1,5));
t6q=squeeze(temp1(:,:,1,6));
t7q=squeeze(temp1(:,:,1,7));
t8q=squeeze(temp1(:,:,1,8));
t9q=squeeze(temp1(:,:,1,9));
t10q=squeeze(temp1(:,:,1,10));
t11q=squeeze(temp1(:,:,1,11));
t12q=squeeze(temp1(:,:,1,12));
t13q=squeeze(temp1(:,:,1,13));
t14q=squeeze(temp1(:,:,1,14));
t15q=squeeze(temp1(:,:,1,15));
t16q=squeeze(temp1(:,:,1,16));
tmq=(t1q+t2q+t3q+t4q+t5q+t6q+t7q+t8q+t9q+t10q+t11q+t12q+t13q+t14q)/14;
tmq=(t1q+t2q+t3q+t4q+t5q+t6q+t7q+t8q+t9q+t10q+t11q+t12q+t13q+t14q+t15q)/15;
tmq=(t1q+t2q+t3q+t4q+t5q+t6q+t7q+t8q+t9q+t10q+t11q+t12q+t13q+t14q+t15q+t16q)/16;
tmq=tmq';
map=pcolor(longitud,latitud,tmq)
map.EdgeAlpha=0
load coast
hold on
plot(long,lat,'k')
plot(long+360,lat,'k')
contour(longitud,latitud,tmq,'k','ShowText','on')
colorbar
caxis([14 25])
colormap jet
xlabel('Longitud (°W)')
ylabel('Latitud (°S)')

VARIACION DE LA TEMPERATURA SUPERFICIAL
var=tm-tmq;
map=pcolor(longitud,latitud,var)
map.EdgeAlpha=0
load coast
hold on
plot(long,lat,'k')
plot(long+360,lat,'k')
contour(longitud,latitud,var,'k','ShowText','on')
colorbar
colormap jet
xlabel('Longitud (°W)')
ylabel('Latitud (°S)')
caxis([-1.5 1.5])