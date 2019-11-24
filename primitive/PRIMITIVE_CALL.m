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


% start primitive run
disp('                                          ')
disp('                                          ')
disp('        =========================         ')
disp('        *    PRIMITIVE MODEL    *         ')
disp('        =========================         ')
disp('                                          ')
disp('                                          ')


% Primitive = 0 modelType
modelType = 0;

% Call the following if the model suite is NOT being run.
% Otherwise these are called in SUITE_CALL.m.
if modelSuite == 1
  % Call CONSTANT_DEFINITIONS.m, initialize global constants.
  CONSTANT_DEFINITIONS;

  % Call VARIABLE_DEFINITIONS.m, initialize variables.
  VARIABLE_DEFINITIONS;

  % Call STATUS.m, wait for 10 seconds
  STATUS;
  disp('Sleeping for 10 seconds...');
  pause(1);
  disp('To ABORT run:  CTRL-C');
  pause(10);
  
  % Compute variables needed for all 5 fields
  primitiveBasis;
end

% write record to runParameters.txt file
writeStatus;


% Compute u field
disp('                                          ')
disp('                                          ')
disp('    ----------------------------------    ')
disp('            Computing u field             ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% If the model suite is not being run, generate eigenStructure.
% If it is, simply load it as it has already been computed.
if modelSuite == 1
  % Get Eigenfunction U
  Umnr = getEigenU(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
else
  % load Umnr(yHat)
  disp('Loading Umnr...')
  load ./matFiles/Umnr_out.mat
  disp('Finished loading Umnr field.')
  disp(' ')
end

% Calculate u dependent on wave type
uPrimitive;

% clear Umnr
clear Umnr

disp('    ----------------------------------    ')
disp('          End computing u field           ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% Compute v field
disp('                                          ')
disp('                                          ')
disp('    ----------------------------------    ')
disp('            Computing v field             ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% If the model suite is not being run, generate eigenStructure.
% If it is, simply load it as it has already been computed.
if modelSuite == 1
  % Get Eigenfunction V
  Vmnr = getEigenV(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
else
  % load Vmnr(yHat)
  disp('Loading Vmnr...')
  load ./matFiles/Vmnr_out.mat
  disp('Finished loading Vmnr field.')
  disp(' ')
end

% Calculate v dependent on wave type
vPrimitive;

% clear Vmnr
clear Vmnr

disp('    ----------------------------------    ')
disp('          End computing v field           ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% Compute phi field
disp('                                          ')
disp('                                          ')
disp('    ----------------------------------    ')
disp('           Computing phi field            ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% If the model suite is not being run, generate eigenStructure.
% If it is, simply load it as it has already been computed.
if modelSuite == 1
  % Get Eigenfunction PHI
  PHImnr = getEigenPHI(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
else
  % load PHImnr(yHat)
  disp('Loading PHImnr...')
  load ./matFiles/PHImnr_out.mat
  disp('Finished loading PHImnr field.')
  disp(' ')
end

% Calculate phi dependent on wave type
phiPrimitive;

% DO NOT clear PHImnr, needed for omegaM calculation

disp('    ----------------------------------    ')
disp('         End computing phi field          ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% Compute omegaM field
disp('                                          ')
disp('                                          ')
disp('    ----------------------------------    ')
disp('         Computing omegaM field           ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% If the model suite is not being run, generate eigenStructure.
% If it is, simply load it as it has already been computed.
if modelSuite == 1
  % Eigenfunction PHI ( PHImnr ) still avialble from above
  % Get expansion Structure function w_mnr(yHat)
  wmnr = getStructurew(NUmnr,PHImnr,yHatVec,mMax,nMax);
  % clear PHImnr
  clear PHImnr
else
  % clear PHImnr
  clear PHImnr
  % load wmnr(yHat)
  disp('Loading wmnr...')
  load ./matFiles/wmnr_out.mat
  disp('Finished loading wmnr field.')
  disp(' ')
end

% Calculate omegaM dependent on wave type
omegaMPrimitive;

% clear wmnr
clear wmnr

disp('    ----------------------------------    ')
disp('        End computing omegaM field        ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% Compute q field
disp('                                          ')
disp('                                          ')
disp('    ----------------------------------    ')
disp('            Computing q field             ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% If the model suite is not being run, generate eigenStructure.
% If it is, simply load it as it has already been computed.
if modelSuite == 1
  % Get expansion Structure function q_mnr(yHat)
  qmnr = getStructureq(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
else
  % load qmnr(yHat)
  disp('Loading qmnr...')
  load ./matFiles/qmnr_out.mat
  disp('Finished loading qmnr field.')
  disp(' ')  
end

% Calculate q dependent on wave type
qPrimitive;

% clear qmnr
clear qmnr

disp('    ----------------------------------    ')
disp('          End computing q field           ')
disp('    ----------------------------------    ')
disp('                                          ')
disp('                                          ')

% Print all fields to a text file
%%%printResults;

% End primitive run
disp('                                          ')
disp('                                          ')
disp('        =========================         ')
disp('        *  END PRIMITIVE MODEL  *         ')
disp('        =========================         ')
disp('                                          ')
disp('                                          ')

% END

