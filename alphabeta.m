function [alpha,beta] = alphabeta(s,t,p)
% ALPHABETA Coefficients of thermal expansion and saline contraction.
%
% [alpha,beta] = alphabeta(s,t,p) computes the coefficients of thermal 
% expansion and saline contraction, respectively alpha and beta.
% 
% Input Parameters:
%     s salinity    [psu]          
%     t temperature [degC]
%     p pressure    [decibar]
%
% Output Parameters:
%     alpha         [1/degC]
%     beta          [1/psu]
%

% Coefficients from Millero & Poisson, DSR 28 (6a),625 (1981).
% Formulae for alpha,beta and kappa from Lillibridge, J. Atm. and Ocean.
% Tech.,6,p.59 (1989)
%
% checkvalues: s = 35.057 psu, t = 9.216 deg C, p = 435.0 dB, 
%              alpha = 1.670e-4 deg C^-1, beta = 7.578e-4 psu^-1;
%              s = 34.995 psu, t = 8.770 deg C, p = 480.1 dB,
%              alpha = 1.63e-04 deg C^-1, beta = 7.583e-04 psu^-1;
%              

% Derived with permission from source code by R.G.Lueck, Univ. Victoria, BC.
% Fabian Wolk 2001/02/03
% 2001 Alec Electronics Co., Ltd.
% #Revision 0.0: 2001/08/09#



a = [
   -0.157406    6.793952e-02 -9.095290e-03  1.001685e-04 -1.120083e-06  6.536336e-09;
    0.824493   -4.0899e-03    7.6438e-05   -8.2467e-07    5.3875e-09    0; 
   -5.72466e-03 1.02270e-04  -1.65460e-06   0             0             0; 
    4.8314e-04  0             0             0             0             0]';
 
e = [
   19652.21    148.4206     -2.327105    1.360477e-02 -5.155288e-5; ...
      54.6746   -0.603459    1.09987e-2 -6.167e-5 0; ...
       7.944e-02 1.6483e-02 -5.3009e-04  0        0 ]';

h = [
   3.239908     1.43713e-03 1.16092e-04 -5.77905e-07; ...
   2.2838e-03  -1.0981e-5  -1.6078e-06   0; ...
   1.91075e-04  0           0            0]';

m = [
   8.50935e-05 -6.12293e-6 5.2787e-08; ...
  -9.9348e-07   2.0816e-08 9.1697e-10]';

p = p/10;

% compute sigma (in situ density)

sigma0  = a(1,1) + a(2,1)*t + a(3,1)*t.^2 + a(4,1)*t.^3 + a(5,1)*t.^4 + ... 
          a(6,1)*t.^5 ...
        + s.*(a(1,2) + a(2,2)*t + a(3,2)*t.^2 + a(4,2)*t.^3 + a(5,2)*t.^4) ...
        + sqrt(s.^3).*(a(1,3) + a(2,3)*t + a(3,3)*t.^2) ...
        + s.^2*a(1,4);

k       = e(1,1) + e(2,1)*t + e(3,1)*t.^2 + e(4,1)*t.^3 + e(5,1)*t.^4 ...
        + s.*(e(1,2) + e(2,2)*t + e(3,2)*t.^2 + e(4,2)*t.^3) ...
        + sqrt(s.^3).*(e(1,3) + e(2,3)*t + e(3,3)*t.^2) ...
        + (h(1,1) + h(2,1)*t + h(3,1)*t.^2 + h(4,1)*t.^3 ...
        + s.*(h(1,2) + h(2,2)*t + h(3,2)*t.^2) ...
        + sqrt(s.^3)*h(1,3)).*p ...
        + (m(1,1) + m(2,1)*t + m(3,1)*t.^2 ...
        + s.*(m(1,2) + m(2,2)*t + m(3,2)*t.^2)).*p.*p;

sigma   = (sigma0 + 1000*p./k)./(1. - p./k);

% compute kappa

%kappa = (1.-(p./k).*(aa+2.*bb.*p))./(k-p)

% compute alpha

drho0   = a(2,1) + 2*a(3,1)*t + 3*a(4,1)*t.^2 + 4*a(5,1)*t.^3 + ... 
          5*a(6,1)*t.^4 ...
        + s.*(a(2,2) + 2*a(3,2)*t + 3*a(4,2)*t.^2 + 4*a(5,2)*t.^3) ...
        + sqrt(s.^3).*(a(2,3) + 2*a(3,3)*t);

dk      = e(2,1) + 2*e(3,1)*t + 3*e(4,1)*t.^2 + 4*e(5,1)*t.^3 ...
        + s.*(e(2,2) + 2*e(3,2)*t + 3*e(4,2)*t.^2) ...
        + sqrt(s.^3).*(e(2,3) + 2*e(3,3)*t) ...
        + (h(2,1) + 2*h(3,1)*t + 3*h(4,1)*t.^2 ...
        + s.*(h(2,2) + 2*h(3,2)*t)).*p ...
        + (m(2,1) + 2*m(3,1)*t ...
        + s.*(m(2,2) + 2*m(3,2)*t)).*p.*p;

alpha   =-(1./(sigma + 1000)).*(drho0 ./(1 - p./k) ...
        - (sigma0+1000.).*p.*dk./((k-p).^2));

% compute beta

drho0   = a(1,2) + a(2,2)*t + a(3,2)*t.^2 + a(4,2)*t.^3 + a(5,2)*t.^4 ...
        + 1.5*sqrt(s).*(a(1,3) + a(2,3)*t + a(3,3)*t.^2) ...
        + 2*s*a(1,4);

dk      = e(1,2) + e(2,2)*t + e(3,2)*t.^2 + e(4,2)*t.^3 ...
        + 1.5*sqrt(s).*(e(1,3) + e(2,3)*t + e(3,3)*t.^2) ...
        + (h(1,2) + h(2,2)*t + h(3,2)*t.^2 ...
        + 1.5*sqrt(s)*h(1,3)).*p ...
        + (m(1,2) + m(2,2)*t + m(3,2)*t.^2).*p.*p;

beta    =(1./(sigma + 1000)) ... 
        .*(drho0 ./(1 - p./k) - (sigma0+1000).*p.*dk./((k-p).^2));
