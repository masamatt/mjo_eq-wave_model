function RNfield = rossbyNormalMode(ETA,EIGEN,yHatVec,M,N);
% ROSSBYNORMALMODE - "rossby" component "Normal" "Mode" expansion.
%                    This function computes the Rossby wave component only
%                    by doing a Normal Mode expansion of the field
%                    variables over only the rossby modes 
%                    (n = 1,2,3,.. and r = 0).
%                    The output is a 2-D array, dependent on the integer
%                    zonal wavenumbers (m) and the dimensionless 
%                    meridional distance (yHat). The normal mode expansion
%                    consists of summing the product of the eigenfunction
%                    EIGENmnr(yHat) with the expansion coefficient ETAmnr,
%                    over the above specified Rossby modes.
%                    ETAmnr is a complex coefficient.
%                    Note: RNfield_m(yHat) = RNfield(yIndex,mIndex) 
%                    is complex.
%                    RNfield = "R"ossby "N"ormal Mode expanded "field",
%                    where field can be either u, v, phi, q, or w.
%              
%
% FILE:        rossbyNormalMode.m
% AUTHOR:      Matt Masarik
% DATE:        August 11 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: RNfield = rossbyNormalMode(ETA,EIGEN,yHatVec,M,N);
%                RNfield = RNfield(yIndex,mIndex) complex 2-D array
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
%                 RNfield = RNfield(yHatIndex,mIndex).
%                 

% Entry statement
disp('    rossbyNormalMode.m func  : [n>0,r=0] Rossby component normal mode expansion')


% size of yHat vector
ySize = length(yHatVec);

% local variables
mSize = 2*M + 1;    % m dimension
nSize = N + 2;      % n dimension
nIndexStart = 3;    % This variable specifies what n-Index
                    % to start with in the n loop. Recall
                    % we only want to sum the Rossby modes,
                    % so we only need n = 1,2,3,..
                    % Recall the nIndex is not the same as
                    % the value of n it access'.
                    %
                    % nIndex =   1  2  3  4  5  ... (N+2)
                    % nVec   = [-1  0  1  2  3  ...   N]
                    %
                    % Since for we the Rossby modes start
                    % with n = 1, you can see above we start
                    % the nIndices with nIndex = 3.
rIndex = 1;         % There is only one r value for the
                    % the Rossby modes, r = 0.
                    %
                    % rIndex =  1  2  3
                    % rVec   = [0  1  2]
                    % 
                    % So you can see above the r-Index we
                    % want to use is rIndex = 1.


% initialize complex solution array
tmpArray = zeros(ySize,mSize);
RNfield = complex(tmpArray,tmpArray);


%       Rossby Normal Mode Expansion
% ---------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    sumVar = 0;

    for jn = nIndexStart:nSize    % n loop
      ETA_mnr = ETA(im,jn,rIndex);
      sumVar = sumVar + ETA_mnr*EIGEN(yy,im,jn,rIndex);
    end    % end n loop

    RNfield(yy,im) = sumVar;
  end    % end m loop
end    % end yHat loop


% Exit statement
% disp('Exiting rossbyNormalMode.m function.')
% disp(' ')

% END

