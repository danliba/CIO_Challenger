fn='2018-2020.nc';
lon=double(ncread(fn,'lon'));
lat=double(ncread(fn,'lat'));
%chlor=double(ncread(fn,'CHL'));
time=double(ncread(fn,'time'));
[yr,mo,da,hr,mi,se]=datevec(time+datenum(1900,1,1,1,0,0));
range0=[-100 -65 -22 0];

%% select the area
% i=-2;
% select_area=[-85 -65 i-1 i];
select_area=[-85 -65 -4 2;-85 -65 -10 -4;-85 -65 -16 -10;-85 -65 -22 -16];
%seleccionar area con request
request=2;
%area norte1
indxlon=find(lon>=select_area(request,1) & lon<=select_area(request,2));
indxlat=find(lat>=select_area(request,3) & lat<=select_area(request,4));

lono=lon(indxlon); latno=lat(indxlat);
[loni,lati]=meshgrid(lono,latno);
yrst=2020;
yren=2020;
most=1;
moen=10;
moen0=moen;
load coastlines

iter=0;
for iy=yrst:1:yren
    if iy>yrst
        most=1;
    end
    % if iy is equal to yren, then let most is moen0,
    if iy==yren
        moen=moen0;
    % otherwise 12
    else
        moen=12;        
    end
     for im=most:1:moen
         disp(datestr(datenum(iy,im,28,0,0,0)));
       
         indx01=find(yr==iy&mo==im);
         
         for i=1:length(indx01)
            iter=iter+1;
            disp (['Proceess No.' num2str(i) ' ... '])
            
            chlor=double(ncread(fn,'CHL',[indxlon(1) indxlat(1) indx01(i)],...
                [length(indxlon) length(indxlat) 1], [1 1 1]));
            
            pcolor(loni,lati,log10(chlor'));
            shading flat;colormap jet
            colorbar;
            caxis(['auto']);caxis(log10([0.01 60]));
            hc=colorbar; set(hc,'ticks',log10([0.01 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
                'ticklabels',[0.01 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
             xlim([-90 -65]);ylim([-22 2]);
             hold on
             plot(coastlon,coastlat,'k');
             xlim([-90 -65]);ylim([-22 2]);
             pause(0.5)
             clf
        %%getting chlor mean
         chlor_latmean=nanmean(chlor,2);%promedio 
      %%almacena los datos
        chlori(:,iter)=chlor_latmean;
        disti(:,iter)=loni(1,:);
        timeis(:,iter)=datenum(iy,im,28,0,0,0);
         end
     end
end


%% plot
figure
for ii=1:1:length(timeis)
plot(disti(:,ii),chlori(:,ii));
xlim([-85 -76]);
pause(0.5)
clf
end
%% sumar long
lon_sum=nanmean(disti,2);
offshore_coast=lon_sum.*~isnan(chlor_latmean);
 offshore_coast(offshore_coast==0)=NaN;
nanstart=find(isnan(offshore_coast));
disti2=~isnan(chlor_latmean).*disti;
disti2(disti2==0)=NaN;
disti2=deg2km(disti2-(disti2(nanstart(1)-1)));
%% grafica
figure
pcolor(timeis,-disti2,chlori); shading flat;
ylim([0 100]);
colormap jet
 colorbar; caxis([0 11]);
datetick('x','mm/yy','keepticks')
%  caxis(log10([1 200]));
%  hc=colorbar; set(hc,'ticks',log10([ 1 2 3 4 5 10 20 30 40 50 60 200]),...
%      'ticklabels',[ 1 2 3 4 5 10 20 30 40 50 60 200],'TickDirection',('out'));