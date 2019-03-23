% SUITE_CALL - Root script for the total model suite. 
%              i.e. - Both the primitive and balanced models are
%              run. All wave components for the primitive model are
%              computed unless the forcing is symmetric about the
%              equator (y0 = 0), in which case the mixed-rossby
%              gravity wave component is identically zero so it
%              is not run.
%              This script calls scripts to do the 
%              following: (1) define parameter variables
%              and constants, (2) display the current
%              parameter status, (3) compute intermediate
%              variables needed in the computations for
%              all 5 field variables, (4) compute each
%              of the 5 field variables independently,
%              (5) print the data to a text file.
%              
%                      
% FILE:         SUITE_CALL.m
% AUTHOR:       Matt Masarik
% DATE:         August 25 2006
% MODIFIED:     N/A
% CALL SYNTAX:  SUITE_CALL;
%
% PRE:  The following script has been called:
%               MJO_MASTER.m
%
% POST: Output text files containing the data from 
%       both Primitive Model runs and the Balanced Model run
%       will be written to the "output" directory.
%


% start Model Suite
disp('                                          ')
disp('                                          ')
disp('        =========================         ')
disp('        *       MODEL SUITE     *         ')
disp('        =========================         ')
disp('                                          ')
disp('                                          ')


% Primitive Model
% ===============

% Call CONSTANT_DEFINITIONS.m, VARIABLE_DEFINITIONS.m.
% ---> define global variables and then access
% value for y0 to determine if the Primitive model will be run
% for the mixed-rossby gravity wave response.  If y0 = 0, it
% is not run.
CONSTANT_DEFINITIONS;
VARIABLE_DEFINITIONS;

% define vector of wave ID's based on value of y0.
if y0 == 0;
  % no mixed-rossby gravity wave
  waveVec = [0,1,3,4];
  wSize = length(waveVec);
  disp('NOTE: y0 = 0, Mixed-Rossby Gravity wave is not computed.')
  disp(' ')
else
  % include mixed-rossby gravity wave
  waveVec = [0,1,2,3,4];
  wSize = length(waveVec);
end

% Compute variables for all 5 fields, for all wave types
primitiveBasis;

% Compute structure arrays for all waves
% --------------------------------------

% Get Eigenfunction U
Umnr = getEigenU(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
% Save U
disp('Saving Umnr(yHat) variable in file: ./matFiles/Umnr_out.mat')
save ./matFiles/Umnr_out.mat Umnr
disp('Done saving.')
disp('Clear Umnr(yHat).')
clear Umnr
disp('Done clearing.')
disp(' ')

% Get Eigenfunction V
Vmnr = getEigenV(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
% Save V
disp('Saving Vmnr(yHat) variable in file: ./matFiles/Vmnr_out.mat')
save ./matFiles/Vmnr_out.mat Vmnr
disp('Done saving.')
disp('Clear Vmnr(yHat).')
clear Vmnr
disp('Done clearing.')
disp(' ')

% Get Eigenfunction PHI
PHImnr = getEigenPHI(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Get expansion Structure function w_mnr(yHat)
wmnr = getStructurew(NUmnr,PHImnr,yHatVec,mMax,nMax);
% Save PHI
disp('Saving PHImnr(yHat) variable in file: ./matFiles/PHImnr_out.mat')
save ./matFiles/PHImnr_out.mat PHImnr
disp('Done saving.')
disp('Clear PHImnr(yHat).')
clear PHImnr
disp('Done clearing.')
disp(' ')
% Save w
disp('Saving wmnr(yHat) variable in file: ./matFiles/wmnr_out.mat')
save ./matFiles/wmnr_out.mat wmnr
disp('Done saving.')
disp('Clear wmnr(yHat).')
clear wmnr
disp('Done clearing.')
disp(' ')

% Get expansion Structure function q_mnr(yHat)
qmnr = getStructureq(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);
% Save q
disp('Saving qmnr(yHat) variable in file: ./matFiles/qmnr_out.mat')
save ./matFiles/qmnr_out.mat qmnr
disp('Done saving.')
disp('Clear qmnr(yHat).')
clear qmnr
disp('Done clearing.')
disp(' ')


% Run primitive model for total and all wave components
for wIndex=1:wSize
  waves = waveVec(wIndex);
  PRIMITIVE_CALL;
end

% delete unneeded primitive "out" .mat files
delete('./matFiles/*out.mat');



% Balanced Model
% ==============

% clear all Primitive variables
clear

% Run balanced model
BALANCED_CALL;



% End Model Suite
disp('                                          ')
disp('                                          ')
disp('        =========================         ')
disp('        *     END MODEL SUITE   *         ')
disp('        =========================         ')
disp('                                          ')
disp('                                          ')

% END

