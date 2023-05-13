%idea filtro de directorios
for i=1:1:size(hdircl,1)
a=hdir(i); aa=hdircl(i);
b=a.name; bb=aa.name;
boya=b(2:7); boyacl=bb(19:24);

if boya==boyacl
    x=true;
else
    x=false
end
    xi(:,i)=x;
end

    %a=find(hdircl.name(1)=hdir.name);