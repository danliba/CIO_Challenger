%Crea la climatologia mensual de la velocidad de las boyas doppler

%%
clear all
close all
clc

path1='D:\CIO\ayuda\velocidad_u';
hdir=dir(fullfile(path1,'c*a*.cdf'));
mkdir perfiles

figure
for iboya=1:1:size(hdir,1)
    fns=hdir(iboya).name;
    lon=double(ncread(fns,'lon'));
    lat=ncread(fns,'lat');
    depth=double(ncread(fns,'depth'));
    time=ncread(fns,'time');
    platform_code=ncreadatt(fns,'/','platform_code');
    creation_day=ncreadatt(fns,'time','units');
    yy=str2num(creation_day(12:15)); mm=str2num(creation_day(17:18)); dd=str2num(creation_day(20:21)); hr=str2num(creation_day(23:24));

    time_boya=double(time)+datenum(yy,mm,dd,hr,0,0);
    [yr,mo,da,hr,mi,se]=datevec(time_boya);
    
    t=datetime(yr,mo,da,hr,0,0);
    iter=0;
    for im=1:1:12
        disp(['Month: ' num2str(im)])
        indx=find(mo==im);
        iter=iter+1;
         numrec=length(indx);
    
        for irec=1:1:numrec
            velu=ncread(fns,'u_1205',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            masknan=double(~isnan(velu));
            velu(isnan(velu))=0;
            
            if irec==1
                velum=zeros(size(velu));
                numnonnan=zeros(size(velu));
            end
            
            velum=velum+velu;
            numnonnan=numnonnan+masknan;
        end
        velum=velum./numnonnan;
        uvel(:,:,:,iter)=velum;
        months(im,1)=im;
     end

    u_vel=permute(uvel,[3,4,1,2]);
    
    [monti,dep]=meshgrid(months,depth);
formatSpec= ['La climatologia semanal de la boya ',platform_code,' se ha realizado exitosamente'];
  disp(formatSpec)    
% [c,h]=contourf(monti,-dep,u_vel,':'); shading flat; colorbar; colormap jet;
% clabel(c,h); title(platform_code);
% pause(2)
% clf
%store the data 
JM='D:\CIO\ayuda\velocidad_u\perfiles';
mfile=fullfile(JM,['Boya_climatologia_', platform_code]);
save(mfile,'u_vel','months','depth','time_boya','lon','platform_code');

%clear after saving
clear im indx numrec irec velu masknan velum numnonnan uvel months
%  keepvars={path1,hdir};
% clearvars('-except', keepvars{:});
end



