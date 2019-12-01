function PHI = bRossbyEigenPHI(H0,H,yHatVec,M,N)
% BROSSBYEIGENPHI - Calculates the Rossby Wave approximation to
%                   the Eigenfunction PHI in the primitive model.
%                   bRossbyEigenPHI = "b"alanced model "Rossby" wave
%                                     approximation to "Eigen"function
%                                     "PHI"
%                   PHI = PHI_mn(yHat) = PHI(yHatIndex,mIndex,nIndex)
%                   The function name includes "Rossby" instead
%                   of just "bEigenPHI" to reflect the fact that 
%                   this function PHI was not found from an 
%                   Eigenrelation, but rather can be seen to be a 
%                   low frequency approximation to the eigenfunction PHI
%                   that was found in the primitive model. 
% 
% FILE:        bRossbyEigenPHI.m
% AUTHOR:      Matt Masarik
% DATE:        August 9 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: PHI = bRossbyEigenPHI(H0,H,yHatVec,M,N);
%                    PHI = PHI(yHatIndex,mIndex,nIndex)
%                    H0 = H0(yHatIndex) script-H polys, n = 0
%                    H = H(yHatIndex,nIndex) script-H polys, n = 1..(N+1)
%                    yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                    M = mMax, maximum zonal wavenumber
%                    N = nMax, maximum meridional Mode
%
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        PHI(yHatIndex,mIndex,nIndex) has been returned.
%              
%    

% entry statement
disp('    bRossbyEigenPHI.m func   : [PHI(yHat,xi)mn] - rossby approx. eigen PHI');

% global declaration
global ep cBar

% local variables
ySize = length(yHatVec);
mSize = 2*M + 1;
nSize = N + 1;

% initialize index arrays
nVec = [0:1:N];             % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N

% declare solution array
PHI = zeros(ySize,mSize,nSize);


%                  Compute PHI
% -----------------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    for jn = 1:nSize    % n loop
      
      % n = 0
      % -----
      if nVec(jn) == 0
        %%% (EQ 3) %%%
        PHI(yy,im,jn) = cBar*ep^(1/4)*2^(-1/2)*H(yy,1);
        
      % n = 1
      % -----
      elseif nVec(jn) == 1
        %%% (EQ 2) %%%
        PHI(yy,im,jn) = cBar*ep^(1/4)*(H(yy,2) + 2^(-1/2)*H0(yy));
        
      % n = 2,3,..
      % ----------
      else
        %%% (EQ 1) %%%
        T1 = ((nVec(jn)+1)/2)^(1/2)*H(yy,(nVec(jn)+1));
        T2 = (nVec(jn)/2)^(1/2)*H(yy,(nVec(jn)-1));
        PHI(yy,im,jn) = cBar*ep^(1/4)*(T1 + T2);
      end
      
    end    % end n loop
  end    % end m loop
end    % end yHat loop



% exit statement
% disp('Exiting bRossbyEigenPHI.m function.')
% disp(' ')

% END

