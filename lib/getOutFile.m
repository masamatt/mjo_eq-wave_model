function fileName = getOutFile(modelName,pVal,y0Val,waveID);
% GETOUTFILE - Determines the name of the ouput file.
%              This function is used for the primitive model,
%              balanced model, and when extracting specific wave
%              components from the primitive model. In each
%              case a filename string is returned containing
%              information about the pressure level of the 
%              field variables, the offset distance of the
%              cloud cluster from the equator, the wave
%              components if the model is primitive, and
%              the model name.
%
% FILE:         getOutFile.m
% AUTHOR:       Matt Masarik
% DATE:         August 13 2005
% MODIFIED:     August 28 2006 - MM - does not return the file
%                                     extension any more.
% CALL SYNTAX:  fName = getOutFile(modelName,pVal,y0Val,waveID);
%                       fName = output file name (string)
%                       modelName = name of model (string)
%                       pVal = pressure level (int)
%                       y0Val = y0 offset (int)
%                       waveID = number ID for which wave
%                                components will be used.
%                                waveID      component
%                                ------      ---------
%                                  0             all
%                                  1           rossby
%                                  2           mixed
%                                  3           gravity
%                                  4           kelvin
%
% PRE: The following scripts have been called:
%               CONSTANT_DEFINITIONS.m
%               VARIABLE_DEFINITIONS.m
%
% POST: A string containing the output file name is returned.
%       The convention is as follows:
%       Ex.
%             prim_p010_y000_r
%         
%             prim = model name, could also be "bal"
%             p010 = "p"ressure, 3 digit pressure
%             y000 = "y"0 offset
%             r    = rossby component, could be blank if all
%                    components are used, or have the respective
%                    first letter for other components.
%

% entry statement
% disp('Entering getOutFile.m function...')


% initialize output file name string
fileName = '';

% y0Val is in meters, need in kilometers
y0_km = y0Val/1000;

% convert pVal and y0_km into strings
pString = int2str(pVal);
y0String = int2str(y0_km);

% find length of each string
pLength = length(pString);
y0Length = length(y0String);

% find length of modelName string
% prim = 4, bal = 3
modelLength = length(modelName);

% make sure pressure string has length 3, prepend "_p"
if pLength == 4
  pPart = ['_p',pString(2:4)];
else
  pPart = ['_p',pString];
end

% prepend "_y"
if y0Length >= 3
  y0Part = ['_y',y0String];
elseif y0Length == 2
  y0Part = ['_y0',y0String];
else
  y0Part = ['_y00',y0String];
end



% Primitive Model
% ---------------
if modelLength == 4

  % wave components
  %
  % waveID    =    0      1       2       3       4      
  % wavename  =  total  rossby  mixed  gravity  kelvin
  % char      =           r       m       g       k
  if waveID == 0
    % total solution, standard case
    fileName = [modelName,pPart,y0Part];
  elseif waveID == 1
    % rossby
    fileName = [modelName,pPart,y0Part,'_r'];
  elseif waveID == 2
    % mixed rossby-gravity
    fileName = [modelName,pPart,y0Part,'_m'];
  elseif waveID == 3
    % gravity
    fileName = [modelName,pPart,y0Part,'_g'];
  else
    % kelvin (waveID == 4)
    fileName = [modelName,pPart,y0Part,'_k'];
  end
  
% Balanced Model
% --------------
else
  fileName = [modelName,pPart,y0Part];
end


% Exit Statement
% disp('Exiting getOutFile.m function.')
% disp(' ')

% END

