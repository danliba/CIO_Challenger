%%%weekly average data
%%%% 95W
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=95;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=double(ncread(fns,'time'));
[yr,mo,da,hr,mi,se]=datevec(time+datenum(1981,7,5,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;

weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));%%dividr entre numero de dias 
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
      title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(2)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');
%% 110w
clear all
close all
clc

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=110;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1980,3,7,0,0,0));
t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
       title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

%% 125W
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=125;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1983,10,30,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
       title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

%% 140W
clear all
clc
close all


path1='D:\CIO\Kelvin-cromwell\boyas';


boy=140;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1983,4,16,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
      title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

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

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
      title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');


%% 170W
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=170;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1988,5,16,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
     title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

%% 180W
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=180;
fn1=sprintf('t0n%dw_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1993,3,27,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
       title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

%% 165E
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=165;
fn1=sprintf('t0n%de_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1986,1,20,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
       title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');

%% 156E
clear all
clc
close all

path1='D:\CIO\Kelvin-cromwell\boyas';

boy=156;
fn1=sprintf('t0n%de_dy.cdf',boy);
fns=fullfile(path1,fn1);
lon=double(ncread(fns,'lon'));
lat=ncread(fns,'lat');
depth=double(ncread(fns,'depth'));
time=ncread(fns,'time');
[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1991,8,29,12,0,0));

t=datetime(yr,mo,da,hr,0,0);
w=week(t);

iter=0;
% yrst=yr(1,1);
yrst=2020;

yren=yr(end,1);
% most=mo(1,1);

weeknd=w(end,1);
week0=weeknd;
weekst=week0-3;

figure
for iy=yrst:1:yren
    if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=week0;
    else
        weeknd=54;
    end
       
    for iw=weekst:1:weeknd
       iter=iter+1;      
     
  
       indx0=find(yr==iy&w==iw);
       
%        daynum=datestr(datenum(iy,iw,0,0,0,0));
       
       numrec=length(indx0);
       
       for irec=1:1:numrec

       temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
           [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
       
       temp=permute(temp,[3,4,1,2]);
       masknan=double(~isnan(temp));
       temp(isnan(temp))=0;
       
       if irec==1
           sstm=zeros(size(temp));
           numnonnan=zeros(size(temp));
       end
       sstm=sstm+temp;
       numnonnan=numnonnan+masknan;
       
       end
          sstm=sstm./numnonnan;
          
       scatter(sstm,-depth);
      title([num2str(lon) 'ºE '  'week Nº '  num2str(iw)]);
       pause(0.5)
       clf
       
       SST(:,iter)=sstm;
       weeks(iter,:)=iw;
      end
      
      % time2(iter,1)=datenum(iy,iw,15,0,0,0);
    end


JM='D:\CIO\Kelvin-cromwell\boyas\boya_example';
mfile=fullfile(JM,['Boya-w-' num2str(lon)]);
save(mfile,'SST','weeks','lon','depth');
