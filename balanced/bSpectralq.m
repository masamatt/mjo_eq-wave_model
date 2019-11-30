function q = bSpectralq(NU,Q,alfa,c,M,N)
% BSPECTRALQ - bSpectralq = "b"alanced model "Spectral" "q".
%              Calculates and returns a 2-D array of spectral space
%              potential vorticity, q = q_mn = q(mIndex,nIndex).
%              q is a complex array, and n = 0..(N+1).
% 
% FILE:        bSpectralq.m
% AUTHOR:      Matt Masarik
% DATE:        July 20 2005
% MODIFIED:    (1) MM August 8 2005 - n = 0..N -> n = 0..(N+1)
%
% CALL SYNTAX: q = bSpectralq(NU,Q,alfa,c,M,N);
%                  q = q(mIndex,nIndex), n=0..(N+1), spectral space PV
%                  NU = NU(mIndex,nIndex), n=0..(N+1), dim-less app. freq.
%                  Q = Q(mIndex,nIndex), n=0..(N+2), spectral space heat
%                  alfa = "alpha" (scalar), friction/cooling
%                  c = (scalar), propagation speed of cloud cluster
%                  M = max m value. m = -M..M, maximum zonal wavenumber
%                  N = max n value. n = 0..N, maximum meridional mode
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        q(mIndex,nIndex) has been returned.
% 
% NOTE: This is another place where care must be taken in 
%       indexing.. In the calculations below, Q_m,(n+1) and 
%       Q_m,(n-1) are both accessed. The only previous calculations
%       that accessed a variable with (n+1) or (n-1) were the
%       script-H polynomials. "In a coding sense" these are
%       indexed differently in n than the other arrays, namely:
%       For the script-H polynomials the actual value of n is
%       used as the index, and the n = 0 case is a different array
%       specifically for that case. The other quantity arrays
%       such as NU and Q use the nIndex, which is the index
%       that corresponds to a specific n value in the array of
%       n values, nVec(). An example below illustrates the proper
%       access for the different types of arrays. 
%
%       Ex.
%       nVec(nIndex) = n
%       H_(n+1)[yHat] = H(yIndex,(nVec(nIndex) + 1))
%       Q_m,(n+1) = Q(mIndex,(nIndex + 1))
%


% entry statement
disp('bSpectralq.m function')

% global declarations
global Omega kappa cBar ep a

% local variables
mSize = 2*M + 1;             % m dimension
n_1_Size = (N + 1) + 1;      % (n + 1) dimension
                             % NOTE: When we want an array to have
                             %       values from n = 0..N we set
                             %       the nSize = N + 1. This is
                             %       because arrays start indexing
                             %       with 1 not 0. So in an array
                             %       of n values, nVec(1) = 0.
                             %       Likewise, nVec(N+1) = N.
                             %       In some computations for a
                             %       variable indexed by n, we
                             %       need array entrys indexed by
                             %       n+1. So in this computation
                             %       we want all values from 
                             %       n = 0..(N+1).

% initialize index arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [0:1:(N+1)];         % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N
                            % nVec(N+2) = (N+1)
                            % As described above, in later calculations
                            % this solution array will need to 
                            % contain values corresponding to n = (N+1).
                            
                            
% define common constant term, T1
T1 = -(2*Omega*kappa)/(cBar^2*ep^(1/4));

% declare complex solution array
tmpArray = zeros(mSize,n_1_Size);
q = complex(tmpArray,tmpArray);


%                  Compute q
% ----------------------------------------------
for im = 1:mSize       % m loop
  for jn = 1:n_1_Size    % n loop
    
    % n = 0
    % -----
    if nVec(jn) == 0
      %%% (EQ 1) %%%
      num = 2^(-1/2)*Q(im,(jn+1));
      den = alfa + i*(2*Omega*NU(im,jn) - c*(mVec(im)/a));
      q(im,jn) = T1*(num/den);
    
    % n != 0
    % ------
    else
      %%% (EQ 2) %%%
      L1 = sqrt((nVec(jn)+1)/2)*Q(im,(jn+1));
      L2 = sqrt(nVec(jn)/2)*Q(im,(jn-1));
      num = L1 + L2;
      den = alfa + i*(2*Omega*NU(im,jn) - c*(mVec(im)/a));
      q(im,jn) = T1*(num/den);
    end
    
  end    % end n loop
end    % end m loop


% exit statement
% disp('Exiting bSpectralq.m function.')
% disp(' ')

% END

