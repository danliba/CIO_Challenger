%% Profundidad de la Isoterma 15
%El objetivo de este codigo es encontrar la profundidad de la isoterma de
%15ºC frente al Peru y relacionarlo con el ingreso de masas de agua
%oceanicas(ASS), ondas kelvin, etc. El estudio de esta variable se hará con
%promedios quincenales, promediando asi los primeros 15 dìas y luego los
%ultimos 15 días, generando los graficos.
%Para esto vamos a utilizar las funciones descritas por:
% RA_ISOTHERM  $Id: ra_isotherm.m, 2015/02/20 $
% Copyright (C) CORAL-IITKGP, Ramkrushn S. Patel 2014.

%% datos
fn='junio.nc';

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
temp=double(ncread(fn,'thetao'));
%sal=double(ncread(fn,'so'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

TEMPs=permute(temp,[3 2 1 4]);
%% vamos a buscar las 2 quincenas
imonth=mo(1);

indxtime15=find(da<=15 & mo==imonth); %15/mes
indxtime30=find(da>15 & da<=30 & mo==imonth);%30/mes

%promediamos
temp15=nanmean(TEMPs(:,:,:,indxtime15),4); %time15 = timeis(indxtime15);
temp30=nanmean(TEMPs(:,:,:,indxtime30),4); %time30 = timeis(indxtime30);

%Ya tenemos las 2 quincenas ahora vamos a hallar la profundidad de la
%isoterma de 15
temperature=cat(4,temp15,temp30);

t1 = datetime(yr(1),mo(1),da(indxtime15(end)));
t2 = datetime(yr(1),mo(1),da(indxtime30(end)));
t = [t1,t2];
%% isoterma de 15
isovalue=15;
for ii=1:1:size(temperature,4)
    isotherm(:,:,:,ii)=ra_isotherm(temperature(:,:,:,ii),depth,isovalue);
end

grayColor = [.7 .7 .7];
cmp = getPyPlot_cMap('rainbow');
%% Grafico
load('Mapa_Peru.mat');

labels_x={'86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
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

for ij=1:1:size(temperature,4)
    subplot(1,2,ij)
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'Color',grayColor);
            hold on
        end

    pcolor(lon,lat,isotherm(:,:,:,ij));shading interp;
    colormap(cmp);
    hold on
    [c,h]=contour(lon,lat,isotherm(:,:,:,ij),[20:20:120],'k:');
    clabel(c,h,'Fontsize',8);
    hc=colorbar;
    set(hc,'ticks',[0:20:180],'TickDirection',('out'),'TickLength',0.005);
%     hc.Location='eastoutside';
%     hc.Position=[0.11 0.11 0.01 0.8];
    ylabel(hc,'Profundidad [m]');
    caxis([0 180]);
    title(['Profundidad Isoterma 15ºC' '    ' datestr(t(ij))],'fontsize',12)
    ylim([-20 0]);
    hold on
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
    set(gca,'xtick',[-86:2:-68],'xticklabel',labels_x,'xlim',[-86 -68]);
    text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    %         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    text(-85.5,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
    %text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
    clear c d 
    load('Mapa_Peru.mat')
end

print('Prof_isoterma15.jpg','-djpeg','-r300');


