function Hfield = bHermite(COEFF,H0,H,yHatVec,M,N)
% BHERMITE - Computes "b"alanced "Hermite" Inverse Transform.
%            This function will be used to Hermite expand the
%            Potential Vorticity (q), Streamfunction (psi), and
%            Vertical Velocity (w) fields. The output is a 2-D array,
%            dependent on the integer zonal wavenumbers (m) and the
%            dimensionless meridional distance (yHat). 
%            Hfield = "H"ermite expanded "field"
%            Hfield = Hfield(yHatIndex,mIndex)
%            The Hermite expansion consists of summing the product of the
%            script-H polynomial (Hermite polynomials with additional
%            n-dependent coefficient) and the expansion coefficient
%            for a particular field over all n=0..N.
%            The expansion coefficent is the spectral space solution
%            for that particular field.
%            COEFF = expansion "COEFF"icienct
%            COEFF = COEFF(mIndex,nIndex), complex 2-D array.
%            COEFF can be any of the following: q_mn, psi_mn, w_mn.
%            
% FILE:        bHermite.m
% AUTHOR:      Matt Masarik
% DATE:        July 21 2005
% MODIFIED:    N/A
%          
% CALL SYNTAX: Hfield = bHermite(COEFF,H0,H,yHatVec,M,N);
%                Hfield = Hfield(yIndex,mIndex) complex 2-D array
%                COEFF = COEFF(mIndex,nIndex) complex 2-D array
%                H0 = H0(yHatIndex) script-H polys, n = 0
%                H = H(yHatIndex,nIndex) script-H polys, n = 1..(N+1)
%                yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                M = mMax, maximum zonal wavenumber
%                N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 2-D complex array is returned:
%                 Hfield = Hfield(yHatIndex,mIndex).
%       
% NOTE: Care must be taken in the below calculations with
%       indicies.. Specifically: COEFF is a 2-D array
%       indexed with mIndex,nIndex which are not equal to 
%       the values of m,n used to calculate a specific value
%       of COEFF_mn (As a note this is only because m,n involve 
%       zero and negative numbers, and thus cannot be used
%       for indicies. Matlab indexes starting with 1).
%       For specific values: mVec(mIndex) = m
%                            nVec(nIndex) = n
%           ==> COEFF_mn = COEFF(mIndex,nIndex)
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
disp('    bHermite.m function      : [n -> yHat] b inverse Hermite transform')


% local variables
ySize = length(yHatVec);   % yHat dimension
mSize = 2*M + 1;           % m dimension
nSize = N + 1;             % n dimension

% initialize index arrays
nVec = [0:1:N];             % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N

% initialize complex solution array
tmpArray = zeros(ySize,mSize);
Hfield = complex(tmpArray,tmpArray);



%             Inverse Hermite Transform
% ----------------------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    sumVar = 0;
    
    for jn = 1:nSize    % n loop
      
      % n = 0
      % -----
      if nVec(jn) == 0
        sumVar = sumVar + COEFF(im,jn)*H0(yy);
      
      % n != 0
      % ------
      else
        sumVar = sumVar + COEFF(im,jn)*H(yy,nVec(jn));
      end
      
    end    % end n loop
    
    Hfield(yy,im) = sumVar;
  end    % end m loop
end    % end yHat loop

% END

