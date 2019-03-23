% STATUS - Displays the current values of the variable parameters.
% 
% FILE:        STATUS.m
% AUTHOR:      Matt Masarik
% DATE:        July 2 2005
% MODIFIED:    August 28 2006 - MM - added output type:
%                                    binary or formatted text (ascii)
% CALL SYNTAX: STATUS;
%
% PRE:         VARIABLE_DEFINITIONS.m has been called.
% POST:        The values for the current run of some variables
%              of interest are displayed.

% compose strings
% ---------------

% zonal wave number
zonalString = ['Maximum Zonal Wavenumber, M: ',int2str(mMax)];

% meridional mode
meridionalString = ['Maximum Meridional Mode, N: ',int2str(nMax)];

% phase speed of cloud cluster
cString = ['Phase speed, c = ',num2str(c),' m/s.'];

% zonal half-width of cloud cluster
a0_km = a0/1000;    % a0 expressed in kilometers
a0String = ['Zonal half-width, a0 = ',num2str(a0_km),' km.'];

% meridional e-folding width of cloud cluster
b0_km = b0/1000;
b0String = ['Meridional e-folding width, b0 = ',num2str(b0_km),' km.'];

% meridional displacement off equator of center of cloud cluster
y0_km = y0/1000;
y0String = ['Meridional displacement, y0 = ',num2str(y0_km),' km.'];

% pressure level
p_mb = p;
pString = ['Pressure level, p = ',num2str(p_mb),' mb.'];

% model type
if modelType == 0
  modelName = 'Model Type: Primitive - ';
  
  % wave component
  if waves == 0
    waveType = 'Total wave solution';
  elseif waves == 1
    waveType = 'Rossby wave';
  elseif waves == 2
    waveType = 'Mixed wave';
  elseif waves == 3
    waveType = 'Gravity wave';
  else
    waveType = 'Kelvin wave';
  end
  
  modelString = [modelName,waveType];
  clear modelName waveType
    
else
  modelString = 'Model Type: Balanced';
end

% output format
load ./matFiles/type_input.mat
if outputType == 0
  outString = 'Output Format: Binary - float64';
else
  outString = 'Output Format: Formatted text (ascii)';
end

% display information
% -------------------
space1 = '            ';
disp('                                                             ')
disp('        _____________________________________________        ')
disp('       |                                             |       ')
disp('       |         CURRENT PARAMETER STATUS            |       ')
disp('       |_____________________________________________|       ')
disp([space1,outString]);
disp([space1,modelString]);
disp([space1,zonalString]);
disp([space1,meridionalString]);
disp([space1,cString]);
disp([space1,a0String]);
disp([space1,b0String]);
disp([space1,y0String]);
disp([space1,pString]);
disp('        _____________________________________________        ')
disp('       |                                             |       ')
disp('       |            END PARAMETER STATUS             |       ')
disp('       |_____________________________________________|       ')
disp('                                                             ')
disp('                                                             ')

% clear unneeded strings, temp variables
clear a0_km b0_km y0_km p_mb
clear zonalString meridionalString a0String b0String y0String pString
clear cString space1 modelType modelString outputType outString

% END

