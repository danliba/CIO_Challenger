%% Pa mi causa Giane 
disp('Justin bieber')

%% Clorofila para romperle el ojo a Carrillo 
path1='D:\CIO\Kelvin-cromwell\iso15';

mapa='Mapa_Peru.mat';
ma=fullfile(path1,mapa); load(ma);
fn='clorofila.nc';

lat=double(ncread(fn,'lat'));
lon=double(ncread(fn,'lon'));
chl=double(ncread(fn,'CHL'));
time=double(ncread(fn,'time'));

[yr,mo,da]=datevec(double(time)+datenum(1900,1,1,0,0,0));

[loni,lati]=meshgrid(lon,lat);
grayColor = [.7 .7 .7];
t = datetime(yr,mo,28);
%% graficamos facilito 
labels_x={'88°W','86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};
r_huarmey=[-84 -77 -11.5 -8.5]; 

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(time,1)
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'Color',grayColor);
        hold on
    end
pcolor(loni,lati,log10(chl(:,:,i)'));shading interp;colorbar;colormap jet
%pcolor(loni,lati,chl(:,:,i)');shading flat;colorbar;colormap jet
hc=colorbar; caxis(['auto']);
       caxis(log10([0.01 100]));
       set(hc,'ticks',log10([0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60 100]),...
    'ticklabels',[0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60 100],'TickDirection',('out'));
 %title(datestr(datenum(yr(i),mo(i),28,0,0,0)));
     hold on
     axis square
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0],'fontsize',8);
    set(gca,'xtick',[-88:2:-68],'xticklabel',labels_x,'xlim',[-88 -68],'fontsize',8);
    title(['Chl-a ' '   ' datestr(t(i))]);
    %text(-73.5,-1,['Chl-a ' '   ' datestr(t(i))],'fontsize',10,'fontweight','bold')
    text(-87,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    %         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    %text(-87,-19,'Procesamiento: Gianella Bieber','color','black','fontweight','bold','fontsize',9);
    %text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
    axis(r_huarmey)
    clear c d 
    load(ma)
 mfile=['clorofila_',datestr(t(i)),'.png'];
 disp(mfile)
 print(mfile,'-dpng','-r300');
 
 pause(1)
 clf
end
