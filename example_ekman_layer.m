load pacific_wind.mat

figure
imagescn(lon,lat,sst)
axis image      % (trims away extra whitespace & sets aspect ratio to 1:1)
cmocean thermal % sets the colormap
cb = colorbar;
ylabel(cb,' sea surface temperature ({\circ}C) ')

hold on
quiversc(lon,lat,u10,v10,'color',rgb('dark gray'))

%%
%positive WE means upwelling, negative means Downwelling
[Lon,Lat] = meshgrid(lon,lat);
[UE,VE,wE] = ekman(Lat,Lon,u10,v10);

wE(isnan(sst)) = nan;
%% 
figure
%subplot(1,2,1)
imagescn(lon,lat,wE*1e7); %se multiplica *10^7 para mejorar la visualizacion de los datos
axis image
caxis([-1 1]*40)
cmocean -delta
cb = colorbar;
ylabel(cb,'Ekman velocity m x 10^{-7}/s')
axis([-140 -107 22 45])

hold on

% Plot wind vectors:
quiversc(lon,lat,u10,v10,'color',rgb('dark gray'));

% Plot Ekman transport vectors:
quiversc(lon,lat,UE,VE,'color',rgb('bright red'));


borders('countries','facecolor',rgb('gray'))
%% Mimicking Kessler
%Similarly, let's take a look at the region analyzed by Kessler 2002. 
%We'll recreate Kessler's Figure 6b, which plots upwelling in units of meters 
%per month. There are 2629800 seconds in a month, so we have to multiply wE by
%that number before contouring. Also, Kessler's color axis is nonlinear, so 
%we'll use their contour values, but I'm not going to worry about stetching 
%and compressing the colorbar to match Kessler.

cvals = [-40 -20 -10 -5 -2.5 -1 - 2.5 5 10 20 40];

figure
contourf(lon,lat,wE*2629800,cvals);
axis xy image
caxis([-1 1]*40)
cb = colorbar;
ylabel(cb,'Ekman velocity m/month')
axis([-110 -80 8 23])

% Set the colormap:
colormap(rgb('yellow','orange','red','pink','light pink','white',...
   'pale blue','light blue','blue','cyan','light cyan'));

borders('countries','facecolor',rgb('gray'))
