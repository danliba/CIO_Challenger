%[yr,mo,da,hr,mi,se]=datevec(time+datenum(1950,1,1,1,0,0));

%date=[cell2str(jj_S3(1)):10:jj_S3(end)];
%aa=datetime(jj_S3{1}, 'InputFormat', 'dd/MM/yyyy HH:MM:SS');
% t1 = datetime(str2num(jj_S3{1}(7:10)),str2num(jj_S3{1}(4:5)),str2num(jj_S3{1}(1:2)),str2num(jj_S3{1}(12:13)),str2num(jj_S3{1}(15:16)),str2num(jj_S3{1}(18:19)));
% t2 = datetime(str2num(jj_S3{end}(6:10)),str2num(jj_S3{end}(4:5)),str2num(jj_S3{end}(1:2)),str2num(jj_S3{end}(12:13)),str2num(jj_S3{end}(15:16)),str2num(jj_S3{end}(18:19)));
% t1 = datetime(2015,09,13,14,19,10);
% t2 = datetime(2016,08,5,16,42,06);
% t = t1:2.1:t2;

%% crear el vector tiempo para glider plot, hacerlo por temporadas , meses  en una longitud 