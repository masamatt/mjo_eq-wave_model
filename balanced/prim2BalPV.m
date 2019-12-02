function q = prim2BalPV(ETA,A,NU,M,N)
% PRIM2BALPV - prim2BalPV = "prim"itive "to" "Bal"anced "PV".
%              This function computes what is essentially the
%              Rossby (and Mixed Rossby-Gravity) component of 
%              the spectral space PV in the primitive model. This
%              PV will be used in the balanced model, so is stored
%              in an array indexed only by m,n. A complex 2-D
%              array is returned: q = q_mn = q(mIndex,nIndex).
%              The values of n for q are n = 0..(N+1).
%
% FILE:        prim2BalPV.m
% AUTHOR:      Matt Masarik
% DATE:        September 05 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: q = prim2BalPV(ETA,A,NU,M,N);
%                  q = q(mIndex,nIndex), n=0..(N+1), spectral space PV
%                  ETA = ETA(mIndex,nIndex,rIndex), n = -1..(N+1) {prim}
%                  A = A(mIndex,nIndex,rIndex), n = -1..(N+1)     {prim}
%                  NU = NU(mIndex,nIndex,rIndex), n = -1..(N+1)   {prim}
%                  M = max m value. m = -M..M, maximum zonal wavenumber
%                  N = max n value. n = 0..N, maximum meridional mode
%
% PRE:         The following scripts have been called:
%                  CONSTANT_DEFINITIONS.m
%                  VARIABLE_DEFINITIONS.m
% POST:        q(mIndex,nIndex) has been returned.
%
% NOTE: Care should be taken here with indexing. This is the first
%       function to give results for the balanced model, using
%       quantities from the primitive model. The thing to watch
%       for is how you are accessing arrays from the primitive
%       vs. balanced models. The primitive arrays have 3 indicies,
%       mIndex,nIndex,rIndex. The balanced model only has 2 indicies,
%       mIndex,nIndex. The values of n in the primitive model start at
%       n = -1, the values in the balanced model start at n = 0. The
%       array "nVec" will have values corresponding to the primitive
%       model. Thus, an nIndex in a primitive model array (or the array
%       nVec) does not correspond to the same n value that it corresponds
%       to in the balanced model. Here, the array "q" will be indexed for
%       the balanced model. The arrays "ETA", "A", "NU", and "nVec"
%       will be indexed according to the primitive model. In the loops
%       below, the primitive arrays will be accessed with the index
%       variable nPrim = (nIndex + 1). While the balanced solution
%       array is accessed with nBal = nIndex.
%
%       EX. 
%       q(mIndex,nBal)            -- corresponds to -->
%       NU(mIndex,nPrim,rIndex)   -- corresponds to -->
%       nVec(nPrim)
%                        where   nBal  = nIndex
%                                nPrim = nIndex + 1.


% Entry statement
disp('  prim2BalPV.m function      : [q_mn] - compute primitive to balanced PV')

% global declarations
global ep a

% local variables
rIndex = 1;                  % rIndex is fixed and corresponds to 
                             % the r-index for both the Rossby
                             % components and the Mixed Rossby-Gravity
                             % components. r = 0 --> rIndex = 1.
mSize = 2*M + 1;             % m dimension
n_1_Size = (N+1) + 1;        % (n+1) dimension
                             % NOTE: When we want an array to have
                             %       values from n = 0..N we set
                             %       the nSize = N + 1. This is
                             %       because arrays start indexing
                             %       with 1 not 0. In an array
                             %       of n values, nVec(1) = 0.
                             %       Likewise, nVec(N+1) = N. So
                             %       for values n = 0..(N+1) we need
                             %       the nSize to be (N+1)+1. 
                             %
mVec = [-M:1:M];             % mVec is a 1-D array of m index values
                             % mVec(1) = -M
                             % mVec(M+1) = 0
                             % mVec(2M+1) = M
nVec = [-1:1:(N+1)];         % nVec is a 1-D array of n values {prim}
                             % nVec(1) = -1
                             % nVec(N+2) = N
                             % nVec((N+2)+1) = (N+1)
 
% declare complex solution array
tmpArray = zeros(mSize,n_1_Size);
q = complex(tmpArray,tmpArray);



%              Compute q
% -------------------------------------------
for im = 1:mSize        % m loop
  for jn = 1:n_1_Size     % n loop
    
    % Define two different n-indicies. See discussion
    % above, at 'NOTE'.
    nBal  = jn;       % used in q()
    nPrim = jn+1;     % used in nVec(),ETA(),A(),NU()
    
    % n = 0
    % -----
    if nVec(nPrim) == 0
      %%% (EQ 2) %%%
      T1 = ETA(im,nPrim,rIndex)*A(im,nPrim,rIndex);
      num = mVec(im)^2 - ep*NU(im,nPrim,rIndex)^2;
      den = a*NU(im,nPrim,rIndex);
      q(im,nBal) = T1*(num/den);
      
    % n > 0
    % -----
    elseif nVec(nPrim) > 0
      % m = 0
      % -----
      if mVec(im) == 0
        %%% (EQ 1) %%%
        T1 = ETA(im,nPrim,rIndex)*A(im,nPrim,rIndex);
        T2 = -(2*ep^(1/4))/a;
        T3 = sqrt(nVec(nPrim)*(nVec(nPrim) + 1));
        q(im,nBal) = T1*T2*T3;
        
      % m != 0
      % ------
      else
        %%% (EQ 2) %%%
        T1 = ETA(im,nPrim,rIndex)*A(im,nPrim,rIndex);
        num = mVec(im)^2 - ep*NU(im,nPrim,rIndex)^2;
        den = a*NU(im,nPrim,rIndex);
        q(im,nBal) = T1*(num/den);
      end
    end
    
  end    % end n loop
end    % end m loop


% exit statement
% disp('Exiting prim2Bal.m function.')
% disp(' ')

% END

