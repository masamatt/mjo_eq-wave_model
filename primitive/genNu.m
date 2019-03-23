function V = genNu(M,N);
% GENNU - Calls function getNu(m,n,r) returns V(m,n,r).
%         This function returns a 3-D array of frequencys (nu)
%         where m=-M..M, n=-1..(N+1), r=0..2. (function)
%
% FILE:        genNu.m
% AUTHOR:      Matt Masarik
% DATE:        June 08 2006
% MODIFIED:    MM September 05 2005 -  n=-1..N  --> n=-1..(N+1)
%                                      This routine will actually
%                                      be used for the balanced 
%                                      model now as well, to 
%                                      calculate the PV. Because 
%                                      of this we need to have 
%                                      nu up to the value 
%                                      n = (N+1).
%
% CALL SYNTAX: V = genNu(M,N);
%                  V = V(mIndex,nIndex,rIndex), for n=-1..(N+1)
%                  M = max m value, m=-M..M
%                  N = max n value, n=-1..N
% PRE:         None
% POST:        3-D array of nu(m,n,r) values has been returned.
%              

% Entry statement
disp('Entering genNu.m function...')

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
V = zeros(mSize,n_1_Size,rSize);

% compute V
% ---------

% loop m=-M..M
for im = 1:mSize 
  %loop n=-1..(N+1)
  for jn = 1:n_1_Size
    %loop r=1..R
    for kr = 1:rSize
      V(im,jn,kr) = getNu(mVec(im),nVec(jn),rVec(kr));
    end
  end
end


% Exit statement
disp('Exiting genNu.m function.')
disp(' ')

% END

