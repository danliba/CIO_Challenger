%% Remolinos SSH y UV vel
%Estudio de remolinos utilizando SSH y Corriente geostrofica de CMEMS, modelo fisico 024

%% Datos
fn='ag_ssh_uv.nc';

depth=double(ncread(fn,'depth'));
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
uvel=double(ncread(fn,'vo'));
vvel=double(ncread(fn,'uo'));
ssh=double(ncread(fn,'zos'));
time=double(ncread(fn,'time'))./24;
[yr,mo,da]=datevec(double(time)+datenum(1950,1,1,0,0,0));

%traspose

UVELs=permute(uvel,[1 2 4 3]);
VVELs=permute(vvel,[1 2 4 3]);
%% vamos a buscar los 7 días
imonth=mo(1);

indxtime7=find(da<=7 & mo==imonth); %7/mes
indxtime14=find(da>7 & da<=14 & mo==imonth);%14/mes
indxtime21=find(da>14 & da<=21 & mo==imonth); %21/mes
indxtime30=find(da>21 & da<=30 & mo==imonth);%30/mes

%promediamos SSH
ssh7=nanmean(ssh(:,:,indxtime7),3); %time15 = timeis(indxtime15);
ssh14=nanmean(ssh(:,:,indxtime14),3); %time30 = timeis(indxtime30);
ssh21=nanmean(ssh(:,:,indxtime21),3); %time15 = timeis(indxtime15);
ssh30=nanmean(ssh(:,:,indxtime30),3); %time30 = timeis(indxtime30);

%promediamos uvel
uvel7=nanmean(UVELs(:,:,indxtime7),3); %time15 = timeis(indxtime15);
uvel14=nanmean(UVELs(:,:,indxtime14),3); %time30 = timeis(indxtime30);
uvel21=nanmean(UVELs(:,:,indxtime21),3); %time15 = timeis(indxtime15);
uvel30=nanmean(UVELs(:,:,indxtime30),3); %time30 = timeis(indxtime30);

%promediamos vvel
vvel7=nanmean(VVELs(:,:,indxtime7),3); %time15 = timeis(indxtime15);
vvel14=nanmean(VVELs(:,:,indxtime14),3); %time30 = timeis(indxtime30);
vvel21=nanmean(VVELs(:,:,indxtime21),3); %time15 = timeis(indxtime15);
vvel30=nanmean(VVELs(:,:,indxtime30),3); %time30 = timeis(indxtime30);

%Ya tenemos las 4 semanas hora vamos a concaternar ambos
sshis=cat(3,ssh7,ssh14,ssh21,ssh30);
uvelis=cat(3,uvel7,uvel14,uvel21,uvel30);
vvelis=cat(3,vvel7,vvel14,vvel21,vvel30);

t1 = datetime(yr(1),mo(1),da(indxtime7(end))); t2 = datetime(yr(1),mo(1),da(indxtime14(end)));
t3 = datetime(yr(1),mo(1),da(indxtime21(end))); t4 = datetime(yr(1),mo(1),da(indxtime30(end)));
t = [t1,t2,t3,t4];
%% probamos
[loni,lati]=meshgrid(lon,lat);

for i=1:1:size(sshis,3)

pcolor(lon,lat,sshis(:,:,i)');shading flat; colorbar; colormap jet;
caxis([0 0.3]);
hold on
quiversc(loni,lati,uvelis(:,:,i)',vvelis(:,:,i)','k','density',65);
axis tight
pause(2)
clf
end

%% 2nda
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;

for i=1:1:size(UVELs,3)

pcolor(lon,lat,ssh(:,:,i)');shading flat; colorbar; colormap jet;
caxis([0 0.3]);
hold on
quiversc(loni,lati,UVELs(:,:,i)',VVELs(:,:,i)','k','density',65);
axis tight
pause(1)
clf
end

%surfc(lon,lat,sshis(:,:,i)');shading flat;
%%
%colorcito
grayColor = [.5 .5 .5];


%mapa
load('Mapa_Peru.mat');