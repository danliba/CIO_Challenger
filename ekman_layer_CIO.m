%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Ekman Layer CIO CHALLENGER %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Using Climate Data Toolbox %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  By D.A.L.B & OSO approved %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Vamos a calcular el tranporte ekman durante las ultimas quincenas en Peru
%y lo vamos a relacionar con la clorofila, ya que esta directamente
%relacionado con los Upwelling y downwelling
%% set working directory

cd D:\CIO\ekman_layer

%% leemos la data de vientos

fn='wind_26_01_22.nc';

lon=double(ncread(fn,'lon'))';
lat=double(ncread(fn,'lat'));
time=double(ncread(fn,'time'))./86400;
[yr,mo,da,hr]=datevec(double(time)+datenum(1990,1,1,0,0,0));

vwind=double(ncread(fn,'northward_wind'));
uwind=double(ncread(fn,'eastward_wind'));

%% hallamos el promedio diario 

imonth=mo(1);
iyr=yr(1);
%Separamos las quincenas
indxtime15=find(da<=15 & mo==imonth(1));%quincena 1
indxtime30=find(da>=15 & da<=30 & mo==imonth(1));%quincena 2
%calculamos los promedios quincenales
vwind15=nanmean(vwind(:,:,indxtime15),3);
vwind30=nanmean(vwind(:,:,indxtime30),3);

uwind15=nanmean(uwind(:,:,indxtime15),3);
uwind30=nanmean(uwind(:,:,indxtime30),3);

%todo el mes
vwind_t=nanmean(vwind,3);
uwind_t=nanmean(uwind,3);

%% 
[Lon,Lat] = meshgrid(lon,lat);
%quincena 1
[UE15,VE15,wE15] = ekman(Lat,Lon,uwind15',vwind15');

%quincena 2
[UE30,VE30,wE30] = ekman(Lat,Lon,uwind30',vwind30');

%total mensual
[UEt,VEt,wEt] = ekman(Lat,Lon,uwind_t',vwind_t');


t1=datestr(datetime(iyr,imonth,15)); t2=datestr(datetime(iyr,imonth,30));
%t1=[datestr(fecha(1))]; t2=[datestr(fecha(2))];
%t_1=t1(4:end); t_2=t2(4:end);
%% graficamos
%15na
figure 
subplot(1,2,1)
pcolor(lon,lat,wE15*1e7); shading interp;%se multiplica *10^7 para mejorar la visualizacion de los datos
caxis([-1 1]*300)
cmocean -delta
cb = colorbar;
ylabel(cb,'Ekman velocity m x 10^{-7}/s')
axis([-85 -70 -20 -2])
axis square 
hold on

% Plot wind vectors:
quiversc(lon,lat,uwind15',vwind15','color',rgb('dark gray'));

% Plot Ekman transport vectors:
quiversc(lon,lat,UE15,VE15,'color',rgb('bright red'));
borders('countries','facecolor',rgb('gray'))
title(t1);

%30na
subplot(1,2,2) 
pcolor(lon,lat,wE30*1e7); shading interp;%se multiplica *10^7 para mejorar la visualizacion de los datos
caxis([-1 1]*300)
cmocean -delta
cb = colorbar;
ylabel(cb,'Ekman velocity m x 10^{-7}/s')
axis([-85 -70 -20 -2])
axis square
hold on

% Plot wind vectors:
quiversc(lon,lat,uwind30',vwind30','color',rgb('dark gray'));

% Plot Ekman transport vectors:
quiversc(lon,lat,UE30,VE30,'color',rgb('bright red'));
borders('countries','facecolor',rgb('gray'))
title(t2);
%% Aqui se ven todas las fechas, pero es pesado
% figure
% for ii=1:1:length(time);
% u10=uwind(:,:,ii);
% v10=vwind(:,:,ii);
% 
% fecha=datetime(yr(ii),mo(ii),da(ii));
% %%plot
% % quiversc(lon,lat,u10',v10','color',rgb('dark gray'))
% % borders('countries','k');
% %  axis square
% %  axis([-90 -65 -20 0])
% 
% [Lon,Lat] = meshgrid(lon,lat);
% [UE,VE,wE] = ekman(Lat,Lon,u10',v10');
% 
% %wE(isnan(sst)) = nan;
% 
% %subplot(1,2,1)
% pcolor(lon,lat,wE*1e7); shading interp;%se multiplica *10^7 para mejorar la visualizacion de los datos
% caxis([-1 1]*150)
% cmocean -delta
% cb = colorbar;
% ylabel(cb,'Ekman velocity m x 10^{-7}/s')
% axis([-90 -65 -20 0])
% 
% hold on
% 
% % Plot wind vectors:
% quiversc(lon,lat,u10',v10','color',rgb('dark gray'));
% 
% % Plot Ekman transport vectors:
% quiversc(lon,lat,UE,VE,'color',rgb('bright red'));
% borders('countries','facecolor',rgb('gray'))
% title(datestr(fecha));
% pause(0.1)
% clf
% clear UE VE wE
% end
%%
% %% Mimicking Kessler
% %Similarly, let's take a look at the region analyzed by Kessler 2002. 
% %We'll recreate Kessler's Figure 6b, which plots upwelling in units of meters 
% %per month. There are 2629800 seconds in a month, so we have to multiply wE by
% %that number before contouring. Also, Kessler's color axis is nonlinear, so 
% %we'll use their contour values, but I'm not going to worry about stetching 
% %and compressing the colorbar to match Kessler.
% 
cvals = [-40 -20 -10 -5 -2.5 -1 - 2.5 5 10 20 40];

figure
contourf(lon,lat,wEt*2629800,cvals,'edgecolor','none');
axis xy image
caxis([-1 1]*40)
cb = colorbar;
ylabel(cb,'Ekman velocity m/month')
axis([-85 -70 -20 -2])

% Set the colormap:
colormap(rgb('yellow','orange','red','pink','light pink','white',...
   'pale blue','light cyan','cyan','light blue','blue','dark blue'));

borders('countries','facecolor',rgb('gray'))
