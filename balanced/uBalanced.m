% UBALANCED - Computes b_u(yHat,xi) for the balanced model.
%
% FILE:         uBalanced.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM - August 26 2006 - Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  uBalanced;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               BALANCED_CALL.m
%               balancedBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_b_u.mat and contains
%       the variable b_u = b_u(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('  uBalanced.m script         : [b_u(yHat,xi)] - b zonal wind')

% Get Rossby wave approximation to Eigenfunction U
Umn = bRossbyEigenU(H0,Hn,yHatVec,mMax,nMax);

% SE expansion (Streamfunction/Eigenfunction)
U_SE = bStreamEigen(psimn,Umn,yHatVec,mMax,nMax);

% Inverse fourier transform the SE expanded, balanced, rotational u
bUF = bIFourier(U_SE,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total balanced u field b_u(yHat,xi,z)
b_u = Z*bUF;

% save b_u field
disp('  Saving b_u(yHat,xi)        : [b_u] -> matFiles/field_b_u.mat')
save ./matFiles/field_b_u.mat b_u
clear Umn U_SE Z

% Finish statement
% disp('Finished uBalanced.m script.')
% disp(' ')

% END

