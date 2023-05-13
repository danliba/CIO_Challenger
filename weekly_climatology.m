%% Climatologia semanal
%% 95W
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=95;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=double(ncread(fns,'time'));

[yr,mo,da,hr,mi,se]=datevec(time+datenum(1981,7,5,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST95W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST95W','ST','weeks','depth','time','lon');

%% 110W
clear all
close all
clc

path0='D:\CIO\Kelvin-cromwell\boyas';

boy=110;
buoy=sprintf('t0n%dw_dy.cdf',boy);
buoys=fullfile(path0,buoy);

lon=double(ncread(buoys,'lon'));
lat=double(ncread(buoys,'lat'));
depth=double(ncread(buoys,'depth'));

time=ncread(buoys,'time');

[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1980,3,7,0,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

%[loni,depi]=meshgrid(lon,depth);

weekst=1;
weeknd=54;
% dast=1;
% daen=15;
% daen0=daen;
iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(buoys,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST110W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST110W','weeks','ST','depth','time','lon');
% 
%% 125W
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=125;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1983,10,30,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST125W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST125W','ST','weeks','depth','time','lon');

%% 140W
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';


boy=140;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1983,4,16,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST140W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST140W','ST','weeks','depth','time','lon');

%% 155W
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=155;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1991,7,21,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST155W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST155W','ST','weeks','depth','time','lon');

%% 170W
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=170;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1988,5,16,12,0,0));


time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST170W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST170W','ST','weeks','depth','time','lon');

%% 180
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas\boyas_202006030';


boy=180;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1993,3,27,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST180W=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\boyas_202006030\perfiles';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST180W','ST','weeks','depth','time','lon');

%% 165E
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=165;
fn1=sprintf('t0n%de_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1986,1,20,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST165E=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST165E','ST','weeks','depth','time','lon');

%% 156E
clear all
close all
clc 

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=156;
fn1=sprintf('t0n%de_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1991,8,29,12,0,0));

time=datenum(yr,mo,da,hr,mi,se);

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

weekst=1;
weeknd=54;

iter=0;

    for iw=weekst:1:weeknd
        iter=iter+1;
        disp(['week: ' num2str(iw)])
        
        indx=find(w==iw);
        
        numrec=length(indx);
        
        for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            %transpose data
            temp2=temp;
            %temp2=permute(temp,[1 3 4 2]);
            masknan=double(~isnan(temp2));
            temp2(isnan(temp2))=0;
            
            if irec==1
                SSTm=zeros(size(temp2));
                numnonnan=zeros(size(temp2));
            end
            
            SSTm=SSTm+temp2;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        weeks(iw,1)=iw;
     end
 
%       end

    ST=permute(SSTs,[3,4,1,2]);
    SST156E=ST;
    
    [weeki,dep]=meshgrid(weeks,depth);
    
[c,h]=contourf(weeki,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
clabel(c,h); title(lon);

 
JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,['Boya_Nº' num2str(lon)]);
save(mfile,'SST156E','ST','weeks','depth','time','lon');



