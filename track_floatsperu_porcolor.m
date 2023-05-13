%% Trayectoria por longitud de diferentes colores

range1=[-95 -90 -85 -80];

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
     
     indxlonR0=find(range1(1)<=lon & lon<=range1(2));
     indxlonAm0=find(range1(2)<=lon & lon<=range1(3));
     indxlonAz0=find(range1(3)<=lon & lon<=range1(4));
     
     lonR0=lon(indxlonR0);
     lonAm0=lon(indxlonAm0);
     lonAz0=lon(indxlonAz0);

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
     lonR1(1:size(lonR0,1),itray)=lonR0;
     lonAm1(1:size(lonAm0,1),itray)=lonAm0;
     lonAz1(1:size(lonAz0,1),itray)=lonAz0;
     
     lat2(lat2==0)=NaN;
     lon2(lon2==0)=NaN;
     lon2(lon2==0)=NaN;
     date2(date2==0)=NaN;
     fnumber(fnumber==0)=NaN;
     lonR1(lonR1==0)=NaN;
     lonAm1(lonAm1==0)=NaN;
     lonAz1(lonAz1==0)=NaN;
     
   
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

h=pcolor(longitude,latitude,topo);
shading flat;cmocean('topo'); 
c=colorbar;
c.Label.String='Depth in m';
caxis([-4500 0]);
set(gca,'xtick',[262:2:286],'xticklabel',[-98:2:-74],'xlim',[262 286]);
title('Floats 0ºS-18ºS/ 95ºW-80ºW');
hold on

a=plot(lonAz1+360,lat2(1:length(lonAz1),:),'go--');
hold on
b=plot(lonAm1+360,lat2(1:length(lonAm1),:),'yo--');
hold on
c=plot(lonR1+360,lat2(1:length(lonR1),:),'ro--');

xlim([262 284]); xlabel('Longitud (ºW)');
ylim([-20 5]); ylabel('Latitud (ºS)');

%  MD='G:\ocean ecosystem dynamics laboratory\argo floats\float_peru';
%  mfile=fullfile(MD,'Flotadores Peru_colores');
%  print(mfile,'-dpng','-r500');

%legend('85-80ºW','90-85ºW','95-90ºW');
%},

