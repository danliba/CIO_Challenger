%%Climatologia de vientos por boya

%110W
fn='w0n110w_dy.cdf';
path0='D:\CIO\winds_buoys';
boy=110;
buoy=sprintf('w0n110w_dy.cdf',boy);
buoys=fullfile(path0,buoy);

lon=double(ncread(buoys,'lon'));
lat=double(ncread(buoys,'lat'));
% uwind0=double(ncread(buoys,'WU_422'));
% vientosU=permute(uwind0,[1 4 2 3]);


time=ncread(buoys,'time');

[yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1980,3,7,0,0,0));

time=datenum(yr,mo,da,hr,mi,se);

most=1;
moen=12;

%% 
iter=0;
for im=most:1:moen
    
    iter=iter+1;
    
    disp(['Month: ' num2str(im)])
    
    indx=find(mo==im);
    
    numrec=length(indx);
     for irec=1:1:numrec
         
         uwind=ncread(buoy,'WU_422',[1 1 1 indx(irec)],...
             [length(lon) length(lat) 1 1], [1 1 1 1]);
          vwind=ncread(buoy,'WV_423',[1 1 1 indx(irec)],...
             [length(lon) length(lat) 1 1], [1 1 1 1]);
         
         uwindi=uwind;
         vwindi=vwind;
         
         masknan=double(~isnan(uwindi));
         masknan2=double(~isnan(vwindi));
         
         uwindi(isnan(uwindi))=0;
         vwindi(isnan(vwindi))=0;
         
         if irec==1
             
             uwind_m=zeros(size(uwindi));
             vwind_m=zeros(size(vwindi));
             
             numnonnan=zeros(size(uwindi));
             numnonnan2=zeros(size(vwindi));
         end
         
         uwind_m=uwind_m+uwindi;
         vwind_m=vwind_m+vwindi;
         
         numnonnan=numnonnan+masknan;
         numnonnan2=numnonnan2+masknan2;
         
     end
     
     uwind_m=uwind_m./numnonnan;
     vwind_m=vwind_m./numnonnan2;
     
     uwindis(:,:,:,iter)=uwind_m;
     vwindis(:,:,:,iter)=vwind_m;
     months0(im,1)=im;
end

vientosU=permute(uwindis,[1 4 2 3]);
vientosV=permute(vwindis,[1 4 2 3]);
uwind110W=vientosU;
vwind110W=vientosV;


%% plot
figure
feather(vientosU,vientosV);


figure
subplot(1,2,1)
bar(months0,vientosU);
xlabel('time');
ylabel('vientos v (m/s)');
title('0ºN110ºW');

subplot(1,2,2)
barh(months0,vientosV);
ylabel('time');
xlabel('vientos u (m/s)');        
title('0ºN110ºW');
         
         
   

    
