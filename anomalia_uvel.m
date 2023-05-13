clear all
clc
close all
path1='D:\CIO\ayuda\velocidad_u';
pathcl='D:\CIO\ayuda\velocidad_u\perfiles';
hdir=dir(fullfile(path1,'time*.cdf')); 
hdircl=dir(fullfile(pathcl,'B*0n*.mat'));

mkdir anomalias
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
    t=datetime(yr,mo,da,hr,0,0);
    
    iter=0;
    yrst=2017; yren=2018;
    most=12; moen=12;
    moen0=moen;
    
    figure
    for iy=yrst:1:yren
        if iy>yrst
            most=1;
        end

        if iy==yren
            moen=moen0;
        else
            moen=12;
        end
        for im=most:1:moen
           iter=iter+1;      
           indx0=find(yr==iy&mo==im);
           if isempty(indx0)==1
               continue
           end
           numrec=length(indx0);
           
           for irec=1:1:numrec
            velu=ncread(fns,'u_1205',[1 1 1 indx0(irec)],...
                [length(lon) length(lat) length(depth) 1], [1 1 1 1]);
            velu=permute(velu,[3,4,1,2]);
            masknan=double(~isnan(velu));
            velu(isnan(velu))=0;
            velu2(:,irec)=velu;
            if irec==1
                velum=zeros(size(velu));
                numnonnan=zeros(size(velu));
            end
            
            velum=velum+velu;
            numnonnan=numnonnan+masknan;
           end
           velum=velum./numnonnan;
           %anomalia
           velu_anom=velum-u_vel(:,im);
           formatSpec= ['Anomalia de velocidad del ',num2str(im),'/',num2str(iy),' de la boya ',platform_code,' se ha realizado exitosamente'];        
            disp(formatSpec)  
           plot(velu_anom,-depth,'o--');
          title([platform_code,  ' ',num2str(im),'/',num2str(iy)]);
          grid on
           pause(2)
           clf
           
           VELU_anom(:,iter)=velu_anom;
           velu_im(:,iter)=velum;
           month_number(iter,:)=im;
           number_of_months=month_number;

           JM='.\anomalias';
            mfile=fullfile(JM,['Boya-w-' platform_code]);
            save(mfile,'VELU_anom','month_number','lon','depth','velu_im','lat','velu2','platform_code');

        end
    end
    clear im indx0 numrec irec velu masknan velum numnonnan uvel months VELU_anom velu_im velu2
    close all
end

    