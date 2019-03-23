% PHIPRIMITIVE - Computes phi(yHat,xi) for the primitive model.
%
% FILE:         phiPrimitive.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM - August 25 2006 - moved getEigenPHI to PRIMITIVE_CALL
%               and SUITE_CALL.
%               Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  phiPrimitive;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               PRIMITIVE_CALL.m
%               primitiveBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_phi.mat and contains
%       the variable phi = phi(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting phiPrimitive.m script...')
disp(' ')


% Determine which wave components are wanted in Normal Mode
% expansion. Then perform expansion.
if waves == 0
  % standard case, all components, waves = 0
  PHIN = normalMode(Eta,PHImnr,yHatVec,mMax,nMax);
elseif waves == 1
  % rossby
  PHIN = rossbyNormalMode(Eta,PHImnr,yHatVec,mMax,nMax);
elseif waves == 2
  % mixed
  PHIN = mixedNormalMode(Eta,PHImnr,yHatVec,mMax,nMax);
elseif waves == 3
  % gravity
  PHIN = gravityNormalMode(Eta,PHImnr,yHatVec,mMax,nMax);
else
  % kelvin (waves == 4)
  PHIN = kelvinNormalMode(Eta,PHImnr,yHatVec,mMax,nMax);
end

% Inverse Fourier transform Normal Mode expanded phi
PHIF = IFourier(PHIN,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total phi field phi(yHat,xi,z)
phi = Z*PHIF;

% Save phi field
disp('Saving phi(yHat,xi) variable in file: ./matFiles/field_phi.mat')
save ./matFiles/field_phi.mat phi
disp('Done saving.')
disp(' ')

% Clear variables used to calculate phi
disp('Clearing phi specific variables.')
clear PHIN PHIF Z phi
disp('Done clearing.')
disp(' ')



% Finish statement
disp('Finished phiPrimitive.m script.')
disp(' ')

% END

