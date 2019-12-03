function IFfield = bIFourier(HF,yHatVec,xiVec,M)
% BIFOURIER - Computes "b"alanced "I"nverse "Fourier" Transformed fields.
%             This takes the 2-D array HF_m(yHat) = HF(yIndex,mIndex),
%             which was recovered from a Inverse Hermite Transform,
%             and does an inverse fourier transform.
%             (HF = "H"ermite expanded "F"ield). The result,
%             IFfield = IFfield(yHatIndex,xiIndex) is a real 2-D array,
%             (IFfield = "I"nverse "F"ourier transformed "field")
%             and is a field (u_psi,v_psi,phi,q,psi,w) dependent on
%             the variables: yHat = dimensionless meridional distance,
%             and xi = zonal distance in the reference frame moving 
%             at speed c. Recall that HF is a complex 2-D array.
%             There really is no mechanical difference between this
%             function and the function IFourier.m used in the primitive
%             model. Some language/comments were changed..
%             The input variable NF = "N"ormal mode expanded "F"ield 
%             in IFourier.m, is HF = "H"ermite expanded "F"ield field
%             here. Note that this also takes fields that were
%             "Streamfunction/Eigenfunction expanded fields". As
%             discussed in the module bStreamEigen.m, that expansion
%             is essentially a Hermite expansion. 
%             
%
% FILE:        bIFourier.m
% AUTHOR:      Matt Masarik
% DATE:        July 21 2005
% MODIFIED:    N/A
%
% CALL SYNTAX: IFfield = bIFourier(HF,yHatVec,xiVec,M);
%                IFfield = IFfield(yHatIndex,xiIndex) real 2-D array
%                HF = HF(yHatIndex,mIndex) complex 2-D array
%                yHatVec = -yHatMax..yHatMax, 1-D array yHat of values
%                xiVec = -xiMax..xiMax, 1-D array xi values
%                M = mMax, maximum zonal wavenumber
%
%              
% PRE: The following scripts have been called:
%                 CONSTANT_DEFINITIONS.m
%                 VARIABLE_DEFINITIONS.m
% POST: A 2-D real array is returned:
%                 IFfield = IFfield(yHatIndex,xiIndex).
%                 

% Entry statement
disp('  bIFourier.m function       : [m -> xi] b inverse Fourier transform')


% global declaration
global a

% size of xi, yHat, m vectors
xSize = length(xiVec);
ySize = length(yHatVec);
mSize = 2*M + 1;

% initialize m vector
mVec = [-M:1:M];            % mVec is a 1-D array of m values
                            % mVec(1) = -M
                            % mVec(M+1) = 0
                            % mVec(2M+1) = M
                            
% initialize solution array
IFfield = zeros(ySize,xSize);



%         Inverse Fourier Transform
% -------------------------------------------
for yy = 1:ySize    % yHat loop
  for xx = 1:xSize    % xi loop
    sumVar = 0;
    
    for im = 1:mSize    % m loop
      sumVar = sumVar + HF(yy,im)*exp((1i*mVec(im)*xiVec(xx))/a);
    end
    
    IFfield(yy,xx) = real(sumVar);
  end    
end

% END

