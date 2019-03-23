% CONSTANTDEFINITIONS - declares/initializes global constants. (script)
% 
% FILE:        CONSTANT_DEFINITIONS.m
% AUTHOR:      Matt Masarik
% DATE:        June 08 2006
% MODIFIED:    MM August 25 2005 - R -> Rd
%                                  When the dry air gas constant
%                                  was used in functions with 
%                                  roots (R), then R was overloaded.
%
% CALL SYNTAX: CONSTANT_DEFINITIONS;
% PRE:         None
% POST:        Constants contained here are available to functions
%              that also contain the global declaration 
%              within them.
%
% NOTE:        [] = dimensionless quantity, otherwise dimension
%                   is contained within the square brackets.
%

% Starting statement
disp('Starting CONSTANT_DEFINITIONS.m script...')

% global declaration (this same declaration must also be
% included in a function file to access these constants.
% However, a declaration is not needed in a script file.)
global Omega a Rd cp kappa Gmma p0 zT zM cBar ep


%              initialize global constants
% ----------------------------------------------------------

% Earth's speed of rotation [rad/s]
Omega = 7.292*10^-5; 

% Earth's mean radius [m]
a = 6.37*10^6;        

% dry air gas constant [J/K*kg]
Rd = 287;              

% dry air specific heat at constant pressure [J/K*kg]
cp = 1004;            

% dimensionless ratio []                  
kappa = Rd/cp;         

% basic state static stability [K]
% Gmma = Gamma... Gamma already taken.
Gmma = 23.79;         

% model surface pressure [mb]                      
p0 = 1010;            

% log-pressure top of model []    
zT = log(p0/200);     

% dimensionless log-pressure level at which Z'(z) 
% reaches its maximum value = 1. []
zM = 0.5803*zT;      

% pressure level corresponding to zM. []
% recall p = p0*e^-z 
pM = p0*exp(-zM);

% gravity wave speed? [m/s]
cBar = sqrt((Rd*Gmma)/((pi/zT)^2 + 1/4));  

% Lamb's parameter []
% ep = epsilon
ep = (4*Omega^2*a^2)/cBar^2;  
                              


% Finish statement
disp('Finishing CONSTANT_DEFINITIONS.m script.')
disp(' ')  % empty line.. cosmetics

% END                             
                      
                      
