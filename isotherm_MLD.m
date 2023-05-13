%% %% %shapes file
%departamentos del Peru
deppath='D:\CIO\Kelvin-cromwell\clorofila\departamentos';
depfn='DEPARTAMENTOS.shp';
depfns=fullfile(deppath,depfn);

%puertos del peru
puertopath='D:\CIO\Kelvin-cromwell\clorofila\puerto';
puertofn='puerto.shp';
puertofns=fullfile(puertopath,puertofn);

%% shape file departamentos
[c,d]=shaperead(depfns);
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'k');
            hold on
        end
        
%% shapefile puertos
[a,b]=shaperead(puertofns);

for i=1:1:size(a,1)
plot(a(i).X,a(i).Y,'k.');
lonpuertos(i,:)=a(i).X;
latpuertos(i,:)=a(i).Y;
nombrepuertos{i,:}=b(i).NOMPUERT;
text(lonpuertos(i),latpuertos(i),nombrepuertos{i,:},'fontsize',7);
hold on
end

indx=[3,5,10,12,13,14,15,22,25,30,31,33,36,38,50];
%puertos ya seleccionados
puertoselect=nombrepuertos(indx,:);
%callao nombre cambiar
puertoselect(2,:)={'CALLAO'};
lonpuertosi=lonpuertos(indx);
latpuertosi=latpuertos(indx);


%% datos
fn='junio.nc';

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
temp=double(ncread(fn,'thetao'));
sal=double(ncread(fn,'so'));
%mld=double(ncread(fn,'mlotst'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

%% encontrar la profundidad de la isoterma de 1a isoterma 15ªC
tempi=permute(temp,[3,2,1,4]);
tempi=tempi(:,:,:,1);

isovalue=15;
isotherm=ra_isotherm(tempi,depth,isovalue);

 [c,d]=shaperead(depfns);
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'k');
            hold on
        end
        
pcolor(lon,lat,isotherm);shading flat; colorbar;colormap('jet')
hold on
[c,h]=contour(lon,lat,isotherm,[20:20:120],'k:');
clabel(c,h,'Fontsize',8);
colorbar; 

%% encontrar la capa de mezcla CTD toolbox
sali=permute(sal,[3,2,1,4]);
sali=sali(:,:,:,1);
dT=1;
[mld]=ra_mld(sali,tempi,depth,dT);
%% grafico MLD
labels_x={'86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

 [c,d]=shaperead(depfns);
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'k');
            hold on
        end
        
pcolor(lon,lat,mld);shading interp; colorbar;colormap('jet')
hold on
[c,h]=contour(lon,lat,mld,[20:20:120],'k:');
clabel(c,h,'Fontsize',8);
caxis([0 120]);
title('Profundidad de Capa de Mezcla','fontsize',12)
ylim([-20 0]);
 hold on
 [c,d]=shaperead(depfns);
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
 end
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-86:2:-68],'xticklabel',labels_x,'xlim',[-86 -68]);
text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
%         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-85.5,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
%text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
