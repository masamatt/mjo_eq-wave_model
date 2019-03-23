% QBALANCED - Computes b_q(yHat,xi) for the balanced model.
%
% FILE:         qBalanced.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM - August 26 2006 - Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  qBalanced;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               BALANCED_CALL.m
%               balancedBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_b_q.mat and contains
%       the variable b_q = b_q(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting qBalanced.m script...')
disp(' ')

% Hermite expand q
qH = bHermite(qmn,H0,Hn,yHatVec,mMax,nMax);

% Inverse fourier transform the Hermite expanded, balanced q
bqF = bIFourier(qH,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total balanced q field b_q(yHat,xi,z)
b_q = Z*bqF;

% save b_q field
disp('Saving b_q(yHat,xi) variable in file: ./matFiles/field_b_q.mat')
save ./matFiles/field_b_q.mat b_q
disp('Done saving.')
disp(' ')

% clear variables used to calculate b_q
disp('Clearing balanced q specific variables.')
clear qH bqF Z b_q
disp('Done clearing.')
disp(' ')


% Finish statement
disp('Finished qBalanced.m script.')
disp(' ')

% END

