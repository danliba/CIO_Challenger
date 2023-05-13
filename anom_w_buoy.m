%% Buoy weekly_anomaly 
clear all
clc
close all

path0='D:\CIO\Kelvin-cromwell\Semanal\Climatology';
path1='G:\ocean ecosystem dynamics laboratory\boyas\Semanal\boy_w_anom';

fn0='Buoy Climatology.mat';
fn1='Buoy_weekly_average.mat';

fns0=fullfile(path0,fn0);
fns1=fullfile(path1,fn1);

load(fns0);
load(fns1);

% [yrcl,mocl,dacl,hrcl,micl,secl]=datevec(time);
%[yr,mo,da,hr,mi,se]=datevec(time);

%%hoy-1
ystd=today-1;
[yrw,mow,daw,hrw,miw,sew]=datevec(double(ystd));
w=week(datetime(yrw,mow,daw,hrw,0,0));

yrst=2020;
yren=2020;
weekst=w-3;
weeknd=w;

weeknd0=weeknd;

%%week to date function
datew=week_to_date(2020,1,1,[weekst:weeknd]);

%aviobj = QTWriter('Buoy-weekly-anom.mov','FrameRate',1);%aviobj.Quality = 100;

figure
P=get(gcf,'position');
P(3)=P(3)*2.1;
P(4)=P(4)*1.8;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

iter=0;
for iy=yrst:1:yren
    
          if iy>yrst
        weekst=1;
    end
    
    if iy==yren
        weeknd=weeknd0;
    else
        weeknd=54;
    end
    
    
    for iw=weekst:1:weeknd
        
        indx0=find(yrw==iy&weeks==iw);
%         daynum=datestr(datenum(iy,iw,15,0,0,0));
        if length(indx0)>1
            disp('index has more than 2 entries')
            datestr(timeis(indx0));
        elseif isempty(indx0)==1
        end
        
        iter=iter+1;
        disp(['Year: ' num2str(iy) ' Week: ' num2str(iw)])
        %modify SST(:,:,iter) to SST (:,:, indx0) if startweek=1
        SSTanom=SST_weekly(:,:,iter)-SSTclim(:,:,iw);
        %ST2=detrend(SSTanom);
%         pcolor(lonb,-depthcl3,SSTanom); shading flat; colorbar;
       subplot(2,2,iter)
        [c,h]=contourf(lonb,-depthcl3(1:100,1),SSTanom,[-6:1:6],'k:');
        clabel(c,h);
        cmocean('balance'); colorbar;
        caxis([-6 6]);
        title(datestr(datew(1,iter)));
        %title(['Year: ' num2str(iy) ' Week: ' num2str(iw)]); 
        hold on 
        [c,h]=contour(lonb,-depthcl3(1:100,1),SST_weekly(:,:,iter),[15:5:20],'g:','Linewidth',1.5);
        clabel(c,h);
        hold on
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
         set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
        xlabel('Longitud'); ylabel('Profundidad');
        text(160,-270,'Fuente: NOAA','color','k');
        text(160,-285,'Procesamiento: CIO-Challenger','color','k');
       
%         subplot(2,1,2)
%         pcolor(lonb,-depthcl3,SST_weekly(:,:,iter));
%         shading flat;
%         hold on
%         [c,h]=contour(lonb,-depthcl3(1:100,1),SST_weekly(:,:,iter));
%         clabel(c,h);
%         cmocean('balance'); colorbar;
%         caxis([12 30]);
%         title(['Year: ' num2str(iy) ' Week: ' num2str(iw)]); 
%         hold on 
%         set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
%         set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
%         xlabel('Longitud'); ylabel('Profundidad');
%         
%         pause(2)
% %          M1=getframe(gcf);
% %          writeMovie(aviobj, M1);
%        clf
       
    end
end
% close(aviobj);

buoy15='G:\ocean ecosystem dynamics laboratory\boyas\30mayo';
mfile=fullfile(buoy15,'Anomalias semanales 5 ');
print(mfile,'-dpng','-r500');
%saveas(gcf,mfile,'png','-dpng','-r500');

 %% figure
 figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*1.3;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

        subplot(1,2,2)
        [c,h]=contourf(lonb,-depthcl3(1:100,1),SSTanom,[-6:1:6],'k:');
        clabel(c,h);
        cmocean('balance'); colorbar;
        caxis([-6 6]);
        %title(['Anomalia Subsuperficial ' 'Year: ' num2str(iy) ' Week: ' num2str(iw)] ); 
        title(['Anomalia Subsuperficial semanal ' datestr(datew(1,end))] ); 
        hold on 
        [c,h]=contour(lonb,-depthcl3(1:100,1),SST_weekly(:,:,end),[15:5:20],'g:','Linewidth',3);
        clabel(c,h);
        hold on
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
         set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
        xlabel('Longitud'); ylabel('Profundidad');
        
        subplot(1,2,1)
        imagescn(lonb,-depthcl3(:,1),SST_weekly(:,:,end));
        shading flat; cmocean('balance'); colorbar;
        hold on
        [c,h]=contour(lonb,-depthcl3(1:100,1),SST_weekly(:,:,end),'k--');
        clabel(c,h);
         hold on 
        [c,h]=contour(lonb,-depthcl3(1:100,1),SST_weekly(:,:,end),[15:5:20],'g:','Linewidth',3);
        clabel(c,h);
        cmocean('balance'); colorbar;
        caxis([12 30]);
        title(['Temperatura Subsuperficial semanal ' datestr(datew(1,end))] ); 
        hold on 
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
        set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
        xlabel('Longitud'); ylabel('Profundidad');
        text(160,-270,'Fuente: NOAA','color','w');
        text(160,-280,'Procesamiento: CIO-Challenger','color','w');
% % 
buoy15='G:\ocean ecosystem dynamics laboratory\boyas\30mayo';
mfile=fullfile(buoy15,'Anomalia Temperatura Subsuperficial ');
print(mfile,'-dpng','-r500');
