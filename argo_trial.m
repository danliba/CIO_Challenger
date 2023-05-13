%%argo_fullscript_trial_1

path01='F:\ocean ecosystem dynamics laboratory\argo floats\Agost30\DataSelection_20190902_112618_8236354';

hdir=dir(fullfile(path01,'argo-profiles-*.nc'));
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    P=ncread(fname,'PRES');
    T=ncread(fname,'TEMP');
    S=ncread(fname,'PSAL');
    L=ncread(fname,'LONGITUDE');
    
    data=cat(2,round(P(:,1:end)),round(T(:,1:end),2),round(S(:,1:end),2),repmat(L(1,1:end),[size(T(:,1:end),1) 1]));
   
    i=0;
    for iz=4:2:300
        i=i+1;
        a=size(P,2);
        b=a+size(T,2);
        c=b+size(S,2);
        d=c+size(L,2);
        indx=find(data(:,1==iz));
        if ~isempty(indx)
            temp(i,ifloat)=data(indx,1:a);
            sal(i,ifloat)=data(indx,a+1:b);
            pres(i,ifloat)=data(indx,b+1:c);
            lon(i,ifloat)=data(indx,d);
       else
%             temp(i,ifloat)=NaN;
%              sal(i,ifloat)=NaN;
%              pres(i,ifloat)=NaN;
%              lon(i,ifloat)=NaN;
        end
           
        
     end
    
end
%Create a j=0, then create a 2nd ~isempty with indx2, repeat this or find
%another way 