%% weekly Climatology until April 2020
clear all
clc
close all

path0='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';

hdir=dir(fullfile(path0,'B*.mat'));
hdir(4) = []; 

for i=1:1:54
iter=0;

for iclim=1:1:size(hdir,1)
    iter=iter+1;
   fname=[hdir(iclim).name]; 
   load(fname)
   
    loncl1(:,iclim)=lon;
    
    [yr,mo,da,hr,mi,se]=datevec(time);
    
    weekst=1;
    weeknd=i;
    monti=0;
    
    for iw=weekst:1:weeknd
        
%         indx=find(mo==im);
        monti=monti+1;
        datab=cat(2,depth,ST(:,iw),repmat(lon(1,1),[size(depth(:,1),1),1]));
        
        j=0;
        for iz=5:5:500
         
         j=j+1;
         
         indx=find(datab(:,1)==iz);
         
         if ~isempty(indx)
             tempclim(j,iclim)=datab(indx,2);
             depthcl(j,iclim)=datab(indx,1);
             lon(j,iclim)=datab(indx,3);
             
         else
             tempclim(j,iclim)=NaN;
             depthcl(j,iclim)=NaN;
            lon(j,iclim)=NaN;
         end
     end
 
        
    end
    
  
end

%% Order long 

loncl1(loncl1<0)=loncl1(loncl1<0)+360;
[lonb,Indx]=sort(loncl1(1,:),2);
lonb=loncl1(:,Indx);
tempclim2=double(tempclim(:,Indx));
depthcl2=double(depthcl(:,Indx));


%% Interpolation

[ai,bi]=meshgrid(1:1:size(hdir,1),1:1:size(depthcl2,1));
SSTclimb=griddata(ai(~isnan(tempclim2)),bi(~isnan(tempclim2)),tempclim2(~isnan(tempclim2)),ai,bi);
%sal3=griddata(xi(~isnan(salb)),di(~isnan(salb)),salb(~isnan(salb)),xi,di);
depthcl3=griddata(ai(~isnan(depthcl2)),bi(~isnan(depthcl2)),depthcl2(~isnan(depthcl2)),ai,bi);



SSTclim(:,:,monti)=SSTclimb;
weeks(iw,1)=iw;
end



%% Save and store
for ik=1:1:54
%pcolor(lonb,-depthcl3(1:60),SSTclimat(1:60,:,ik)); shading flat; colormap jet;
title(ik);
hold on
[c,h]=contourf(lonb,-depthcl3(1:60,2),SSTclim(1:60,:,ik));colormap jet; colorbar
clabel(c,h);
set(gca,'xtick',[147:10:265],'xticklabel',[[147:10:180] [-175:10:-95]],'xlim',[147 265]);
xlabel('Longitud'); ylabel('Profundidad');

pause(0.2)
clf
end
%[c,h]=contourf(lonb,-depthcl3(1:60,2),SSTclimat(1:60,:,1));
%clabel(c,h);

JM='D:\CIO\Kelvin-cromwell\boyas\climatologia_example';
mfile=fullfile(JM,'Buoy Climatology');
save(mfile,'SSTclim','weeks','depthcl3','time','lonb');