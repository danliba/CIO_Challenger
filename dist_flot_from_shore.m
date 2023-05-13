% 1500 random points around the Indian Ocean:
lat = 40*rand(1500,1)-10;
lon = 60*rand(1500,1)+40;

% Limit this random dataset to ocean points:
land = island(lat,lon);
lat(land) = [];
lon(land) = [];

% Plot the random datapoints:
figure
plot(lon,lat,'.','color',rgb('gray'))
hold on
he = earthimage;     % adds an earth image
uistack(he,'bottom') % places earth image below dots

d = dist2coast(lat,lon);

scatter(lon,lat,30,d,'filled')

cb = colorbar;
ylabel(cb,'distance to nearest land (km)')

cmocean -matter % sets the colormap