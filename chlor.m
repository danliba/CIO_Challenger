chlpath='D:\CIO\Kelvin-cromwell\clorofila\chabuca';
chlfn='aaa.nc';
chlfns=fullfile(chlpath,chlfn);
%shapes file
%departamentos del Peru
deppath='D:\CIO\Kelvin-cromwell\clorofila\departamentos';
depfn='DEPARTAMENTOS.shp';
depfns=fullfile(deppath,depfn);

%puertos del peru
puertopath='D:\CIO\Kelvin-cromwell\clorofila\puerto';
puertofn='puerto.shp';
puertofns=fullfile(puertopath,puertofn);

lat=double(ncread(chlfns,'lat'));
lon=double(ncread(chlfns,'lon'));
chl=double(ncread(chlfns,'CHL'));
time=double(ncread(chlfns,'time'));
timechl=time+datenum(1900,1,1,0,0,0);
[yr,mo,da,hr,mi,se]=datevec(timechl);

[loni,lati]=meshgrid(lon,lat);

aviobj = QTWriter('CHL_absolutedata_CMEMS.mov','FrameRate',1);%aviobj.Quality = 100;
for i=1:1:size(time,1)
pcolor(loni,lati,log10(chl(:,:,i)'));shading flat;colorbar;colormap jet
%pcolor(loni,lati,chl(:,:,i)');shading flat;colorbar;colormap jet
hc=colorbar; caxis(['auto']);
       caxis(log10([0.01 60]));
       set(hc,'ticks',log10([0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60]),...
    'ticklabels',[0.01 0.1 0.5 1 2 3 4 5 10 20 30 40 50 60],'TickDirection',('out'));
 title(datestr(datenum(yr(i),mo(i),0,0,0,0)));
 M1=getframe(gcf);
 writeMovie(aviobj, M1);
 pause(1)
 clf
end
close(aviobj);
disp(max(max(max(chl))))