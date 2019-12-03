% WRITESTATUS - writes the current values of the variable parameters.
% 
% FILE:        writeStatus.m
% AUTHOR:      Matt Masarik
% DATE:        August 27, 2006
% MODIFIED:    N/A
% CALL SYNTAX: writeStatus;
%
% PRE:         VARIABLE_DEFINITIONS.m has been called,
%              modelType = 0 or 1, has been defined.
% POST:        The values for the current run of some variables
%              of interest are appended to the file runParameters.txt
%              located in the directory ./output


% display writing message
disp('Writing run status           : output/runParameters.txt')

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


% corresponding output file name
if modelType == 0
  mName = 'prim';
else
  mName = 'bal';
  waves = -1;
end
outFileName = getOutFile(mName,p,y0,waves);

% % get output type file extension
% load ./matFiles/type_input.mat
% if outputType == 0
%   fileType = '.bin';
% else
%   fileType = '.txt';
% end
%
% % full output file name
% outFileString = ['Output File Name: ',outFileName,fileType];

% date / time strings
runDateString=['Run Date                      : ',date];
timeStartStr =['Start Time                    : ',startTimeString];
timeStopStr  =['Stop Time                     : ',stopTimeString];

% formatting space
space1 = '            ';

% write information
% -----------------
RUNFILE = fopen('./output/runParameters.txt','w');
fprintf(RUNFILE,'\n%s%s\n',space1,runDateString);
fprintf(RUNFILE,'%s%s\n',space1,timeStartStr);
fprintf(RUNFILE,'%s%s\n\n',space1,timeStopStr);
%%%fprintf(RUNFILE,'%s%s\n',space1,outFileString);
fprintf(RUNFILE,'%s%s\n',space1,modelString);
fprintf(RUNFILE,'%s%s\n',space1,Q0_cpString);
fprintf(RUNFILE,'%s%s\n',space1,a0String);
fprintf(RUNFILE,'%s%s\n',space1,b0String);
fprintf(RUNFILE,'%s%s\n',space1,y0String);
fprintf(RUNFILE,'%s%s\n',space1,cString);
fprintf(RUNFILE,'%s%s\n',space1,pString);
fprintf(RUNFILE,'%s%s\n',space1,zonalString);
fprintf(RUNFILE,'%s%s\n\n',space1,meridionalString);
fclose(RUNFILE);

% clear unneeded strings, temp variables
clear zonalString meridionalString a0String b0String y0String pString
clear cString space1 modelString outFileName outFileString
clear timeString runTimeString outputType fileType RUNFILE

% END

