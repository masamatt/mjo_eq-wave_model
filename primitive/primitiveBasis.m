% PRIMITIVEBASIS - Calls scripts/functions necessary for all fields.
%                  This script makes calls to the functions that
%                  return variables needed to calculate all 5 fields of
%                  interest for the primitive model. After it is called,
%                  specific scripts to generate each field can then be
%                  called.
%
% FILE:         primitiveBasis.m
% AUTHOR:       Matt Masarik
% DATE:         August 12 2005
% MODIFIED:     N/A
% CALL SYNTAX:  primitiveBasis;
%
% PRE:  The following scripts have been called:
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
%       "primitive", which must be located in the parent
%       directory "models":
%
%               genHC.m
%               getNu.m
%               genNu.m
%               getA.m
%               getQ.m
%               getEta.m
%               
% POST: Scripts to calculate the 5 specific primitive fields
%       of interest can be called. The following variables
%       will exist:
%
%       H0 = Script-H polys at n = 0
%       Hn = Script-H polys at n = 1..(N+1)
%       HC0 = Script-H poly at n = 0, constant-y-argument
%       HC = Script-H polys at n = 1..(N+2), constant-y-argument 
%       NUmnr = dimensonless frequency array, n = -1..(N+1)
%       Amnr = normalization constant array, n = -1..(N+1)
%       Qmnr = heating expansion coefficient array, n = -1..(N+1)
%       Eta = Eta solution vector expansion coefficient array, 
%             n = -1..(N+1)
%

% entry statement
disp('primitiveBasis.m script')

% Generate Script-H polys n = 0
H0 = genH0(yHatVec);

% Generate Script-H polys n = 1..(N+1)
Hn = genH(yHatVec,nMax);

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


% exit statement
% disp('Finished primitiveBasis.m script.')
%disp(' ')

% END

