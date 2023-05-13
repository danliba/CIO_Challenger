temp1=xlsread('output_data.xlsx','temp');
temp1=temp1(2:end,2:end);

temp2=xlsread('output_data.xlsx','temp2');
temp2=temp2(2:end,2:end);

sal1=xlsread('output_data.xlsx','sal');
sal1=sal1(2:end,2:end);

sal2=xlsread('output_data.xlsx','sal2');
sal2=sal2(2:end,2:end);

oxi1=xlsread('output_data.xlsx','oxi');
oxi1=oxi1(2:end,2:end);

oxi2=xlsread('output_data.xlsx','oxi2');
oxi2=oxi2(2:end,2:end);

%% perfiles temp
lon=[1:1:4];
depth=[1:1:100];

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

subplot(1,2,1)
[C,h]=contourf(lon,-depth,temp1,15,'k:');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,temp1,[15:0.5:18],'k:');
cmocean('balance');title('Temperatura [ºC] Zona de Pesca   5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([14 20]);
set(gca,'xtick',[1:4],'xticklabel',[[1:2:7]]);
xlabel('Lances');

subplot(1,2,2)
[C,h]=contourf(lon,-depth,temp2,15,'k:');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,temp2,[15:0.5:18],'k:');
cmocean('balance');title('Temperatura [ºC] Zona de Pesca   5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([14 20]);
set(gca,'xtick',[1:4],'xticklabel',[[2:2:8]]);
xlabel('Lances');


%% %% perfiles sal
lon=[1:1:4];
depth=[1:1:100];

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

subplot(1,2,1)
%pcolor(lon,-depth,sal1); shading flat;hold on;
[C,h]=contourf(lon,-depth,sal1,15,'k:');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,sal1,15,'k:');
h.LevelList=round(h.LevelList,1);
title('Salinidad [PSU] Zona de Pesca   5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([35 35.8]);
set(gca,'xtick',[1:4],'xticklabel',[[1:2:7]]);
xlabel('Lances');

subplot(1,2,2)
[C,h]=contourf(lon,-depth,sal2,15,'k:');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,sal2,15,'k:');
h.LevelList=round(h.LevelList,1);
title('Salinidad [PSU] Zona de Pesca   5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([35 35.8]);
set(gca,'xtick',[1:4],'xticklabel',[[2:2:8]]);
xlabel('Lances');

%% perfil ox
lon=[1:1:4];
depth=[1:1:100];

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

subplot(1,2,1)
%pcolor(lon,-depth,sal1); shading flat;hold on;
[C,h]=contourf(lon,-depth,oxi1,15,'k:');
colormap('jet');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,oxi1,15,'k:');
h.LevelList=round(h.LevelList);
title('Oxigeno [ml/L]  5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([1.8 6.5]);
set(gca,'xtick',[1:4],'xticklabel',[[1:2:7]]);
xlabel('Lances');

subplot(1,2,2)
[C,h]=contourf(lon,-depth,oxi2,15,'k:');
colormap('jet');
set(h,'LineColor','none');
hold on
[C,h]=contour(lon,-depth,oxi2,15,'k:');
h.LevelList=round(h.LevelList);
title('Oxigeno [ml/L]  5°41 23.24 S','Fontsize',11)
clabel(C,h); colorbar; caxis([1.8 6.5]);
set(gca,'xtick',[1:4],'xticklabel',[[2:2:8]]);
xlabel('Lances');

