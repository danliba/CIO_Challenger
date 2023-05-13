%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%INFOGRAFIA AREAS DE VEDA DE ANCHOVETA
%selected_area=[-79 -78 -11 -10; -76 -77 -14 -13; -77.1 -76];
%areamn=[9ºS 10ºS 30-60mn];
%req_axis=[-80 -77 -12 -9; -78 -76 -14.2 -11];

pathmap='D:\descargas\CIO\nov_perupesca\Paises_Mundo';
fnmap='Paises_Mundo.shp';

pathpuerto='D:\descargas\CIO\nov_perupesca\puerto';
fnpuerto='puerto.shp';

pathvar='D:\descargas\CIO\nov_perupesca';
fntemp='sst_2.nc';
fntempo=fullfile(pathvar,fntemp);
fnsal='sal_2.nc';
fnsali=fullfile(pathvar,fnsal);
%% read shapefile peru
jj=shaperead(fullfile(pathmap,fnmap));
%%read shapefile puertos
[a,b]=shaperead(fullfile(pathpuerto,fnpuerto));


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

%% plot shapefile 
for ii=1:1:length(jj)
plot(jj(ii).X,jj(ii).Y,'k');
hold on
end
axis([-100 -68 -22 10]);
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6);
plot(lonpuertos,latpuertos,'b.');
%% read sst
lon=double(ncread(fntempo,'longitude'));
lat=double(ncread(fntempo,'latitude'));
temp=double(ncread(fntempo,'thetao'));
temp=permute(temp,[1,2,4,3]);
time=double(ncread(fntempo,'time')./24);
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1950,1,1,0,0,0));
fecha=datestr(datenum(yr,mo,da));

%% read sal
lonsal=double(ncread(fnsali,'longitude'));
latsal=double(ncread(fnsali,'latitude'));
timesal=double(ncread(fnsali,'time'))./24;
[yrsal,mosal,dasal,hrsal,misal,sesal]=datevec(double(timesal)+datenum(1950,1,1,0,0,0));
fechasal=datestr(datenum(yrsal,mosal,dasal));

sal=double(ncread(fnsali,'so'));
sal=permute(sal,[1,2,4,3]);
[lonisal,latisal]=meshgrid(lonsal,latsal);
%% lon label
[loni,lati]=meshgrid(lon,lat);
lonlab=[100:-2:68]';
latlab=[10:-2:-22]';
 for ff=1:1:length(lonlab)
    lonilab(ff,:)=string([mat2cell(lonlab(ff,1),1,1),'ºW']);
 end
lonilabel=join(lonilab,'',2);
%% lat label
for ff=1:1:length(latlab)
    if latlab(ff,1)>=0
        latilab(ff,:)=string([mat2cell(latlab(ff,1),1,1),'ºN']);
    else
        latilab(ff,:)=string([mat2cell(latlab(ff,1)*-1,1,1),'ºS']);
    end
end
latilabel=join(latilab,'',2);

%% Requested places 
%Piden 4 lugares =length(req_place);
request=1;%cambiar cuando se quiera otro lugar dentro de req_axis
req_axis=[-100 -68 -22 10;-86 -68 -22 0;-84 -77 -12 -7;-82 -74 -16 -11];
%req_axis=[-80 -77 -12 -9; -78 -76 -14.2 -11; -77.1 -76 -13 -12];
req_place_temp={'TSM PACIFICO','TSM PERU','TSM CHIMBOTE','TSM PISCO'};
req_place_sal={'SSM PACIFICO','SSM PERU','SSM CHIMBOTE','SSM PISCO'};
%% plot temp
figure 
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(time,1)
    pcolor(loni,lati,temp(:,:,i)'); shading flat; colormap jet
    colorbar; caxis([13 32]); title([req_place_temp(request),'',fecha(i,:)]);
    hold on
    if request<3
        fuente=8;
        linea=0.01;
    else
        fuente=10;
        linea=1;
    end
    [c,h]=contour(lon,lat,temp(:,:,i)',[13:1:32],'k');
    grid on
    axis square
    hold on
        for ii=1:1:length(jj)
            if request<3
                plot(jj(ii).X,jj(ii).Y,'k');
                clabel(c,h,'FontSize',fuente,'Color','k');
                text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6);
                h.LineWidth=linea;
                hold on
            else
                plot(jj(ii).X,jj(ii).Y,'k','LineWidth',2);
                clabel(c,h,'FontSize',fuente,'Color','k');
                text(lonpuertosi,latpuertosi,puertoselect,'fontsize',fuente);
                h.LineWidth=linea;
                hold on
            end
        end
    axis(req_axis(request,:));
    set(gca,'xtick',[-100:2:-68],'xticklabel',lonilabel,'fontsize',fuente);
    set(gca,'ytick',[-22:2:10],'yticklabel',flipud(latilabel),'fontsize',fuente);
    plot(lonpuertos,latpuertos,'k.');
    pause(1)
%     figure_map=[sprintf('temp_%d_request_%d',i,request),'.png'];
%     print(figure_map,'-dpng','-r500');
    clf
end
%% plot salinidad 
% aviobj = QTWriter('Chimbote.mov','FrameRate',1);
figure 
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(timesal,1)
    pcolor(lonisal,latisal,sal(:,:,i)'); shading flat; colormap parula
    colorbar; caxis([32 36]); 
    hold on
    if request<3
        interval=0.2;
        fuente=8;
        linea=0.01;
    else
        interval=0.1;
        fuente=10;
        linea=1;
    end
    [c,h]=contour(lonsal,latsal,sal(:,:,i)',[32:interval:36],'k');
     h.LineWidth=linea;
    grid on
    axis square
    hold on
        for ii=1:1:length(jj)
            if request<3
                plot(jj(ii).X,jj(ii).Y,'k');
                clabel(c,h,'FontSize',8,'Color','k');
                text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6);
                hold on               
            else
                caxis([34.3 35.4])
                plot(jj(ii).X,jj(ii).Y,'k','LineWidth',2);
                clabel(c,h,'FontSize',10,'Color','k');
                text(lonpuertosi,latpuertosi,puertoselect,'fontsize',10);
                hold on
            end
        end
    axis(req_axis(request,:));title([req_place_sal(request),'',fechasal(i,:)],'Fontsize',15);
    set(gca,'xtick',[-100:2:-68],'xticklabel',lonilabel,'fontsize',fuente);
    set(gca,'ytick',[-22:2:10],'yticklabel',flipud(latilabel),'fontsize',fuente);
    set(gca,'TickDir','out');
    plot(lonpuertos,latpuertos,'b.');
    pause(1)
%     M1=getframe(gcf);
%     writeMovie(aviobj, M1);
% figure_map=[sprintf('imagen_%d_request_%d',i,request),'.png'];
% print(figure_map,'-dpng','-r500');
 clf
end
% close(aviobj);