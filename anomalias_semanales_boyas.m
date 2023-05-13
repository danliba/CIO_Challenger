clear all
clc
close all
%hoy
fecha=datevec(today); yyy=fecha(1,1);mmm=fecha(1,2);ddd=fecha(1,3);
%rutas
path1=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yyy,mmm,ddd);
new_folder=cd(path1);
pathcl='D:\CIO\Kelvin-cromwell\boyas\climatologias_boyas';
hdir=dir(fullfile(path1,'t0n*.cdf')); 
hdir([1,5,6,8,9])=[];
%delete missing buoy 170ºw in 0%2n delete 156e%2s delete 155w,156e,170w

hdircl=dir(fullfile(pathcl,'B*0n*.mat'));%no olvidar cambiar climatologia y retirar boyas que no transmiten
hdircl([1,5,6,8,9])=[];

%crear carpeta para guardar anomalias
mkdir anomalias
%codigo
for iboya=1:1:size(hdir,1)
    fns=hdir(iboya).name;
    fncl=hdircl(iboya).name;
    load(fullfile(pathcl,fncl));
    lon=double(ncread(fns,'lon')); lat=ncread(fns,'lat'); depth=double(ncread(fns,'depth'));
    time=double(ncread(fns,'time')); platform_code=ncreadatt(fns,'/','platform_code');
    creation_day=ncreadatt(fns,'time','units');
    yy=str2num(creation_day(12:15)); mm=str2num(creation_day(17:18)); dd=str2num(creation_day(20:21)); hr=str2num(creation_day(23:24));

    time_boya=double(time)+datenum(yy,mm,dd,hr,0,0);
    [yr,mo,da,hr,mi,se]=datevec(time_boya);
    t=datetime(yr,mo,da,hr,0,0); w=week(t);

    iter=0;
    yrst=2022; yren=yr(end,1);
    weeknd=w(end,1)-1;%semana anterior 
    week0=weeknd; weekst=week0-3; if weekst==-2; weekst=50; elseif weekst==-1; weekst=51; else weekst=week0-3;end
    disp(t(end))
    figure
    for iy=yrst:1:yren
        if iy>yrst
            weekst=1;
        end

        if iy==yren
            weeknd=week0;
        else
            weeknd=52;
        end

        for iw=weekst:1:weeknd
           iter=iter+1;      
           indx0=find(yr==iy&w==iw);
           numrec=length(indx0);

           for irec=1:1:numrec

           temp=ncread(fns,'T_20',[1 1 1 indx0(irec)],...
               [length(lon) length(lat) length(depth) 1],[1 1 1 1]);
           temp=permute(temp,[3,4,1,2]);
           masknan=double(~isnan(temp));
           temp(isnan(temp))=0;
           temp2(:,irec)=temp;%revisar cada dia de la semana
           if irec==1
               sstm=zeros(size(temp));
               numnonnan=zeros(size(temp));%%dividr entre numero de dias 
           end
           sstm=sstm+temp; 
           numnonnan=numnonnan+masknan;
           end
              sstm=sstm./numnonnan;
             %anomalia
              sstanom=sstm-ST(:,iw);

            formatSpec= ['La anomalia semanal Nº',num2str(iw),' de la boya ',platform_code,' se ha realizado exitosamente'];        
            disp(formatSpec)  
           plot(sstanom,-depth,'o--');
          title([platform_code,'-semana ',  num2str(iw),'-',num2str(iy)]);
           pause(0.5)
           clf
    
           SSTanom(:,iter)=sstanom;
           SSTw(:,iter)=sstm;
           week_number(iter,:)=iw;
           number_of_weeks=week_number;
    %      disp(num2str(week_number));
           JM=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d\\anomalias',yyy,mmm,ddd);
            mfile=fullfile(JM,['Boya-w-' platform_code]);
            save(mfile,'SSTanom','week_number','lon','depth','SSTw','lat','temp2');
    end
    end
            JN=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d\\anomalias',yyy,mmm,ddd);
            mfile=fullfile(JN,['Number_of_weeks_lat',num2str(lat)]);
            save(mfile,'number_of_weeks');
%clear after saving
clear iboya iw indx0 numrec irec temp masknan sstm numnonnan sstanom SSTanom weeks SSTw temp2
close all
end
%% Cat anomaly provisional
clear all
clc
%hoy
fecha=datevec(today); yy=fecha(1,1);mm=fecha(1,2);dd=fecha(1,3);
%ruta
pathanom=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d\\anomalias',yy,mm,dd);
hdiranom=dir(fullfile(pathanom,'B*0n*.mat')); %hdiranom(1) = [];%eliminar boya desactualizada
%  hdiranom(3:5) = []; hdiranom(1) = []; hdiranom(4)=[];
 
load(fullfile(pathanom,'Number_of_weeks_lat0.mat'))

figure
P=get(gcf,'position'); P(3)=P(3)*2.1; P(4)=P(4)*1.8;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.1 0.08], [0.06 0.05], [0.15 0.01]);
if ~make_it_tight,  clear subplot;  end
for iw=1:1:length(number_of_weeks)
    
for iboya=1:1:size(hdiranom,1)
    fname=[hdiranom(iboya).name];
    load(fullfile(pathanom,fname));
    datew=week_to_date(2022,1,1,number_of_weeks);

        datab=cat(2,depth,SSTanom(:,iw),SSTw(:,iw),repmat(lon(1,1),[size(depth(:,1),1),1]));
         j=0;
        for iz=5:5:500
         j=j+1;    
         indxiz=find(datab(:,1)==iz);
         
         if ~isempty(indxiz)
             sst_anom(j,iboya)=datab(indxiz,2);
             depth_anom(j,iboya)=datab(indxiz,1);
             SST_w(j,iboya)=datab(indxiz,3);
             loni(j,iboya)=datab(indxiz,4);
             
         else
             sst_anom(j,iboya)=NaN;
             depth_anom(j,iboya)=NaN;
             SST_w(j,iboya)=NaN;
            loni(j,iboya)=NaN;
         end
        end
end
     %no error
        nonan_logical=isnan(loni); 
        nonan_select=sum(nonan_logical,2); 

        %%no error nonan_select
        only_zero=find(nonan_select==0); 
        no_error=only_zero(1,1); 
     %order longitude
            longitude=loni(no_error,:);
            [lonb,Indx]=sort(longitude,2);
            lonb=longitude(:,Indx);
            sst_anomi=double(sst_anom(:,Indx));
            sst_wi=double(SST_w(:,Indx));
            depth_anomi=double(depth_anom(:,Indx));
         %Interpolation         
            [ai,bi]=meshgrid(1:1:size(hdiranom,1),1:1:size(depth_anomi,1));
            SST_anomaly=griddata(ai(~isnan(sst_anomi)),bi(~isnan(sst_anomi)),sst_anomi(~isnan(sst_anomi)),ai,bi);
            SST_weekly=griddata(ai(~isnan(sst_wi)),bi(~isnan(sst_wi)),sst_wi(~isnan(sst_wi)),ai,bi);
            depth_anomaly=griddata(ai(~isnan(depth_anomi)),bi(~isnan(depth_anomi)),depth_anomi(~isnan(depth_anomi)),ai,bi);
            %no error in depth
            nonan_logicald=isnan(depth_anomaly); nonan_selectd=sum(nonan_logicald,1);
            only_zerod=find(nonan_selectd==0); no_errord=only_zerod(1,1);
            %plot

            
            subplot(2,2,iw)
            [c,h]=contourf(lonb,-depth_anomaly(1:100,no_errord),SST_anomaly(1:end,:),'k:');
            clabel(c,h);caxis([-6 6]); cmocean('balance'); 
            hc=colorbar;
            hc.Location='eastoutside';
            hc.Position=[0.08 0.11 0.02 0.8];
            ylabel(hc,'SST anomaly');
            title(['Anomalia Subsuperficial semanal ' datestr(datew(iw,end))] );
            hold on 
            [c,h]=contour(lonb,-depth_anomaly(1:100,no_errord),SST_weekly(1:end,:),[15:5:20],'g:','Linewidth',1.5);
            clabel(c,h);
            hold on
            set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
            set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
            xlabel('Longitud'); ylabel('Profundidad');
            text(160,-270,'Fuente: NOAA','color','k');
            text(160,-285,'Procesamiento: CIO-Challenger.DALB','color','k');            
end
buoyW=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
mfile=fullfile(buoyW,['-aAnomalias semanales ' datestr(datew(iw,end)), '_lat_',num2str(lat)]);
print(mfile,'-dpng','-r500');
%% Last week plot
figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*1.3;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

        subplot(1,2,2)
        [c,h]=contourf(lonb,-depth_anomaly(2:100,no_errord),SST_anomaly(2:end,:),'k:');
        clabel(c,h);caxis([-6 6]); cmocean('balance'); colorbar;
        title(['Anomalia Subsuperficial semanal ' datestr(datew(iw,end))] ); 
        hold on 
        [c,h]=contour(lonb,-depth_anomaly(2:100,no_errord),SST_weekly(2:end,:),[15:5:20],'g:','Linewidth',3);
        clabel(c,h);
        hold on
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
         set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
        xlabel('Longitud'); ylabel('Profundidad');
        
        subplot(1,2,1)
        imagescn(lonb,-depth_anomaly(2:100,no_errord),SST_weekly(2:end,:));
        shading flat; cmocean('balance'); colorbar;
        hold on
        [c,h]=contour(lonb,-depth_anomaly(2:100,no_errord),SST_weekly(2:end,:),'k--');
        clabel(c,h);
         hold on 
        [c,h]=contour(lonb,-depth_anomaly(2:100,no_errord),SST_weekly(2:end,:),[15:5:20],'g:','Linewidth',3);
        clabel(c,h);
        cmocean('balance'); colorbar;
        caxis([12 30]);
        title(['Temperatura Subsuperficial semanal ' datestr(datew(iw,end))] ); 
        hold on 
        set(gca,'ytick',[-300:20:0],'yticklabel',[-300:20:0],'ylim',[-300 -4]);
        set(gca,'xtick',[155:10:265],'xticklabel',[[155:10:180] [-175:10:-95]],'xlim',[155 265]);
        xlabel('Longitud'); ylabel('Profundidad');
        text(160,-270,'Fuente: NOAA','color','w');
        text(160,-280,'Procesamiento: CIO-Challenger.DALB','color','w');
% % 
buoy15=sprintf('D:\\CIO\\Kelvin-cromwell\\boyas\\boyas_%d%02d%03d',yy,mm,dd);
mfile=fullfile(buoy15,['Anomalia Temperatura Subsuperficial ','_lat_',num2str(lat)]);
print(mfile,'-dpng','-r500');


%% Daniel Lizarbe Barreto
%Anomalia boyas version 1.0 
%30/jun/2020
