function w = getStructurew(NU,PHI,yHatVec,M,N)
% GETSTRUCTUREW - function to compute w_mnr(yHat).
%                 w_mnr(yHat) does not appear in the paper as
%                 a defined quantity. It is defined here for
%                 coding convienence, and can be thought of
%                 as analogous to the eigenfunctions. 
%                 This function returns a 4-D array: 
%                 w_mnr(yHat) = w(yHatIndex,mIndex,nIndex,rIndex).
%                 This array ( w_mnr(yHat) ) is used in the 
%                 normal mode expansion of w_m(yHat), which is the
%                 fourier transformed "vertical log-pressure velocity"
%                 field dependent on zonal wavenumber (m) and meridional
%                 distance (yHat). As mentioned above, w_mnr(yHat) is
%                 analogous to the eigenfunctions [ Umnr(yHat), 
%                 Vmnr(yHat), PHImnr(yHat) used in the normal mode
%                 expansion of u,v,phi respectively ], for the normal 
%                 mode expansion of the fourier transformed vertical
%                 log-pressure velocity field. Since w_mnr(yHat) is not
%                 actually an eigenfunction, the name of this function
%                 to compute it has the word "Structure"
%                 instead of "Eigen". 
%                 getStructurew = "get" expansion "Structure" function
%                                  of "w" field.
%                 This array w_mnr(yHat) can then be used in the 
%                 general function normalMode.m, the output of which
%                 can then be used in IFourier.m, as was done for the 
%                 u,v,phi fields.
%
% FILE:        getStructurew.m
% AUTHOR:      Matt Masarik
% DATE:        July 15, 2005
% MODIFIED:    MM August 25 2005 - dry air gas constant R -> Rd
%                                  R was overloaded by the dry air
%                                  gas constant and the number of 
%                                  roots.. This was a bug.
%                                  So now:
%                                          R = number of roots, 3
%                                          Rd = dry air gas constant
%              MM August 06 2008 - removed call to internal matlab
%                 'pack'.  In current versions of matlab, pack can
%                 only be called from the command line.
%    
%
% CALL SYNTAX: w = getStructurew(NU,PHI,yHatVec,M,N);
%                  w = w(yHatIndex,mIndex,nIndex,rIndex)
%                  NU = NU(mIndex,nIndex,rIndex) dimensionless frequency
%                  PHI = PHI(yHatIndex,mIndex,nIndex,rIndex)
%                  yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                  M = mMax, maximum zonal wavenumber
%                  N = nMax, maximum meridional Mode
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 4-D array is returned.
%                 w = w(yHatIndex,mIndex,nIndex,rIndex).
%                 If a cell corresponds to an invalid
%                 eigenfunction (ex. y,m,n=-1,r=1), the cell
%                 will be given an error value of -9999.
%

% Entry statement
disp('    getStructurew.m function : [w(yHat)mnr] - expansion w structure')


% global declaration
global Omega Rd Gmma

% local variables
R = 3;                   % number of roots 
ySize = length(yHatVec); % yHat dimension
mSize = 2*M + 1;         % m dimension
nSize = N + 2;           % n dimension
rSize = R;               % r dimension

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

% initialize 4-D complex solution array
tmpArray = zeros(ySize,mSize,nSize,rSize);
w = complex(tmpArray,tmpArray);

% save space, get rid of tmpArray
clear tmpArray



%                 Compute w
% -----------------------------------------

% iConstant = "i"maginary "Constant"; used in loop, so just compute once.
iConstant = i*((2*Omega)/(Rd*Gmma));


for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    for jn = 1:nSize    % n loop
      for kr = 1:rSize    % r loop
        
        
        % n = 0 and r = 1
        % ---------------
        if (nVec(jn) == 0) && (rVec(kr) == 1)
          w(yy,im,jn,kr) = -9999;
          
        % n = -1 and r = 0,1
        % ------------------
        elseif (nVec(jn) == -1) && (rVec(kr) ~= 2)
          w(yy,im,jn,kr) = -9999;
          
        % all other n,r
        % -------------
        else
          w(yy,im,jn,kr) = iConstant*NU(im,jn,kr)*PHI(yy,im,jn,kr);
          
        end
        
        
      end    % end r loop
    end    % end n loop
  end    % end m loop
end    % end yHat loop
  

% Exit statement
% disp('Exiting getStructurew.m function.')
% disp(' ')

% END

