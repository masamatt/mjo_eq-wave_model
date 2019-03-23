% VBALANCED - Computes b_v(yHat,xi) for the balanced model.
%
% FILE:         vBalanced.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM - August 26 2006 - Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  vBalanced;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               BALANCED_CALL.m
%               balancedBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_b_v.mat and contains
%       the variable b_v = b_v(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting vBalanced.m script...')
disp(' ')


% Get Rossby wave approximation to Eigenfunction V
Vmn = bRossbyEigenV(H0,Hn,yHatVec,mMax,nMax);

% SE expansion (Streamfunction/Eigenfunction)
V_SE = bStreamEigen(psimn,Vmn,yHatVec,mMax,nMax);

% Inverse fourier transform the SE expanded, balanced, rotational v
bVF = bIFourier(V_SE,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total balanced v field b_v(yHat,xi,z)
b_v = Z*bVF;

% save b_v field
disp('Saving b_v(yHat,xi) variable in file: ./matFiles/field_b_v.mat')
save ./matFiles/field_b_v.mat b_v
disp('Done saving.')
disp(' ')

% clear variables used to calculate b_v
disp('Clearing balanced v specific variables.')
clear Vmn V_SE bVF Z b_v
disp('Done clearing.')
disp(' ')


% Finish statement
disp('Finished vBalanced.m script.')
disp(' ')

% END

