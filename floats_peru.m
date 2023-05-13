%% Leyendo floats en Peru 0S-18S/95W-80W

%ruta
path01='D:\descargas\DataSelection_20200320_225440_9715145';

%lista de directorio
hdir=dir(fullfile(path01,'argo-profiles-*.nc*'));
  hdir(2) = [];
  hdir(4)= [];
  hdir(6)= [];
  hdir(12:16)=[];
  hdir(29)=[];
  
%%rango de tiempo 
daT=[0 10];
moT=[8];
yrT=[2019];

rangeT=datenum(yrT,moT,daT,0,0,0);

%%rango de tiempo total
daT1=[0 30];
moT1=[8 12];
yrT1=[2019];

rangeT1=datenum(yrT1,moT1,daT1,0,0,0);
%%rango de profundidad
range0=[0 100];
%loop que lee cada flotador desde 1 hasta el tamaño asignado hdir
iter=0;
%  for ik=1:1:size(rangeT,2)-1
%      disp(ik)
     iter=iter+1;
     ik=1;
for ifloat=1:1:size(hdir,1)
   
    %llamando al archivo nc
    fname=hdir(ifloat).name;
    %leer la data
    depth0=ncread(fname,'PRES');
    temp0=ncread(fname,'TEMP');
     salt0=ncread(fname,'PSAL');
    lon0=ncread(fname,'LONGITUDE');
    lat0=ncread(fname,'LATITUDE');
    time0=ncread(fname,'JULD');
    
    %seleccionar solo columnas impares 
    depth=depth0(:,1:2:end);
    temp=temp0(:,1:2:end);
     salt=salt0(:,1:2:end);
    lon=lon0(1:2:end,:);
    lat=lat0(1:2:end,:);
    time=time0(1:2:end,:);
    
    %convertir julian days 
    [yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1950,1,1,0,0,0));
    
    disp(['number of process ... ',num2str(ifloat)])
%     disp(da)
%     pause(1)
     date=datenum(yr,mo,da,0,0,0);
     fecha=date';
     %encontrar el indx
     indxT=find(rangeT(ik)<=date & date<=rangeT(ik+1));
     [indxdep,depindx]=find(range0(1)<=depth(:,indxT) & depth(:,indxT)<=range0(2));
     
    % depindexcat(:,ifloat)=depindx;
     %indxT2=indxT;
%      A=size(indxT,2);
%      if size(indxT==2)
%          indxT2=[];
%      end
         
      disp(indxT)
     %seleccionar la data hasta los 100m
     depthi=depth(indxdep);
     tempi=temp(indxdep); %%aqui es donde falla!!!
     disp(tempi)
     %pause(1)
     tempi2=nanmean(tempi,1);
     %%seleccionar data por tiempo
     timeTi=date(indxT);
      indxt2=find(indxT==1);
     tempTi=tempi2(indxt2);

%      disp(['tempi size ...' ,num2str(size(tempi))])
     %leer data
     lat2(1:size(lat,1),ifloat)=lat;
     lon2(1:size(lon,1),ifloat)=lon; 
     date2(1:size(date,1),ifloat)=date;
     timeT(1:size(timeTi,1),ifloat)=timeTi;
     tempT(1:size(tempTi,1),ifloat)=tempTi;
  
  
      date2(date2==0)=NaN;
      lat2(lat2==0)=NaN;
      lon2(lon2==0)=NaN;
      tempT(tempT==0)=NaN;

end

Temperature(ik,:)=tempT;

%  end

%% days count
date2(isnan(date2))=0;
start0=date2(1,:)';
for i=1:1:size(hdir,1)
    
end0=max(date2(:,i));
end0day(1:size(end0,1),i)=end0;
end
start0day=num2str(datestr(start0));
endday=num2str(datestr(end0day));
% 
%notfinished
    