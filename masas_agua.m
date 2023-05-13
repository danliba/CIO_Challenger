%% para la tocaya
%Pasos
%% PASO 1
%Primero descargar los datos de https://resources.marine.copernicus.eu/products
%Seleccionar los modelos resolucion de 8km o 1/12º : 
%GLOBAL_REANALYSIS_PHY_001_030/ periodo: 2014-2019 && 
%GLOBAL_ANALYSIS_FORECAST_PHY_001_024/  periodo: 2019-2021
%Descargar los datos diarios de Sal y Temp
clear all
close all
clc
%% Paso 2
%Aqui vamos a seleccionar solo los dias 15 de los archivos nc que hemos
%descargado de ambos modelos y los procesamos. Fin. xd

path01='D:\CIO\ayuda\danielle';
hdir=dir(fullfile(path01,'20*sal.nc'));
load('MA_peru');
% aviobj = QTWriter('Masas_awa.mov','FrameRate',1);%aviobj.Quality = 100;

for icmems=1:1:size(hdir,1)

    fn=hdir(icmems).name;
    time=double(ncread(fn,'time'))./24;
    time=time+datenum(1950,1,1,0,0,0);
    [yr,mo,da,hr,mi,se]=datevec(time);
    lon=double(ncread(fn,'longitude'));
    lat=double(ncread(fn,'latitude'));
    
    %indx_day=find(da==15 | da==30);2 quincenas
    indx_day=find(da==15);
    sal=double(ncread(fn,'so')); sal=permute(sal,[1 2 4 3]);
    sal_sel=sal(:,:,indx_day);
    t = datetime(yr,mo,da);
    fecha=t(indx_day);
    
    for ii=1:1:size(indx_day)
        pcolor(lon,lat,sal_sel(:,:,ii)'); shading interp; colormap(peru_wm);
        colorbar; caxis([33 35.5]);
        title(datestr(fecha(ii)));
        hold on
        [cc,h]=contour(lon,lat,sal_sel(:,:,ii)',[33:0.2:36],'k:');
        clabel(cc,h,'Fontsize',8);
        colorbar; caxis([33 35.5]);
        hc=colorbar;
        set(hc,'ticks',[33,33.8,34.8,35.1,35.5],'TickDirection',('out'),'TickLength',0.005);

%         M1=getframe(gcf);
%         writeMovie(aviobj, M1);
        pause(0.5)
        clf
    end
end
% close(aviobj);
