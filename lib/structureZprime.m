function Zprime = structureZprime(p)
% STRUCTUREZPRIME - Computes the vertical structure function Z'(z).
%                   Here z = ln(p0/p), log-pressure. p0 = 1010mb
%                   is the surface pressure in the model atmosphere.
%                   p = 200mb is the pressure at the top of the model
%                   atmosphere. Z'(z) is the separable vertical structure 
%                   for the field variable w, log-pressure vertical
%                   velocity. Z'(z) is also the z-derivative of the
%                   vertical structure function Z(z).
%
%
% FILE:        structureZprime.m
% AUTHOR:      Matt Masarik
% DATE:        August 11 2005
% MODIFIED:    N/A
% CALL SYNTAX: Zprime = structureZprime(p);
%                       Zprime = vertical structure function (scalar)
%                       p = pressure (mb)  p=1010..200  (scalar)
%
% PRE:         The following scripts have been called:
%                CONSTANT_DEFINITIONS
%                VARIABLE_DEFINITIONS
% POST:        A scalar value, Zprime, is returned.
%              


% entry statement
disp('structureZprime.m function')

% global declaration
global p0 zT zM

% get log-pressure, z
z = log(p0/p);

% get Z(z). 
T1 = (1 + zT^2/(4*pi^2))^(1/2);
T2 = exp((z - zM)/2);
T3 = sin((pi*z)/zT);
Zprime = T1*T2*T3;

% END

