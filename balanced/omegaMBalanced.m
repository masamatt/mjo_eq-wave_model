% OMEGAMBALANCED - Computes b_omegaM(yHat,xi) for the balanced model.
%
% FILE:         omegaMBalanced.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     MM August 22 2005 - wBalanced.m -> omegaMBalanced.m
%               This script was changed from calculating log-pressure
%               vertical velocity (w = Dz/Dt, units = 1/s) to computing
%               a pressure vertical velocity at the pressure level of
%               maximum vertical structure, pM.
%               omegaM has units of mb/day.
%               MM - August 26 2006 - Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
%
% CALL SYNTAX:  omegaMBalanced;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               BALANCED_CALL.m
%               balancedBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_b_omegaM.mat and contains
%       the variable b_omegaM = b_omegaM(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting omegaMBalanced.m script...')
disp(' ')

% Get spectral space log-pressure vertical velocity
wmn = bSpectralw(psimn,Qmn,alfa,c,mMax,nMax);

% Hermite expand w
wH = bHermite(wmn,H0,Hn,yHatVec,mMax,nMax);

% Inverse fourier transform the Hermite expanded, balanced w
bwF = bIFourier(wH,yHatVec,xiVec,mMax);

% Want to plot at vertical structure max: Z'(zM) = 1.
Zprime = 1;

% Get total balanced w field b_w(yHat,xi,z)
b_w = Zprime*bwF;

% Get vertical velocity in pressure units (mb/day), at the
% pressure level of maximum vertical structure magnitude, pM.
% b_omega = -p*b_w, so b_omegaM = -pM*b_w.
b_omegaM = -pM*86400*b_w;

% save b_omegaM field
disp('Saving b_omegaM(yHat,xi) in file: ./matFiles/field_b_omegaM.mat')
save ./matFiles/field_b_omegaM.mat b_omegaM
disp('Done saving.')
disp(' ')

% clear variables used to calculate b_omegaM
disp('Clearing balanced omegaM specific variables.')
clear wmn wH bwF Zprime b_w b_omegaM
disp('Done clearing.')
disp(' ')


% Finish statement
disp('Finished omegaMBalanced.m script.')
disp(' ')

% END

