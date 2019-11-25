% 
% MJO_PARAMS.m - user adjustable run parameters.
%


% *****************  DIABATIC FORCING PARAMETERS ****************** %
% Q0/cp [K/day]:  diabatic heating rate          [default, Q0/cp=12K/day]
Q0_cp = 15;                      %   comment: for fixed integrated heating
fixedIntegratedForcing=false;    %   comment: for fixed integrated heating
%%% fixedIntegratedForcing=true; % uncomment: for fixed integrated heating
%%% Q0_cp     = NaN;             % uncomment: for fixed integrated heating
%%% a0b0Q0_cp = 1250*450*12;     % uncomment: for fixed integrated heating
                                 %   set integrated heating fixed amount,
                                 %   a0b0Q0_cp:= a0*b0*Q0/cp
                                 %             = 1250*450*12
                                 %     default = 6750x10^3 [(K*km^2)/day]                      

% a0 [km]:  zonal half-width of diabatic heating
%           [default, a0=1250km]
a0_km = 300;

% b0 [km]:  meridional e-folding width of diabatic heating
%           [default,  b0=450km]
b0_km = 350;

% y0 [km]:  meridional displacement from equator of diabatic heating
%           [default,  y0=450km]
y0_km = 1200;        

% c [m/s]:  phase speed of diabatic forcing
%           [default,    c=5m/s]
c  = 5;
% ***************************************************************** %


% p [hPa]:  vertical pressure level                  [default, p=850hPa]             
p = 850;           


% N []:  maximum meridional mode, integer            [default,    N=200]
nMax = 300;

% M []:  maximum zonal wavenumber, integer           [default,    M=200]
mMax = 300;


% zonalDomain []:  zonal extent of equatorial channel to display
%               0.5  (half)                          [default]
%               1.0  (full)
zonalDomain = 0.5;

% END
