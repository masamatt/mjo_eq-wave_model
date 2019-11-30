% PRIMITIVE_CALL - Root script for the Primitive Model.
%                  This script calls scripts to do the 
%                  following: (1) define parameter variables
%                  and constants, (2) display the current
%                  parameter status, (3) compute intermediate
%                  variables needed in the computations for
%                  all 5 field variables, (4) compute each
%                  of the 5 field variables independently,
%                  (5) print the data to a text file.
%                      
% FILE:         PRIMITIVE_CALL.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM August 21 2005 - calls omegaMPrimitive.m 
%                                   instead of wPrimitive.m
%               MM August 25 2006 - call non-wave-type-dependent
%                                   functions outside of 
%                                   "x"Primitive.m calls.
%               MM August 27 2006 - added writeStatus
%
% CALL SYNTAX:  PRIMITIVE_CALL;
%
% PRE:  The following script has been called:
%               MJO_MASTER.m
%
% POST: An output text file containing the data from the
%       current Primitive Model run will be written to
%       the "output" directory.
%

disp('                                          ')
disp('        =========================         ')
disp('        *    PRIMITIVE MODEL    *         ')
disp('        =========================         ')
disp('                                          ')

% Primitive = 0 modelType
modelType = 0;

% Call CONSTANT_DEFINITIONS.m, initialize global constants.
CONSTANT_DEFINITIONS;

% Call VARIABLE_DEFINITIONS.m, initialize variables.
VARIABLE_DEFINITIONS;

% Call STATUS.m, wait for 10 seconds
STATUS;
disp('Sleeping for 10 seconds...');
pause(1);
disp('To ABORT run:  CTRL-C');
disp('');
pause(10);
disp('');disp('');

% Compute variables needed for all 5 fields
primitiveBasis;

% write record to runParameters.txt file
writeStatus;



% Compute u field
disp('----------------------------------    ')
disp('        Computing u field             ')
disp('----------------------------------    ')
% Get Eigenfunction U
Umnr = getEigenU(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Calculate u dependent on wave type
uPrimitive;

% clear Umnr
clear Umnr
disp('----------------------------------    ')
disp('      End computing u field           ')
disp('----------------------------------    ')
disp('                                      ')



% Compute v field
disp('----------------------------------    ')
disp('        Computing v field             ')
disp('----------------------------------    ')
% Get Eigenfunction V
Vmnr = getEigenV(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Calculate v dependent on wave type
vPrimitive;

% clear Vmnr
clear Vmnr
disp('----------------------------------    ')
disp('      End computing v field           ')
disp('----------------------------------    ')
disp('                                      ')




% Compute phi field
disp('----------------------------------    ')
disp('       Computing phi field            ')
disp('----------------------------------    ')
% Get Eigenfunction PHI
PHImnr = getEigenPHI(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Calculate phi dependent on wave type
phiPrimitive;

% DO NOT clear PHImnr, needed for omegaM calculation
disp('----------------------------------    ')
disp('     End computing phi field          ')
disp('----------------------------------    ')
disp('                                      ')




% Compute omegaM field
disp('----------------------------------    ')
disp('     Computing omegaM field           ')
disp('----------------------------------    ')
% Eigenfunction PHI ( PHImnr ) still avialble from above
% Get expansion Structure function w_mnr(yHat)
wmnr = getStructurew(NUmnr,PHImnr,yHatVec,mMax,nMax);
% clear PHImnr
clear PHImnr

% Calculate omegaM dependent on wave type
omegaMPrimitive;

% clear wmnr
clear wmnr
disp('----------------------------------    ')
disp('    End computing omegaM field        ')
disp('----------------------------------    ')
disp('                                      ')



% Compute q field
disp('----------------------------------    ')
disp('        Computing q field             ')
disp('----------------------------------    ')
% Get expansion Structure function q_mnr(yHat)
qmnr = getStructureq(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Calculate q dependent on wave type
qPrimitive;

% clear qmnr
clear qmnr
disp('----------------------------------    ')
disp('      End computing q field           ')
disp('----------------------------------    ')
disp('                                      ')



% Print all fields to a text file
%%%printResults;

% End primitive run
disp('                                          ')
disp('        =========================         ')
disp('        *  END PRIMITIVE MODEL  *         ')
disp('        =========================         ')
disp('                                          ')

% END

