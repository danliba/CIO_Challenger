%% Script para graficar TSM, SAL y Sigmat (densidad)
%Primero leemos la data
fn='temp_sal.nc'; %aqui lee la temperatura

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
temp=double(ncread(fn,'thetao'));
sal=double(ncread(fn,'so'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

%colorcito
grayColor = [.5 .5 .5];
%% promedio quincenal
imonth=[mo(1),mo(end)];
iyr=[yr(1),yr(end)];
%Segunda quincena Temperatura
indxtime30_1=find(da>=15 & da<=30 & mo==imonth(1));%segunda quincena 1
indxtime30_2=find(da>=15 & da<=30 & mo==imonth(2));%segunda quincena 2

temp30_1=nanmean(temp(:,:,:,indxtime30_1),4); %segunda quincena 1
temp30_2=nanmean(temp(:,:,:,indxtime30_2),4); %segunda quincena 2

sal30_2=nanmean(sal(:,:,:,indxtime30_2),4); %Salinidad segunda quincena 2

temp_dif=temp30_2-temp30_1; %calculamos la diferencia entre las quincenas

%cargamos el mapa del peru 
load('Mapa_Peru.mat');
%cargamos las masas de awa
wm=load('MA_peru.mat');

fecha=datetime(iyr,imonth,15);
t1=[datestr(fecha(1))]; t2=[datestr(fecha(2))];
t_1=t1(4:end); t_2=t2(4:end);
%% Graficamos la temperatura

labels_x={'90°W','88°W','86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*3;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.11 0.08], [0.06 0.05], [0.04 0.04]);
if ~make_it_tight,  clear subplot;  end

subplot(1,2,1)
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'Color',grayColor);
    hold on
end

pcolor(lon,lat,temp30_2');shading interp; colorbar; colormap jet;
caxis([12 32]);
hold on
[cc,h]=contour(lon,lat,temp30_2',[15:1:26],'k:');
w = h.LineWidth;
h.LineWidth = 0.4;
clabel(cc,h,'Fontsize',8);
hc=colorbar;
set(hc,'ticks',[12:2:32],'TickDirection',('out'),'TickLength',0.005);
ylabel(hc,'Temperatura [°C]');
title(['Temperatura Superficial del Mar (2da quincena de ',t_2,')'],'fontsize',12)
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);

subplot(1,2,2)
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'Color',grayColor);
    hold on
end

pcolor(lon,lat,temp_dif');shading interp; colorbar; cmocean('balance');
caxis([-3.5 3.5]);
hold on
[cc,h]=contour(lon,lat,temp_dif',[-3:1:3],'k:');
w = h.LineWidth;
h.LineWidth = 0.4;
clabel(cc,h,'Fontsize',8);
hc=colorbar;
set(hc,'ticks',[-3.5:0.5:3.5],'TickDirection',('out'),'TickLength',0.005);
ylabel(hc,'ATSM [°C]');
title(['Variacion de la TSM (2da Q ',t_2(1:3),' - ','2da Q ',t_1,')'],'fontsize',12)
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);

print('TSM_ATSM.png','-dpng','-r300');

%% Calculamos la Densidad 
%Como la temperatura y la temperatura potencial son iguales en la
%superficie, se calcula con esta formula noma 

sigma_t=sigmat(temp30_2,sal30_2);

%% Ahora las masas de Awa y la densidad

labels_x={'90°W','88°W','86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*3;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.11 0.08], [0.06 0.05], [0.04 0.04]);
if ~make_it_tight,  clear subplot;  end

subplot(1,2,1)
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'Color',grayColor);
    hold on
end

pcolor(lon,lat,sal30_2');shading interp; colorbar;
hold on
[cc,h]=contour(lon,lat,sal30_2',[33:0.2:36],'k:');
w = h.LineWidth;
h.LineWidth = 0.4;
clabel(cc,h,'Fontsize',8);
colorbar; caxis([33 35.5]);
colormap(wm.peru_wm)
hc=colorbar;
set(hc,'ticks',[33,33.8,34.8,35.1,35.5],'TickDirection',('out'),'TickLength',0.005);
ylabel(hc,'Salinidad [UPS]');
title(['Masas de agua (2da Quincena ',t_2,')'],'fontsize',12)
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);

clear colormap
subplot(1,2,2)
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'Color',grayColor);
    hold on
end

pcolor(lon,lat,sigma_t');shading interp; colorbar; cmocean('icea');
hold on
[cc,h]=contour(lon,lat,sigma_t',[22:0.2:26],'k:');
w = h.LineWidth;
h.LineWidth = 0.4;
clabel(cc,h,'Fontsize',8);
colorbar; caxis([21 26]);
hc=colorbar;
set(hc,'ticks',[21:0.2:26],'TickDirection',('out'),'TickLength',0.005);
ylabel(hc,'Densidad [sigma-t]');
title(['Densidad superficial (2da Quincena ',t_2,')'],'fontsize',12)
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);

print('WM_Densidad.png','-dpng','-r300');
%% Ver1

