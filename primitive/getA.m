function A = getA(M,N,V)
% GETA - Calculates normalization coefficients Amnr, returns 3-D array.
%        (function). This function takes as arguments the scalars
%        M=mMax and N=nMax. It also takes the 3-D array
%        V=V(mIndex,nIndex,rIndex). The array V is an array of
%        "nu" (frequency) values for each valid choice of m,n,r.
%        Because arrays cannot be indexed by 0 (or -1), the
%        values of mIndex, nIndex, rIndex are not equal to
%        the values m, n, r. So in the calculation below, the
%        previously calculated frequencys are retrieved from the
%        array V with the "index" that corresponds to the actual
%        value for m, n, r which appear in the calculation.
%        When an invalid combination appears in the computation
%        loops (ex: n = -1, r = 1 ), the error value: -9999 is returned
%        as the value for Amnr.
%
% FILE:        getA.m
% AUTHOR:      Matt Masarik
% DATE:        June 16 2005
% MODIFIED:    MM September 05 2005 -  n=-1..N  --> n=-1..(N+1)
%                                      This routine will actually
%                                      be used for the balanced 
%                                      model now as well, to 
%                                      calculate the PV. Because 
%                                      of this we need to have 
%                                      A up to the value 
%                                      n = (N+1).
% CALL SYNTAX: A = getA(M,N,V);
%                  A = A(mIndex,nIndex,rIndex), for n=-1..(N+1)
%                  M = max m value, m=-M..M
%                  N = max n value, n=-1..N
%                  V = V(mIndex,nIndex,rIndex) 3-D array of frequencys
%                      where n = -1..(N+1)
%                      
% PRE:         The following scripts/functions have been called:
%              CONSTANT_DEFINITIONS.m  -->  CONSTANT_DEFINITIONS
%              VARIABLE_DEFINITIONS.m  -->  VARIABLE_DEFINITIONS
%              genNu.m  -->  genNu(M,N)
% POST:        3-D array A = A(mIndex,nIndex,rIndex) is returned.
%              

% Entry statement
disp('  getA.m function            : [A_mnr] - calc p normalization coeff.')


% global declaration
global ep

% local variables
R = 3;                % number of roots 
mSize = 2*M + 1;      % m dimension of V
n_1_Size = (N+2) + 1; % (n+1) dimension of V
rSize = R;            % r dimension of V

% initialize index arrays
mVec = [-M:1:M];            % mVec is a 1-D array of m index values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
nVec = [-1:1:(N+1)];        % nVec is a 1-D array of n index values
                            % nVec(1) = -1
                            % nVec(2) = 0
                            % nVec(N+2) = N
                            % nVec((N+2)+1) = N+1
                            
rVec = [0 1 2];             % rVec is a 1-D array of r index values
                            % rVec(1) = 0
                            % rVec(2) = 1
                            % rVec(3) = 2
                            
% initialize 3-D solution array full of zeros
A = zeros(mSize,n_1_Size,rSize);


% ---- compute A ----


% loop m = -M..M
% --------------
for im=1:mSize
  % loop n = -1..N
  % --------------
  for jn=1:n_1_Size
    % loop r = 0..2
    % -------------
    for kr=1:rSize
      
      % n = 1,2,3, ...
      % --------------
      if nVec(jn) > 0
        % m = 0 and r = 0
        % ---------------
        if (mVec(im) == 0) & (rVec(kr) == 0)
          A(im,jn,kr) = (2*nVec(jn) + 1)^(-1/2);
        % m != 0 and/or r != 0
        % --------------------
        else
          termI=ep^(1/2)*(nVec(jn)+1)*(ep^(1/2)*V(im,jn,kr)+mVec(im))^2;
          termII=ep^(1/2)*nVec(jn)*(ep^(1/2)*V(im,jn,kr)-mVec(im))^2;
          termIII=(ep*V(im,jn,kr)^2 - mVec(im)^2)^2;
          A(im,jn,kr) = (termI + termII + termIII)^(-1/2);
        end
      % n = 0
      % -----
      elseif nVec(jn) == 0
        % r = 0,2
        % -------
        if rVec(kr) ~= 1
          termI=ep^(1/2)*(ep^(1/2)*V(im,jn,kr) + mVec(im))^2;
          termIII=(ep*V(im,jn,kr)^2 - mVec(im)^2)^2;
          A(im,jn,kr) = (termI + termIII)^(-1/2);
        % r = 1
        % -----
        else
          A(im,jn,kr) = -9999;
        end
      % n = -1
      % ------
      else
        % r = 2
        % -----
        if rVec(kr) == 2
          A(im,jn,kr) = 2^(-1/2)*pi^(-1/4);
        % r = 0,1
        % -------
        else
          A(im,jn,kr) = -9999;
        end
      end  % end n-if
      
    end  % end r-loop
  end  % end n-loop
end  % end m-loop


% Exit statement
% disp('Exiting getA.m function.')
% disp(' ')

% END

