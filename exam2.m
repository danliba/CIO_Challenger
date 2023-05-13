ldir=dir('*.nc');
 ldir(1:2) = [];
for ifloat=1:1:size(ldir,1)
    fname=ldir(ifloat).name;
    P=ncread(fname,'PRES');
    T=ncread(fname,'TEMP');
    S=ncread(fname,'PSAL');
    L=ncread(fname,'LATITUDE');
    L2=ncread(fname,'LONGITUDE');
    
    data=cat(2,round(P(:,1)),round(T(:,1),2),round(S(:,1),2),...
        repmat(L(1,1),[size(T(:,1),1) 1]),repmat(L2(1,1),[size(T(:,1),1) 1]));
   
    i=0;
    for iz=4:2:1000
        i=i+1;
        indx=find(data(:,1)==iz);
        if ~isempty(indx)
            temp(i,ifloat)=data(indx,2);
            sal(i,ifloat)=data(indx,3);
            pres(i,ifloat)=data(indx,1);
            lat(i,ifloat)=data(indx,4);
            lon(i,ifloat)=data(indx,5);
        else
            temp(i,ifloat)=NaN;
             sal(i,ifloat)=NaN;
             pres(i,ifloat)=NaN;
             lon(i,ifloat)=NaN;
             lat(i,ifloat)=NaN;
        end
           
        
     end
    
end

[latb,Indx]=sort(lon(1,:),2);
lat2=lat(:,Indx);
lon2=lon(:,Indx);
temp2=temp(:,Indx);
sal2=round(sal(:,Indx),2);
pres2=pres(:,Indx);

temp2=flipdim(temp2,1);
sal2=flipdim(sal2,1);
pres2=flipdim(pres2,1);

[V, trnsp]=comp_geov(temp2(:,1),sal2(:,1),pres2(:,1),lon2(1,1),lat2(1,1),...
    temp2(:,2),sal2(:,2),pres2(:,2),lon2(1,2),lat2(1,2));


figure
plot(V,-pres2(:,1))
