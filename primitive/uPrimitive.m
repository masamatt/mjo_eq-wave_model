% UPRIMITIVE - Computes u(yHat,xi) for the primitive model.
%
% FILE:         uPrimitive.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM - August 25 2006 - moved getEigenU() to PRIMITIVE_CALL
%                    and SUITE_CALL.
%                    Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  uPrimitive;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               PRIMITIVE_CALL.m 
%               primitiveBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_u.mat and contains
%       the variable u = u(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('Starting uPrimitive.m script...')
disp(' ')

% Determine which wave components are wanted in Normal Mode
% expansion. Then perform expansion.
if waves == 0
  % standard case, all components, waves = 0
  UN = normalMode(Eta,Umnr,yHatVec,mMax,nMax);
elseif waves == 1
  % rossby
  UN = rossbyNormalMode(Eta,Umnr,yHatVec,mMax,nMax);
elseif waves == 2
  % mixed
  UN = mixedNormalMode(Eta,Umnr,yHatVec,mMax,nMax);
elseif waves == 3
  % gravity
  UN = gravityNormalMode(Eta,Umnr,yHatVec,mMax,nMax);
else
  % kelvin (waves == 4)
  UN = kelvinNormalMode(Eta,Umnr,yHatVec,mMax,nMax);
end

% Inverse Fourier transform Normal Mode expanded u
UF = IFourier(UN,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total u field u(yHat,xi,z)
u = Z*UF;

% Save u field
disp('Saving u(yHat,xi) variable in file: ./matFiles/field_u.mat')
save ./matFiles/field_u.mat u
disp('Done saving.')
disp(' ')

% Clear variables used to calculate u
disp('Clearing u specific variables.')
clear UN UF Z u
disp('Done clearing.')
disp(' ')



% Finish statement
disp('Finished uPrimitive.m script.')
disp(' ')

% END

