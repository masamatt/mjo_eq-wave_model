% BALANCEDBASIS - Calls scripts/functions necessary for all fields.
%                 This script calls the functions that return variables
%                 needed to calculate all 5 fields of interest for the 
%                 balanced model. After it is called, specific 
%                 scripts to generate each field can then be called.
%
% FILE:         balancedBasis.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM September 05 2005 - This script now calls a
%                                      chunk of primitive model
%                                      functions with the end
%                                      result being the calculation
%                                      of the primitive model 
%                                      spectral space PV.
%               MM August 06 2008 - removed call to internal matlab
%                  'pack'.  In current versions of matlab, pack can
%                   only be called from the command line.
%
% CALL SYNTAX:  balancedBasis;
%
% PRE:  The following scripts must have been called:
%
%               CONSTANT_DEFINITIONS.m
%               VARIABLE_DEFINITIONS.m
%
%       The following scripts/functions must be located in a 
%       directory "lib", which must be located in the parent
%       directory "models":
%
%               getH.m
%               genH0.m
%               genH.m
%
%       The following functions must be located in a directory
%       "balanced", which must be located in the parent
%       directory models:
%
%               bGenHC.m
%               bGetNu.m
%               bGetQ.m
%               bSpectralq.m
%               bSpectralPsi.m
%               
% POST: Scripts to calculate the 5 specific balanced fields
%       of interest can be called. The following variables
%       will exist:
%
%       H0 = Script-H polys at n = 0
%       Hn = Script-H polys at n = 1..(N+1)
%       bHC0 = Script-H poly at n = 0, constant-y-argument
%       bHC = Script-H polys at n = 1..(N+2), constant-y-argument 
%       NUmn = dimensonless frequency array
%       Qmn = heating expansion coefficient array
%       qmn = spectral space PV array
%       psimn = spectral space streamfunction array
%

% entry statement
disp('Starting balancedBasis.m script...')
disp(' ')


% Generate Script-H polys n = 0
H0 = genH0(yHatVec);

% Generate Script-H polys n = 1..(N+1)
Hn = genH(yHatVec,nMax);

% Generate Script-H polys n=0 and n=1..(N+2) 
% evaluated at constant-y-argument. The "b" is prepended
% just to note the difference from the primitive model. 
% Here the difference is just that n = 1..(N+2) unlike in the 
% primitive where n = 1..(N+1).
[bHC0,bHC] = bGenHC(y0,b0,nMax);

% Get (balanced) dimensionless frequency nuHat = nu = NUmn
NUmn = bGetNu(mMax,nMax);

% Get (balanced) heating coefficient Q
Qmn = bGetQ(bHC0,bHC,Q0,a0,b0,y0,mMax,nMax);



% ^^^^^^^^^^^^^ Primitive Section ^^^^^^^^^^^^^^^^^^^^^ %
%
% Within here several Primitive model functions are called
% to generate the "Rossby component spectral space primitive
% model PV". 

% Generate Script-H polys n=0 and n=1..(N+2) 
% evaluated at constant-y-argument
[HC0,HC] = genHC(y0,b0,nMax);

% Generate dimensionless frequencies, nuHat = nu = NUmnr
NUmnr = genNu(mMax,nMax);

% Generate normalization constant Amnr
Amnr = getA(mMax,nMax,NUmnr);

% Get 3-D array of Qmnr.. heating expansion coefficient
Qmnr = getQ(Amnr,NUmnr,HC0,HC,Q0,a0,b0,y0,mMax,nMax);

% Get expansion coefficient Eta
Eta = getEta(NUmnr,Qmnr,alfa,c,mMax,nMax);

% ^^^^^^^^^^^^^ End Primitive Section ^^^^^^^^^^^^^^^^^^ %



% Get balanced PV from primitive-rossby-PV
qmn = prim2BalPV(Eta,Amnr,NUmnr,mMax,nMax);

% Calculate (balanced) spectral space streamfunction, psi
% (using primitive-rossby-PV --> balanced PV).
psimn = bSpectralPsi(qmn,mMax,nMax);

% clear unneeded primitive model variables
disp('Clearing unneeded primitive model variables.')
clear HC0 HC NUmnr Amnr Qmnr Eta
disp('Done clearing primitive variables.')
disp(' ')

% exit statement
disp('Finished balancedBasis.m script.')
disp(' ')

% END

