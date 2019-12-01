function Nfield = normalMode(ETA,EIGEN,yHatVec,M,N)
% NORMALMODE - Computes "normal" "Mode" expansion of u,v,phi,q,w fields.
%              This function computes any of the single components of the 
%              "eta_m(yHat)" vector: Um(yHat),Vm(yHat),PHIm(yHat).
%              In addition, this function also computes the PV field,
%              qm(yHat) and the vertical velocity field, wm(yHat).
%              The output is a 2-D array, dependent on the integer
%              zonal wavenumbers (m) and the dimensionless meridional
%              distance (yHat). The normal mode expansion consists of 
%              summing the product of the eigenfunction EIGENmnr(yHat)
%              with the expansion coefficient ETAmnr, over all meridional
%              modes (sum over n and r). In the case of q (the PV field),
%              the "expansion structure function" q_mnr(yHat) is 
%              analogous to the eigenfunctions used for the other
%              expansions. The same is true for the w expansion. We
%              will call w_mnr(yHat) (even though there is no such thing
%              defined in the paper, it will be defined here for coding
%              simplicity) the "expansion structure function" for the
%              vertical velocity field. So when the array EIGEN is used 
%              it refers to the u,v,phi eigenfunctions as well as the
%              q and w structure functions. 
%              ETAmnr is a complex coefficient.
%              Note: Nfield_m(yHat) = Nfield(yIndex,mIndex) is complex.
%              Nfield = "N"ormal Mode expanded "field", where 
%              field can be either u, v, phi, q, or w.
%
% FILE:        normalMode.m
% AUTHOR:      Matt Masarik
% DATE:        July 07 2005
% MODIFIED:    MM July 08 2005 - generalized: normalModeU -> normalMode
%              MM July 15 2005 - also works for q,w fields.. no code
%                                modifications, just comments.
%
% CALL SYNTAX: Nfield = normalMode(ETA,EIGEN,yHatVec,M,N);
%                Nfield = Nfield(yIndex,mIndex) complex 2-D array
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
%                 Nfield = Nfield(yHatIndex,mIndex).
%                 

% Entry statement
disp('    normalMode.m function    : [n,r] normal mode expansion')


% size of yHat vector
ySize = length(yHatVec);

% local variables
R = 3;              % number of roots 
mSize = 2*M + 1;    % m dimension
nSize = N + 2;      % n dimension
rSize = R;          % r dimension

% initialize complex solution array
tmpArray = zeros(ySize,mSize);
Nfield = complex(tmpArray,tmpArray);


%         Normal Mode Expansion
% -------------------------------------
for yy = 1:ySize    % yHat loop
  for im = 1:mSize    % m loop
    sumVar = 0;
    
    for jn = 1:nSize    % n loop
      for kr = 1:rSize    % r loop

        ETA_mnr = ETA(im,jn,kr);
        if ETA_mnr ~= -9999
          sumVar = sumVar + ETA_mnr*EIGEN(yy,im,jn,kr);
        end
        
      end    % end r loop
    end    % end n loop
    
    Nfield(yy,im) = sumVar;
  end    % end m loop
end    % end yHat loop


% Exit statement
% disp('Exiting normalMode.m function.')
% disp(' ')

% END

