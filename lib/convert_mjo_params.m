%
% convert_mjo_params.m - copy user input parameters into 'mks' form
%                          for computation.
%

% Q0/cp [K/day], Q0 [J/(kg*s)]: diabatic heating rate
sec_in_day=24*60*60;                      % =86400 [s/day]
if fixedIntegratedForcing == true
    Q0_cp = a0b0Q0_cp / (a0_km * b0_km);  %        [K/day]
end
Q0        = (Q0_cp / sec_in_day) * cp;    %       [J/kg*s]

% a0 [m]:  diabatic heating zonal half-width
a0 = a0_km * 10^3;

% b0 [m]:  diabatic heating meridional e-folding width
b0 = b0_km * 10^3;

% y0 [m]:  diabatic heating meridional displacement from equator
y0 = y0_km * 10^3;

