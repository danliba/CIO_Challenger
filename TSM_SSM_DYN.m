fn='outfile.nc';

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
temp=double(ncread(fn,'thetao'));
sal=double(ncread(fn,'so'));
ssh=double(ncread(fn,'zos'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

%colorcito
grayColor = [.5 .5 .5];
t = datetime(yr,mo,15);
%mapa
load('Mapa_Peru.mat');
%% Graficamos Temperatura
%colocar la zona deseada
r_huarmey=[-84 -77 -11.5 -8.5]; 

labels_x={'90°W','88°W','86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*1.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(time,1)
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'Color',grayColor);
        hold on
    end

    pcolor(lon,lat,temp(:,:,:,i)');shading interp; colorbar; colormap jet;
    caxis([12 32]);
    hold on
    [cc,h]=contour(lon,lat,temp(:,:,:,i)',[15:1:26],'k:');
    w = h.LineWidth;
    h.LineWidth = 0.4;
    clabel(cc,h,'Fontsize',8);
    hc=colorbar;
    set(hc,'ticks',[12:2:32],'TickDirection',('out'),'TickLength',0.005);
    ylabel(hc,'Temperatura [°C]');
    title(['Temperatura Superficial del Mar  ',datestr(t(i))],'fontsize',12)
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
    set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
    text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
    axis(r_huarmey)
    
     mfile=['temp_',datestr(t(i)),'.png'];
     disp(mfile)
     print(mfile,'-dpng','-r300');
 
    pause(1)
    clf
end


%% Salinidad 
load('MA_peru.mat');

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*1.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(time,1)
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'Color',grayColor);
        hold on
    end

    pcolor(lon,lat,sal(:,:,:,i)');shading interp; colorbar; colormap jet;
    caxis([33 36]);
    hold on
    [cc,h]=contour(lon,lat,sal(:,:,:,i)',[34.8:.1:35.5],'k:');
    w = h.LineWidth;
    h.LineWidth = 0.4;
    clabel(cc,h,'Fontsize',8);
    hc=colorbar;
    set(hc,'ticks',[33:.2:36],'TickDirection',('out'),'TickLength',0.005);
    ylabel(hc,'Salinidad [UPS]');
    title(['Salinidad Superficial del Mar ',datestr(t(i))],'fontsize',12)
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
    set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
    text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
    axis(r_huarmey)
    
    mfile=['sal_',datestr(t(i)),'.png'];
    disp(mfile)
    print(mfile,'-dpng','-r300');
    
     pause(1)
    clf
end

%% SSH 

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*1.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for i=1:1:size(time,1)
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'Color',grayColor);
        hold on
    end

    pcolor(lon,lat,ssh(:,:,i)');shading interp; colorbar; colormap jet;
    caxis([0 0.3]);
    hold on
    [cc,h]=contour(lon,lat,ssh(:,:,i)',[0:.05:0.3],'k:');
    w = h.LineWidth;
    h.LineWidth = 0.4;
    clabel(cc,h,'Fontsize',8);
    hc=colorbar;
    set(hc,'ticks',[0:.05:0.3],'TickDirection',('out'),'TickLength',0.005);
    ylabel(hc,'SSH [m]');
    title(['Altura superficial del Mar ',datestr(t(i))],'fontsize',12)
    text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
    ax = gca;
    set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
    set(gca,'xtick',[-90:2:-68],'xticklabel',labels_x,'xlim',[-90 -68]);
    text(-89,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
    text(-89,-19,'Procesamiento: CIO-CHALLENGER','color','black','fontweight','bold','fontsize',9);
    %axis(r_huarmey)
    
%     mfile=['ssh_',datestr(t(i)),'.png'];
%     disp(mfile)
%     print(mfile,'-dpng','-r300');
    
    pause(1)
    clf
end





