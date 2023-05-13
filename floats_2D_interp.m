%% 2D interpolation

clear;
close all;
%ruta
path01='D:\descargas\floats';

%lista de directorio
hdir=dir(fullfile(path01,'argo-profiles-*.nc*'));

hdir(7:8)=[];
hdir(12:13)=[];
hdir(23:24)=[];
hdir(27:37)=[];
hdir(64:67)=[];

%%profundidad
range0=[0 100];

for ifloat=1:1:size(hdir,1)
    
     fname=hdir(ifloat).name;
     
    depth0=ncread(fname,'PRES');
    temp0=ncread(fname,'TEMP');
     salt0=ncread(fname,'PSAL');
    lon0=ncread(fname,'LONGITUDE');
    lat0=ncread(fname,'LATITUDE');
    time0=ncread(fname,'JULD');
    
    %seleccionar solo columnas impares 
    depth=depth0(:,1:2:end);
    temp=temp0(:,1:2:end);
     salt=salt0(:,1:2:end);
    lon=lon0(1:2:end,:);
    lat=lat0(1:2:end,:);
    
    [indxdep]=find(range0(1)<=depth & depth<=range0(2));
    
    tempi=temp(indxdep);
    tempi2=nanmean(tempi,1);
    
    salti=salt(indxdep);
    salti2=nanmean(salti,1);
   
    lat2(1:size(lat,1),ifloat)=lat;
    lon2(1:size(lon,1),ifloat)=lon; 
    temp2(1:size(tempi2,1),ifloat)=tempi2;
    salt2(1:size(salti2,1),ifloat)=salti2;
    

end

lat3=lat2(1,:)';
[lati,a,b]=unique(lat3);

lon3=lon2(1,:)';
loni=lon3(a);

temp2=temp2';
temperature=temp2(a);

salt2=salt2';
salinity=salt2(a);
W=[-96:0.01:-80];
S=[-18:0.01:5];


%% Interpolation 

[xx,yy]=meshgrid(S,W);


% [xi,di]=meshgrid(1:1:size(hdir,1),1:1:size(pres2,1));
% temp3=griddata(xi(~isnan(temp2)),di(~isnan(temp2)),temp2(~isnan(temp2)),xi,di);
% 
%SAL2D=griddata(xx(~isnan(salinity)),yy(~isnan(salinity)),salinity(~isnan(salinity')),xx,yy);
vv=griddata(lati,loni,salinity,xx,yy);

figure
pcolor(yy,xx,vv);
shading flat
colorbar;
hold on
plot3(loni,lati,salinity,'ro');

grid on;
ylabel('longitude');
xlabel('latitude');
%vlabel('salinity');
