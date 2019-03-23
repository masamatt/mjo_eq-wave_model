function NU = bGetNu(M,N);
% BGETNU - bGetNu = "b"alanced model "Get" "Nu". 
%          Calculates and returns a 2-D array of dimensionless
%          frequencies, nu (actually nuHat are the dimensionless
%          frequencies, and nu are dimensional.. though we will only
%          deal with dimensionless in computations so nu will be
%          used in place of nuHat). Nu is calculated for n values
%          n = 0..(N+1). When this quantity is used later, values 
%          corresponding to n = (N+1) will be needed. 
%          (Other quantity arrays may have values for n = 0..N,
%          n = 0..(N+1) or n = 0..(N+2) ).
%
% 
% FILE:        bGetNu.m
% AUTHOR:      Matt Masarik
% DATE:        July 20 2005
% MODIFIED:    (1) MM August 8 2005 - changed the maximum value of n
%                                     that nu is calculated for.
%                                     n = 0..N   ->   n = 0..(N+1)
%
% CALL SYNTAX: NU = bGetNu(M,N);
%              M = max m value. m = -M..M, maximum zonal wavenumber
%              N = max n value. n = 0..N, maximum meridional wave mode
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        NU(mIndex,nIndex) has been returned.
%              
%              


% entry statement
disp('Entering bGetNu.m function...');

% global declaration
global ep

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
                            
                            
% initialize 2-D solution array
NU = zeros(mSize,n_1_Size);


%                Compute Nu
% ----------------------------------------------
for im = 1:mSize    % m loop
  for jn = 1:n_1_Size    % n loop
    
    num = -mVec(im);
    den = mVec(im)^2 + sqrt(ep)*(2*nVec(jn) + 1);
    NU(im,jn) = num/den;
    
  end    % end n loop
end    % end m loop


% exit statement
disp('Exiting bGetNu.m function.')
disp(' ')

% END

