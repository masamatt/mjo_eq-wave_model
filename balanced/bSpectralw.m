function w = bSpectralw(stream,Q,alfa,c,M,N)
% BSPECTRALW - bSpectralw = "b"alanced model "Spectral" "w".
%              Calculates and returns a 2-D array of spectral space
%              log-pressure vertical velocity, w = w_mn = w(mIndex,nIndex).
%              w is a complex array, and n = 0..N.
% 
% FILE:        bSpectralw.m
% AUTHOR:      Matt Masarik
% DATE:        August 10 2005
% MODIFIED:    MM August 25 2005 - R -> Rd  
%                                  The gas constant for dry air
%                                  was changed from R to Rd. 
%                                  This was a bug in the primitive
%                                  model... R was also being used
%                                  as the number of roots.
%                                  
%
% CALL SYNTAX: w = bSpectralw(stream,Q,alfa,c,M,N);
%                  w = w(mIndex,nIndex), n=0..N, spectral space w
%                  stream = stream(mIndex,nIndex), n=0..(N+1) spectral psi
%                  Q = Q(mIndex,nIndex), n=0..(N+2), spectral space heat
%                  alfa = "alpha" (scalar), friction/cooling
%                  c = (scalar), propagation speed of cloud cluster
%                  M = max m value. m = -M..M, maximum zonal wavenumber
%                  N = max n value. n = 0..N, maximum meridional mode
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        w(mIndex,nIndex) has been returned.
% 
% NOTE: This is another place where care must be taken in 
%       indexing.. In the calculations below, stream_m,(n+1) and 
%       stream_m,(n-1) are both accessed. The only previous calculations
%       that accessed a variable with (n+1) or (n-1) were the
%       script-H polynomials. "In a coding sense" these are
%       indexed differently in n than the other arrays, namely:
%       For the script-H polynomials the actual value of n is
%       used as the index, and the n = 0 case is a different array
%       specifically for that case. The other quantity arrays
%       such as NU, Q, and stream; use the nIndex, which is the index
%       that corresponds to a specific n value in the array of
%       n values, nVec(). An example below illustrates the proper
%       access for the different types of arrays. 
%
%       Ex.
%       nVec(nIndex) = n
%       H_(n+1)[yHat] = H(yIndex,(nVec(nIndex) + 1))
%       stream_m,(n+1) = stream(mIndex,(nIndex + 1))
%


% entry statement
disp('  bSpectralw.m function      : [w_mn] - b spectral vertical velocity')

% global declarations
global cp Gmma Omega Rd ep a

% local variables
mSize = 2*M + 1;             % m dimension
nSize = N + 1;               % n dimension

% initialize index arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [0:1:N];             % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N

% define common constant terms, T1 and T2
T1 = 1/(cp*Gmma);
T2 = (2*Omega)/(Rd*Gmma*ep^(1/4));

% declare complex solution array
tmpArray = zeros(mSize,nSize);
w = complex(tmpArray,tmpArray);


%                  Compute w
% ----------------------------------------------
for im = 1:mSize    % m loop
  for jn = 1:nSize    % n loop
    
    % n = 0
    % -----
    if nVec(jn) == 0
      %%% (EQ 1) %%%
      L1 = T1*Q(im,jn);     % L1 = "L"oop variable "1"
      L2 = T2*(alfa - (1i*mVec(im)*c)/a);
      L3 = 2^(-1/2)*stream(im,(jn+1));
      w(im,jn) = L1 - L2*L3;
    
    % n != 0
    % ------
    else
      %%% (EQ 2) %%%
      L1 = T1*Q(im,jn);
      L2 = T2*(alfa - (1i*mVec(im)*c)/a);
      L3 = ((nVec(jn)+1)/2)^(1/2)*stream(im,(jn+1));
      L4 = (nVec(jn)/2)^(1/2)*stream(im,(jn-1));
      w(im,jn) = L1 - L2*(L3 + L4);
    end
    
  end    % end n loop
end    % end m loop

% END

