function Q = getQ(A,NU,HC0,HC,Q0,a0,b0,y0,M,N);
% GETQ - A function to compute heating function expansion coefficients.
%        Q = QHatmnr = Q(mIndex,nIndex,rIndex). The returned quantity, Q,
%        is a 3-D array indexed by m,n,r and contains the expansion
%        coefficients for the heating function for each specified value 
%        of m,n,r. Here the values of n are n = -1..(N+1).
%
% FILE:        getQ.m
% AUTHOR:      Matt Masarik
% DATE:        June 30, 2005
% MODIFIED:    MM September 05 2005 -  n=-1..N  --> n=-1..(N+1)
%                                      This routine will actually
%                                      be used for the balanced 
%                                      model now as well, to 
%                                      calculate the PV. Because 
%                                      of this we need to have 
%                                      Q up to the value 
%                                      n = (N+1).
%
% CALL SYNTAX: Q = getQ(A,NU,HC0,HC,Q0,a0,b0,y0,M,N);
%                  Q = Q(mIndex,nIndex,rIndex) expansion coefficient
%                  A = A(mIndex,nIndex,rIndex) normalization constant
%                  NU = Nu(mIndex,nIndex,rIndex) dimensionless frequency
%                  HC0 = HC0 = H0(Const), (scalar) script-H, n=0, y=const
%                  HC = HC(nIndex) = Hn(Const), 1-D array, n=1..(N+2) []
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
% POST: A 3-D array is returned.
%                 Q = Q(mIndex,nIndex,rIndex).
%                 If a cell corresponds to an invalid
%                 eigenfunction (ex. m,n=-1,r=1), the cell
%                 will be given an error value of -9999.
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
%       HC = HC(n), 1-D array of script-H polys for n=1..(N+1)
%       evaluated at a constant-y-argument.
%       So, for the loop iterations:
%                         nVec(nIndex) = n
%          ==> HCn = HC(nVec(nIndex))
%       
%              

% Entry statement
disp('Entering getQ.m function...')


% global declaration
global ep cBar a

% local variables
R = 3;                   % number of roots 
mSize = 2*M + 1;         % m dimension
n_1_Size = (N+2) + 1;    % (n+1) dimension
rSize = R;               % r dimension

% initialize m,n,r value arrays
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

% initialize 3-D solution array
Q = zeros(mSize,n_1_Size,rSize);



% Calculate b0Hat and y0Hat, which are the dimensionless versions
% of b0 and y0 respectively.
b0Hat = (ep^(1/4)/a)*b0;
y0Hat = (ep^(1/4)/a)*y0;

% Calculate some common terms containing constants to be used
% in the calculations below.. The calculations have many terms
% and a few different special cases so these will help keep
% it cleaner.
% TN = "T"erm "N"
% EN = "E"psilon raised to 1/"N"
T1 = (Q0*a0*b0)/(2*pi*cBar*a^2);
T2 = (pi*Q0*a0*b0)/(2*cBar*a^2);
T3 = sqrt((2*pi)/(2+b0Hat^2));
T4 = exp((y0Hat^2*b0Hat^2)/(4-b0Hat^4));
T5 = (2-b0Hat^2)/(2+b0Hat^2);
T6 = exp((-y0Hat^2)/(2+b0Hat^2));
T7 = 2^(-1/2);
E1 = ep;
E2 = ep^(1/2);
E4 = ep^(1/4);
 
 
 
% Compute Q
% ---------

for im = 1:mSize     % m loop
  for jn = 1:n_1_Size  % n loop
    for kr = 1:rSize    % r loop


      
      % --------------- %
      %       n > 1     %
      % --------------- %
      if nVec(jn) > 1
        % m = 0
        % -----
        if mVec(im) == 0
          % r = 0
          % -----
          if rVec(kr) == 0
            % LN = "L"oop variable "N"
            % Loop variables are just the name i came up with
            % and are used to try to keep the code clean by
            % not having a bunch of overflowing lines.
            %%% >>> EQ 1 <<< %%%
            L1 = A(im,jn,kr)*T1*E4*T3*T4;
            L2 = T5^((nVec(jn)+1)/2)*sqrt(nVec(jn)/2);
            L3 = T5^((nVec(jn)-1)/2)*sqrt((nVec(jn)+1)/2);
            Q(im,jn,kr) = L1*(L2*HC(nVec(jn)+1) + L3*HC(nVec(jn)-1));

          % r = 1,2
          % -------
          else
            %%% >>> EQ 2 <<< %%%
            L1 = A(im,jn,kr)*T1*E1*NU(im,jn,kr)*T3*T4;
            L2 = T5^((nVec(jn)+1)/2)*sqrt((nVec(jn)+1)/2);
            L3 = T5^((nVec(jn)-1)/2)*sqrt(nVec(jn)/2);
            Q(im,jn,kr) = L1*(L2*HC(nVec(jn)+1) - L3*HC(nVec(jn)-1));

          end
        % m != 0
        % ------
        else
          %%% >>> EQ 3 <<< %%%
          L1 = A(im,jn,kr)*T2*E2*T3*T4;
          L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
          L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
          L4 = E2*NU(im,jn,kr) + mVec(im);
          L5 = T5^((nVec(jn)+1)/2)*sqrt((nVec(jn)+1)/2);
          L6 = E2*NU(im,jn,kr) - mVec(im);
          L7 = T5^((nVec(jn)-1)/2)*sqrt(nVec(jn)/2);
          L8 = L1*L2*L3;
          L9 = (L4*L5*HC(nVec(jn)+1) - L6*L7*HC(nVec(jn)-1));
          Q(im,jn,kr) = L8*L9;

        end
        

        
      % --------------- %        
      %       n = 1     %
      % --------------- %
      elseif nVec(jn) == 1
        % m = 0
        % -----
        if mVec(im) == 0
          % r = 0
          % -----
          if rVec(kr) == 0
            %%% >>> EQ 4 <<< %%%
            L1 = A(im,jn,kr)*T1*E4*T3*T4;
            L2 = T5*T7*HC(2) + HC0;
            Q(im,jn,kr) = L1*L2;

          % r = 1,2
          % -------
          else
            %%% >>> EQ 5 <<< %%%
            L1 = A(im,jn,kr)*T1*E1*NU(im,jn,kr)*T3*T4;
            L2 = T5*HC(2) - T7*HC0;
            Q(im,jn,kr) = L1*L2;
            
          end
        % m != 0
        % ------
        else
          %%% >>> EQ 6 <<< %%%
          L1 = A(im,jn,kr)*T2*E2*T3*T4;
          L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
          L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
          L4 = (E2*NU(im,jn,kr) + mVec(im))*T5*HC(2);
          L5 = (E2*NU(im,jn,kr) - mVec(im))*T7*HC0;
          Q(im,jn,kr) = L1*L2*L3*(L4 - L5);
          
        end
        
      
 
        
      % ---------------- %  
      %       n = 0      %
      % ---------------- %
      elseif nVec(jn) == 0
        % m = 0
        % -----
        if mVec(im) == 0
          % r = 0,2
          % -------
          if rVec(kr) ~= 1
            %%% >>> EQ 7 <<< %%%
            L1 = A(im,jn,kr)*T1*E1*NU(im,jn,kr)*T3;
            L2 = sqrt(T5)*T7*T4*HC(1);
            Q(im,jn,kr) = L1*L2;
            
          % r = 1
          % -----
          else
            %%% -9999 %%%
            Q(im,jn,kr) = -9999;
            
          end
        % m != 0
        % ------
        else
          % r = 0,2
          % -------
          if rVec(kr) ~= 1
            %%% >>> EQ 8 <<< %%%
            L1 = A(im,jn,kr)*T2*E2*T3*T4;
            L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
            L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
            L4 = (E2*NU(im,jn,kr)+mVec(im))*sqrt(T5)*T7*HC(1);
            Q(im,jn,kr) = L1*L2*L3*L4;
            
          % r = 1
          % -----
          else
            %%% -9999 %%%
            Q(im,jn,kr) = -9999;
            
          end
        end

        
      
      % ---------------- %  
      %       n = -1     %
      % ---------------- %
      else
        % m = 0
        % -----
        if mVec(im) == 0
          % r = 2
          % -------
          if rVec(kr) == 2
            %%% >>> EQ 9 <<< %%%
            Q(im,jn,kr) = A(im,jn,kr)*T1*E4*T3*T6;
            
          % r = 0,1
          % -------
          else
            %%% -9999 %%%
            Q(im,jn,kr) = -9999;
            
          end
        % m != 0
        % ------
        else
          % r = 2
          % -------
          if rVec(kr) == 2
            %%% >>> EQ 10 <<< %%%
            L1 = A(im,jn,kr)*T2*E4*T3*T6;
            L2 = 1/(pi^2 - ((mVec(im)*a0)/a)^2);
            L3 = sin((mVec(im)*a0)/a)/((mVec(im)*a0)/a);
            Q(im,jn,kr) = L1*L2*L3;
            
          % r = 0,1
          % -------
          else
            %%% -9999 %%%
            Q(im,jn,kr) = -9999;
            
          end
        end
      end    % end n-if

      
      
      
    end    % end r loop
  end    % end n loop
end    % end m loop


% Exit statement
disp('Exiting getQ.m function.')
disp(' ')

% END

