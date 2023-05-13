%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%puertos%%%%%%%%%%%%%%%%%%%%%%%

pathmap='D:\descargas\CIO\nov_perupesca\Paises_Mundo';
fnmap='Paises_Mundo.shp';

pathpuerto='D:\descargas\CIO\nov_perupesca\puerto';
fnpuerto='puerto.shp';

%% read shapefile peru
sudamerica=shaperead(fullfile(pathmap,fnmap));
%%read shapefile puertos
[a,b]=shaperead(fullfile(pathpuerto,fnpuerto));


for i=1:1:size(a,1)
plot(a(i).X,a(i).Y,'k.');
lonpuertos(i,:)=a(i).X;
latpuertos(i,:)=a(i).Y;
nombrepuertos{i,:}=b(i).NOMPUERT;
text(lonpuertos(i),latpuertos(i),nombrepuertos{i,:},'fontsize',7);
hold on
end

indx=[3,5,10,12,13,14,15,22,25,30,31,33,36,38,50];
%puertos ya seleccionados
puertoselect=nombrepuertos(indx,:);
%callao nombre cambiar
puertoselect(2,:)={'CALLAO'};
lonpuertos_text=lonpuertos(indx);
latpuertos_text=latpuertos(indx);
close 
%% plot shapefile 
for ii=1:1:length(sudamerica)
plot(sudamerica(ii).X,sudamerica(ii).Y,'k');
hold on
end
axis([-100 -68 -22 10]);
text(lonpuertos_text,latpuertos_text,puertoselect,'fontsize',6);
plot(lonpuertos,latpuertos,'b.');

 save('mapa_puertos','sudamerica','lonpuertos_text','latpuertos_text'...
     ,'puertoselect','lonpuertos','latpuertos');