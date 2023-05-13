fnsal='global-analysis-forecast-phy-001-024_1607384544993.nc';
pathmap='D:\CIO\Kelvin-cromwell\anchoveta_info\anchoveta_desove\anchoveta_desove';
fnmap='mapa_puertos.mat';
%puertos data read
load(fullfile(pathmap,fnmap));
%sal data read
lon=double(ncread(fnsal,'longitude'));
lat=double(ncread(fnsal,'latitude'));
time=double(ncread(fnsal,'time'))./24;

[yrsal,mosal,dasal,hrsal,misal,sesal]=datevec(double(time)+datenum(1950,1,1,0,0,0));
fecha=datestr(datenum(yrsal,mosal,dasal));

sal=double(ncread(fnsal,'so'));
sal=permute(sal,[1,2,4,3]);
[loni,lati]=meshgrid(lon,lat);
%lugares
req_axis=[-80 -77 -12.2 -9; -78 -76 -14.2 -11];
request=1;
%areas
selected_area=[-78-(40/60) -78-(10/60) -10.5 -10; -79 -78-(10/60) -10-(50/60) -10 ...
    ;-78-(35/60) -78-(5/60) -11.5 -10-(50/60)];
area_lab={'10ºS-10º30S/78º10W-78º40W','10ºS-10º50S/79ºW-78º10W'...
    ,'10º50S-11º30S/78º05W-78º35W'};
color_lab={'k','r','m'};

%% figure
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for isal=1:1:size(time,1)
% plot
    pcolor(loni,lati,sal(:,:,isal)'); shading interp; colorbar; colormap parula
    caxis([34.8 35.3]);
    hold on
    [c,h]=contour(lon,lat,sal(:,:,isal)',[34.8:.1:35.5],'k:');
    clabel(c,h);
    title(fecha(isal,:))
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
        for ii=1:1:size(selected_area,1)
        a(ii)=plot([selected_area(ii,1) selected_area(ii,2) selected_area(ii,2)...
            selected_area(ii,1) selected_area(ii,1)],[selected_area(ii,3) ...
            selected_area(ii,3) selected_area(ii,4) selected_area(ii,4) ...
            selected_area(ii,3)],char(color_lab(ii)),'linewidth',2);
        hold on
        end
        legend(a,area_lab,'fontsize',8,'Location','southwest');
        axis(req_axis(request,:));
        axis square   
    pause(0.5)

figure_map=[sprintf('imagen_%d_request_%d',isal,request),'.png'];
print(figure_map,'-dpng','-r500');
clf
end