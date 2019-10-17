% VARIABLEDEFINITIONS - declares/initializes basic variables. (script)
% 
% FILE:        VARIABLE_DEFINITIONS.m
% AUTHOR:      Matt Masarik
% DATE:        June 15 2005
% MODIFIED:    N/A
% CALL SYNTAX: VARIABLE_DEFINITIONS;
% PRE:         CONSTANT_DEFINITIONS.m has been called
% POST:        Variables contained in this script will be
%              declared and initialized with the value they
%              will have for the current "run". These variables
%              will be in the workspace, but are not global,
%              so they must be passed into functions. To
%              clarify, these are quantities that may be 
%              varied from run to run (unlike those in 
%              CONSTANT_DEFINITIONS). However, they will not
%              change during a run (like those in 
%              CONSTANT_DEFINITIONS).
%
% NOTES:       1 deg lat = 111 km
%              [] = dimensionless quantity, otherwise dimension
%                   is contained within the square brackets.
%

% Starting statement
disp('Starting VARIABLE_DEFINITIONS.m script...')

% global declaration
global a



%               initialize variables
% ----------------------------------------------------

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

% Constant coefficient for Rayleigh friction 
% and Newtonian cooling. [1/s]
% "alfa" = alpha... alpha already taken
alfa = 2.894*10^(-6); 

% Chosen pressure level. [mb]                   
p = 850;           

% N = nMax, maximum meridional mode (integer). []
nMax = 200;

% M = mMax, maximum zonal wavenumber (integer). []
mMax = 200;          

% Maximum dimensionless meridional distance from the equator. []
% Corresponds to about yMax = 2731 km, or roughly 
% 25 deg lat.
yHatMax = 2.035;    

% Increment of dimensionless meridional distance. []
% Corresponds to about yIncrement = 49.7 km, or a little less
% than 1/2 deg lat.
yHatIncrement = 0.037; 

% 1-D array of yHat values. []
% Corresponds to values spanning (roughly) 25 deg S
% to 25 deg N at increments of 1/2 deg. 
yHatVec = [-yHatMax:yHatIncrement:yHatMax]; 

% Maximum zonal distance in the frame of 
% reference moving at a constant speed, c. [m]
xiMax = (pi*a)/2;      
                   
% Increment of "xi" zonal distance. [m]
xiIncrement = 50000;   

% 1-D array of xi values [m]
% Values span 1/2 the globe in the zonal direction, and
% have increments of 50 km. (Close to the increments in
% the meridional direction).
xiVec = [-xiMax:xiIncrement:xiMax];  



% Finishing statement
disp('Finishing VARIABLE_DEFINITIONS.m script.')
disp(' ')

% END
