clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas\boyas_202109004';
hdir=dir(fullfile(path1,'c*.cdf'));
mkdir perfiles
iter=0;
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
w=week(t);

weekst=1;
weeknd=52;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            

            masknan=double(~isnan(temp));
            temp(isnan(temp))=0;
            
            if irec==1
                SSTm=zeros(size(temp));
                numnonnan=zeros(size(temp));
            end
            
            SSTm=SSTm+temp;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    
    [weeki,dep]=meshgrid(weeks,depth);
formatSpec= ['La climatologia semanal de la boya ',platform_code,' se ha realizado exitosamente'];
  disp(formatSpec)    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(platform_code);
pause(2)
clf
%store the data boyas_202007019
JM='D:\CIO\Kelvin-cromwell\boyas\boyas_202109004';
mfile=fullfile(JM,['Boya_climatologia_', platform_code]);
save(mfile,'ST','weeks','depth','time_boya','lon');

%clear after saving
clear iw indx numrec irec temp masknan SSTm numnonnan SSTs weeks 
%  keepvars={path1,hdir};
% clearvars('-except', keepvars{:});
end

