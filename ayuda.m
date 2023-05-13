COMANDOS PARA TEMPERATURA SUPERFICIAL

file='ts3z.nc'
ncdisp(file)
latitud=ncread(file,'lat');
longitud=ncread(file,'lon');
temp=ncread(file,'water_temp');
time=ncread(file,'time');
longitud=longitud-360;
t1=squeeze(temp(:,:,1,1));
t2=squeeze(temp(:,:,1,2));
t3=squeeze(temp(:,:,1,3));
t4=squeeze(temp(:,:,1,4));
t5=squeeze(temp(:,:,1,5));
t6=squeeze(temp(:,:,1,6));
t7=squeeze(temp(:,:,1,7));
t8=squeeze(temp(:,:,1,8));
t9=squeeze(temp(:,:,1,9));
t10=squeeze(temp(:,:,1,10));
t11=squeeze(temp(:,:,1,11));
t12=squeeze(temp(:,:,1,12));
t13=squeeze(temp(:,:,1,13));
t14=squeeze(temp(:,:,1,14));
t15=squeeze(temp(:,:,1,15));
t16=squeeze(temp(:,:,1,16));

sal=ncread(file,'salinity');
s1=squeeze(sal(:,:,1,1));
s2=squeeze(sal(:,:,1,2));
s3=squeeze(sal(:,:,1,3));
s4=squeeze(sal(:,:,1,4));
s5=squeeze(sal(:,:,1,5));
s6=squeeze(sal(:,:,1,6));
s7=squeeze(sal(:,:,1,7));
s8=squeeze(sal(:,:,1,8));
s9=squeeze(sal(:,:,1,9));
s10=squeeze(sal(:,:,1,10));
s11=squeeze(sal(:,:,1,11));
s12=squeeze(sal(:,:,1,12));
s13=squeeze(sal(:,:,1,13));
s14=squeeze(sal(:,:,1,14));
s15=squeeze(sal(:,:,1,15));
s16=squeeze(sal(:,:,1,16));
lon,lat,depth,time
tm=(t1+t2+t3+t4+t5+t6+t7+t8+t9+t10+t11+t12+t13+t14)/14;
sm=(s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12+s13+s14)/14;
tm=(t1+t2+t3+t4+t5+t6+t7+t8+t9+t10+t11+t12+t13+t14+t15)/15;
sm=(s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12+s13+s14+s15)/15;
tm=(t1+t2+t3+t4+t5+t6+t7+t8+t9+t10+t11+t12+t13+t14+t15+t16)/16;
sm=(s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12+s13+s14+s15+s16)/16;
tm=tm';
sm=sm';

map=pcolor(longitud,latitud,tm)
map.EdgeAlpha=0
load coast
hold on
plot(long,lat,'k')
plot(long+360,lat,'k')
contour(longitud,latitud,tm,'k','ShowText','on')
colorbar
caxis([12 32])
colormap jet
xlabel('Longitud (°W)')
ylabel('Latitud (°S)')

map=pcolor(longitud,latitud,sm)
map.EdgeAlpha=0
load coast
hold on
plot(long,lat,'k')
plot(long+360,lat,'k')
contour(longitud,latitud,sm,'k','ShowText','on','fill','on')
caxis([32 36])
xlabel('Longitud (°W)')
ylabel('Latitud (°S)')

