function U = bRossbyEigenU(H0,H,yHatVec,M,N)
% BROSSBYEIGENU - Calculates the Rossby Wave approximation to
%                 the Eigenfunction U in the primitive model.
%                 bRossbyEigenU = "b"alanced model "Rossby" wave
%                                 approximation to "Eigen"function
%                                 "U"
%                 U = U_mn(yHat) = U(yHatIndex,mIndex,nIndex)
%                 The function name includes "Rossby" instead
%                 of just "bEigenU" to reflect the fact that 
%                 this function U was not found from an 
%                 Eigenrelation, but rather can be seen to be a 
%                 low frequency approximation to the eigenfunction U
%                 that was found in the primitive model. 
% 
% FILE:        bRossbyEigenU.m
% AUTHOR:      Matt Masarik
% DATE:        August 9 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: U = bRossbyEigenU(H0,H,yHatVec,M,N);
%                  U = U(yHatIndex,mIndex,nIndex)
%                  H0 = H0(yHatIndex) script-H polys, n = 0
%                  H = H(yHatIndex,nIndex) script-H polys, n = 1..(N+1)
%                  yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        U(yHatIndex,mIndex,nIndex) has been returned.
%              
%    

% entry statement
disp('    bRossbyEigenU.m function : [U(yHat)mn] - rossby approx. eigen U');

% global declaration
global ep

% local variables
ySize = length(yHatVec);
mSize = 2*M + 1;
nSize = N + 1;

% initialize index arrays
nVec = [0:1:N];             % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N

% declare solution array
U = zeros(ySize,mSize,nSize);


%                  Compute U
% -----------------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    for jn = 1:nSize    % n loop
      
      % n = 0
      % -----
      if nVec(jn) == 0
        %%% (EQ 2) %%%
        U(yy,im,jn) = ep^(1/4)*2^(-1/2)*H(yy,1);
        
      % n = 1
      % -----
      elseif nVec(jn) == 1
        %%% (EQ 3) %%%
        U(yy,im,jn) = ep^(1/4)*(H(yy,2) - 2^(-1/2)*H0(yy));
        
      % n = 2,3,..
      % ----------
      else
        %%% (EQ 1) %%%
        T1 = ((nVec(jn)+1)/2)^(1/2)*H(yy,(nVec(jn)+1));
        T2 = (nVec(jn)/2)^(1/2)*H(yy,(nVec(jn)-1));
        U(yy,im,jn) = ep^(1/4)*(T1 - T2);
      end
      
    end    % end n loop
  end    % end m loop
end    % end yHat loop



% exit statement
% disp('Exiting bRossbyEigenU.m function.')
% disp(' ')

% END

