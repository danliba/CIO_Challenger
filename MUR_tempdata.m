
pathmap='D:\CIO\Kelvin-cromwell\anchoveta_info\anchoveta_desove\anchoveta_desove';
hdir=dir(fullfile(pathmap,'20*.nc')); hdir(1)=[];
load(fullfile(pathmap,'mapa_puertos.mat'));
%limites
req_axis=[-80 -77 -12.2 -9; -78 -76 -14.2 -11];
request=1;
%areas
selected_area=[-78-(40/60) -78-(10/60) -10.5 -10; -79 -78-(10/60) -10-(50/60) -10 ...
    ;-78-(35/60) -78-(5/60) -11.5 -10-(50/60)];
area_lab={'10ºS-10º30S/78º10W-78º40W','10ºS-10º50S/79ºW-78º10W'...
    ,'10º50S-11º30S/78º05W-78º35W'};
color_lab={'k','r','m'};
%% fig
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for imur=1:1:size(hdir,1)
    fn=hdir(imur).name;
    fns=fullfile(pathmap,fn);
    range0=[-90 -65 -22 5];
    lon=double(ncread(fns,'lon'));
    lat=double(ncread(fns,'lat'));
    time=double(ncread(fns,'time'))./86400;
    [yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1981,1,1,0,0,0));
    fecha=datestr(datenum(yr,mo,da));
    indxlon=find(lon>=range0(1) & lon<=range0(2));
    indxlat=find(lat>=range0(3) & lat<=range0(4));
    lon=lon(indxlon);
    lat=lat(indxlat);
    temp=double(ncread(fn,'analysed_sst',[indxlon(1) indxlat(1) 1]...
        ,[length(lon) length(lat) 1],[1 1 1]));

    sst_anomaly=double(ncread(fn,'sst_anomaly',[indxlon(1) indxlat(1) 1]...
        ,[length(lon) length(lat) 1],[1 1 1]));

    [loni,lati]=meshgrid(lon,lat);
%% plot
     subplot(1,2,1)
    pcolor(loni,lati,temp'-273.15); shading flat; colorbar; colormap jet
    caxis([12 28]);
    hold on
    [c,h]=contour(lon,lat,temp'-273.15,[12:1:30],'k:');
    clabel(c,h);
    title(fecha)
    hold on
    % puerto
        for ii=1:1:length(sudamerica)
        plot(sudamerica(ii).X,sudamerica(ii).Y,'k');
        hold on
        end
        axis([-100 -68 -22 10]);
        text(lonpuertos_text,latpuertos_text,puertoselect,'fontsize',6);
        plot(lonpuertos,latpuertos,'b.');
    hold on
        for i=1:1:size(selected_area,1)
        a(i)=plot([selected_area(i,1) selected_area(i,2) selected_area(i,2)...
            selected_area(i,1) selected_area(i,1)],[selected_area(i,3) ...
            selected_area(i,3) selected_area(i,4) selected_area(i,4) ...
            selected_area(i,3)],char(color_lab(i)),'linewidth',2);
        hold on
        end
        legend(a,area_lab,'fontsize',8,'Location','southwest');
        axis(req_axis(request,:));
        axis square
    
    subplot(1,2,2)
    pcolor(loni,lati,sst_anomaly'); shading flat; colorbar; cmocean balance;caxis([-6 6]);
    hold on
    [c,h]=contour(lon,lat,sst_anomaly',[-6:1:6],'k:');
    clabel(c,h);
    title(fecha)
    hold on
    % puerto
        for ii=1:1:length(sudamerica)
        plot(sudamerica(ii).X,sudamerica(ii).Y,'k');
        hold on
        end
        axis([-100 -68 -22 10]);
        text(lonpuertos_text,latpuertos_text,puertoselect,'fontsize',6);
        plot(lonpuertos,latpuertos,'b.');
        hold on
        for i=1:1:size(selected_area,1)
        a(i)=plot([selected_area(i,1) selected_area(i,2) selected_area(i,2)...
            selected_area(i,1) selected_area(i,1)],[selected_area(i,3) ...
            selected_area(i,3) selected_area(i,4) selected_area(i,4) ...
            selected_area(i,3)],char(color_lab(i)),'linewidth',2);
        hold on
        end
        legend(a,area_lab,'fontsize',8,'Location','southwest');
        axis(req_axis(request,:));
        axis square
    pause(0.5)

% figure_map=[sprintf('imagen_%d_request_%d',imur,request),'.png'];
% print(figure_map,'-dpng','-r500');
clf
end