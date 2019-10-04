% OMEGAMPRIMITIVE - Computes omegaM(yHat,xi) for the primitive model.
%
% FILE:         omegaMPrimitive.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM August 21 2005 - wPrimitive.m -> omegaMPrimitive.m
%                  This script was changed from calculating log-pressure
%                  vertical velocity (w = Dz/Dt, units = 1/s) to computing
%                  a pressure vertical velocity at the pressure level of
%                  maximum vertical structure, pM. 
%                  omegaM has units of mb/day.
% 
%               MM August 25 2006 - moved getEigenPHI() and 
%                  getStructurew() to PRIMITIVE_CALL.m and SUITE_CALL.m.
%                  Writes to matFiles vs. output
%               MM August 06 2008 - removed call to internal matlab
%                  'pack'.  In current versions of matlab, pack can
%                  only be called from the command line.
%
% CALL SYNTAX:  omegaMPrimitive;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               PRIMITIVE_CALL.m
%               primitiveBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_omegaM.mat and contains
%       the variable omegaM = omegaM(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting omegaMPrimitive.m script...')
disp(' ')


% Determine which wave components are wanted in Normal Mode
% expansion. Then perform expansion.
if waves == 0
  % standard case, all components, waves = 0
  wN = normalMode(Eta,wmnr,yHatVec,mMax,nMax);
elseif waves == 1
  % rossby
  wN = rossbyNormalMode(Eta,wmnr,yHatVec,mMax,nMax);
elseif waves == 2
  % mixed
  wN = mixedNormalMode(Eta,wmnr,yHatVec,mMax,nMax);
elseif waves == 3
  % gravity
  wN = gravityNormalMode(Eta,wmnr,yHatVec,mMax,nMax);
else
  % kelvin (waves == 4)
  wN = kelvinNormalMode(Eta,wmnr,yHatVec,mMax,nMax);
end

% Inverse Fourier transform Normal Mode expanded w
wF = IFourier(wN,yHatVec,xiVec,mMax);

% Want to plot at vertical structure max: Z'(zM) = 1.
Zprime = 1;

% Get total w field w(yHat,xi,z)
w = Zprime*wF;

% Get vertical velocity in pressure units (mb/day), at the
% pressure level of maximum vertical structure magnitude, pM.
% omega = -p*w, so omegaM = -pM*w.
omegaM = -pM*86400*w;

% Save omegaM field
disp('Saving omegaM(yHat,xi) in file: ./matFiles/field_omegaM.mat')
save ./matFiles/field_omegaM.mat omegaM
disp('Done saving.')
disp(' ')

% Clear variables used to calculate omegaM
disp('Clearing w specific variables.')


%%%clear wN wF Zprime w omegaM     %%% save: omegaM
clear wN wF Zprime w


disp('Done clearing.')
disp(' ')



% Finish statement
disp('Finished omegaMPrimitive.m script.')
disp(' ')

% END

