% QPRIMITIVE - Computes q(yHat,xi) for the primitive model.
%
% FILE:         qPrimitive.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     MM - Aug 25 2006 - moved getStructureq to PRIMITIVE_CALL
%               and SUITE_CALL.
%               Writes to matFiles vs. output
%               MM - August 06 2008 - removed call to internal matlab
%                    'pack'.  In current versions of matlab, pack can
%                    only be called from the command line.
% CALL SYNTAX:  qPrimitive;
%
% PRE: The following scripts have been been called:
%               MJO_MASTER.m
%               PRIMITIVE_CALL.m
%               primitiveBasis.m
%
% POST: A matlab format output file is written to 
%       the directory "matFiles" found in the parent directory
%       "models". The file name is field_q.mat and contains
%       the variable q = q(yHat,xi). Also has the vertical
%       structure applied to it.
%

% Start statement
disp('  qPrimitive.m script        : [q(yHat,xi)]')

% Get expansion Structure function q_mnr(yHat)
qmnr = getStructureq(Amnr,NUmnr,H0,Hn,yHatVec,mMax,nMax);

% Determine which wave components are wanted in Normal Mode
% expansion. Then perform expansion.
if waves == 0
  % standard case, all components, waves = 0
  qN = normalMode(Eta,qmnr,yHatVec,mMax,nMax);
elseif waves == 1
  % rossby
  qN = rossbyNormalMode(Eta,qmnr,yHatVec,mMax,nMax);
elseif waves == 2
  % mixed
  qN = mixedNormalMode(Eta,qmnr,yHatVec,mMax,nMax);
elseif waves == 3
  % gravity
  qN = gravityNormalMode(Eta,qmnr,yHatVec,mMax,nMax);
else
  % kelvin (waves == 4)
  qN = kelvinNormalMode(Eta,qmnr,yHatVec,mMax,nMax);
end

% Inverse Fourier transform Normal Mode expanded q
qF = IFourier(qN,yHatVec,xiVec,mMax);

% Find vertical structure Z(z)
Z = structureZ(p);

% Get total q field q(yHat,xi,z)
q = Z*qF;

% Save q field
disp('  Saving q(yHat,xi)          : [q] -> matFiles/field_q.mat')
save ./matFiles/field_q.mat q

%%%clear qN qF Z q   %%% save: q
clear qmnr qN Z

% END

