%extracting data in the equatorial
clear all

range0=[0 500];

path01='E:\float30mar';

%lista de directorio
hdir=dir(fullfile(path01,'argo-profiles-*.nc*'));
hdir(8) = [];
hdir(22)=[];
hdir(5:7)=[];
hdir(12:14)=[];

for ifloat=1:1:size(hdir,1)
    
fname=hdir(ifloat).name;

    depth=ncread(fname,'PRES');
    temp=ncread(fname,'TEMP');
    salt=ncread(fname,'PSAL');
    lon=ncread(fname,'LONGITUDE')';
    lat=ncread(fname,'LATITUDE')';
    time0=ncread(fname,'JULD')';
    
    disp(['number of process ... ',num2str(ifloat)])
    
    for id=1:1:size(time0,2)
        depi=depth(:,id);
        indxdepth=find(range0(1)<=depi & depi<=range0(2));
         temp2=temp(indxdepth,id);
%          temperature=nanmean(temp2,1);
         
         salt2=salt(indxdepth,id);
%          salinity=nanmean(salt2,1);
        depth2=depi(indxdepth,id);
         
         loni=lon(1,id);
         lati=lat(1,id);  
         time=time0(:,id);
        [yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1950,1,1,0,0,0));
    
        date=datenum(yr,mo,da,0,0,0)';
%          
         MD='E:\float30mar\perfiles';
         mfile=fullfile(MD,[datestr(datenum(yr,mo,da,0,0,0),'yyyymmdd'), '--', num2str(ifloat)]);
         save(mfile,'date','loni','lati','temp2','salt2','depth2');
         
%          temperature2(1:1:size(temperature,1),id)=temperature;
%          salinity2(1:1:size(salinity,1),id)=salinity;
    end
end
    
%%no funciono pq la data viene con errores
%%revisar la fecha , que no se repita
%%si se repite volver a descargar la data y evitar que la fecha se repita
%%con valores NaN en las variables, ya que al guardar se puede ver afectado
%%el codigo por la manera como esta escrita.
%%OJO-- este codigo si sirve para data sin error en largos periodos de
%%tiempo.

%%fin de la transmision