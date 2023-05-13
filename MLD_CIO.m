cd D:\CIO\Kelvin-cromwell\iso15
%% Profundidad de la Capa de mezcla
%El objetivo de este codigo es encontrar la profundidad de la capa de
%mezcla frente a la costa peruana, la cual será relacionada con la
%abundancia o escaces de clorofila, basandonos en la hipotesis de
%profundidad critica de Sverdrup. El estudio de esta variable se hará semanal, 
%generando 4 graficos, 1 por cada semana, a fin de ser comparado con la
%Clorofila.
%Para esto vamos a utilizar las funciones descritas por:
% RA_ISOTHERM  $Id: ra_isotherm.m, 2015/02/20 $
% Copyright (C) CORAL-IITKGP, Ramkrushn S. Patel 2014.

%% datos
fn='junio.nc';

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
temp=double(ncread(fn,'thetao'));
sal=double(ncread(fn,'so'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

TEMPs=permute(temp,[3 2 1 4]);
SALs=permute(sal,[3 2 1 4]);

%% vamos a buscar los 7 días
imonth=mo(1);

indxtime7=find(da<=7 & mo==imonth); %7/mes
indxtime14=find(da>7 & da<=14 & mo==imonth);%14/mes
indxtime21=find(da>14 & da<=21 & mo==imonth); %21/mes
indxtime30=find(da>21 & da<=30 & mo==imonth);%30/mes

%promediamos TEMP
temp7=nanmean(TEMPs(:,:,:,indxtime7),4); %time15 = timeis(indxtime15);
temp14=nanmean(TEMPs(:,:,:,indxtime14),4); %time30 = timeis(indxtime30);
temp21=nanmean(TEMPs(:,:,:,indxtime21),4); %time15 = timeis(indxtime15);
temp30=nanmean(TEMPs(:,:,:,indxtime30),4); %time30 = timeis(indxtime30);

%promediamos SAL
sal7=nanmean(SALs(:,:,:,indxtime7),4); %time15 = timeis(indxtime15);
sal14=nanmean(SALs(:,:,:,indxtime14),4); %time30 = timeis(indxtime30);
sal21=nanmean(SALs(:,:,:,indxtime21),4); %time15 = timeis(indxtime15);
sal30=nanmean(SALs(:,:,:,indxtime30),4); %time30 = timeis(indxtime30);


%Ya tenemos las 4 semanas hora vamos a concaternar ambos
temperature=cat(4,temp7,temp14,temp21,temp30);
salinity=cat(4,sal7,sal14,sal21,sal30);

t1 = datetime(yr(1),mo(1),da(indxtime7(end))); t2 = datetime(yr(1),mo(1),da(indxtime14(end)));
t3 = datetime(yr(1),mo(1),da(indxtime21(end))); t4 = datetime(yr(1),mo(1),da(indxtime30(end)));
t = [t1,t2,t3,t4];

%% MLD -  capa de mezcla
dT=1;

for ii=1:1:size(temperature,4)
    mld(:,:,:,ii)=ra_mld(salinity(:,:,:,ii),temperature(:,:,:,ii),depth,dT);
    disp(['Gnerando la MLD de la semana ' datestr(t(ii))])
end

cmp = getPyPlot_cMap('rainbow');
load('Mapa_Peru.mat');
grayColor = [.7 .7 .7];
%% Grafico
labels_x={'86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.05], [0.02 0.02], [0.04 0.04]);
if ~make_it_tight,  clear subplot;  end

for ij=1:1:size(temperature,4)
    subplot(2,2,ij)
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'Color',grayColor);
            hold on
        end

    pcolor(lon,lat,mld(:,:,:,ij));shading interp;
    colormap(cmp)
    hold on
    [c,h]=contour(lon,lat,mld(:,:,:,ij),[20:20:120],'k:');
    clabel(c,h,'Fontsize',8);
    hc=colorbar;
    set(hc,'ticks',[0:20:120],'TickDirection',('out'),'TickLength',0.005);
%     hc.Location='eastoutside';
%     hc.Position=[0.11 0.11 0.01 0.8];
    ylabel(hc,'Profundidad [m]');
    caxis([0 120]);
    %title(['Profundidad Capa de Mezcla [MLD]' '    ' datestr(t(ij))],'fontsize',10)
    hold on
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0],'fontsize',8);
    set(gca,'xtick',[-86:2:-70],'xticklabel',labels_x,'xlim',[-86 -70],'fontsize',8);
    text(-73.5,-1,['MLD' ' ' datestr(t(ij))],'fontsize',10)
    text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    %         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    text(-85.5,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
    %text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
    clear c d 
    load('Mapa_Peru.mat')
    axis square
end

%print('MLD_junio.jpg','-djpeg','-r300');