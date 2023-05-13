%%Codigo para hallar la trayectoria de los flotadores en Peru 
%%Dudas sobre el codigo escribir a 20141316@lamolina.edu.pe %%DLB

%ruta
path01='D:\descargas\DataSelection_20200320_225440_9715145';
path02='G:\ocean ecosystem dynamics laboratory\CIO\deepnija';
topofn='data.nc';
topofns=fullfile(path02,topofn);

%lista de directorio
hdir=dir(fullfile(path01,'argo-trajectory-*.nc'));

%loop que lee cada flotador desde 1 hasta el tamaño asignado hdir
for itray=1:1:size(hdir,1)
    
    %llamando al archivo nc
     fname=hdir(itray).name;
     
     time=ncread(fname,'JULD');
     lat=ncread(fname,'LATITUDE');
     lon=ncread(fname,'LONGITUDE');
     arraylength0=length(lon);
     Nfloat=ncread(fname,'PLATFORM_NUMBER');
     Nfloat=Nfloat(:,1);
     Nfloat=Nfloat';
     Nfloat=str2num(Nfloat);
     
     [yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1950,1,1,0,0,0));
     
     date=datenum(yr,mo,da,0,0,0);
     
     lat2(1:size(lat,1),itray)=lat;
     lon2(1:size(lon,1),itray)=lon; 
     date2(1:size(date,1),itray)=date;
     fnumber(1:size(Nfloat,1),itray)=Nfloat;
     arraylength(1:size(arraylength0,1),itray)=arraylength0;
     
     lat2(lat2==0)=NaN;
     lon2(lon2==0)=NaN;
     lon2(lon2==0)=NaN;
     date2(date2==0)=NaN;
     fnumber(fnumber==0)=NaN;
   
end   

date2(isnan(date2))=0;
%% PLOT

latitude=ncread(topofns,'Y');
longitude=ncread(topofns,'X');
topo=ncread(topofns,'bath');
topo=topo';

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*1.8;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

pcolor(longitude,latitude,topo);
shading flat;cmocean('topo'); 
c=colorbar;
c.Label.String='Depth in m';
caxis([-4500 0]);
set(gca,'xtick',[262:2:286],'xticklabel',[-98:2:-74],'xlim',[262 286]);
title('Floats 0ºS-18ºS/ 95ºW-80ºW');
hold on
% gif('Flotadores.gif','frame',gcf,'delaytime',1/2,'nodither')

iter=0;
formatOut = 'mm/dd/yy';
for i=1:1:size(hdir,1)
    iter=iter+1;
    txt=['Float Nº ',num2str(fnumber(:,i))];
    plot(lon2(:,i)+360,lat2(:,i),'o--','DisplayName',txt);
    hold on
    

        ylat=[lat2(1,i)];
        ylat0=[lat2(arraylength(1,i),i)];
        xlon=[lon2(1,i)];
        xlon0=[lon2(arraylength(1,i),i)];
        dia=num2str(datestr(date2(1,i),formatOut));
        dia0=num2str(datestr(date2(arraylength(1,i),i),formatOut));
        text(xlon+360,ylat,dia);
        text(xlon0+360,ylat0,dia0);

    xlim([262 284]); xlabel('Longitud (ºW)');
    ylim([-20 5]); ylabel('Latitud (ºS)');


    pause(0.5)
    disp(['number of process ... ',num2str(iter)])
    legend('Location','northeastoutside');
    legend('Orientation','vertical');
    legend show
% gif
end
% % 
%  MD='G:\ocean ecosystem dynamics laboratory\argo floats\float_peru';
%  mfile=fullfile(MD,'Flotadores Peru_inicio');
%  print(mfile,'-dpng','-r500');

%% Cite this code
%Daniel Lizarbe B.
%03/03/2020
%Argo floats track along the Peruvian Coast 
%Code version 1.0
%MATLAB 2016
%UNALM

    