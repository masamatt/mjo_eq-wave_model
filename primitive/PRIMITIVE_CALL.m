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
disp('To ABORT run:  CTRL-C');disp(' ');
pause(10);
disp(' ');


% Compute variables needed for all 5 fields
disp('----------------------------------    ')
disp('    Computing basis quantities        ')
disp('----------------------------------    ')
primitiveBasis;
disp(' ')


% Compute u field
disp('----------------------------------    ')
disp('        Computing u field             ')
disp('----------------------------------    ')
uPrimitive;  % Calculate u dependent on wave type
disp(' ')



% Compute v field
disp('----------------------------------    ')
disp('        Computing v field             ')
disp('----------------------------------    ')
vPrimitive;  % Calculate v dependent on wave type
disp(' ')



% Compute phi field
disp('----------------------------------    ')
disp('       Computing phi field            ')
disp('----------------------------------    ')
phiPrimitive;  % Calculate phi dependent on wave type
disp(' ')



% Compute omegaM field
disp('----------------------------------    ')
disp('     Computing omegaM field           ')
disp('----------------------------------    ')
omegaMPrimitive;  % Calculate omegaM dependent on wave type
disp(' ')



% Compute q field
disp('----------------------------------    ')
disp('        Computing q field             ')
disp('----------------------------------    ')
qPrimitive;        % Calculate q dependent on wave type
disp(' ')



% write record to runParameters.txt file
writeStatus;
% Print all fields to a text file
%%%printResults;
% End primitive run
disp('                                          ')
disp('        =========================         ')
disp('        *  END PRIMITIVE MODEL  *         ')
disp('        =========================         ')

% END

