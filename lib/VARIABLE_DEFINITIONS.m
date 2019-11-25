% VARIABLEDEFINITIONS - declares/initializes basic variables. (script)
% 
% FILE:        VARIABLE_DEFINITIONS.m
% AUTHOR:      Matt Masarik
% DATE:        June 15 2005
% MODIFIED:    MM Nov 08 2019 - moved 'alfa' to CONSTANT_DEFINITIONS.m.
%                               Also moved all interesting user params
%                               to MJO_PARAMS.m in the root dir, and added
%                               a call to that file in this script.
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

% Call MJO_PARAMS.m, which contains user adjustable parameters previously
% contained in this file.
MJO_PARAMS;
convert_mjo_params;

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
% zonalDomain is a dimensionless parameter prescribing if
% the full (1.0) equatorial channel is computing or half (0.5).
% The default is half.
xiMax = (pi*a)*zonalDomain;      
                   
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
