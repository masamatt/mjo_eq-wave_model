function KNfield = kelvinNormalMode(ETA,EIGEN,yHatVec,M,N)
% KELVINNORMALMODE - "kelvin" component "Normal" "Mode" expansion.
%                    This function computes the Kelvin wave component only
%                    by doing a Normal Mode expansion of the field
%                    variables over only the kelvin mode
%                    (n = -1 and r = 2).
%                    The output is a 2-D array, dependent on the integer
%                    zonal wavenumbers (m) and the dimensionless 
%                    meridional distance (yHat). The normal mode expansion
%                    consists of summing the product of the eigenfunction
%                    EIGENmnr(yHat) with the expansion coefficient ETAmnr,
%                    over the above specified Kelvin mode.
%                    ETAmnr is a complex coefficient.
%                    Note: KNfield_m(yHat) = KNfield(yIndex,mIndex) 
%                    is complex.
%                    KNfield = "K"elvin "N"ormal Mode expanded "field",
%                    where field can be either u, v, phi, q, or w.
%              
%
% FILE:        kelvinNormalMode.m
% AUTHOR:      Matt Masarik
% DATE:        August 14 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: KNfield = kelvinNormalMode(ETA,EIGEN,yHatVec,M,N);
%                KNfield = KNfield(yIndex,mIndex) complex 2-D array
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
%                 KNfield = KNfield(yHatIndex,mIndex).
%                 

% Entry statement
disp('  kelvinNormalMode.m func    : [n=-1,r=2 -> yHat] - Kelvin component normal mode expansion')


% size of yHat vector
ySize = length(yHatVec);

% local variables
mSize = 2*M + 1;    % m dimension
nIndex = 1;         % This variable specifies what nIndex
                    % to use below. Recall we want to sum
                    % the Kelvin mode, so we only need 
                    % n = -1. Recall the nIndex is not the
                    % same as the value of n it access'.
                    %
                    % nIndex =   1  2  3  4  5  ... (N+2)
                    % nVec   = [-1  0  1  2  3  ...   N]
                    %
                    % Since for the Kelvin mode n = -1,
                    % you can see above the nIndex = 1.
rIndex = 3;         % There is only one r value for the
                    % the Kelvin mode, r = 2.
                    %
                    % rIndex =  1  2  3
                    % rVec   = [0  1  2]
                    % 
                    % So you can see above the rIndex we
                    % want to use is rIndex = 3.


% initialize complex solution array
tmpArray = zeros(ySize,mSize);
KNfield = complex(tmpArray,tmpArray);


%       Rossby Normal Mode Expansion
% ---------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    KNfield(yy,im) = ETA(im,nIndex,rIndex)*EIGEN(yy,im,nIndex,rIndex);
  end    % end m loop
end    % end yHat loop

% END

