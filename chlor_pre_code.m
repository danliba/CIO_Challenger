fn='1997_19_chlor.nc';
lon=double(ncread(fn,'lon'));
lat=double(ncread(fn,'lat'));
chlor=double(ncread(fn,'CHL'));
time=double(ncread(fn,'time'));
[yr,mo,da,hr,mi,se]=datevec(time+datenum(1900,1,1,1,0,0));
range0=[-100 -65 -22 0];
% %%
% [loni,lati]=meshgrid(lon,lat);
% pcolor(loni,lati,log10(chlor(:,:,30)'));
% shading flat;colormap jet
% colorbar;
% caxis(['auto']);caxis(log10([0.01 60]));
% hc=colorbar; set(hc,'ticks',log10([0.01 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
%     'ticklabels',[0.01 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
%  xlim([-90 -65]);ylim([-22 2]);

%% select the area
i=0;
select_area=[-85 -65 i-1 i];
%;-85 -65 -10 -4;-85 -65 -16 -10;-85 -65 -22 -16];
%area norte1
indxlon=find(lon>=select_area(1,1) & lon<=select_area(1,2));
indxlat=find(lat>=select_area(1,3) & lat<=select_area(1,4));

lono=lon(indxlon); latno=lat(indxlat);
%compute chlor within the selected area
% maskssh=double(select_area(1,1)<=loni & loni<=select_area(1,2) &...
%     select_area(1,3)<=lati & lati<=select_area(1,4));
% maskssh(maskssh==0)=NaN;

a=chlor(indxlon,indxlat,30)';
%chloro=a.*maskssh;

[loni,lati]=meshgrid(lono,latno);
pcolor(loni,lati,log10(a));
shading flat;colormap jet
colorbar;
caxis(['auto']);caxis(log10([0.01 60]));
hc=colorbar; set(hc,'ticks',log10([0.01 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.01 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 xlim([-90 -65]);ylim([-22 2]);

%% get offshore axis

 [lonk,latk]=Extract_offshore_axis(loni,lati,100,range0);
  hold on
 plot(lonk,latk,'k.')
 
%% some fit 
% [lonki,latki]=meshgrid(lonk,latk);
%  [fc,fo]=fit(lonki,latki,'smoothingspline');
 
%% 
t=polyfit(lonk,latk,23);
t0=polyval(t,lonk);

plot(lonk,t0); hold on; plot(lonk,latk,'k.');

%lat0=t(1,1).*lono.^7+t(1,2).*lono.^6+t(1,3).*lono.^5+t(1,4).*lono.^4+t(1,5).*lono.^3+t(1,6)*lono.^2+t(1,7).*lono+t(1,8);
ff=length(t);
for jj=1:1:length(t)
    ff=ff-1;
    lata(:,jj)=t(1,jj).*lono.^ff;
    lat0=sum(lata,2);
end

% vector_limitator=find(lat0>=min(latno) & lat0<=max(latno));
% lat01=lat0(vector_limitator);
% plot(lat0,'b.'); hold on; plot(latno,'r.');hold on; plot(lat01);

mask=double(lat0>latno');
axis([-83 -80 i-1 i]);
  chloro=a.*mask';
  chloro(chloro==0)=NaN;
  %% 
  pcolor(loni,lati,mask'); shading flat; colorbar
hold on
 plot(lonk,latk,'k.')
 hold on
 plot(lonk,t0,'r.');

%% plot 
load coastlines
figure
 pcolor(loni,lati,log10(chloro)); shading flat
shading flat;colormap jet
colorbar;
caxis(['auto']);caxis(log10([0.01 60]));
hc=colorbar; set(hc,'ticks',log10([0.01 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.01 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 xlim([-90 -65]);ylim([-22 2]);
 hold on
 plot(coastlon,coastlat,'k');
 %sacar promedio por 1º de latitud

 chlor_latmean=nanmean(chloro,1);
figure
 plot(lono,chlor_latmean);
