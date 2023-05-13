fnsal='global-analysis-forecast-phy-001-024_1609527482030.nc';
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
    a=plot(x,y,'b-','Linewidth',2);
    legend(a,area_lab,'fontsize',10,'Location','southwest');
    axis square
    axis([-79.5 -76.5 -12.5 -10.5]);
    set(gca,'ytick',[-12.5:0.5:-10.5],'yticklabel',y_label);
    set(gca,'xtick',[-79.5:0.5:-76.5],'xticklabel',x_label);
    
    pause(0.1)
    figure_map=[sprintf('sal_%d',isal),'.png'];
    print(figure_map,'-dpng','-r500');
    clf
end
