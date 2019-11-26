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


% zonal wave number
zonalString      = ['Maximum Zonal Wavenumber,    M: ',int2str(mMax)];

% meridional mode
meridionalString = ['Maximum Meridional Mode,     N: ',int2str(nMax)];

% phase speed of cloud cluster
cString          = ['Phase speed,                 c: ',num2str(c),' m/s'];

% zonal half-width of cloud cluster
a0String         = ['Zonal half-width,           a0: ',num2str(a0_km),' km'];

% meridional e-folding width of cloud cluster
b0String         = ['Meridional e-folding width, b0: ',num2str(b0_km),' km'];

% meridional displacement off equator of center of cloud cluster
y0String         = ['Meridional displacement,    y0: ',num2str(y0_km),' km'];

% diabatic heating rate for prescribed forcing
Q0_cpString      = ['Diabatic heating rate,   Q0/cp: ',sprintf('%0.2f',Q0_cp),' K/day'];

% pressure level (mb == hPa)
p_mb = p;
pString          = ['Pressure level,              p: ',num2str(p_mb),' hPa'];

% model type
if modelType == 0
  modelName = 'Simulation Type:  Primitive';
  
  % wave component
  if waves == 0
    waveType = 'Total';
  elseif waves == 1
    waveType = 'Rossby';
  elseif waves == 2
    waveType = 'Mixed';
  elseif waves == 3
    waveType = 'Gravity';
  else
    waveType = 'Kelvin';
  end
  
  modelString = [modelName,'[',waveType,']'];
  clear modelName waveType
    
else
  modelString = 'Simulation Type:           Balanced';
end
modelString=[modelString,' Model'];

% output format
load ./matFiles/type_input.mat
if outputType == 0
  outString = 'Output Format: Binary - float64';
else
  outString = 'Output Format: Formatted text (ascii)';
end

% display information
% -------------------
space1 = '                 ';
disp('                                                                 ');
disp('              ________________________________________________   ');
disp('             |                                                |  ');
disp('             |                RUN  PARAMETERS                 |  ');
disp('             |________________________________________________|  ');
disp(' ');
%%%disp([space1,outString]);
disp([space1,modelString]);
disp([space1,Q0_cpString]);
disp([space1,a0String]);
disp([space1,b0String]);
disp([space1,y0String]);
disp([space1,cString]);
disp([space1,pString]);
disp([space1,zonalString]);
disp([space1,meridionalString]);
disp('              ________________________________________________   ');
disp('             |                                                |  ');
disp('             |                                                |  ');
disp('             |________________________________________________|  ');
disp('                                                                 ');
disp('                                                                 ');

% clear unneeded strings, temp variables
clear zonalString meridionalString a0String b0String y0String pString Q0_cpString
clear cString space1 modelString outputType outString

% END

