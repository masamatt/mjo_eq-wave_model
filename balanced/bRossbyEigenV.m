function V = bRossbyEigenV(H0,H,yHatVec,M,N);
% BROSSBYEIGENV - Calculates the Rossby Wave approximation to
%                 the Eigenfunction V in the primitive model.
%                 bRossbyEigenV = "b"alanced model "Rossby" wave
%                                 approximation to "Eigen"function
%                                 "V"
%                 V = V_mn(yHat) = V(yHatIndex,mIndex,nIndex)
%                 The function name includes "Rossby" instead
%                 of just "bEigenV" to reflect the fact that 
%                 this function V was not found from an 
%                 Eigenrelation, but rather can be seen to be a 
%                 low frequency approximation to the eigenfunction V
%                 that was found in the primitive model. 
% 
% FILE:        bRossbyEigenV.m
% AUTHOR:      Matt Masarik
% DATE:        August 9 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: V = bRossbyEigenV(H0,H,yHatVec,M,N);
%                  V = V(yHatIndex,mIndex,nIndex), complex 3-D array
%                  H0 = H0(yHatIndex) script-H polys, n = 0
%                  H = H(yHatIndex,nIndex) script-H polys, n = 1..(N+1)
%                  yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        V(yHatIndex,mIndex,nIndex) has been returned.
%              
%    

% entry statement
disp('Entering bRossbyEigenV.m function...');

% local variables
ySize = length(yHatVec);
mSize = 2*M + 1;
nSize = N + 1;

% initialize index arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [0:1:N];             % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N
                            
% declare complex solution array
tmpArray = zeros(ySize,mSize,nSize);
V = complex(tmpArray,tmpArray);


%                  Compute V
% -----------------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    for jn = 1:nSize    % n loop
      
      % n = 0
      % -----
      if nVec(jn) == 0
        %%% (EQ 2) %%%
        V(yy,im,jn) = i*mVec(im)*H0(yy);
        
      % n != 0
      % ------
      else
        %%% (EQ 1) %%%
        V(yy,im,jn) = i*mVec(im)*H(yy,nVec(jn));
      end
      
    end    % end n loop
  end    % end m loop
end    % end yHat loop



% exit statement
disp('Exiting bRossbyEigenV.m function.')
disp(' ')

% END

