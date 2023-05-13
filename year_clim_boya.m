clear all
clc
path0='D:\CIO\ayuda';
fn='t5n95w_mon.cdf';
fns=fullfile(path0,fn);

lon=double(ncread(fns,'lon'));
lat=double(ncread(fns,'lat'));
depth=double(ncread(fns,'depth'));
time=double(ncread(fns,'time'));

platform_code=ncreadatt(fns,'/','platform_code');
creation_day=ncreadatt(fns,'time','units');
yy=str2num(creation_day(12:15)); mm=str2num(creation_day(17:18)); dd=str2num(creation_day(20:21)); hr=str2num(creation_day(23:24));

time_boya=double(time)+datenum(yy,mm,dd,hr,0,0);
[yr,mo,da,hr,mi,se]=datevec(time_boya);

anos_boya=unique(yr);
iter=0;
figure
for i=anos_boya(1,1):1:anos_boya(end,1)
    iter=iter+1;
    disp(['Year: ' num2str(i)])
    indx=find(yr==i);
    
    numrec=length(indx);
    for irec=1:1:numrec
         
            temp=ncread(fns,'T_20',[1 1 1 indx(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            

            masknan=double(~isnan(temp));
            temp(isnan(temp))=0;
            
            if irec==1
                SSTm=zeros(size(temp));
                numnonnan=zeros(size(temp));
            end
            
            SSTm=SSTm+temp;
            numnonnan=numnonnan+masknan;
        end
        SSTm=SSTm./numnonnan;
        SSTs(:,:,:,iter)=SSTm;
        boy_year(iter,1)=iter;
end
        ST=permute(SSTs,[3,4,1,2]);
    
    [boy_yeari,dep]=meshgrid(boy_year,depth);
    formatSpec= ['La climatologia semanal de la boya ',platform_code,' se ha realizado exitosamente'];
    disp(formatSpec)    
    [c,h]=contourf(boy_yeari,-dep,ST,[6:2:30],':'); shading flat; colorbar; colormap jet;
    clabel(c,h); title(platform_code);
    set(gca,'xtick',[1:1:27],'xticklabel',[1994:1:2020]);
    ylim([-300 0]);
    %% 
     ST(5,19)=NaN;
    year_climatology=nanmean(ST,2);
    
    %year anom
    for iclim=1:1:size(ST,2)
        year_anom(:,iclim)=ST(:,iclim)-year_climatology;
        
        plot(year_anom,-dep(:,1),'o-');
        pause(0.5)
        hold on
    end
    
   %%
  make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.05], [0.1 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end

    subplot(2,3,1)
    plot(year_anom(:,1:5),-dep(:,1),'o-');
    legend(num2str(anos_boya(1:5)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,2)
     plot(year_anom(:,6:10),-dep(:,1),'o-');
    legend(num2str(anos_boya(6:10)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,3)
    plot(year_anom(:,11:15),-dep(:,1),'o-');
    legend(num2str(anos_boya(11:15)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,4)
    plot(year_anom(:,16:20),-dep(:,1),'o-');
    legend(num2str(anos_boya(16:20)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,4)
    plot(year_anom(:,21:24),-dep(:,1),'o-');
    legend(num2str(anos_boya(21:24)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,5)
    plot(year_anom(:,25:27),-dep(:,1),'o-');
    legend(num2str(anos_boya(25:27)),'Location','southeast')
    xlim([-3 3]);
    grid minor
    
    subplot(2,3,6)
    text(.5,.5,'Anomalias Anuales de Temperatura Subsuperficial',...
    'FontSize',14,'HorizontalAlignment','center')
    axis off
    
    %% promedio
     make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.05], [0.1 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end

    subplot(2,3,1)
    plot(ST(:,1:5),-dep(:,1),'o-');
    legend(num2str(anos_boya(1:5)),'Location','southeast')
    xlim([8 30]);
    grid minor
    
    subplot(2,3,2)
     plot(ST(:,6:10),-dep(:,1),'o-');
    legend(num2str(anos_boya(6:10)),'Location','southeast')
     xlim([8 30]);
    grid minor
    
    subplot(2,3,3)
    plot(ST(:,11:15),-dep(:,1),'o-');
    legend(num2str(anos_boya(11:15)),'Location','southeast')
     xlim([8 30]);
    grid minor
    
    subplot(2,3,4)
    plot(ST(:,16:20),-dep(:,1),'o-');
    legend(num2str(anos_boya(16:20)),'Location','southeast')
     xlim([8 30]);
    grid minor
    
    subplot(2,3,4)
    plot(ST(:,21:24),-dep(:,1),'o-');
    legend(num2str(anos_boya(21:24)),'Location','southeast')
     xlim([8 30]);
    grid minor
    
    subplot(2,3,5)
    plot(ST(:,25:27),-dep(:,1),'o-');
    legend(num2str(anos_boya(25:27)),'Location','southeast')
     xlim([8 30]);
    grid minor
    
    subplot(2,3,6)
    text(.5,.5,'Promedio Anual Temperatura Subsuperficial',...
    'FontSize',14,'HorizontalAlignment','center')
    axis off