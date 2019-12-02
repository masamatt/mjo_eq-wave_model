function stream = bSpectralPsi(q,M,N)
% BSPECTRALPSI - "b"alanced model "Spectral" "Psi".
%                Calculates and returns a 2-D array of spectral
%                space streamfunction (psi),
%                psi = psi_mn = stream(mIndex,nIndex).
%                stream is a complex array, and n = 0..(N+1).
%
% FILE:          bSpectralPsi.m
% AUTHOR:        Matt Masarik
% DATE:          August 8 2005
% MODIFIED:      N/A
%
% CALL SYNTAX:   stream = bSpectralPsi(q,M,N);
%                         stream = stream(mIndex,nIndex), n=0..(N+1)
%                                = spectral space streamfunction
%                         q = q(mIndex,nIndex), n=0..(N+1)
%                           = spectral space PV
%                         M = max m value. m = -M..M
%                           = maximum zonal wavenumber
%                         N = max n value. n = 0..N
%                           = maximum meridional mode
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        stream(mIndex,nIndex) has been returned.
%


% entry statement
disp('  bSpectralPsi.m function    : [psi_mn] - calc balanced spectral streamfunction')

% global declarations
global ep a

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

% declare complex solution array
tmpArray = zeros(mSize,n_1_Size);
stream = complex(tmpArray,tmpArray);


%                  Compute psi
% ----------------------------------------------
for im = 1:mSize       % m loop
  for jn = 1:n_1_Size    % n loop   
    
    num = -a^2*q(im,jn);
    den = mVec(im)^2 + sqrt(ep)*(2*nVec(jn) + 1);
    stream(im,jn) = num/den;
    
  end
end

% END

