% MJO_SIM    - Main script to orchestrate primitive and balanced runs.
%
% FILE:         MJO_SIM.m
% AUTHOR:       Matt Masarik
% DATE:         October 21, 2019
% CALL SYNTAX:  MJO_SIM;
%
%

disp('                                                ')
disp('    ****************************************    ')
disp('    *                                      *    ')
disp('    *    MJO: Primitive/Balanced Models    *    ')
disp('    *                                      *    ')
disp('    ****************************************    ')
disp('                                                ')
disp('                                                ')
disp('                                                ')

clear;

% Add current working directory and subdirs to search path
disp('Adding paths to search path...')

currentDir = pwd;
subDir1  = '/primitive';
subDir2  = '/balanced';
subDir3  = '/lib';
subDir4  = '/output';
subDir5  = '/matFiles';
subDir6  = '/plotting';

primPath = [currentDir,subDir1];
balPath  = [currentDir,subDir2];
libPath  = [currentDir,subDir3];
outPath  = [currentDir,subDir4];
matPath  = [currentDir,subDir5];
plotPath = [currentDir,subDir6];


if exist('./matFiles') ~= 7     % 7 = directory
    mkdir matFiles;
else
    delete('./matFiles/*');
end
if exist('./output') ~= 7
    mkdir output;
else
    delete('./output/*');
end

addpath(currentDir,primPath,balPath,libPath,outPath,matPath,plotPath);

disp('Done adding paths.')
disp(' ')
disp(' ')


% Prompt for which model: primitive or balanced
disp('Which model should be run?')
disp('        Primitive: 0')
disp('        Balanced:  1')
primitiveModel = input('Enter [0 or 1]: ');
balancedModel  = 1;              % init outside of 'if'
modelRunString = '';             % init outside of 'if'
modelSuite     = 1;              % never run full modelSuite
if primitiveModel == 0
    balanceModel = 1;
    modelRunString = 'Primitive';
else
    balancedModel = 0;
    modelRunString = 'Balanced';
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


% save input parameters
outputType = 1;
save ./matFiles/type_input.mat      outputType
save ./matFiles/suite_input.mat     modelSuite
save ./matFiles/primitive_input.mat primitiveModel
save ./matFiles/balanced_input.mat  balancedModel


% Call selected model
startTimeString = getTimeString();
if primitiveModel == 0
    PRIMITIVE_CALL;
else
    BALANCED_CALL;
end
stopTimeString  = getTimeString();

% write file header -> title, date, time
RUNFILE = fopen('./output/runParameters.txt','w');
fprintf(RUNFILE,'\n                   MODEL RUN PARAMETERS\n');
fprintf(RUNFILE,'                   --------------------\n\n');
fprintf(RUNFILE,'Run Date:       %s\n',date);
fprintf(RUNFILE,'Model Run:      %s\n',modelRunString);
fprintf(RUNFILE,'Start Time:     %s\n',startTimeString);
fprintf(RUNFILE,'Stop Time:      %s\n',stopTimeString);
fclose(RUNFILE);

disp('                                                ')
disp('                                                ')
disp('                                                ')
disp('    ****************************************    ')
disp('    *                                      *    ')
disp('    *         End MJO Model Run            *    ')
disp('    *                                      *    ')
disp('    ****************************************    ')
disp('                                                ')
disp('                                                ')
disp(' ')
disp(' ')


disp('   ********* PLOT MJO RUN RESULTS *********')
disp(' ')

MJO_PLOT;

disp(' ')
disp('   *********** END MJO PLOTTING ***********')
disp(' ')
disp(' ')

return
% END

