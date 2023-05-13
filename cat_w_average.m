%% Cat weekly average
clear all
close all
clc

path0='G:\ocean ecosystem dynamics laboratory\boyas\Semanal\buoy_read';

hdir=dir(fullfile(path0,'*-w-*'));

iter=0;
yrst=2020;
yren=2020;
%%hoy-1
ystd=today-1;
[yr,mo,da,hr,mi,se]=datevec(double(ystd));
w=week(datetime(yr,mo,da,hr,0,0));

weekst=w-3;
weeknd=w;

weekn0=weeknd;
monti=0;
figure
   for iy=yrst:1:yren
    
         if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=weekn0;
    else
        weeknd=12;
    end
    
    for iw=weekst:1:weeknd
        
       disp(['Year: ' num2str(iy) ' week: ' num2str(iw)])
        monti=monti+1;
        
for isst=1:1:size(hdir,1)
    iter=iter+1;
   fname=[hdir(isst).name]; 
   load(fname)
   
    lonsst1(:,isst)=lon;
    
     %[yr,mo,da,hr,mi,se]=datevec(time2);
%     daynum=datestr(datenum(iy,iw,15,0,0,0));
%     daynum2=datenum(iy,iw,15,0,0,0);
    indx0=find(yr==iy&weeks==iw);
        datab=cat(2,depth,SST(:,indx0),repmat(lon(1,1),[size(depth(:,1),1),1]));
        
        j=0;
        for iz=5:5:500
         
         j=j+1;
         
         indx=find(datab(:,1)==iz);
         
         if ~isempty(indx)
             tempclim(j,isst)=datab(indx,2);
             depthcl(j,isst)=datab(indx,1);
             lon(j,isst)=datab(indx,3);
             
         else
             tempclim(j,isst)=NaN;
             depthcl(j,isst)=NaN;
            lon(j,isst)=NaN;
         end
     end
 
        
    end
    
  

%% Order long 

lonsst1(lonsst1<0)=lonsst1(lonsst1<0)+360;
[lonb,Indx]=sort(lonsst1(1,:),2);
lonb=lonsst1(:,Indx);
tempclim2=double(tempclim(:,Indx));
depthcl2=double(depthcl(:,Indx));


%% Interpolation

[ai,bi]=meshgrid(1:1:size(hdir,1),1:1:size(depthcl2,1));
SSTclimb=griddata(ai(~isnan(tempclim2)),bi(~isnan(tempclim2)),tempclim2(~isnan(tempclim2)),ai,bi);
%sal3=griddata(xi(~isnan(salb)),di(~isnan(salb)),salb(~isnan(salb)),xi,di);
depthcl3=griddata(ai(~isnan(depthcl2)),bi(~isnan(depthcl2)),depthcl2(~isnan(depthcl2)),ai,bi);

%size(depthcl3(:,1),1)

pcolor(lonb,-depthcl3,SSTclimb); shading flat; colormap jet; colorbar;
hold on
[c,h]=contour(lonb,-depthcl3(1:100,1),SSTclimb,'k:');
clabel(c,h);
title(num2str(iw));
pause(0.5)
clf

SST_weekly(:,:,monti)=SSTclimb;
timeis(monti,1)=iw;
end
   end
% % 
JM='G:\ocean ecosystem dynamics laboratory\boyas\Semanal\boy_w_anom';
mfile=fullfile(JM,'Buoy_weekly_average');
save(mfile,'SST_weekly','timeis','depthcl3');