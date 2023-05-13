hdir=dir('*.nc');
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    P=ncread(fname,'PRES');
    T=ncread(fname,'TEMP');
    S=ncread(fname,'PSAL');
    L=ncread(fname,'LONGITUDE');
    
    data=cat(2,round(P(:,1)),round(T(:,1),2),round(S(:,1),2),repmat(L(1,1),[size(T(:,1),1) 1]));
   
    i=0;
    for iz=4:2:1000
        i=i+1;
        indx=find(data(:,1)==iz);
        if ~isempty(indx)
            temp(i,ifloat)=data(indx,2);
            sal(i,ifloat)=data(indx,3);
            pres(i,ifloat)=data(indx,1);
            lon(i,ifloat)=data(indx,4);
        else
            temp(i,ifloat)=NaN;
             sal(i,ifloat)=NaN;
             pres(i,ifloat)=NaN;
             lon(i,ifloat)=NaN;
        end
           
        
     end
    
end