%%Codigo de trayectorias en la linea ecuatorial
%%Dudas sobre el codigo escribir a 20141316@lamolina.edu.pe %%DLB

path01='F:\float30mar';
path02='G:\ocean ecosystem dynamics laboratory\CIO\deepnija';
topofn='data.nc';
topofns=fullfile(path02,topofn);
hdir=dir(fullfile(path01,'argo-trajectory-*.nc'));%%directorio

%loop que lee cada flotador desde 1 hasta el tamaño asignado hdir
for itray=1:1:size(hdir,1)
      %leyendo cada archivo nc
      fname=hdir(itray).name;
      
      %leyendo las variables de cada archivo nc por separado
      Nfloat=ncread(fname,'PLATFORM_NUMBER');
%       Ncycle=ncread(fname,'CYCLE_NUMBER');
%       DCR=ncread(fname,'DC_REFERENCE');
      time=ncread(fname,'JULD');
      lat=ncread(fname,'LATITUDE');
      lon=ncread(fname,'LONGITUDE');
       
      
     Nfloat=Nfloat(:,1);
     numflot=Nfloat';
     numflot=str2num(numflot);
   
     %%almacenando la latitud,longitud y tiempo de cada flotador en la
     %%primera dimension
      lat2(itray,1:size(lat,1))=lat;
      lon2(itray,1:size(lon,1))=lon;
      date(itray,1:size(time,1))=time;
      
      %%si lat2 es 0, reemplazar por NaN (not a number)
      lat2(lat2==0)=NaN;
      lon2(lon2==0)=NaN;
      date(date==0)=NaN;
    %almacenamos el nombre de cada flotador %%para ver colocar
    %disp(numfloat)
     numfloat(itray,1)=numflot;
     
     [yr,mo,da,hr,mi,se]=datevec(double(time(1,1))+datenum(1950,1,1,0,0,0));
     daynum=datestr(datenum(yr,mo,da,hr,mi,se));
      disp([num2str(numflot),'--', daynum])
     
end

%%ordenar en orden de menor a mayor 
lon2(lon2<0)=lon2(lon2<0)+360;
[lonb,Indx]=sort(lon2(:,1),1);
lonb2=lon2(Indx,:);
latb2=lat2(Indx,:);

%% plot
latitude=ncread(topofns,'Y');
longitude=ncread(topofns,'X');
topo=ncread(topofns,'bath');
topo=topo';

figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*0.7;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

pcolor(longitude,latitude,topo);
shading flat;cmocean('topo'); 
c=colorbar;
c.Label.String='Depth in m';
caxis([-4500 0]);
hold on
plot(lonb2(:,1),latb2(:,1),'ko--','markerfacecolor','g');
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[140 280]);
set(gca,'ytick',[-5:1:5],'yticklabel',[-5:1:5]);
ylim([-5 5]);
title('Ubicacion Argo Float 150E-85W'); 
ylabel('Latitud'); xlabel('Longitud');
xlim([150 280]);
text(255,-4,'Fuente: ARGO & NGDC','color','w','fontweight','bold');
text(255,-4.5,'Procesamiento: CIO','color','w','fontweight','bold');
%saveas(gcf,'Ubicacion Argo Float vs batimetria 150E-85W.jpg','jpg');


%% Cite this code
%Daniel Lizarbe B.
%12/05/2019
%Argo floats track along the Equatorial line 
%Code version 2.0
%MATLAB 2017
%TUMSAT