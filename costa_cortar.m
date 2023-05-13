%% Corta la costa peruana en el rango deseado y plotealo sumando o restando su posicion en el eje X.
%Util para hacer el corte de la costa con masknan 
range0=[-85 -68 -22 2];
load coastlines
indxlong=find(coastlon>=range0(1) & coastlon<=range0(2) & coastlat>=range0(3) & coastlat<=range0(4));
indxlat=find(coastlat>=range0(3) & coastlat<=range0(4) & coastlon>=range0(1) & coastlon<=range0(2));

loni=coastlon(indxlong); 
lati=coastlat(indxlat); 

plot(loni,lati,'k.')
hold on
plot(loni-km2deg(100),lati,'b.')%%5º se asegura de que todos los puntos estan a 100km

coast_zero=[loni,lati];
coast_offshore=[loni-km2deg(100),lati];

coast_distance=distance(coast_zero,coast_offshore);

%save('Costa_Peruana','coast_zero','coast_offshore');
%% 
% range1=[-100 -65 -22 0];
% % [lonis,latis]=meshgrid(loni,lati);
% D=dist2coast(latis,lonis);
% D(island(latis,lonis))=NaN;
% pcolor(lonis,latis,D); shading flat; colorbar;
% hold on
% [c,h]=contour(lonis(1,:),latis(:,1),D,[200 60],'k');
% clabel(c,h);
% 
% km=nm2km(100);
% a=km-range1;
% b=km+range1;
% c=contour(lonis,latis,D,[a b]);
% hold on
% plot(loni,lati,'k.');
% 
% [m,n]=size(c);
% flag=1;
% endnum=0;
% numdatap=0;
% while flag==1
%     numdata=c(2,endnum+1);
%     if numdata > numdatap;
%         lonk=c(1, endnum+2: endnum+1+numdata);
%         latk=c(2, endnum+2: endnum+1+numdata);
%         numdatap=numdata;
%     end
%     endnum=endnum+1+numdata;
%     if endnum+1>n
%         flag=-1;
%      end
% end
% %% 
% plot(lonk,latk,'b.');
% hold on
% plot(loni,lati,'k.');
% hold on
% plot(loni-km2deg(100),lati,'ro');