%%Codigo para leer datos del glider 
%% Primero leemos los datos de u_vel
%Para esto vamos a usar la funcion xlsread
[data,jj,raw]=xlsread('data_2015_2016.xlsx','u_vel','A1:DA7279'); %Aqui leemos todos los datos disponibles

%%%%vamos a plotear las coordenadas de los perfiles para tener una idea
%%%%general de la zona geográfica
load coast %cargamos datos de costa 

%%%%ploteo%%%% 
figure
P=get(gcf,'position'); P(3)=P(3)*2; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

subplot(1,2,1)
plot(long,lat,'k')
%axis([min(data(:,2)) max(data(:,2)) min(data(:,3)) max(data(:,3))])
axis([-97 -75 -10 10 ]);
hold on
plot(data(:,2),data(:,3),'*','MarkerSize',2);
xlabel('Longitud'); ylabel('Latitud');
grid on 

subplot(1,2,2)
plot(long,lat,'k'); hold on; axis([min(data(:,2)) max(data(:,2)) min(data(:,3)) max(data(:,3))]); 
plot(data(:,2),data(:,3),'*','MarkerSize',2);
xlabel('Longitud'); ylabel('Latitud');
grid minor

print('Ubicacion_Glider.png','-dpng','-r300');
%%%latitud: min: -2.9638 %max:2.0061  %promedio: -0.3883
%%%longitud: min:-95.0821  %max:-91.2212  %promedio: -93.1373
%% Ahora si los datos de u_vel 

%filtrar solo los datos a usar
t=sum(((isnan(data))*1),2); %borrar los que tienen 100 NANs
indx_sel=find(t~=100); %asies esta es la funcion find de la que hable abajo
jj=jj(indx_sel);
data(sum(isnan(data), 2) == 100, :) = [];
lati=data(:,3); loni=data(:,2); depth=data(1,5:end); %datos

%listo ya esta filtrado %%éxito *-*

%ploteo inicial
for ii=1:1:size(data,1)
    plot(data(ii,5:end), -depth,'*--');title(['Uvel ' jj(ii)]);
    legend(['longitude: ' num2str(loni(ii)) '   ' 'latitude: ' num2str(lati(ii))],...
        'Location', 'southwest');
    pause(0.5)
    clf
end

%% ahora separemos por latitud (asi como ella se separo de ti okno :'v) 
%%-3, -2, -1, 0, 1, 2
%%usaremos la funcion "find" que usamos arriba

%filtramos #cutismo
indx_latS3=find(lati>=-3 & lati<-2);
indx_latS2=find(lati>=-2 & lati<-1);
indx_latS1=find(lati>=-1 & lati<0);
indx_latN0=find(lati>=0& lati<1);
indx_latN1=find(lati>=1& lati<2);
indx_latN2=find(lati>=2& lati<3);

%Seguimos filtrando %tenga fe la fe del CUTO #cutismo
data_S3=data(indx_latS3,:);%lat -3 a -2
data_S2=data(indx_latS2,:);%lat -2 a -1
data_S1=data(indx_latS1,:);%lat.. ya sabes que sigue e.e
data_N0=data(indx_latN0,:);
data_N1=data(indx_latN1,:);
data_N2=data(indx_latN2,:);

%los tiempos del CUTO son perfectos %filtramos las fechas #cutismo
jj_S3=jj(indx_latS3);
jj_S2=jj(indx_latS2);
jj_S1=jj(indx_latS1);
jj_N0=jj(indx_latN0);
jj_N1=jj(indx_latN1);
jj_N2=jj(indx_latN2);

disp('AHORA SI se viene lo CHIDO')

%%Mousequerramienta misteriosa
%data_try=rot90(data,-1); 
%data_try2=flip(data_try,2);
%% acomodamos los datos 
% este truco solo se puede hacer una vez!!

data_S3=flip(rot90(data_S3,-1),2); %le metemos un terrible flip
data_S2=flip(rot90(data_S2,-1),2); %FLIP
data_S1=flip(rot90(data_S1,-1),2); %FLIP
data_N0=flip(rot90(data_N0,-1),2); %FLIP
data_N1=flip(rot90(data_N1,-1),2); %FLIP
%% Acomode acomode 
%Lat= 3S
u_velS3=data_S3(5:end,:);
lons3=data_S3(2,:);
lats3=data_S3(3,:);

%Lat= 2S
u_velS2=data_S2(5:end,:);
lons2=data_S2(2,:);
lats2=data_S2(3,:);

%Lat= 1S
u_velS1=data_S1(5:end,:);
lons1=data_S1(2,:);
lats1=data_S1(3,:);

%Lat= 0N
u_velN0=data_N0(5:end,:);
lonN0=data_N0(2,:);
latN0=data_N0(3,:);

%Lat= 1N
u_velN1=data_N1(5:end,:);
lonN1=data_N1(2,:);
latN1=data_N1(3,:);

%% Colocar el intervalo de fechas para el eje X del plot
interv=5;
ff=0;
for ij=1:interv:length(jj_S3)
    ff=ff+1;
    fechaS3(ff)=cellstr(jj_S3{ij}(1:10));
end
ff=0;
for ij=1:60:length(jj_S2)
    ff=ff+1;
    fechaS2(ff)=cellstr(jj_S2{ij}(1:10));
end
ff=0;
for ij=1:60:length(jj_S1)
    ff=ff+1;
    fechaS1(ff)=cellstr(jj_S1{ij}(1:10));
end
ff=0;
for ij=1:60:length(jj_N0)
    ff=ff+1;
    fechaN0(ff)=cellstr(jj_N0{ij}(1:10));
end
ff=0;
for ij=1:30:length(jj_N1)
    ff=ff+1;
    fechaN1(ff)=cellstr(jj_N1{ij}(1:10));
end
%% AHORA SIII A LOKIAAAR (DIRE PLOTIAR**)
%%%%%%%%%%%%%%%%%%%Lat= 3ºS %%%%%%%%%%%%%%%%%%%%%%%%

figure;P=get(gcf,'position'); P(3)=P(3)*3; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

pcolor([1:size(u_velS3,2)],-depth,u_velS3); shading interp; colormap(parula);
set(gca,'xtick',[1:interv:size(u_velS3,2)],'xticklabel',fechaS3,'xlim',[1 size(u_velS3,2)]);
set(gca,'XTickLabelRotation',45); set(gca,'TickDir','out'); set(gca,'TickLength',[0.002, 0.002])
c=colorbar;c.Label.String='U velocity [m/s]';hold on; title('U Velocity Glider 3ºS - 2ºS');ylabel('Depth [m]');
[C,h]=contour([1:size(u_velS3,2)],-depth,u_velS3,'k:'); clabel(C,h); ylim([-300 0]);
print('Uvel_Glider_3S_2S.png','-dpng','-r300');

figure
plot(lons3,lats3,'^:','MarkerSize',2); grid minor; ylabel('Latitud');xlabel('Longitud'); title('Trayectoria Glider 3ºS - 2ºS');
text(lons3(1),lats3(1),jj_S3{1}); text(lons3(end-1),lats3(end-1),jj_S3{end-1}); text(lons3(60),lats3(60),jj_S3{60});
fprintf(' <strong> LA FE ES LO MÁS LINDO DE LA VIDA, ALLA LOS INCREDULOS </strong>.\n')
print('Trayectoria_Glider_3S_2S.png','-dpng','-r300');
%%%%%%%%%%%%%%%%%%%Lat= 2ºS %%%%%%%%%%%%%%%%%%%%%%%%

figure;P=get(gcf,'position'); P(3)=P(3)*3; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

pcolor([1:size(u_velS2,2)],-depth,u_velS2); shading interp; colormap(parula);
set(gca,'xtick',[1:60:size(u_velS2,2)],'xticklabel',fechaS2,'xlim',[1 size(u_velS2,2)]);
set(gca,'XTickLabelRotation',45); set(gca,'TickDir','out'); set(gca,'TickLength',[0.002, 0.002])
c=colorbar;c.Label.String='U velocity [m/s]';hold on; title('U Velocity Glider 2ºS - 1ºS');ylabel('Depth [m]');
[C,h]=contour([1:size(u_velS2,2)],-depth,u_velS2,[-0.8,-0.5,0.8,1.2],'k:'); clabel(C,h); ylim([-300 0]);
print('Uvel_Glider_2S_1S.png','-dpng','-r300');

figure
plot(lons2,lats2,'^:','MarkerSize',2); grid minor; ylabel('Latitud');xlabel('Longitud'); title('Trayectoria Glider 2ºS - 1ºS');
text(lons2(1),lats2(1),jj_S2{1}); text(lons2(end-1),lats2(end-1),jj_S2{end-1}); text(lons2(60),lats2(60),jj_S2{60});
print('Trayectoria_Glider_2S_1S.png','-dpng','-r300');
%%%%%%%%%%%%%%%%%%%Lat= 1ºS %%%%%%%%%%%%%%%%%%%%%%%%

figure;P=get(gcf,'position'); P(3)=P(3)*3; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

pcolor([1:size(u_velS1,2)],-depth,u_velS1); shading interp; colormap(parula);
set(gca,'xtick',[1:60:size(u_velS1,2)],'xticklabel',fechaS1,'xlim',[1 size(u_velS1,2)]);
set(gca,'XTickLabelRotation',45); set(gca,'TickDir','out'); set(gca,'TickLength',[0.002, 0.002])
c=colorbar;c.Label.String='U velocity [m/s]';hold on; title('U Velocity Glider 1ºS - 0ºN');ylabel('Depth [m]');
[C,h]=contour([1:size(u_velS1,2)],-depth,u_velS1,[-0.8,-0.5,0.8,1.2],'k:'); clabel(C,h); ylim([-300 0]);
print('Uvel_Glider_1S_0N.png','-dpng','-r300');

figure
plot(lons1,lats1,'^:','MarkerSize',2); grid minor; ylabel('Latitud');xlabel('Longitud'); title('Trayectoria Glider 1ºS - 0ºN');
text(lons1(1),lats1(1),jj_S1{1}); text(lons1(end-1),lats1(end-1),jj_S1{end-1}); text(lons1(60),lats1(60),jj_S1{60});
print('Trayectoria_Glider_1S_0N.png','-dpng','-r300');
%%%%%%%%%%%%%%%%%%%Lat= 0ºN %%%%%%%%%%%%%%%%%%%%%%%%

figure;P=get(gcf,'position'); P(3)=P(3)*3; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

pcolor([1:size(u_velN0,2)],-depth,u_velN0); shading interp; colormap(parula);
set(gca,'xtick',[1:60:size(u_velN0,2)],'xticklabel',fechaN0,'xlim',[1 size(u_velN0,2)]);
set(gca,'XTickLabelRotation',45); set(gca,'TickDir','out'); set(gca,'TickLength',[0.002, 0.002])
c=colorbar;c.Label.String='U velocity [m/s]';hold on; title('U Velocity Glider 0ºN - 1ºN');ylabel('Depth [m]');
[C,h]=contour([1:size(u_velN0,2)],-depth,u_velN0,[-0.8,-0.5,0.8,1.2],'k:'); clabel(C,h); ylim([-300 0]);
print('Uvel_Glider_0N_1N.png','-dpng','-r300');

figure
plot(lonN0,latN0,'^:','MarkerSize',2); grid minor; ylabel('Latitud');xlabel('Longitud'); title('Trayectoria Glider 0ºN - 1ºN');
text(lonN0(1),latN0(1),jj_N0{1}); text(lonN0(end-1),latN0(end-1),jj_N0{end-1}); text(lonN0(60),latN0(60),jj_N0{60});
print('Trayectoria_Glider_0N_1S.png','-dpng','-r300');

%%%%%%%%%%%%%%%%%%%Lat= 1ºN %%%%%%%%%%%%%%%%%%%%%%%%

figure;P=get(gcf,'position'); P(3)=P(3)*3; P(4)=P(4)*1;
set(gcf,'position',P); set(gcf,'PaperPositionMode','auto');

pcolor([1:size(u_velN1,2)],-depth,u_velN1); shading interp; colormap(parula);
set(gca,'xtick',[1:30:size(u_velN1,2)],'xticklabel',fechaN1,'xlim',[1 size(u_velN1,2)]);
set(gca,'XTickLabelRotation',45); set(gca,'TickDir','out'); set(gca,'TickLength',[0.002, 0.002])
c=colorbar;c.Label.String='U velocity [m/s]';hold on; title('U Velocity Glider 1ºN - 2ºN');ylabel('Depth [m]');
[C,h]=contour([1:size(u_velN1,2)],-depth,u_velN1,[-0.8,-0.5,0.5,0.6],'k:'); clabel(C,h); ylim([-300 0]);
print('Uvel_Glider_1N_2N.png','-dpng','-r300');

figure
plot(lonN1,latN1,'^:','MarkerSize',2); grid minor; ylabel('Latitud');xlabel('Longitud'); title('Trayectoria Glider 1ºN - 2ºN');
text(lonN1(1),latN1(1),jj_N1{1}); text(lonN1(end-1),latN1(end-1),jj_N1{end-1}); text(lonN1(60),latN1(60),jj_N1{60});
print('Trayectoria_Glider_1N_2N.png','-dpng','-r300');

%%%%%%%%%%%%%%% Felicidades ya tienes la velocidad %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Ahora ten fe para los demás parametros %%%%%%%%%%%%%%%%%%%%
fprintf(' <strong> LA FE ES LO MÁS LINDO DE LA VIDA, ALLA LOS INCREDULOS </strong>.\n')

