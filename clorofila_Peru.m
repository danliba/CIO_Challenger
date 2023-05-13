chlpath='D:\CIO\Kelvin-cromwell\clorofila';
chlfn='abril_2021.nc';
chlfns=fullfile(chlpath,chlfn);
%shapes file
%departamentos del Peru
deppath='D:\CIO\Kelvin-cromwell\clorofila\departamentos';
depfn='DEPARTAMENTOS.shp';
depfns=fullfile(deppath,depfn);

%puertos del peru
puertopath='D:\CIO\Kelvin-cromwell\clorofila\puerto';
puertofn='puerto.shp';
puertofns=fullfile(puertopath,puertofn);

lat=double(ncread(chlfns,'lat'));
lon=double(ncread(chlfns,'lon'));
chl=double(ncread(chlfns,'CHL'));
time=double(ncread(chlfns,'time'));
timechl=time+datenum(1900,1,1,0,0,0);
[yr,mo,da,hr,mi,se]=datevec(timechl);

[loni,lati]=meshgrid(lon,lat);

aviobj = QTWriter('CHL_absolutedata_CMEMS_abril.mov','FrameRate',1);%aviobj.Quality = 100;
for i=1:1:size(time,1)
pcolor(loni,lati,log10(chl(:,:,i)'));shading flat;colorbar;colormap jet
%pcolor(loni,lati,chl(:,:,i)');shading flat;colorbar;colormap jet
hc=colorbar; caxis(['auto']);
       caxis(log10([0.01 60]));
       set(hc,'ticks',log10([0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 title(datestr(datenum(yr(end),mo(end),da(i),0,0,0)));
 M1=getframe(gcf);
 writeMovie(aviobj, M1);
 pause(1)
 clf
end
close(aviobj);
disp(max(max(max(chl))))

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
%% shape file departamentos
[c,d]=shaperead(depfns);
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
end

%% Promedios 15nales
chlor15=nanmean(chl(:,:,1:15),3);
chlor30=nanmean(chl(:,:,15:end),3);

subplot(1,2,1)
pcolor(loni,lati,log10(chlor15'));shading flat; colormap jet
colorbar;
caxis(['auto']);caxis(log10([0.5 60]));
hc=colorbar; set(hc,'ticks',log10([0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 title(datestr(datenum(yr(end),mo(end),15,0,0,0)));
 xlim([-90 -65]);ylim([-22 0]);
 hold on
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
end
plot(lonpuertos,latpuertos,'b.');
%axis square
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6);
 ylabel(hc,'Clorofila mg/m^3');
 
subplot(1,2,2)
pcolor(loni,lati,log10(chlor30'));shading flat;colorbar;colormap jet
caxis(['auto']);caxis(log10([0.5 60]));
hc=colorbar; set(hc,'ticks',log10([0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));       
 title(datestr(datenum(yr(end),mo(end),30,0,0,0)));
 xlim([-90 -65]);ylim([-22 0]);
 hold on
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
end
hold on
plot(lonpuertos,latpuertos,'b.');
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',6);
axis square
ylabel(hc,'Clorofila mg/m^3');
0
%% promedio semanal
indxsel=[7,15,22,29]';
for i=1:1:size(indxsel,1) %numero de semanas
    if i==1
        chlor7(:,:,i)=nanmean(chl(:,:,1:indxsel(i)),3);
    else
        chlor7(:,:,i)=nanmean(chl(:,:,indxsel(i-1):indxsel(i)),3);
       indxsel(i-1)
       indxsel(i)
end
end
%% graficar las semanas
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1.2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

for k=1:1:size(chlor7,3)
subplot(1,4,k)
pcolor(loni,lati,log10(chlor7(:,:,k)'));shading flat; colormap jet
%colorbar;
caxis(['auto']);caxis(log10([0.5 60]));
% hc=colorbar; set(hc,'ticks',log10([0.5 1 2 3 4 5 10 20 30 40 50 60]),...
%     'ticklabels',[0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 title(datestr(datenum(2020,10,indxsel(k),0,0,0)));
 xlim([-90 -65]);ylim([-22 0]);
 hold on
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'k');
        hold on
    end
plot(lonpuertos,latpuertos,'b.');
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',5);
% ylabel(hc,'Clorofila mg/m^3');
 %hc.Location='southoutside';
 axis square
 box on
end
hc=colorbar; 
set(hc,'ticks',log10([0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'),'TickLength',0.005);
 hc.Location='southoutside';
 hc.Position=[0.17 0.15 0.7 0.03];
 ylabel(hc,'Clorofila mg/m^3');

 %% promedio semanal 2x2
 figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

 make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.01], [0.05 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end
 
for k=1:1:size(chlor7,3)
subplot(2,2,k)
pcolor(loni,lati,log10(chlor7(:,:,k)'));shading flat; colormap jet
%colorbar;
caxis(log10([0.01 60]));
% hc=colorbar; set(hc,'ticks',log10([0.5 1 2 3 4 5 10 20 30 40 50 60]),...
%     'ticklabels',[0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 text(-71,-7.5,datestr(datenum(yr(end),mo(end),indxsel(k),0,0,0)),'fontsize',12);
 hold on
    for j=1:1:size(c,1)
        plot(c(j).X,c(j).Y,'k');
        hold on
    end
plot(lonpuertos,latpuertos,'b.');
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',5);
% ylabel(hc,'Clorofila mg/m^3');
%hc.Location='southoutside';
axis equal
 box on
xlim([-90 -65]);ylim([-22 0]);

end

hc=colorbar; 
set(hc,'ticks',log10([0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'),'TickLength',0.005);
 hc.Location='eastoutside';
 hc.Position=[0.08 0.11 0.02 0.8];
 ylabel(hc,'Clorofila mg/m^3');

 %print('Clorofila_abril_2021.png','-dpng','-r500');