function q = getStructureq(A,NU,H0,H,yHatVec,M,N);
% GETSTRUCTUREQ - function to compute q_mnr(yHat).
%                 This function returns a 4-D array: 
%                 q_mnr(yHat) = q(yHatIndex,mIndex,nIndex,rIndex).
%                 This array ( q_mnr(yHat) ) is used in the 
%                 normal mode expansion of q_m(yHat), which is the
%                 fourier transformed PV field dependent on zonal
%                 wavenumber (m) and meridional distance (yHat).
%                 q_mnr(yHat) is analogous to the eigenfunctions
%                 [ Umnr(yHat), Vmnr(yHat), PHImnr(yHat) used
%                 in the normal mode expansion of u,v,phi respectively ],
%                 for the normal mode expansion of the fourier
%                 transformed PV field. Since q_mnr(yHat) is not
%                 actually an eigenfunction, the name of this function
%                 to compute it has the word "Structure" instead of
%                 "Eigen". getStructureq = "get" expansion 
%                                          "Structure" function
%                                          of "q" field.
%                 This array q_mnr(yHat) can then be used in the 
%                 general function normalMode.m, the output of which
%                 can then be used in IFourier.m, as was done for the 
%                 u,v,phi fields.
%
% FILE:        getStructureq.m
% AUTHOR:      Matt Masarik
% DATE:        July 14, 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: q = getStructureq(A,NU,H0,H,yHatVec,M,N);
%                  q = q(yHatIndex,mIndex,nIndex,rIndex)
%                  A = A(mIndex,nIndex,rIndex) normalization constant
%                  NU = NU(mIndex,nIndex,rIndex) dimensionless frequency
%                  H0 = H0(yHatIndex) script-H polys, n = 0
%                  H = H(yHatIndex,n) script-H polys, n = 1..(N+1)
%                  yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 4-D array is returned.
%                 q = q(yHatIndex,mIndex,nIndex,rIndex).
%                 If a cell corresponds to an invalid
%                 eigenfunction (ex. y,m,n=-1,r=1), the cell
%                 will be given an error value of -9999.
%
% NOTE: Care must be taken in the below calculations with
%       indicies.. Specifically: A and NU are both 3-D arrays
%       that are indexed with mIndex,nIndex,rIndex which
%       are not equal to the values of m,n,r used 
%       to calculate a specific value of Amnr or NUmnr.
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
disp('Entering getStructureq.m function...')


% global declaration
global ep a

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
q = zeros(ySize,mSize,nSize,rSize);


%               Compute q
% ----------------------------------------

for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    for jn = 1:nSize    % n loop
      for kr = 1:rSize    % r loop
        
        
        % n > 0
        % -----
        if nVec(jn) > 0
          % m = 0 and r = 0
          % ---------------
          if (mVec(im) == 0) & (rVec(kr) == 0)
            %%% (EQ 1) %%%
            T1 = -(2/a)*ep^(1/4)*A(im,jn,kr);
            T2 = sqrt(nVec(jn)*(nVec(jn)+1))*H(yy,nVec(jn));
            q(yy,im,jn,kr) = T1*T2;
          % !(m = 0 and r = 0)  
          % ------------------  
          else
            %%% (EQ 2) %%%
            T1 = A(im,jn,kr)*H(yy,nVec(jn));
            num = mVec(im)^2 - ep*NU(im,jn,kr)^2;
            den = a*NU(im,jn,kr);
            q(yy,im,jn,kr) = T1*(num/den);
          end
          
        % n = 0
        % -----
        elseif nVec(jn) == 0
          % r = 0,2
          % -------
          if rVec(kr) ~= 1
            %%% (EQ 3) %%%
            T1 = A(im,jn,kr)*H0(yy);
            num = mVec(im)^2 - ep*NU(im,jn,kr)^2;
            den = a*NU(im,jn,kr);
            q(yy,im,jn,kr) = T1*(num/den);
          % r = 1
          % -----
          else
            %%% -9999 %%%
            q(yy,im,jn,kr) = -9999;
          end
          
        % n = -1
        % ------
        else
          % r = 2
          % -----
          if rVec(kr) == 2
            %%% (EQ 4) %%%
            q(yy,im,jn,kr) = 0;
          % r = 0,1
          % -------
          else
            %%% -9999 %%%
            q(yy,im,jn,kr) = -9999;
          end
          
        end    % end n-if
        
        
      end    % end r loop
    end    % end n loop
  end    % end m loop
end    % end yHat loop


% Exit statement
disp('Exiting getStructureq.m function.')
disp(' ')

% END

