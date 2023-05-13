function [lonk,latk]=Extract_offshore_axis(lon,lat,nm,range1)
    r=range1;
    km=nm2km(nm);
    a=km-r;
    b=km+r;
    D=dist2coast(lat,lon);
    D(island(lat,lon))=NaN;
    c=contour(lon(1,:),lat(:,1),D,[a b]);

    [m,n]=size(c);
    flag=1;
    endnum=0;
    numdatap=0;
while flag==1
    numdata=c(2,endnum+1);
    if numdata > numdatap;
        lonk=c(1, endnum+2: endnum+1+numdata);
        latk=c(2, endnum+2: endnum+1+numdata);
        numdatap=numdata;
    end
    endnum=endnum+1+numdata;
    if endnum+1>n
        flag=-1;
     end
end
