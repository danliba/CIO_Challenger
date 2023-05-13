%% floats 2D with loop in time

%% 2D interpolation

clear all;
close all;

yrst=2019;
yren=2020;
most=1;
moen=3;
moen0=moen;

figure
%  aviobj = QTWriter('Argo_float_at_100m_mean.mov','FrameRate',1);%aviobj.Quality = 100;

% gif('Flotadores_promedio_de0-100m.gif','frame',gcf,'delaytime',1,'nodither')
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
        %ruta
        path01='E:\ocean ecosystem dynamics laboratory\argo floats\flotadores_2';

        %lista de directorio
        hdir=dir(fullfile(path01,sprintf('%02d%02g*',iy,im)));


        %%profundidad
        range0=[0 100];

        for ifloat=1:1:size(hdir,1)

             fname=hdir(ifloat).name;

             load(fname);

        %    
             lat(1:size(lati,1),ifloat)=lati;
             lon(1:size(loni,1),ifloat)=loni; 
             temp(1:size(temperature,1),ifloat)=temperature;
             salt(1:size(salinity,1),ifloat)=salinity;

             salt(salt==0)=NaN;
             temp(temp==0)=NaN;


        end

            salt2=salt';
            %salt(isfinite(salt));

            indxNaN=find(isnan(salt2));
            salt2(indxNaN,:)=[];


            lat2=lat(1,:)';
            lat2(indxNaN,:)=[];

            lon2=lon(1,:)';
            lon2(indxNaN,:)=[];


            temp=temp';

            W=[-100+360:0.04:-80+360];
            S=[-25:0.04:10];
            
           


%% Interpolation 

[xx,yy]=meshgrid(S,W);


% [xi,di]=meshgrid(1:1:size(hdir,1),1:1:size(pres2,1));
% temp3=griddata(xi(~isnan(temp2)),di(~isnan(temp2)),temp2(~isnan(temp2)),xi,di);
% 
%SAL2D=griddata(xx(~isnan(salinity)),yy(~isnan(salinity)),salinity(~isnan(salinity')),xx,yy);
vv=griddata(lat2,lon2+360,salt2,xx,yy,'cubic');

  
pcolor(yy,xx,vv);
shading flat
c=colorbar('Ticks',[33,33.8,34.8,35.1,35.5]);
c.Label.String='Salinidad en UPS';
caxis([33 35.5]);
title(['Seccion horizontal Salinidad a 100m ',datestr(date)])
hold on
plot3(lon2+360,lat2,salt2,'ko','markerfacecolor','g');

grid on;
xlabel('longitude');
ylabel('latitude');
%vlabel('salinity');


    %% colorbar 
    m=0.2;
    ASS=[35.1:0.1:35.5]';
    ACF=[34.8:0.07:35.1]';
    AES=[33.8:0.07:34.8]';
    ATS=[33:0.07:33.8]';

    n=0;
    for i=1:1:size(ASS,1)

        mymapA0=[1 1 0+n];
        n=n+m;
        mymapA(i,1:1:size(mymapA0,2))=mymapA0;
        myA=flip(mymapA);

    end
    % 
    m1=0.2;
    n=0;
    for i=1:1:size(ACF,1)
        mymapB0=[0+n 1 1];
        n=n+m1;
        mymapB(i,1:1:size(mymapB0,2))=mymapB0;
        myB=flip(mymapB);

    end

    m2=0.05;
    n=0;
    for i=1:1:size(AES,1)

        mymapC0=[1 0+n 1];
        n=n+m2;
        mymapC(i,1:1:size(mymapC0,2))=mymapC0;
        myC=flip(mymapC);

    end

    m3=0.05;
    n=0;
    for i=1:1:size(ATS,1)

        mymapD0=[1 0+n 0+n];
        n=n+m3;
        mymapD(i,1:1:size(mymapD0,2))=mymapD0;
        myD=flip(mymapD);

    end


    mycolormap=cat(1,myD,myC,myB,myA);

      colormap(mycolormap)
  
   %% figure
   hold on
        centerLon=180;
        he=earthimage('center',centerLon);
        uistack(he,'bottom');
        set(gca,'ytick',[-25:5:10],'yticklabel',[-25:5:10],'ylim',[-25 10]);
        set(gca,'xtick',[260:5:290],'xticklabel',[-100:5:-70],'xlim',[262 290]);
  pause(0.1)
  
%   M1=getframe(gcf);
%   writeMovie(aviobj, M1);  
%         
%   gif
    clf
    
      
    end
end

%  close(aviobj);