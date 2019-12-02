function IFfield = IFourier(NF,yHatVec,xiVec,M)
% IFOURIER - computes "I"nverse "Fourier" Transformed fields u,v,phi,q,w.
%            This takes the 2-D array NF_m(yHat) = NF(yIndex,mIndex),
%            which was recovered from a normal mode expansion,
%            and does an inverse fourier transform.
%            (NF = "N"ormal Mode expanded "F"ield). The result,
%            IFfield = IFfield(yHatIndex,xiIndex) is a real 2-D array,
%            (IFfield = "I"nverse "F"ourier transformed "field")
%            and is a field (u,v,phi,q,w) dependent on the variables
%            yHat=dimensionless meridional distance, and
%            xi=zonal distance in the reference frame moving at speed (c).
%            Recall that NF is a complex 2-D array.
%
% FILE:        IFourier.m
% AUTHOR:      Matt Masarik
% DATE:        July 08 2005
% MODIFIED:    MM July 08 2005 - generalized: fourierU -> IFourier
%              MM July 11 2005 - switched ordering of solution array 
%                                indices: 
%                                IFfield(xiIndex,yHatIndex)
%                                -> IFfield(yHatIndex,xiIndex)
%              MM July 15 2005 - works for q,w as well as u,v,phi.
%                                no code modifications.. just comments.
%
% CALL SYNTAX: IFfield = IFourier(NF,yHatVec,xiVec,M);
%                IFfield = IFfield(yHatIndex,xiIndex) real 2-D array
%                NF = NF(yHatIndex,mIndex) complex 2-D array
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
disp('    IFourier.m function      : [m -> xi] inverse Fourier transform')


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
      sumVar = sumVar + NF(yy,im)*exp((1i*mVec(im)*xiVec(xx))/a);
    end
    
    IFfield(yy,xx) = real(sumVar);
  end    
end

% END

