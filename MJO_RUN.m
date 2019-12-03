% MJO_RUN.m   - Main run script to orchestrate primitive and balanced simulations.
%
% AUTHOR:       Matt Masarik
% DATE:         October 21, 2019
% CALL SYNTAX:  MJO_RUN;
%
%
disp('                                                ')
disp('    ****************************************    ')
disp('    *                                      *    ')
disp('    *    MJO: Primitive/Balanced Models    *    ')
disp('    *                                      *    ')
disp('    ****************************************    ')
disp('                                                ')

clear;

% Add root directory and subdirs to search path
mjoDir   = pwd;
primPath = [mjoDir,'/','primitive'];
balPath  = [mjoDir,'/','balanced'];
libPath  = [mjoDir,'/','lib'];
outPath  = [mjoDir,'/','output'];
matPath  = [mjoDir,'/','matFiles'];
plotPath = [mjoDir,'/','plotting'];

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
addpath(mjoDir,primPath,balPath,libPath,outPath,matPath,plotPath);


% Prompt for which model: primitive or balanced
disp('Which model should be run?')
disp('        Primitive: 0')
disp('        Balanced:  1')
primitiveModel = input('Enter [0 or 1]: ');
balancedModel  = 1;              % init outside of 'if'
modelRunString = '';             % init outside of 'if'
modelSuite     = 1;              % never run full modelSuite, legacy var
if primitiveModel == 0
    balancedModel = 1;
    modelRunString = 'Primitive';
else
    balancedModel = 0;
    modelRunString = 'Balanced';
end

% Prompt for components if Primitive Model is run
waves = -1;  % value for balancedModel if primitiveModel != 0
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
  waves = input('Enter the wave ID number [0,1,2,3,4]: ');
  disp(' ')
end


% run selected model
startTimeString = getTimeString();
if primitiveModel == 0
    PRIMITIVE_CALL;
else
    BALANCED_CALL;
end
stopTimeString  = getTimeString();


writeStatus;
disp('                                                ')
disp('    ****************************************    ')
disp('    *                                      *    ')
disp('    *         End MJO Model Run            *    ')
disp('    *                                      *    ')
disp('    ****************************************    ')
disp('                                                ')
disp('                                                ')


% PLOTTING
disp(' ')
disp('   ********* PLOT MJO RUN RESULTS *********')

mjo_var_copy;
MJO_PLOT;

disp(' ')
disp('   ************* END PLOTTING *************')
disp(' ')

return
% END

