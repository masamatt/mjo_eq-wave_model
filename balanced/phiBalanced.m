% PHIBALANCED - Computes b_phi(yHat,xi) for the balanced model.
%
% FILE:         phiBalanced.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM - August 26 2006 - Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  phiBalanced;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               BALANCED_CALL.m
%               balancedBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_b_phi.mat and contains
%       the variable b_phi = b_phi(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('  phiBalanced.m script       : [b_phi(yHat,xi)] - b geopotential')

% Get Rossby wave approximation to Eigenfunction PHI
PHImn = bRossbyEigenPHI(H0,Hn,yHatVec,mMax,nMax);

% SE expansion (Streamfunction/Eigenfunction)
PHI_SE = bStreamEigen(psimn,PHImn,yHatVec,mMax,nMax);

% Inverse fourier transform the SE expanded, balanced phi
bPhiF = bIFourier(PHI_SE,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total balanced phi field b_phi(yHat,xi,z)
b_phi = Z*bPhiF;

% % save b_phi field
% disp('  Saving b_phi(yHat,xi)      : [b_phi] -> matFiles/field_b_phi.mat')
% save ./matFiles/field_b_phi.mat b_phi
clear PHImn PHI_SE Z

% END

