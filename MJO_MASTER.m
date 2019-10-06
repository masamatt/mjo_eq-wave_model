% MJO_MASTER - Root script to orchestrate primitive and balanced runs.
%              This script adds the necessary directories to the
%              search path. It then prompts the user for which
%              models to run. If primitive is one, it prompts for
%              the wave components to be included. It then makes
%              the appropriate call(s) to the start up script(s)
%              for the selected model(s). 
%
% FILE:         MJO_MASTER.m
% AUTHOR:       Matt Masarik
% DATE:         August 14 2005
% MODIFIED:     August 25, 2006 - MM - option to run Model suite added.
%               August 27, 2006 - MM - runParameters.txt added
%                                    - auto-exit option added
%               August 28, 2006 - MM - binary output option added
%
% CALL SYNTAX:  MJO_MASTER;
%
% PRE:  None
%
% POST: The wave ID variable (waves) that identifies which 
%       wave components will be used if the primitive model
%       is called, is defined. However, if the model suite
%       is called, the wave ID variable will not be defined
%       here because it will iterate through all possible values
%       in SUITE_CALL.m.  Search path is modified to contain
%       all necessary directories. 
%

% Big entry statement
disp('                                                ')
disp('    ****************************************    ')
disp('    *                                      *    ')
disp('    *    MJO: Primitive/Balanced Models    *    ')
disp('    *                                      *    ')
disp('    ****************************************    ')
disp('                                                ')
disp('                                                ')
disp('                                                ')


% Warn about output files
disp('                 * WARNING *                           ')
disp('                   -------                             ')
disp('You are about to start the execution of new model runs.')
disp('All files from previous runs contained in the directory ')
disp('./output will be deleted if you proceed.  Would you like')
disp('to exit at this time so you can move previous output files')
disp('to a new directory?')
stopNow = input('Enter Yes or No (Yes = 0, No = 1): ');
disp(' ')
disp(' ')
if stopNow == 0
  clear
  disp('Exiting to allow user to move files from ./output')
  disp(' ')
  disp(' ')
  return
end
clear stopNow


% Add current working directory and subdirs to search path
disp('Adding paths to search path...')

currentDir = pwd;
subDir1 = '/primitive';
subDir2 = '/balanced';
subDir3 = '/lib';
subDir4 = '/output';
subDir5 = '/matFiles';

primPath = [currentDir,subDir1];
balPath = [currentDir,subDir2];
libPath = [currentDir,subDir3];
outPath = [currentDir,subDir4];
matPath = [currentDir,subDir5];

addpath(currentDir,primPath,balPath,libPath,outPath,matPath);

clear currentDir subDir1 subDir2 subDir3 subDir4 subDir5
clear primPath balPath libPath outPath matPath

disp('Done adding paths.')
disp(' ')
disp(' ')
disp(' ')


% Prompt for total model suite run
disp('Would you like to run the total modeling suite?')
disp(' ')
disp('i.e. - ')
disp('       * Primitive model is run.')
disp('         Note - All wave components are run unless')
disp('         y0 = 0 (symmetric forcing about the equator).')
disp('         In this case the mixed-rossby gravity wave')
disp('         response is identically zero, so it is not run.')
disp(' ')
disp('       * Balanced model is run.')
disp(' ')
disp('       * If you only want to run the Primitive or')
disp('         Balanced model, and/or you just want to run')
disp('         a specific wave component of the Primitive')
disp('         model, answer "No" here.')
disp(' ')
modelSuite = input('Enter Yes or No (Yes = 0, No = 1): ');
disp(' ')



% Prompt for Primitive Model run if model suite is NOT run
if modelSuite == 1
  disp('Would you like to run the Primitive Model?')
  primitiveModel = input('Enter Yes or No (Yes = 0, No = 1): ');
  disp(' ')
else
  primitiveModel = 1;
end  


% Prompt for components if Primitive Model is run
if primitiveModel == 0
  disp('                                                        ')
  disp('Choose from the wave components for the Primitive Model.')
  disp('                                                        ')
  disp('      Wave Components   Wave ID                         ')
  disp('      ---------------   -------                         ')
  disp('           All waves  =   0                             ')
  disp('         Rossby wave  =   1                             ')
  disp('          Mixed wave  =   2                             ')
  disp('        Gravity wave  =   3                             ')
  disp('         Kelvin wave  =   4                             ')
  disp('                                                        ')
  waves = input('Enter the wave ID number (0,1,2,3,4): ');
  disp(' ')
end


% Prompt for Balanced Model run if model suite is NOT run
if modelSuite == 1
  disp('Would you like to run the Balanced Model?')
  balancedModel = input('Enter Yes or No (Yes = 0, No = 1): ');
  disp(' ')
else
  balancedModel = 1;
end



% Do a few formalities if at least 1 model is going to be run.
% (1) Delete old output and mat files
% (2) Prompt for 'formatted' (ascii, text) or binary output
% (3) Prompt for auto-exit after run
% (4) Save user input to .mat files to be loaded later
% (5) Start runParameters.txt file
% 
if modelSuite == 0 | primitiveModel == 0 | balancedModel == 0
  % delete all files left in ./matFiles directory
  delete('./matFiles/*');
  
  % delete all files left in ./output directory
  delete('./output/*');
  
  % prompt for binary or formatted text output
  disp('Would you like the output files to be in binary ')
  disp('or formatted text (ascii)?')
  outputType = input('Enter binary or text (binary = 0, text = 1): ');
  disp(' ')
  save ./matFiles/type_input.mat outputType
  
  % prompt for auto-exit and save
  disp('Would you like matlab to exit automatically ')
  disp('once all runs have completed?')
  disp('NOTE: All output will be saved in the directory ./output')
  autoExit = input('Enter Yes or No (Yes = 0, No = 1): ');
  save ./matFiles/autoExit_input.mat autoExit
  clear autoExit
  
  % save other user input
  save ./matFiles/suite_input.mat modelSuite
  save ./matFiles/primitive_input.mat primitiveModel
  save ./matFiles/balanced_input.mat balancedModel

  % get start time  
  startTimeString = getTimeString();
  
  % get models run
  if modelSuite == 0
    modelRunString = 'Model Suite';
  else
    if primitiveModel == 0 & balancedModel == 0
      modelRunString = 'Primitive, Balanced';
    elseif primitiveModel == 0
      modelRunString = 'Primitive';
    else
      modelRunString = 'Balanced';
    end
  end
  
  % get output format
  if outputType == 0
    outputTypeString = 'Binary - float64';
  else
    outputTypeString = 'Formatted text (ascii)';
  end
  
  % write file header -> title, date, time
  RUNFILE = fopen('./output/runParameters.txt','w');
  fprintf(RUNFILE,'\n                   MODEL RUN PARAMETERS\n');
  fprintf(RUNFILE,'                   --------------------\n\n');
  fprintf(RUNFILE,'Run Date:       %s\n',date);
  fprintf(RUNFILE,'Start Time:     %s\n',startTimeString);
  fprintf(RUNFILE,'Models Run:     %s\n',modelRunString);
  fprintf(RUNFILE,'Output Format:  %s\n\n',outputTypeString);
  fclose(RUNFILE);
  
  % clear unnecessary variables
  clear startTimeString modelRunString outputType outputTypeString RUNFILE
end

% If selected, make call to Model Suite root script
if modelSuite == 0
  SUITE_CALL;
  loadFlag = 0;
elseif primitiveModel == 0 | balancedModel == 0
  % If selected, make call to Primitive Model root script
  if primitiveModel == 0
    PRIMITIVE_CALL;
    loadFlag = 0;
  end
  % If selected, make call to Balanced Model root script
  if balancedModel == 0
    % clear all variables from possible primitive run
    clear
    BALANCED_CALL;
    loadFlag = 0;
  end
else
  % no models run, set load flag = 1
  loadFlag = 1;
end

% if loadFlag == 0, load user input, then remove "input" .mat files
if loadFlag == 0
  load ./matFiles/suite_input.mat
  load ./matFiles/primitive_input.mat
  load ./matFiles/balanced_input.mat
  load ./matFiles/autoExit_input.mat
  delete('./matFiles/*input.mat');
else
  % no models run, set autoExit = 1
  autoExit = 1;
end

% If at least 1 model was run, finish runParameters.txt file
if modelSuite == 0 | primitiveModel == 0 | balancedModel == 0
  % get stop time
  stopTimeString = getTimeString();

  RUNFILE = fopen('./output/runParameters.txt','a');
  fprintf(RUNFILE,'\n\nStop Time: %s\n',stopTimeString);
  fclose(RUNFILE);
end

% End of all runs - clear all variables, 
%                   display End of runs banner,
%                   and exit if specified
if autoExit == 0
  % clear remaining variables
  %%%clear
  
  % Big end statement
  disp('                                                ')
  disp('                                                ')
  disp('                                                ')
  disp('    ****************************************    ')
  disp('    *                                      *    ')
  disp('    *         End MJO Model Runs           *    ')
  disp('    *                                      *    ')
  disp('    ****************************************    ')
  disp('                                                ')
  disp('                                                ')
  
  % auto-exit
  disp('All output has been saved in directory ./output')
  disp('Remember to move files from the ./output directory ')
  disp('before performing another run, or they will be deleted.')
  disp('Matlab will exit in 10 seconds...')
  disp(' ')
  pause(10);
else
  % clear remaining variables
  %%%clear
  
  % Big end statement
  disp('                                                ')
  disp('                                                ')
  disp('                                                ')
  disp('    ****************************************    ')
  disp('    *                                      *    ')
  disp('    *         End MJO Model Runs           *    ')
  disp('    *                                      *    ')
  disp('    ****************************************    ')
  disp('                                                ')
  disp('                                                ')
  
  disp('All output has been saved in directory ./output')
  disp('Remember to move files from the ./output directory ')
  disp('before performing another run, or they will be deleted.')
  disp(' ')
  disp(' ')
  
  % no exit, return control to main window
  return
end

% auto-exit chosen, exit matlab.
exit


% END

