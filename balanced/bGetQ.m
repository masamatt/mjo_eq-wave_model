function Q = bGetQ(HC0,HC,Q0,a0,b0,y0,M,N);
% BGETQ - A function to compute heating function expansion coefficients.
%         bGetQ = "b"alanced model "Get" "Q"
%         Q = QHat_mn = Q(mIndex,nIndex). The returned quantity, Q,
%         is a 2-D array indexed by m,n and contains the expansion
%         coefficients for the heating function for each specified value 
%         of m,n. When this quantity is used later, values corresponding
%         to n = (N+2) will be needed. So unlike some other variables,
%         Q will be calculated and returned for n = 0..(N+2).
%
%
% FILE:        bGetQ.m
% AUTHOR:      Matt Masarik
% DATE:        July 20, 2005
% MODIFIED:    (1) MM August 8 2005 - n = 0..(N+1) -> n = 0..(N+2)
%
% CALL SYNTAX: Q = bGetQ(HC0,HC,Q0,a0,b0,y0,M,N);
%                  Q = Q(mIndex,nIndex) heating expansion coefficient
%                  HC0 = HC0 = H0(Const), (scalar) script-H, n=0, y=const
%                  HC = HC(nIndex) = Hn(Const), 1-D array, n=1..(N+1) []
%                  Q0 = physical space heating coefficient, scalar [?]
%                  a0 = zonal half-width of cloud cluster, scalar [m]
%                  b0 = meridional cloud e-folding width, scalar [m]
%                  y0 = meridional cloud displacement, scalar [m]
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 2-D array is returned, Q = Q(mIndex,nIndex).
%
% NOTE:  This pertains to the difference between the index of 
%        the m or n arrays and the actual m or n values. 
%        mVec(mIndex) = m
%        nVec(nIndex) = n
%        When accessing the script-H polynomials, use
%        the actual value of n to access (not the nIndex).
%        HC = HC(n), 1-D array of script-H polys for n=1..(N+2)
%        evaluated at a constant-y-argument.
%        So, for the loop iterations:
%                         nVec(nIndex) = n
%          ==> HCn = HC(nVec(nIndex))
%       
%  


% Entry statement
disp('Entering bGetQ.m function...')

% global declarations
global ep a

% local variables
mSize = 2*M + 1;             % m dimension
n_2_Size = (N + 1) + 2;      % (n + 2) dimension
                             % NOTE: When we want an array to have
                             %       values from n = 0..N we set
                             %       the nSize = N + 1. This is
                             %       because arrays start indexing
                             %       with 1 not 0. So in an array
                             %       of n values, nVec(1) = 0.
                             %       Likewise, nVec(N+1) = N.
                             %       In some computations for a
                             %       variable indexed by (n+1), we
                             %       need array entrys indexed by
                             %       (n+2). So in this computation
                             %       we want all values from 
                             %       n = 0..(N+2).

% initialize index arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [0:1:(N+2)];         % nVec is a 1-D array of n index values
                            % nVec(1) = 0
                            % nVec(N+1) = N
                            % nVec(N+2) = (N+1)
                            % nVec(N+3) = (N+2)
                            % As described above, in later calculations
                            % this solution array will need to 
                            % contain values corresponding to n = (N+2).
                            
% initialize 2-D solution array
Q = zeros(mSize,n_2_Size);

% Calculate b0Hat and y0Hat, which are the dimensionless versions
% of b0 and y0 respectively.
b0Hat = (ep^(1/4)/a)*b0;
y0Hat = (ep^(1/4)/a)*y0;

% Calculate some common terms containing constants to be used
% in the calculations below.. The calculations have many terms
% and a few different special cases so these will help keep
% it cleaner.
% TN = "T"erm "N"
T1 = (Q0*a0*b0*ep^(1/4))/(2*pi*a^2);
T2 = (pi*Q0*a0*b0*ep^(1/4))/(2*a^2);
T3 = sqrt((2*pi)/(2+b0Hat^2));
T4 = exp((y0Hat^2*b0Hat^2)/(4-b0Hat^4));
T5 = (2-b0Hat^2)/(2+b0Hat^2);


%                 Compute Q
% --------------------------------------------
for im = 1:mSize        % m loop
  for jn = 1:n_2_Size      % n loop
    
    % m = 0 and n = 0
    % ---------------
    if (mVec(im) == 0) & (nVec(jn) == 0)
      %%% (EQ 1) %%%
      Q(im,jn) = T1*T3*T4*HC0;
    
    % m = 0 and n != 0
    % ----------------
    elseif (mVec(im) == 0) & (nVec(jn) ~= 0)
      %%% (EQ 2) %%%
      Q(im,jn) = T1*T3*T4*T5^(nVec(jn)/2)*HC(nVec(jn));
    
    % m != 0 and n = 0
    % ----------------
    elseif (mVec(im) ~= 0) & (nVec(jn) == 0)
      %%% (EQ 3) %%%
      % LN = "L"oop variable number "N"
      L1 = T2*T3*T4*HC0;
      L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
      L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
      Q(im,jn) = L1*L2*L3;
    
    % m != 0 and n != 0
    % -----------------
    else
      %%% (EQ 4) %%%
      L1 = T2*T3*T4*T5^(nVec(jn)/2)*HC(nVec(jn));
      L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
      L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
      Q(im,jn) = L1*L2*L3;
      
    end
    
  end    % end n loop
end    % end m loop
    

% Exit statement
disp('Exiting bGetQ.m function.')
disp(' ')

% END

