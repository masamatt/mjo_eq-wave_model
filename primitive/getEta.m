function ETA = getEta(NU,Q,alfa,c,M,N)
% GETETA - Calculates the expansion coefficient eta.
%          Eta is the expansion coefficient used to expand the
%          solution vector Eta in terms of the Eigenfunctions
%          of vector Kmnr.
%             ---> take note.. this array is complex <---
%
% FILE:        getEta.m
% AUTHOR:      Matt Masarik
% DATE:        July 6 2005
% MODIFIED:    MM September 05 2005 -  n=-1..N  --> n=-1..(N+1)
%                                      This routine will actually
%                                      be used for the balanced 
%                                      model now as well, to 
%                                      calculate the PV. Because 
%                                      of this we need to have 
%                                      eta up to the value 
%                                      n = (N+1).
%
% CALL SYNTAX: Eta = getEta(NU,Q,alfa,c,M,N);
%              NU = NU(mIndex,nIndex,rIndex) 3-D array of frequencys,"nu"
%              Q = Q(mIndex,nIndex,rIndex) 3-D array of heating exp. coef.
%              alfa = "alpha" Raleigh friction/Newtonian cooling
%              c = propagation speed of cloud cluster
%              M = max m value, m=-M..M
%              N = max n value, n=-1..N
%
% PRE:         The following scripts/functions have been called:
%              CONSTANT_DEFINITIONS.m  -->  CONSTANT_DEFINITIONS
%              VARIABLE_DEFINITIONS.m  -->  VARIABLE_DEFINITIONS
% POST:        3-D array ETA = ETA(mIndex,nIndex,rIndex) is returned.
%              Error value of -9999 is returned when m,n,r values that
%              do not index a valid NU_mnr or Q_mnr are accessed.
%              The Eta array is calculated for n values n = -1..(N+1).
%               

% Entry statement
disp('  getEta.m function          : [eta_mnr] - calc primitive eigen expansion coeff')


% global declaration
global kappa a Omega

% local variables
R = 3;                % number of roots 
mSize = 2*M + 1;      % m dimension of Eta
n_1_Size = (N+2) + 1; % (n+1) dimension of Eta
rSize = R;            % r dimension of Eta

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

% initialize 3-D solution array as complex                            
tmpArray = zeros(mSize,n_1_Size,rSize);
ETA = complex(tmpArray,tmpArray);


% Compute Eta
for im = 1:mSize       % m loop
  for jn = 1:n_1_Size    % n loop
    for kr = 1:rSize       % r loop
      
      Q_mnr = Q(im,jn,kr);
      NU_mnr = NU(im,jn,kr);
      
      % Quality control. Make sure all pieces are index
      % correctly, and the error value (-9999) is not being
      % used in calculations.
      if (Q_mnr ~= -9999) & (NU_mnr ~= -9999)
        % calculate eta in pieces.. cosmetics.
        % num = "num"erator of eta
        num = kappa*Q_mnr;
        % den = "den"ominator of eta
        den = alfa + i*(2*Omega*NU_mnr - (c/a)*mVec(im));
        ETA(im,jn,kr) = num/den;
      elseif (Q_mnr == -9999) & (NU_mnr == -9999)
        % Error Case
        ETA(im,jn,kr) = -9999;
      else
        % Problem case
        disp(' ')
        disp('**** ERROR - ABORTING CALCULATION ****')
        disp(' ')
        return
      end
      
    end    % end r loop
  end    % end n loop
end    % end m loop


% Exit statement
% disp('Exiting getEta.m function.')
% disp(' ')

% END

