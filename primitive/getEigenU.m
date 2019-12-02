function U = getEigenU(A,Nu,H0,H,yHatVec,M,N)
% GETEIGENU - A function to "get" "Eigen"function "U".
%             Computes and returns a 4-D array of eigenfunction 
%             U values. U = U(yHatIndex,mIndex,nIndex,rIndex).
%
% FILE:        getEigenU.m
% AUTHOR:      Matt Masarik
% DATE:        June 23, 2005
% MODIFIED:    MM June 28 2005 - changed input variable: V -> Nu
%
% CALL SYNTAX: U = getEigenU(A,Nu,H0,H,yHatVec,M,N);
%                  U = U(yHatIndex,mIndex,nIndex,rIndex)
%                  A = A(mIndex,nIndex,rIndex) normalization constant
%                  Nu = Nu(mIndex,nIndex,rIndex) dimensionless frequency
%                  H0 = H0(yHatIndex) script-H polys, n = 0
%                  H = H(yHatIndex,nIndex) script-H polys, n = 1..(N+1)
%                  yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 4-D array is returned.
%                 U = U(yHatIndex,mIndex,nIndex,rIndex).
%                 If a cell corresponds to an invalid
%                 eigenfunction (ex. y,m,n=-1,r=1), the cell
%                 will be given an error value of -9999.
% NOTE: Care must be taken in the below calculations with
%       indicies.. Specifically: A and Nu are both 3-D arrays
%       that are indexed with mIndex,nIndex,rIndex which
%       are not equal to the values of m,n,r used 
%       to calculate a specific value of Amnr or Numnr.
%       (As a note this is only because m,n,r involve 
%       zero and negative numbers, and thus cannot be used
%       for indicies. Matlab indexes starting with 1).
%       For specific values: mVec(mIndex) = m
%                            nVec(nIndex) = n
%                            rVec(rIndex) = r
%           ==> Amnr = A(mIndex,nIndex,rIndex)
% 
%       However, when accessing the script-H polynomials, use
%       the actual value of n to access (not the nIndex).
%       But use the yIndex. This may seem confusing, but 
%       again, yHat values can be negative and zero. The
%       n values however could conveniently be used as an
%       index with the hope of easier to understand code.
%       H0 = H0(yHatIndex), 1-D array of script-H polys at n=0
%       H = H(yHatIndex,n), 2-D array of script-H polys for n=1..(N+1)
%       So, for the loop iterations:
%                         nVec(nIndex) = n
%          ==> Hn(yHat) = H(yHatIndex,nVec(nIndex))
%       
%              

% Entry statement
disp('    getEigenU.m function     : [U(yHat)mnr] - eigen zonal wind U')


% global declaration
global ep

% local variables
R = 3;                   % number of roots 
ySize = length(yHatVec); % yHat dimension
mSize = 2*M + 1;         % m dimension
nSize = N + 2;           % n dimension
rSize = R;               % r dimension

% initialize m,n,r value arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [-1:1:N];            % nVec is a 1-D array of n index values
                            % nVec(1) = -1
                            % nVec(2) = 0
                            % nVec(N+2) = N
                            
rVec = [0 1 2];             % rVec is a 1-D array of r index values
                            % rVec(1) = 0
                            % rVec(2) = 1
                            % rVec(3) = 2

% initialize 4-D solution array
U = zeros(ySize,mSize,nSize,rSize);


% compute U
% ---------

for yy = 1:ySize         % yHat loop
  for im = 1:mSize         % m loop
    for jn = 1:nSize         % n loop
      for kr = 1:rSize         % r loop
        
        % n > 1
        % -----
        if nVec(jn) > 1
          % m = 0 and r = 0
          % ---------------
          if (mVec(im) == 0) && (rVec(kr) == 0)
            T1 = sqrt(nVec(jn)/2)*H(yy,(nVec(jn)+1));     % T1 = "T"erm"1"
            T2 = sqrt((nVec(jn)+1)/2)*H(yy,(nVec(jn)-1));
            U(yy,im,jn,kr) = A(im,jn,kr)*(T1 - T2);
          % !(m = 0 and r = 0)
          % ------------------
          else
            T1a = sqrt(ep)*Nu(im,jn,kr) + mVec(im);
            T1b = sqrt((nVec(jn)+1)/2)*H(yy,(nVec(jn)+1));
            T2a = sqrt(ep)*Nu(im,jn,kr) - mVec(im);
            T2b = sqrt(nVec(jn)/2)*H(yy,(nVec(jn)-1));
            U(yy,im,jn,kr) = A(im,jn,kr)*ep^(1/4)*(T1a*T1b + T2a*T2b);
          end
          
        % n = 1
        % -----
        elseif nVec(jn) == 1
          % m = 0 and r = 0
          % ---------------
          if (mVec(im) == 0) && (rVec(kr) == 0)
            T1 = 2^(-1/2)*H(yy,2) - H0(yy);
            U(yy,im,jn,kr) = A(im,jn,kr)*T1;
          % !(m = 0 and r = 0)
          % ------------------
          else
            T1a = sqrt(ep)*Nu(im,jn,kr) + mVec(im);
            T1b = H(yy,2);
            T2a = sqrt(ep)*Nu(im,jn,kr) - mVec(im);
            T2b = 2^(-1/2)*H0(yy);
            U(yy,im,jn,kr) = A(im,jn,kr)*ep^(1/4)*(T1a*T1b + T2a*T2b);
          end
          
        % n = 0
        % -----
        elseif nVec(jn) == 0
          % r = 0,2
          % -------
          if rVec(kr) ~= 1
            T1 = sqrt(ep)*Nu(im,jn,kr) + mVec(im);
            T2 = 2^(-1/2)*H(yy,1);
            U(yy,im,jn,kr) = A(im,jn,kr)*ep^(1/4)*T1*T2;
          % r = 1
          % -----
          else
            U(yy,im,jn,kr) = -9999;
          end
          
        % n = -1
        % ------
        else
          % r = 2
          % -----
          if rVec(kr) == 2
            T1 = exp((-1/2)*yHatVec(yy)^2);
            U(yy,im,jn,kr) = A(im,jn,kr)*T1;
          % r = 0,1
          % -------
          else
            U(yy,im,jn,kr) = -9999;
          end
          
        end  % end n-if
        
      end    % end r-loop
    end    % end n-loop
  end    % end m-loop
end    % end yHat-loop

% END

