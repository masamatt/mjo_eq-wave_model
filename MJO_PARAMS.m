% 
% MJO_PARAMS.m - user adjustable parameters for run diabatic forcing.
%


%%% % CC = 9.8044e+10
%%% % C0 = 0.1743 *  1,250,000 * 450,000
%%% % C1 = 0.0242 *  9,000,000 * 200,000
%%% % C2 = 0.0545 * 18,000,000 * 100,000

% Diabatic forcing coefficient. Maximum magnitude of
% cloud cluster forcing term. [J/kg*s]
%%%Q0 = 0.1743;
Q0 = 0.0242;
%%%Q0 = 0.0545;

% Zonal half-width of cloud cluster. [m]
%%%a0 = 1250000;
a0 = 9000000;
%%%a0 = 18000000;


% Meridional e-folding width of cloud cluster. [m]
%%%b0 = 450000;
b0 = 200000;
%%%b0 = 100000;
                   
% NOTE: Q0*a0*b0 = constant


% The meridional displacement, relative to the equator, 
% of the center of the cloud cluster. [m]
%%%y0 = 0;        
y0 = 500000;        

% Eastward propagation speed of the cloud cluster
% (and frame of reference). [m/s]
%%%c = 2.5;
c = 0;

% Chosen pressure level. [mb]                   
p = 850;           

% N = nMax, maximum meridional mode (integer). []
nMax = 200;

% M = mMax, maximum zonal wavenumber (integer). []
mMax = 200;          
