[data,raw,otro]=xlsread('data.xlsx','data2');
sal=data(:,6);
sal(sal==0)=NaN;
nan_sal=~isnan(sal);
indx_sal=find(nan_sal==1);

datos=data(indx_sal,:);

fecha1=datos(1:33,:);
ff=zeros(1,size(fecha1,1));
ff(ff==0)=20210310;

%dateout=datetime(ff','ConvertFrom','yyyymmdd',fecha1(:,3));
%% plots
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

 make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.1 0.01], [0.05 0.05], [0.1 0.1]);
if ~make_it_tight,  clear subplot;  end

 subplot(2,2,1)
 plot(fecha1(1:12,5),-fecha1(1:12,4),'o--');
 hold on
 plot(fecha1(13:end,5),-fecha1(13:end,4),'o--');
 title('Temperatura- 2021/03/10');
 xlabel('Temperatura ºC'); ylabel('Presión');
 xlim([12 27])
 %legend('Lance','Recojo');
 axis square
 grid minor
 box on 
 
 subplot(2,2,2)
 plot(fecha1(1:12,6),-fecha1(1:12,4),'o--');
 hold on
 plot(fecha1(13:end,6),-fecha1(13:end,4),'o--');
 title('Salinidad- 2021/03/10');
 xlabel('Salinidad UPS'); ylabel('Presión');
 xlim([33 36.5]);
 %legend('Lance','Recojo');
  axis square
 grid minor
 box on 
 
 subplot(2,2,3)
 plot(fecha1(1:12,7),-fecha1(1:12,4),'o--');
 hold on
 plot(fecha1(13:end,7),-fecha1(13:end,4),'o--');
 title('Oxigeno Disuelto- 2021/03/10');
 xlabel('Oxigeno (mg/L)'); ylabel('Presión');
 %xlim([33 36]);
 %legend('Lance','Recojo');
  axis square
 grid minor
 box on 
 
 subplot(2,2,4)
 ts_diagram2(0.5)
 hold on
 scatter(fecha1(1:12,6),fecha1(1:12,5),45,-fecha1(1:12,4));
 hold on
 scatter(fecha1(13:end-1,6),fecha1(13:end-1,5),45,-fecha1(13:end-1,4));
 title('TS- 2021/03/10');
 xlabel('Salinidad ups'); ylabel('Temperatura ºC');
 xlim([33 36]); ylim([16 28]);
  caxis([min(-fecha1(:,4)) 0]);
 colormap jet
 colorbar
  axis square
 grid minor
 box on 
 
%  plot(fecha1(1:12,6),fecha1(1:12,5),'o--');
%  hold on
%  plot(fecha1(13:end-1,6),fecha1(13:end-1,5),'o--');
%  title('TS- 2021/03/10');
%  xlabel('Salinidad ups'); ylabel('Temperatura ºC');
%  xlim([33 36]); ylim([16 28]);
%  %legend('Lance','Recojo');
%  grid minor
%  box on 
 
 
 print('mar_10_2021.png','-dpng','-r500');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%2021/03/12

fecha2=datos(34:128,:);
figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
 subplot(2,2,1)
 plot(fecha2(1:42,5),-fecha2(1:42,4),'o--');
 hold on
 plot(fecha2(43:end,5),-fecha2(43:end,4),'o--');
 title('Temperatura- 2021/03/12');
 xlabel('Temperatura ºC'); ylabel('Presión');
 xlim([12 27])
 %legend('Lance','Recojo');
  axis square
 grid minor
 box on 
 
 subplot(2,2,2)
 plot(fecha2(2:42,6),-fecha2(2:42,4),'o--');
 hold on
 plot(fecha2(43:end,6),-fecha2(43:end,4),'o--');
 title('Salinidad- 2021/03/12');
 xlabel('Salinidad UPS'); ylabel('Presión');
 xlim([34 36.5]);
 %legend('Lance','Recojo');
 axis square
 grid minor
 box on 
 
 subplot(2,2,3)
 plot(fecha2(1:42,7),-fecha2(1:42,4),'o--');
 hold on
 plot(fecha2(43:end,7),-fecha2(43:end,4),'o--');
 title('Oxigeno Disuelto- 2021/03/12');
 xlabel('Oxigeno (mg/L)'); ylabel('Presión');
 %xlim([33 36]);
 %legend('Lance','Recojo');
  axis square
 grid minor
 box on 
 
 subplot(2,2,4)
 ts_diagram2(0.5)
 hold on
 scatter(fecha2(2:42,6),fecha2(2:42,5),45,-fecha2(2:42,4));
 hold on
 scatter(fecha2(43:end,6),fecha2(43:end,5),45,-fecha2(43:end,4));
  xlim([34 36.5]); ylim([12 25]);
  caxis([min(-fecha2(:,4)) 0]);
  title('TS- 2021/03/12')
 colormap jet
 colorbar
 grid minor
  axis square
 box on 
%  plot(fecha2(2:42,6),fecha2(2:42,5),'o--');
%  hold on
%  plot(fecha2(43:end-1,6),fecha2(43:end-1,5),'o--');
%  title('TS- 2021/03/18');
%  xlabel('Salinidad ups'); ylabel('Temperatura ºC');
%  xlim([34 36.5]); ylim([12 25]);
 %legend('Lance','Recojo');

 print('mar_12_2021.png','-dpng','-r500');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%2021/03/14

fecha3=datos(129:end,:);

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*2.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
 subplot(2,2,1)
 plot(fecha3(1:60,5),-fecha3(1:60,4),'o--');
 hold on
 plot(fecha3(61:137,5),-fecha3(61:137,4),'o--');
 hold on
 plot(fecha3(138:166,5),-fecha3(138:166,4),'o--');
 hold on
 plot(fecha3(167:end,5),-fecha3(167:end,4),'o--');
 title('Temperatura- 2021/03/14');
 xlabel('Temperatura ºC'); ylabel('Presión');
 %legend('Lance','Recojo');
 xlim([12 27])
 grid minor
 axis square
 box on 
 
 subplot(2,2,2)
 plot(fecha3(1:60,6),-fecha3(1:60,4),'o--');
 hold on
 plot(fecha3(61:136,6),-fecha3(61:136,4),'o--');
 hold on
 plot(fecha3(138:166,6),-fecha3(138:166,4),'o--');
 hold on
 plot(fecha3(167:end,6),-fecha3(167:end,4),'o--');
 title('Salinidad- 2021/03/14');
 xlabel('Salinidad UPS'); ylabel('Presión');
 xlim([34 36.5]);
 %legend('Lance','Recojo');
 grid minor
 axis square
 box on 
 
 subplot(2,2,3)
 plot(fecha3(1:60,7),-fecha3(1:60,4),'o--');
 hold on
 plot(fecha3(61:136,7),-fecha3(61:136,4),'o--');
  hold on
 plot(fecha3(138:166,7),-fecha3(138:166,4),'o--');
 hold on
 plot(fecha3(167:end,7),-fecha3(167:end,4),'o--');
 title('Oxigeno Disuelto- 2021/03/14');
 xlabel('Oxigeno (mg/L)'); ylabel('Presión');
 %xlim([33 36]);
 %legend('Lance','Recojo');
 grid minor
 axis square
 box on 
 
 subplot(2,2,4)
 ts_diagram2(0.5)
 hold on
 scatter(fecha3(1:60,6),fecha3(1:60,5),45,-fecha3(1:60,4));
 hold on
 scatter(fecha3(61:136,6),fecha3(61:136,5),45,-fecha3(61:136,4));
 hold on
 scatter(fecha3(138:166,6),fecha3(138:166,5),45,-fecha3(138:166,4));
 hold on
 scatter(fecha3(167:end,6),fecha3(167:end,5),45,-fecha3(167:end,4));
 
  xlim([34 36.5]); ylim([12 25]);
  caxis([min(-fecha3(:,4)) 0]);
  title('TS- 2021/03/14')
 colormap jet
 colorbar
 grid minor
 axis square
 box on 
%  plot(fecha2(2:42,6),fecha2(2:42,5),'o--');
%  hold on
%  plot(fecha2(43:end-1,6),fecha2(43:end-1,5),'o--');
%  title('TS- 2021/03/18');
%  xlabel('Salinidad ups'); ylabel('Temperatura ºC');
%  xlim([34 36.5]); ylim([12 25]);
 %legend('Lance','Recojo');

 print('mar_14_2021.png','-dpng','-r500');









