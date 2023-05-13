function [V, trnsp]=comp_geov(Ta,Sa,Pa,LONa,LATa,Tb,Sb,Pb,LONb,LATb)
LATm=0.5.*(LATa+LATb);
Omega=2.*pi./86400;
f=2.*Omega.*sin(LATm.*pi./180);
% load 'TempSalt4Geost.mat'
% f=1e-4;
% Ta=temp(:,1:end-1);
% Tb=temp(:,2:end);
% Sa=salt(:,1:end-1);
% Sb=salt(:,2:end);
% Pa=press(:,1:end-1);
% Pb=press(:,2:end);
L=distance(LATa,LONa,LATb,LONb).*1852.*60
L=repmat(L,[size(Ta,1) 1]);

delA=1./(1000+sigma_p(Ta,Sa,Pa))-1./(1000+sigma_p(0,35,Pa));
delB=1./(1000+sigma_p(Tb,Sb,Pb))-1./(1000+sigma_p(0,35,Pb));
delA=(delA(1:end-1,:))+delA(2:end,:)./2;
delB=(delB(1:end-1,:))+delB(2:end,:)./2;
dp=(Pa(1:end-1,:)-Pa(2:end,:)).*1e4;

delAdp=delA.*dp;
delBdp=delB.*dp;

dPhiA=[zeros(1,size(delAdp,2));cumsum(delAdp,1)];
dPhiB=[zeros(1,size(delBdp,2));cumsum(delBdp,1)];

whos dPhiB dPhiA f L
V=(dPhiB-dPhiA)./f./L;

V2=V;
V2(isnan(V2))=0;
trnsp=trapz(Pa,V2).*L(1);