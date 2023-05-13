clear all
close all
clc

path0='D:\CIO\ayuda\velocidad_u\anomalias';
hdir=dir(fullfile(path0,'B*.mat'));
hdir(6)=hdir(3);
hdir(7)=hdir(4);
hdir(8)=hdir(2);
hdir(9)=hdir(1);
hdir(1:5) = [];
%% plot--anomalia
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for iboy=1:1:size(hdir,1)
    fns=hdir(iboy).name;
    load(fns)
    subplot(2,2,iboy)
    [monti,dep]=meshgrid(month_number(2:size(VELU_anom,2)),depth);
    [c,h]=contourf(monti,-dep,VELU_anom(:,2:end),':'); shading flat; cmocean('balance');
    clabel(c,h); title(platform_code);
    caxis([-60 50]);
    set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -10]);
    axis manual
end
hc=colorbar; 
hc.Location='southoutside';
 hc.Position=[0.17 0.05 0.7 0.02];
 ylabel(hc,'velocidad zonal cm/s');
 
 %% plot2----promedio 2018
 figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for iboy=1:1:size(hdir,1)
    fns=hdir(iboy).name;
    load(fns)
    subplot(2,2,iboy)
    [monti,dep]=meshgrid(month_number(2:size(VELU_anom,2)),depth);
    [c,h]=contourf(monti,-dep,velu_im(:,2:end),[-70:10:140],':'); shading flat; cmocean('curl');
    clabel(c,h); title(platform_code); xlim([1 12]);
    caxis([-70 140]);
    set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -10]);
    axis manual
end
hc=colorbar; 
hc.Location='southoutside';
 hc.Position=[0.17 0.05 0.7 0.02];
 ylabel(hc,'velocidad zonal cm/s');
 
%% plot3--anomalias
iter=0;
meses={'Dic-2017','En-2018','Feb-2018','Mar-2018','Abr-2018','May-2018','Jun-2018','Jul-2018',...
    'Ago-2018','Set-2018','Oct-2018','Nov-2018','Dic-2018'}';
label_boya={'0n165e','0n170w','0n140w','0n110w'};

figure
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.05], [0.05 0.05], [0.02 0.01]);
if ~make_it_tight,  clear subplot;  end
for i=1:1:6
    subplot(2,3,i)
    for iboy=1:1:size(hdir,1)
        fns=hdir(iboy).name;
        iter=iter+1;
        load(fns)
        plot(VELU_anom(:,i),-depth,'o--');
        xlim([-70 50]);ylim([-300 0]);
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0]);
        set(gca,'xtick',[-70:10:50],'yticklabel',[-70:10:50]);
        title(meses(i));
        ldg=legend(label_boya,'Location','southwest','Orientation','vertical');
        lgd.NumColumns = 2;
        hold on
    end
    hold on
    plot([0 0],[0 -500],'k');
    grid on
end

%% plot4---anomalias
k=0;
for i=7:1:13
    k=k+1;
    subplot(2,4,k)
    for iboy=1:1:size(hdir,1)
        fns=hdir(iboy).name;
        iter=iter+1;
        load(fns)
        if size(VELU_anom,2)<i
            label_boya={'0n165e','0n140w','0n110w'};
            continue
        end
        plot(VELU_anom(:,i),-depth,'o--');
        xlim([-70 50]);ylim([-300 0]);
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0]);
        set(gca,'xtick',[-70:10:50],'xticklabel',[-70:10:50]);
        title(meses(i));
        ldg=legend(label_boya,'Location','southwest','Orientation','vertical');
        hold on
    end
    hold on
    plot([0 0],[0 -500],'k');
    grid on
end
subplot(2,4,8)
text(.5,.5,{'Anomalias de velocidad zonal';'en cm/s con las boyas NOAA TAO'},...
    'FontSize',14,'HorizontalAlignment','center')
axis off

%% promedio
iter=0;
meses={'Dic-2017','En-2018','Feb-2018','Mar-2018','Abr-2018','May-2018','Jun-2018','Jul-2018',...
    'Ago-2018','Set-2018','Oct-2018','Nov-2018','Dic-2018'}';
label_boya={'0n165e','0n170w','0n140w','0n110w'};

figure
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.05], [0.05 0.05], [0.02 0.01]);
if ~make_it_tight,  clear subplot;  end
for i=1:1:6
    subplot(2,3,i)
    for iboy=1:1:size(hdir,1)
        fns=hdir(iboy).name;
        iter=iter+1;
        load(fns)
        plot(velu_im(:,i),-depth,'o--');
        xlim([-70 140]);ylim([-300 0]);
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0]);
        set(gca,'xtick',[-70:20:140],'xticklabel',[-70:20:140]);
        title(meses(i));
        ldg=legend(label_boya,'Location','southwest','Orientation','vertical');
        lgd.NumColumns = 2;
        hold on
    end
    hold on
    plot([0 0],[0 -500],'k');
    grid on
end

%% promedio-2
k=0;
for i=7:1:13
    k=k+1;
    subplot(2,4,k)
    for iboy=1:1:size(hdir,1)
        fns=hdir(iboy).name;
        iter=iter+1;
        load(fns)
        if size(VELU_anom,2)<i
            label_boya={'0n165e','0n140w','0n110w'};
            continue
        end
        plot(velu_im(:,i),-depth,'o--');
        xlim([-70 140]);ylim([-300 0]);
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0]);
        set(gca,'xtick',[-70:20:140],'xticklabel',[-70:20:140]);
        title(meses(i));
        ldg=legend(label_boya,'Location','southwest','Orientation','vertical');
        hold on
    end
    hold on
    plot([0 0],[0 -500],'k');
    grid on
end
subplot(2,4,8)
text(.5,.5,{'Anomalias de velocidad zonal';'en cm/s con las boyas NOAA TAO'},...
    'FontSize',14,'HorizontalAlignment','center')
axis off
