path02='E:\ocean_ecosystem_dynamics_laboratory\CIO\deepnija';
topofn='data.nc';
topofns=fullfile(path02,topofn);

latitude=double(ncread(topofns,'Y'));
longitude=double(ncread(topofns,'X'));
topo=double(ncread(topofns,'bath'));
topo=topo';

% pcolor(longitude,latitude,topo);
% shading flat;cmocean('topo'); 
% c=colorbar;
% c.Label.String='Depth in m';
% caxis([-2000 0]);
% axis([274 290 -25 5 ]);

%%
% figure
% P=get(gcf,'position');
% P(3)=P(3)*0.7;
% P(4)=P(4)*2;
% set(gcf,'position',P);
% set(gcf,'PaperPositionMode','auto');
% [c,h]=contour(longitude,latitude,topo,[-2000:500:0]);
% clabel(c,h);
% caxis([-2000 0]);
% axis([274 290 -25 5 ]);
% c=colorbar;
% c.Label.String='Depth in m';

%% nuevos valores solo Peru

indx_lat=find(latitude<=5 & latitude>=-25);
indx_lon=find(longitude<=290 & longitude>=275);

topo_sel=topo(indx_lat,indx_lon);
lat=latitude(indx_lat);
lon=longitude(indx_lon);

figure
P=get(gcf,'position');
P(3)=P(3)*0.7;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
[c,h]=contour(lon,lat,topo_sel,[-2000:500:0]);
clabel(c,h);
caxis([-2000 0]);
axis([274 290 -25 5 ]);
c=colorbar;
c.Label.String='Depth in m';

%% seleccionar solo costa ==2000m

[y,x]=find(topo_sel<=-400 & topo_sel>=-500);

costa=topo_sel(y,x);

loni=lon(x);
lati=lat(y);

plot(loni,lati,'k.');

c=contourc(loni,lati,costa,[-500 -400]);

