function Z = structureZ(p)
% STRUCTUREZ - Computes the vertical structure function Z(z).
%              Here z = ln(p0/p), log-pressure. p0 = 1010mb
%              is the surface pressure in the model atmosphere.
%              p = 200mb is the pressure at the top of the model
%              atmosphere. Z(z) is the separable vertical structure 
%              for the field variables u, v, phi, and potential 
%              vorticity q. 
%
% FILE:        structureZ.m
% AUTHOR:      Matt Masarik
% DATE:        August 10 2005
% MODIFIED:    N/A
% CALL SYNTAX: Z = structureZ(p);
%                  Z = vertical structure function (scalar)
%                  p = pressure (mb)  p=1010..200  (scalar)
%
% PRE:         The following scripts have been called:
%                CONSTANT_DEFINITIONS
%                VARIABLE_DEFINITIONS
% POST:        A scalar value, Z, is returned.
%              


% entry statement
disp('    structureZ.m function    : [Z(p)] apply Z vertical structure')

% global declaration
global p0 zT zM

% get log-pressure, z
z = log(p0/p);

% get Z(z). 
T1 = (pi^2/zT^2 + 1/4)^(-1/2);
T2 = exp((z - zM)/2);
T3 = (zT/(2*pi))*sin((pi*z)/zT);
T4 = cos((pi*z)/zT);
Z = T1*T2*(T3 - T4);

% END

