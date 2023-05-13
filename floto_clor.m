fname2='6902827_Sprof.nc';
%f2=ncinfo(fname2);

lati=double(ncread(fname2,'LATITUDE'));
loni=double(ncread(fname2,'LONGITUDE'));
depth=double(ncread(fname2,'PRES'));
temp=double(ncread(fname2,'TEMP'));
sal=double(ncread(fname2,'PSAL'));
chlor=double(ncread(fname2,'CHLA_ADJUSTED'));
time=double(ncread(fname2,'JULD'));
[yr,mo,da,hr,mi,se]=datevec(time+datenum(1950,1,1,1,0,0));
%% plot 
load coast
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*1.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

aviobj=QTWriter('floto_6902827','FrameRate',2);
%aviobj.Quality=100;
for ii=1:1:size(chlor,2)
    subplot(1,2,1)
    plot(chlor(:,ii),-depth(:,ii),'o');
    ylim([-200 0]); xlim([0 2]);
    grid minor
    title(datestr(datenum(yr(ii),mo(ii),da(ii))));
    pause(0.5)
    
    subplot(1,2,2)
    centerLon=0;
    he=earthimage('center',centerLon);
    uistack(he,'bottom');
    hold on
    plot(long,lat,'k');
    hold on
    plot(loni(ii),lati(ii),'ko--','markerfacecolor','g');
    %title(datestr(datenum(yr(ii),mo(ii),da(ii))));
    axis([-88 -65 -15 -7]);
        
     M1=getframe(gcf);
     writeMovie(aviobj,M1);
end
close(aviobj);