% 
% MJO_PARAMS.m - user adjustable parameters for run diabatic forcing.
%


% Zonal half-width of cloud cluster. [m]
a0 = 1250000;

% Meridional e-folding width of cloud cluster. [m]
b0 = 450000;

% For the purpose of comparison among experiments varying Q0,a0,b0, 
% we have constrained the quantity Q0*a0*b0 to be a constant, namely
% 9.8044e+10.  The default configuration is:
%     Q0 * a0 * b0  =  0.1743 * 1,250,000 * 450,000  =  9.8044e+10
Q0_a0_b0 = 9.8044e+10;

% Diabatic forcing coefficient. Maximum magnitude of
% cloud cluster forcing term. [J/kg*s]
% To ensure the quantity Q0*a0*b0 is constant, the quantity Q0 is 
% computed from it's constants value and the user selected a0 and b0.
Q0 = Q0_a0_b0 / (a0*b0);

% The meridional displacement, relative to the equator, 
% of the center of the cloud cluster. [m]  
y0 = 0;        

% Eastward propagation speed of the cloud cluster
% (and frame of reference). [m/s]
c = 5;

% Chosen pressure level. [mb]                   
p = 300;           

% N = nMax, maximum meridional mode (integer). []
nMax = 200;

% M = mMax, maximum zonal wavenumber (integer). []
mMax = 200;

% zonalDomain = zonal extent of equatorial channel
%               0.5 (half)  default
%               1.0 (full)
zonalDomain = 0.5;

