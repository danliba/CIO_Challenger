pathmap='D:\CIO\Kelvin-cromwell\anchoveta_info\anchoveta_desove\anchoveta_desove';
pathfn='D:\CIO\Kelvin-cromwell\anchoveta_info\anchoveta2';
load(fullfile(pathmap,'mapa_puertos.mat'));
fn='MUR.nc';
fns=fullfile(pathfn,fn);
%%read variables
lon=double(ncread(fns,'lon'));
lat=double(ncread(fns,'lat'));
time=double(ncread(fns,'time'))./86400;
[loni,lati]=meshgrid(lon,lat);
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1981,1,1,0,0,0));
fecha=datestr(datenum(yr,mo,da));
%area coordenadas
x1=-77-(50/60); x2=-77-(20/60); y1=-11-(40/60); y2=-11-(20/60);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
area_lab={'11º20S-11º40S/ 77º20W - 77º50W'};
%label
y_label={'12º30S','12ºS','11º30S','11ºS','10º30S'};
x_label={'79º30S','79ºS','78º30S','78ºS','77º30S','77ºS','76º30S'};
%% 
figure
P=get(gcf,'position');
P(3)=P(3)*3;
P(4)=P(4)*1.8;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for ii=2:1:size(time,1)
    
    temp=double(ncread(fn,'analysed_sst',[1 1 ii]...
        ,[length(lon) length(lat) 1],[1 1 1]));

    sst_anomaly=double(ncread(fn,'sst_anomaly',[1 1 ii]...
        ,[length(lon) length(lat) 1],[1 1 1]));
    
    %plot
    subplot(1,2,1)
    pcolor(loni,lati,temp'-273.15); shading flat; colorbar; colormap jet
    caxis([12 28]);
    hold on
    [c,h]=contour(lon,lat,temp'-273.15,[12:1:30],'k:');
    clabel(c,h);
    title(fecha(ii,:))
    hold on
    % puerto
        for jj=1:1:length(sudamerica)
        plot(sudamerica(jj).X,sudamerica(jj).Y,'k');
        hold on
        end
        text(lonpuertos_text,latpuertos_text,puertoselect,'fontsize',6);
        plot(lonpuertos,latpuertos,'b.');
    hold on
    a=plot(x,y,'b-','Linewidth',2);
    legend(a,area_lab,'fontsize',10,'Location','southwest');
    axis square
    axis([-79.5 -76.5 -12.5 -10.5]);
    set(gca,'ytick',[-12.5:0.5:-10.5],'yticklabel',y_label);
    set(gca,'xtick',[-79.5:0.5:-76.5],'xticklabel',x_label);

    subplot(1,2,2)
    pcolor(loni,lati,sst_anomaly'); shading flat; colorbar; cmocean balance;caxis([-6 6]);
    hold on
    [c,h]=contour(lon,lat,sst_anomaly',[-6:1:6],'k:');
    clabel(c,h);
    title(fecha(ii,:))
    hold on
    % puerto
        for jj=1:1:length(sudamerica)
        plot(sudamerica(jj).X,sudamerica(jj).Y,'k');
        hold on
        end
        text(lonpuertos_text,latpuertos_text,puertoselect,'fontsize',6);
        plot(lonpuertos,latpuertos,'b.');
    hold on
    a=plot(x,y,'b-','Linewidth',2);
    legend(a,area_lab,'fontsize',10,'Location','southwest');
    axis([-79.5 -76.5 -12.5 -10.5]);
    set(gca,'ytick',[-12.5:0.5:-10.5],'yticklabel',y_label);
    set(gca,'xtick',[-79.5:0.5:-76.5],'xticklabel',x_label);
    axis square
    
    pause(0.1)
     figure_map=[sprintf('imagen_%d',ii),'.png'];
     print(figure_map,'-dpng','-r500');
    clf
end
