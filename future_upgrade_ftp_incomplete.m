%%upgrade to FTP boya download
longitudes=[95 110 125 140 155 156 165 170 180];
latitudes=[0 2];
for i=1:1:length(longitudes)
lon=longitudes(i);
lat=0;
if lon==
%north-west
folder=sprintf('/cdf/sites/daily/t%dn%dw_dy.cdf',lat,lon);
%north-east
folder=sprintf('/cdf/sites/daily/t%dn%de_dy.cdf',lat,lon);
%south-west
folder=sprintf('/cdf/sites/daily/t%ds%dw_dy.cdf',lat,lon);
%south-east
folder=sprintf('/cdf/sites/daily/t%ds%de_dy.cdf',lat,lon);

end