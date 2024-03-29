clear all 
close all

path01='F:\float30april\flotadores_fecha';
hdir=dir(fullfile(path01,'20*.nc'));

 hdir(8)=[];
 hdir(17) = [];
 hdir(25) = [];

iter=0;

%S=1; %%%Check the while statement instead of the for%% if fname=0
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    P=ncread(fname,'PRES');
    T=ncread(fname,'TEMP');
%     if S==1
    S=ncread(fname,'PSAL');
%     else 
%         disp(fname)
%     end
    L=ncread(fname,'LONGITUDE');
    
    data=cat(2,round(P(:,1)),round(T(:,1),2),round(S(:,1),2),repmat(L(1,1),[size(T(:,1),1) 1]));
    
    iter=iter+1;
    i=0;
    for iz=4:1:300
        i=i+1;
        indx=find(data(:,1)==iz);
        if ~isempty(indx)
            temp(i,ifloat)=data(indx,2);
            sal(i,ifloat)=data(indx,3);
            pres(i,ifloat)=data(indx,1);
            lon(i,ifloat)=data(indx,4);
        else
            temp(i,ifloat)=NaN;
             sal(i,ifloat)=NaN;
             pres(i,ifloat)=NaN;
             lon(i,ifloat)=NaN;
        end
           
        
     end
    
end
%Create a j=0, then create a 2nd ~isempty with indx2, repeat this or find
%another way 
lon(lon<0)=lon(lon<0)+360;
[lonb,Indx]=sort(lon(31,:),2);
lon2=lon(:,Indx);
temp2=temp(:,Indx);
sal2=round(sal(:,Indx),2);
pres2=pres(:,Indx);

[xi,di]=meshgrid(1:1:size(hdir,1),1:1:size(pres2,1));
temp3=griddata(xi(~isnan(temp2)),di(~isnan(temp2)),temp2(~isnan(temp2)),xi,di);
sal3=griddata(xi(~isnan(sal2)),di(~isnan(sal2)),sal2(~isnan(sal2)),xi,di);
pres3=griddata(xi(~isnan(pres2)),di(~isnan(pres2)),pres2(~isnan(pres2)),xi,di);


pr=0;

pt = theta(sal3,temp3,pres3,pr);
sigma3=sigmat(pt,sal3);
%% graficos

figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

[C,h]=contourf(lonb,-pres3(:,1),temp3,30,'k:');h.LevelList=round(h.LevelList);
colormap(jet);title('Temperatura Subsuperficial 150E-85W','Fontsize',13)
clabel(C,h); colorbar; caxis([11 31]);
hold on
[C,h]=contour(lonb,-pres3(:,1),sal3,[35.5:0.5:36.5],'m--','linewidth',2);
%clabel(C,h);

hold on 
set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[150 275]);
xlabel('Longitud'); ylabel('Profundidad');
text(245,-270,'Fuente: ARGO','color','white','fontweight','bold');
text(245,-280,'Procesamiento: CIO-Challenger','color','white','fontweight','bold');

 %saveas(gcf,'Temperatura Subsuperficial 150E-85W.jpg','jpg');
%% graficos 2
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

subplot(3,1,2)
[C,h]=contourf(lonb,-pres3(:,1),sal3,300,'k:');h.LevelList=round(h.LevelList,1);
colormap(parula);title('Salinidad Subsuperficial 150E-85W');
c=colorbar;
c.Label.String='Salinidad (ups)';
clabel(C,h); caxis([34 36]);
set(gca,'ytick',[-300:50:0],'yticklabel',[-300:50:0],'ylim',[-300 -4]);
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[150 275]);
xlabel('Longitud'); ylabel('Profundidad');
t=text(153,-25,'B','fontsize',15,'color','w');


% saveas(gcf,'Salinidad Subsuperficial 150E-90W.jpg','jpg');
% 
% figure
% P=get(gcf,'position');
% P(3)=P(3)*2.5;
% P(4)=P(4)*0.7;
% set(gcf,'position',P);
% set(gcf,'PaperPositionMode','auto');

subplot(3,1,1)
[C,h]=contourf(lonb,-pres3(:,1),sigma3,[20:0.5:30],':');h.LevelList=round(h.LevelList,1);
colormap(parula);title('Sigma-theta Subsuperficial 150E-85W');
clabel(C,h); caxis([21 27.5]); 
c=colorbar;
c.Label.String='Sigma-theta';
%c.LineWidth=3;

hold on 
set(gca,'ytick',[-300:50:0],'yticklabel',[-300:50:0],'ylim',[-300 -4]);
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[150 275]);
xlabel('Longitud'); ylabel('Profundidad');
t=text(153,-25,'A','fontsize',15,'color','w');

% saveas(gcf,'Sigma-theta Subsuperficial 150E-90W.jpg','jpg');

[loni,presi]=meshgrid(lonb,pres3(:,1));

% figure
% P=get(gcf,'position');
% P(3)=P(3)*2.5;
% P(4)=P(4)*0.7;
% set(gcf,'position',P);
% set(gcf,'PaperPositionMode','auto');
subplot(3,1,3)
pcolor(lonb,sigma3,sal3);
hold on
[C,h]=contour(loni,sigma3,sal3,[35.5 36],'r--');
clabel(C,h);
hold on
[c,h]=contour(loni,sigma3,pres3,'k:');
clabel(c,h);
shading flat; colorbar;
caxis([34 36]);
hold on 
set(gca,'ytick',[21:0.5:26.5],'yticklabel',[21:0.5:26.5],'ylim',[21 26.5]);
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[150 275]);
xlabel('Longitud'); ylabel('Sigma-theta');
title('Salinidad vs Sigma-theta Subsuperficial 150E-85W');
text(153,21.5,'C','fontsize',15,'color','w');
text(152.5,25.5,'Fuente: ARGO','color','white','fontweight','bold');
text(152.5,26,'Procesamiento: CIO-Challenger','color','white','fontweight','bold');
c=colorbar;
c.Label.String='Salinidad (ups)';
set(gca, 'YDir','reverse')


 print('Salinidad vs Sigma-theta Subsuperficial 150E-85W.png','-dpng','-r500');
%saveas(gcf,'Salinidad vs Sigma-theta Subsuperficial 150E-90W.jpg','jpg');

%% graficos 3
figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*0.7;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
pcolor(lonb,sigma3,temp3);
hold on
% [C,h]=contour(loni,sigma3,temp3,[20 20],'r--');
% clabel(C,h);
% hold on
[c,h]=contour(loni,sigma3,pres3,'k:');
clabel(c,h);
shading flat; colormap jet; colorbar;
caxis([14 31]);
hold on 
%set(gca,'ytick',[21:0.5:26.5],'yticklabel',[21:0.5:26.5],'ylim',[21 26.5]);
set(gca,'xtick',[150:5:270],'xticklabel',[[150:5:180] [-175:5:-90]],'xlim',[150 270]);
xlabel('Longitud'); ylabel('Sigma-theta');
title('Temperatura vs Sigma-theta Subsuperficial 150E-90W');







