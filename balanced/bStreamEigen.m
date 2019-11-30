function Sfield = bStreamEigen(STREAM,EIGEN,yHatVec,M,N)
% BSTREAMEIGEN - Computes "b"alanced model "Stream"function -
%                "Eigen"function(Rossby approximated) expansions.
%                This function will be used to expand the rotational
%                components of the horizontal wind field (u_psi,v_psi)
%                and the geopotential height field (phi). The output is a
%                2-D array, dependent on the integer zonal wavenumbers (m)
%                and the dimensionless meridional distance (yHat). 
%                Sfield = "S"treamfunction expanded "field"
%                Sfield = Sfield(yHatIndex,mIndex)
%                The "Streamfunction/Eigenfunction expansion" consists
%                of summing the product of the Rossby wave approximated
%                Eigenfunctions with the spectral space Streamfunction
%                over all n = 0..N. The Rossby approximated Eigenfunctions
%                contain script-H polynomial terms. The script-H 
%                polynomials are Hermite polynomials with an additional 
%                n-dependent coefficient. So these expansion can
%                essentially be seen as Hermite expansions.
%                EIGEN = EIGEN(yHatIndex,mIndex,nIndex) is a complex
%                        3-D array. [Umn(yHat), Vmn(yHat), PHImn(yHat)].
%                STREAM = STREAM(mIndex,nIndex) is a complex
%                         2-D array. [psi_mn]
%            
% FILE:        bStreamEigen.m
% AUTHOR:      Matt Masarik
% DATE:        August 9 2005
% MODIFIED:    N/A
%          
% CALL SYNTAX: Sfield = bStreamEigen(STREAM,EIGEN,yHatVec,M,N);
%                Sfield = Sfield(yHatIndex,mIndex) complex 2-D array
%                STREAM = STREAM(mIndex,nIndex) complex 2-D array
%                EIGEN = EIGEN(yHatIndex,mIndex,nIndex) complex 3-D array
%                yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                M = mMax, maximum zonal wavenumber
%                N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 2-D complex array is returned:
%                 Sfield = Sfield(yHatIndex,mIndex).
%       

% Entry statement
disp('bStreamEigen.m function')


% global declaration
global a

% local variables
ySize = length(yHatVec);   % yHat dimension
mSize = 2*M + 1;           % m dimension
nSize = N + 1;             % n dimension

% initialize complex solution array
tmpArray = zeros(ySize,mSize);
Sfield = complex(tmpArray,tmpArray);



%       Streamfunction/Eigenfunction Expansion
% ----------------------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    
    sumVar = 0;
    for jn = 1:nSize    % n loop
      sumVar = sumVar + (STREAM(im,jn)*EIGEN(yy,im,jn))/a;
    end    % end n loop
    Sfield(yy,im) = sumVar;
    
  end    % end m loop
end    % end yHat loop


% Exit statement
% disp('Exiting bStreamEigen.m function.')
% disp(' ')

% END

