function MNfield = mixedNormalMode(ETA,EIGEN,yHatVec,M,N)
% MIXEDNORMALMODE - "mixed" component "Normal" "Mode" expansion.
%                    This function computes the Mixed Rossby-Gravity wave
%                    component only by doing a Normal Mode expansion of
%                    the field variables over only the mixed R-G mode
%                    (n = 0 and r = 0).
%                    The output is a 2-D array, dependent on the integer
%                    zonal wavenumbers (m) and the dimensionless 
%                    meridional distance (yHat). The normal mode expansion
%                    consists of summing the product of the eigenfunction
%                    EIGENmnr(yHat) with the expansion coefficient ETAmnr,
%                    over the above specified mixed R-G mode.
%                    ETAmnr is a complex coefficient.
%                    Note: MNfield_m(yHat) = MNfield(yIndex,mIndex) 
%                    is complex.
%                    MNfield = "M"ixed R-G "N"ormal Mode expanded "field",
%                    where field can be either u, v, phi, q, or w.
%              
%
% FILE:        mixedNormalMode.m
% AUTHOR:      Matt Masarik
% DATE:        August 14 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: MNfield = mixedNormalMode(ETA,EIGEN,yHatVec,M,N);
%                MNfield = MNfield(yIndex,mIndex) complex 2-D array
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
%                 MNfield = MNfield(yHatIndex,mIndex).
%                 

% Entry statement
disp('    mixedNormalMode.m func   : [n=0,r=0] mixed component normal mode expansion')


% size of yHat vector
ySize = length(yHatVec);

% local variables
mSize = 2*M + 1;    % m dimension
nIndex = 2;         % This variable specifies what nIndex
                    % to use below. Recall we want to sum
                    % the Mixed R-G mode, so we only need 
                    % n = 0. Recall the nIndex is not the
                    % same as the value of n it access'.
                    %
                    % nIndex =   1  2  3  4  5  ... (N+2)
                    % nVec   = [-1  0  1  2  3  ...   N]
                    %
                    % Since for the Mixed R-G mode n = 0,
                    % you can see above the nIndex = 2.
rIndex = 1;         % There is only one r value for the
                    % the Mixed R-G mode, r = 0.
                    %
                    % rIndex =  1  2  3
                    % rVec   = [0  1  2]
                    % 
                    % So you can see above the rIndex we
                    % want to use is rIndex = 1.


% initialize complex solution array
tmpArray = zeros(ySize,mSize);
MNfield = complex(tmpArray,tmpArray);


%       Rossby Normal Mode Expansion
% ---------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    MNfield(yy,im) = ETA(im,nIndex,rIndex)*EIGEN(yy,im,nIndex,rIndex);
  end    % end m loop
end    % end yHat loop

% END

