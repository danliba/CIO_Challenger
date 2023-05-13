%% Reading peruvian coastal data
% data source IMARPE

clear all
close all

% reading excel file
tempall=xlsread('coastal_data.xlsx','temperature');
anomaall=xlsread('coastal_data.xlsx','anomaly');

% time
years=tempall(1:end,1);
months=tempall(1:end,2);
days=tempall(1:end,3);
timed=datenum(years,months,days);

% timeanom
yearsa=anomaall(1:end,1);
monthsa=anomaall(1:end,2);
daysa=anomaall(1:end,3);
timeda=datenum(yearsa,monthsa,daysa);

% location
location

% variables
temps=tempall(1:end,4:end);
anomas=anomaall(1:end,4:end);

% generate masks for NaN
masktemps=double(~isnan(temps));
maskanomas=double(~isnan(anomas));

% copy U and V to U0 and V0 and replace NaN with 0;
temps0=temps; temps0(isnan(temps))=0;
anomas0=anomas; anomas0(isnan(anomas))=0;

% for daily variations
timemd=repmat(timed,[1 size(temps,2)]);
latsalld=repmat(latsall',[size(temps,1) 1]);

% for daily variations
timemda=repmat(timeda,[1 size(anomas,2)]);
latsallda=repmat(latsall',[size(anomas,1) 1]);

% plotting daily temperature

figure
pcolor(timemd,-latsalld,temps)
shading interp
colormap jet
c=colorbar('ticks',[14:1:29],'fontsize',10,'axislocation','out');
c.Label.String=' Temperatura [ºC]';
caxis([15 29])
grid on
set(gca,'xminorgrid','on','xminortick','on')
hold on
[C,h]=contour(timemd,-latsalld,temps,[15,20,25,28],'k','showtext','on',...
'linestyle','-','labelspacing',450,'linewidth',0.005);
clabel(C,h,'fontsize',8,'color','black')
ylim([-17.65 -3.46])
yticks([-17.65 -17.02 -16.23 -13.66 -12.06 -11.11 -9.06 -8.06 -7.71 -6.76 -5.06 -3.46])
yticklabels([{'Ilo','Matarani','Atico','Pisco','Callao','Huacho','Chimbote','Huanchaco','Chicama','San Jose','Paita','Tumbes'}])
datetick('x','mmmyy')
title('Temperatura Superficial del Mar Diaria')

% plotting daily anomalies

figure
pcolor(timemda,-latsallda,anomas)
shading interp
colormap jet
c=colorbar('ticks',[-5:1:5],'fontsize',10,'axislocation','out');
c.Label.String='Anomalia Temperatura [ºC]';
caxis([-5 5])
grid on
set(gca,'xminorgrid','on','xminortick','on')
hold on
[C,h]=contour(timemda,-latsallda,anomas,[-3,-1,1,3],'k','showtext','on',...
'linestyle','-','labelspacing',450,'linewidth',0.005);
clabel(C,h,'fontsize',8,'color','black')
ylim([-17.65 -3.46])
yticks([-17.65 -17.02 -16.23 -13.66 -12.06 -11.11 -9.06 -8.06 -7.71 -6.76 -5.06 -3.46])
yticklabels([{'Ilo','Matarani','Atico','Pisco','Callao','Huacho','Chimbote','Huanchaco','Chicama','San Jose','Paita','Tumbes'}])
datetick('x','mmmyy')
title('Anomalia diaria de Temperatura Superficial del Mar')