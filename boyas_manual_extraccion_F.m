%en caso extremo de que no coincidan las semanas, extraer manualmente
fn='Boya-w-no_2s95w.mat';
load(fn);
SSTanom2=SSTanom(:,2:4); SSTanom2(:,4)=NaN;
SSTanom=SSTanom2;
SSTw2=SSTw(:,2:4);SSTw2(:,4)=NaN;
SSTw=SSTw2;
week_number=[24;25;26;27];

save('Boya-w-2s95w.mat','SSTanom','SSTw','week_number','lat','depth','lon');