function GNfield = gravityNormalMode(ETA,EIGEN,yHatVec,M,N);
% GRAVITYNORMALMODE - "gravity" wave component "Normal" "Mode" expansion.
%                     This function computes the Gravity wave component
%                     only by doing a Normal Mode expansion of the field
%                     variables over only the Gravity wave modes 
%                     (n = 0 and r = 2; n = 1,2,3,.. and r = 1,2)
%                     The output is a 2-D array, dependent on the integer
%                     zonal wavenumbers (m) and the dimensionless 
%                     meridional distance (yHat). The normal mode 
%                     expansion consists of summing the product of the
%                     eigenfunction EIGENmnr(yHat) with the expansion
%                     coefficient ETAmnr, over the above specified
%                     Gravity wave modes.
%                     ETAmnr is a complex coefficient.
%                     Note: GNfield_m(yHat) = GNfield(yIndex,mIndex) 
%                     is complex.
%                     GNfield = "G"ravity "N"ormal Mode expanded "field",
%                     where field can be either u, v, phi, q, or w.
%
% FILE:        gravityNormalMode.m
% AUTHOR:      Matt Masarik
% DATE:        August 14 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: GNfield = gravityNormalMode(ETA,EIGEN,yHatVec,M,N);
%                GNfield = GNfield(yIndex,mIndex) complex 2-D array
%                ETA = ETA(mIndex,nIndex,rIndex) complex 3-D array
%                EIGEN = EIGEN(yIndex,mIndex,nIndex,rIndex) 4-D array
%                yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                M = mMax, maximum zonal wavenumber
%                N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 2-D complex array is returned:
%                 GNfield = GNfield(yHatIndex,mIndex).
%                 

% Entry statement
disp('Entering gravityNormalMode.m function...')


% size of yHat vector
ySize = length(yHatVec);

% local variables
R = 3;              % number of roots 
mSize = 2*M + 1;    % m dimension
nSize = N + 2;      % n dimension
rSize = R;          % r dimension

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

% initialize complex solution array
tmpArray = zeros(ySize,mSize);
GNfield = complex(tmpArray,tmpArray);


%         Normal Mode Expansion
% -------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    sumVar = 0;
    
    for jn = 1:nSize    % n loop
      for kr = 1:rSize    % r loop
        
        % n = 0
        % -----
        if nVec(jn) == 0
          % r = 2
          % -----
          if rVec(kr) == 2
            sumVar = sumVar + ETA(im,jn,kr)*EIGEN(yy,im,jn,kr);
          end
          
        % n = 1,2,3,..
        % ------------
        elseif nVec(jn) >= 1
          % r = 1,2
          % -------
          if (rVec(kr) == 1) | (rVec(kr) == 2)
            sumVar = sumVar + ETA(im,jn,kr)*EIGEN(yy,im,jn,kr);
          end
        end

      end    % end r loop
    end    % end n loop
    
    GNfield(yy,im) = sumVar;
  end    % end m loop
end    % end yHat loop


% Exit statement
disp('Exiting gravityNormalMode.m function.')
disp(' ')

% END

