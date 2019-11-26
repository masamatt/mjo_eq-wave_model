% VPRIMITIVE - Computes v(yHat,xi) for the primitive model.
%
% FILE:         vPrimitive.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM August 2006 - moved getEigenV() call to PRIMITIVE_CALL
%                  and SUITE_CALL.
%                  Writes to matFiles vs. output
%               MM August 06 2008 - removed call to internal matlab
%                  'pack'.  In current versions of matlab, pack can
%                  only be called from the command line.
% CALL SYNTAX:  vPrimitive;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               PRIMITIVE_CALL.m
%               primitiveBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_v.mat and contains
%       the variable v = v(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting vPrimitive.m script...')
disp(' ')


% Determine which wave components are wanted in Normal Mode
% expansion. Then perform expansion.
if waves == 0
  % standard case, all components, waves = 0
  VN = normalMode(Eta,Vmnr,yHatVec,mMax,nMax);
elseif waves == 1
  % rossby
  VN = rossbyNormalMode(Eta,Vmnr,yHatVec,mMax,nMax);
elseif waves == 2
  % mixed
  VN = mixedNormalMode(Eta,Vmnr,yHatVec,mMax,nMax);
elseif waves == 3
  % gravity
  VN = gravityNormalMode(Eta,Vmnr,yHatVec,mMax,nMax);
else
  % kelvin (waves == 4)
  VN = kelvinNormalMode(Eta,Vmnr,yHatVec,mMax,nMax);
end

% Inverse Fourier transform Normal Mode expanded v
VF = IFourier(VN,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total v field v(yHat,xi,z)
v = Z*VF;

% Save v field
disp('Saving v(yHat,xi) variable in file: ./matFiles/field_v.mat')
save ./matFiles/field_v.mat v
disp('Done saving.')
disp(' ')

% Clear variables used to calculate v
disp('Clearing v specific variables.')

%%%clear VN VF Z v    %%% save: v
clear VN Z

disp('Done clearing.')
disp(' ')



% Finish statement
disp('Finished vPrimitive.m script.')
disp(' ')

% END

