function HN = genH(yHatVec,N);
% GENH - "gen"erates a 2-D array of H values for n=1..(N+1), all yHat. 
%        (function). This function takes a vector of yHat values
%        yHatVec = [-yHatMax..yHatMax] and a maximum n value
%        N=nMax, and returns a 2-D array of H values at each 
%        n and yHat, where H are the "script-H" polynomials.
%        HN = HN(yIndex,nIndex).
%
% FILE: genH.m
% AUTHOR: Matt Masarik
% DATE: June 14, 2005
% MODIFIED:  (1) MM June 23 2005 - n index: N -> (N+1)
%
% CALL SYNTAX: HN = genH(yHatVec,N);
%              yHatVec = [-yHatMax..yHatMax], nondim. merid. coord. []
%              N = nMax, scalar []
% PRE: None
% POST: A 2-D array HN = HN(yIndex,nIndex) is returned if 
%       N >= 1. Otherwise a Error message is displayed and 
%       control is returned to the calling function.
%       nIndex = 1..(N+1).


% Entry statement
disp('  genH.m function            : [H_n(yHat)] - generate structure functions')

% Check if N < 1. If so, display error message and return 
% control to calling function.
if N < 1
  disp('Error: Cannot call getH() with N < 1.')
  return
end

% Find the size of yHatVec
ySize = length(yHatVec);

% Initialize solution array
HN = zeros(ySize,(N+1));

% Loop through all values of yHat in the yHatVec and call
% getH(yHat,N) with each. getH(yHat,N) returns a 1-D array
% of H values for that value of yHat, from n=1..(N+1). Store
% each returned 1-D array as a row in the 2-D HN array.
for yy=1:ySize
  HN(yy,:) = getH(yHatVec(yy),N);
end


% Exit statement
% disp('Exiting genH.m function.')
% disp(' ')

% END

