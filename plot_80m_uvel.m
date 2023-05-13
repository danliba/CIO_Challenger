plot([1:13],velu_im(15,:),'o--');%dato
hold on; 
plot([1:13],[u_vel(15,end) u_vel(15,:)],'ko--')%historico
grid minor
meses={'Dic','En','Feb','Mar','Abr','May','Jun','Jul',...
    'Ago','Set','Oct','Nov','Dic'}';
set(gca,'xtick',[1:1:13],'xticklabel',meses);
legend('Promedio mensual 2018','Historico');
title('Velocidad zonal a 80m en 0n110w'); ylabel('Profundidad'); xlabel('2018');

%% merluza
ano=[2009:2018];
merluza=[47162 41108 37645 33147 54522 63940 56286 72404 79613 76416];
caballa=[110605 20467 46946 26781 58297 73844 49964 165396 112862 72002];
jurel=[74694 17559 257240 184951 82111 81748 23036 15121 10094 58356];
perico=[57153 53359 43688 42347 55830 55136 61909 40343 30984 47711];
fish_label={'Merluza','Caballa','Jurel','Perico'};

subplot(2,2,1)
plot(ano,merluza,'bo--');
legend(fish_label(1));
xlabel('Años');ylabel('TM');
title('DESEMBARQUE DE RECURSOS MARÍTIMOS SEGÚN ESPECIE, 2009 - 18 ','Fontsize',9);
grid minor
subplot(2,2,2)
plot(ano,caballa,'ro--');
legend(fish_label(2)); 
xlabel('Años');ylabel('TM');
title('DESEMBARQUE DE RECURSOS MARÍTIMOS SEGÚN ESPECIE, 2009 - 18 ','Fontsize',9);
grid minor
subplot(2,2,3)
plot(ano,jurel,'go--');
legend(fish_label(3)); xlabel('Años');ylabel('TM');
title('DESEMBARQUE DE RECURSOS MARÍTIMOS SEGÚN ESPECIE, 2009 - 18 ','Fontsize',9);
grid minor
subplot(2,2,4)
plot(ano,perico,'ko--');
legend(fish_label(4)); 
xlabel('Años');ylabel('TM');
title('DESEMBARQUE DE RECURSOS MARÍTIMOS SEGÚN ESPECIE, 2009 - 18 ','Fontsize',9);
grid minor