function HnVec = getH(yHat,N)
% GETH - "get"s H, where H are the "script-H" polynomials. (function).
%        This function takes a scalar value yHat and a maximum n
%        value n=N and returns a 1-D vector of "script-H" polynomial
%        values from n=1..(N+1) for yHat if N>=1.
%        As a note, the vector goes from n=1..(N+1) instead
%        of n=1..N because in later calculations, some
%        eigenfunctions indexed at n depend on n+1. So 
%        an eigenfunction indexed at n=N would depend on
%        H(N+1). 
% 
% FILE: getH.m
% AUTHOR: Matt Masarik
% DATE: June 14, 2005
% MODIFIED:  (1) MM June 23 2005 - return index: N -> (N+1)
%
% CALL SYNTAX: HnVec = getH(yHat,N);
%              yHat = scalar value, dimensionless merid. coord. []
%              N = scalar value, N=nMax []
% PRE: None
% POST: A 1-D vector HnVec = HnVec(nIndex) is returned for the 
%       specific value of yHat input and nIndex=1..(N+1).

% Check to make sure N >= 1. If not, display an error message
% and exit the function.
if N < 1
  disp('Error: getH() requires N >= 1.')
  return
end


% Initialize solution vector ( 1 X (N+1) array of zeros )
HnVec = zeros(1,(N+1));

% n = 0
% -----
H0 = pi^(-1/4)*exp((-1/2)*yHat^2);

% n = 1
% -----
HnVec(1) = pi^(-1/4)*sqrt(2)*yHat*exp((-1/2)*yHat^2);

% n = 2
% -----
HnVec(2) = yHat*HnVec(1) - 2^(-1/2)*H0;


if N > 1
  % n = 3,4,5, ...
  % --------------
  for n=2:N
    HnVec(n+1) = sqrt(2/(n+1))*yHat*HnVec(n) - ...
      sqrt(n/(n+1))*HnVec(n-1);
    % Notice the loop variable 'n' goes from n=2..N.
    % However we are finding HnVec(n+1), so the loop
    % calculates HnVec(3)..HnVec(N+1).
  end
end


% END
  
