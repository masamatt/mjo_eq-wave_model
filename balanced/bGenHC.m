function [HC0,HCN] = bGenHC(y0,b0,N)
% BGENHC - calculates "script-H" polynomials for a constant-y-argument.
%          bGenHC --> "b"alanced "Gen"erate script-"H" "C"onstant.
%          This function takes scalar variables y0,b0, and N. It
%          calculates the "script-H" polynomials for n=0..(N+2)
%          evaluated at a constant-y-argument composed of the
%          input variables y0 and b0. Returns a scalar HC0, and
%          a 1-D array HCN. HC0 = H0(Const) ... n = 0
%                          HCN(nIndex) = Hn(Const) ... n = 1..(N+2)
%          Note: The only way this function differs from the
%                primitive model genHC.m is that the n values
%                here are n = 0..(N+2), where as in genHC.m
%                n = 0..(N+1). ...... Actually, they are now
%                the same as of Sep. 05 2005.. will try to 
%                consolidate as time permits.
%
% FILE: bGenHC.m
% AUTHOR: Matt Masarik
% DATE: June 15 2005
% MODIFIED:  (1) MM June 23 2005 - nIndex: N -> (N+1)
%            (2) MM August 8 2005 - nIndex: (N+1) -> (N+2)
%                                 - genHC -> bGenHC
%
% CALL SYNTAX: [HC0,HCN] = bGenHC(y0,b0,N);
%              HC0 = H0(Const), scalar []
%              HCN(nIndex) = Hn(Const), 1-D array, n=1..(N+2) []
%              y0 = meridional cloud displacement, scalar [m]
%              b0 = meridional cloud e-folding width, scalar [m]
%              N = nMax, maximum meridional mode []
% PRE: The following scripts have been called:
%      CONSTANT_DEFINITIONS.m
%      VARIABLE_DEFINITIONS.m
% POST: A scalar (HC0) and 1-D array (HCN) are returned which
%       together contain the values of the script-H polynomials
%       from n=0..(N+2) evaluated at a constant-y-argument. 
%       The cases n=0 and n=1..(N+2) are only broken up for ease
%       of indexing.


% Entry statement
disp('  bGenHC.m function          : [H_0(y_const), H_n(y_const)] - generate balanced y=const, merid H structure functions')

% Global declaration
global ep a

% initialize solution vector HCN to zeros
HCN = zeros(1,(N+2));

% Calculate b0Hat and y0Hat, which are the dimensionless versions
% of b0 and y0 respectively.
b0Hat = (ep^(1/4)/a)*b0;
y0Hat = (ep^(1/4)/a)*y0;

% Calculate constant-y-argument
constY = (2*y0Hat)/sqrt(4-b0Hat^4);

% Calculate Hn(constY) for n=0..(N+2)

% n = 0
% -----
HC0 = pi^(-1/4)*exp((-1/2)*constY^2);

% n = 1..(N+2)
% ------------
HCN = getH(constY,(N+1));        % The function getH(yVal,nVal) 
                                 % returns an array of Hn values
                                 % from n = 1..(nVal+1). Since here
                                 % nVal = (N+1), then the Hn returned
                                 % will be calculated for n values
                                 % n = 1..(N+2).

% END

