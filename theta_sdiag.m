%program to compute theta-s diagram
function theta_sdiag(theta,s)
%% generating background density contours

theta=theta(:);
sal2=sal2(:);
sal2min=min(sal2)-0.01.*min(sal2);
smax=max(sal2)+0.01.*max(sal2);
thetamin=min(theta)-0.1*max(theta);
thetamax=max(theta)+0.1*max(theta);
xdim=round((sal2max-sal2min)./0.1+1);
ydim=round((thetamax-thetamin)+1);
dens=zeros(ydim,xdim);
thetai=((1:ydim)-1)*1+thetamin;
si=((1:xdim)-1)*0.1+sal2min;
disp(xdim);disp(ydim);
for j=1:ydim
    for i=1:xdim
        dens(j,i)=sw_dens(si(i),thetai(j),0);
    end
end

dens=dens-1000;
[c,h]=contour(si,thetai,dens,'k');
clabel(c,h,'LabelSpacing',1000);
xlabel('Salinity (%o)','FontWeight','bold','FontSize',12)
ylabel('Theta (^oC)','FontWeight','bold','FontSize',12)

%% plotting scatter plot of theta and s;
hold on;
scatter(s,theta,'.');
clear s theta;