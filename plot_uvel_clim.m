clear all
close all
clc

path0='D:\CIO\ayuda\velocidad_u\perfiles';
hdir=dir(fullfile(path0,'B*.mat'));
hdir(6)=hdir(3);
hdir(7)=hdir(4);
hdir(8)=hdir(2);
hdir(9)=hdir(1);
hdir(1:5) = [];
%% plot
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for iboya=1:1:size(hdir,1)
    fns=hdir(iboya).name;
    load(fns)
    subplot(2,2,iboya)
    [monti,dep]=meshgrid(months,depth);
    [c,h]=contourf(monti,-dep,u_vel,':'); shading flat; colormap jet;
    clabel(c,h); title(platform_code);
    caxis([-40 120]);
    set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -10]);
    axis manual
end
hc=colorbar; 
hc.Location='southoutside';
 hc.Position=[0.17 0.05 0.7 0.02];
 ylabel(hc,'velocidad zonal cm/s');