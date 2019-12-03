% BALANCED_CALL - Root script for the Balanced Model.
%                 This script calls scripts to do the 
%                 following: (1) define parameter variables
%                 and constants, (2) display the current
%                 parameter status, (3) compute intermediate
%                 variables needed in the computations for
%                 all 5 field variables, (4) compute each
%                 of the 5 field variables independently,
%                 (5) print the data to a text file.
%                      
% FILE:         BALANCED_CALL.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     August 27 2006 - MM - added writeStatus.
% CALL SYNTAX:  BALANCED_CALL;
%
% PRE:  The following script has been called:
%               MJO_MASTER.m
%
% POST: An output text file containing the data from the
%       current Balanced Model run will be written to
%       the "output" directory.
%

disp('                                          ')
disp('        =========================         ')
disp('        *    BALANCED MODEL     *         ')
disp('        =========================         ')
disp('                                          ')


% Balanced = 1 modelType
modelType = 1;

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
disp(' ');disp(' ');

% Compute variables needed for all 5 fields
disp('----------------------------------    ')
disp('    Computing basis quantities        ')
disp('----------------------------------    ')
balancedBasis;
disp(' ')


% Compute u field
disp('----------------------------------    ')
disp('      Computing b_u field             ')
disp('----------------------------------    ')
uBalanced;
disp('                                      ')



% Compute v field
disp('----------------------------------    ')
disp('      Computing b_v field             ')
disp('----------------------------------    ')
vBalanced;
disp('                                      ')



% Compute phi field
disp('----------------------------------    ')
disp('     Computing b_phi field            ')
disp('----------------------------------    ')
phiBalanced;
disp('                                      ')



% Compute omegaM field
disp('----------------------------------    ')
disp('    Computing b_omegaM field          ')
disp('----------------------------------    ')
omegaMBalanced;
disp('                                      ')


% Compute q field
disp('----------------------------------    ')
disp('      Computing b_q field             ')
disp('----------------------------------    ')
qBalanced;
disp('                                      ')



% % Print all balanced fields to a text file
% bPrintResults;
disp('                                          ')
disp('        =========================         ')
disp('        *   END BALANCED MODEL  *         ')
disp('        =========================         ')

% END

