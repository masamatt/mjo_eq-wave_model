% PRINTRESULTS - "print"s the "Results" from .mat files to a .txt file.
%                This script loads all 5 field variables of
%                interest and prints them to a single text file to
%                be used for plotting in IDL. Then deletes .mat files.
%
% FILE:         printResults.m
% AUTHOR:       Matt Masarik
% DATE:         August 12 2005
% MODIFIED:     MM August 21 2005 - field w -> omegaM
%               MM August 25 2006 - deletes *.mat files at end
%                                   Reads from directory, 
%                                   matFiles vs. output
%               MM August 28 2006 - added option for output in
%                                   binary or formatted text (ascii)
%
% CALL SYNTAX:  printResults;
%
% PRE: The following files must exist in a directory
%      "matFiles" located within the current working directory:
%      field_u.mat
%      field_v.mat
%      field_phi.mat
%      field_omegaM.mat
%      field_q.mat
%      These files must contain the following variables,
%      respectively: 
%      u v phi omegaM q
%
% POST: A text output file is stored in the directory "output"
%       and contains the 5 fields and xi and y
%       coordinates in the following format:
%       
%       Columns:     1    2    3    4    5      6     7
%       Fields:      y   xi    u    v   phi  omegaM   q
%

% Start statement
disp('printResults.m script')

% load u(yHat,xi)
disp('Loading u field...')
load ./matFiles/field_u.mat

% load v(yHat,xi)
disp('Loading v field...')
load ./matFiles/field_v.mat

% load phi(yHat,xi)
disp('Loading phi field...')
load ./matFiles/field_phi.mat

% load omegaM(yHat,xi)
disp('Loading omegaM field...')
load ./matFiles/field_omegaM.mat

% load q(yHat,xi)
disp('Loading q field...')
load ./matFiles/field_q.mat


% get dimensional meridional distance (y) from dimensionless (yHat)
yVec = (a/ep^(1/4))*yHatVec;

% get sizes of xi and y vectors
ySize = length(yVec);
xSize = length(xiVec);

% %%% save:  yVec
% disp('Saving y coordinate in file: ./matFiles/coord_y.mat')
% save ./matFiles/coord_y.mat yVec

% %%% save:  xiVec
% disp('Saving xi coordinate in file: ./matFiles/coord_xi.mat')
% save ./matFiles/coord_xi.mat xiVec


% initialize "T"otal array. T is composed of y,xi,u,v,phi,omegaM,q.
T = zeros(7,xSize*ySize);

% count variable will index the columns
count = 0;

%                assemble T
% ---------------------------------------------
% row 1: y
% row 2: xi
% row 3: u
% row 4: v
% row 5: phi
% row 6: omegaM
% row 7: q

% y variable outer loop, xi variable inner loop.
for yy = 1:ySize
  for xx = 1:xSize
    count = count + 1;
    
    T(:,count)=[yVec(yy); xiVec(xx); u(yy,xx); v(yy,xx); ...
                phi(yy,xx); omegaM(yy,xx); q(yy,xx)];
    
  end
end

% %%%  *****************************   save:  u v phi omegaM q
% % clear unneeded variables
% clear u v phi omegaM q
% 
% % delete unneeded "field" .mat files, still need "out" .mat files
% delete('./matFiles/field*.mat');

% get primitive output file name
mName = 'prim';
outFile = getOutFile(mName,p,y0,waves);

% get output type file extension
load ./matFiles/type_input.mat
if outputType == 0
  fileType = '.bin';
else
  fileType = '.txt';
end

% full output file name
outFilePath = ['./output/',outFile,fileType];


%             print T
% -------------------------------------------------
if outputType == 0
  % binary
  disp('Writing output in binary...')
  fid = fopen(outFilePath,'w');
  fwrite(fid,T,'float64');
  fclose(fid);
else
  % formatted text (ascii)
  disp('Writing output in formatted text...')
  fid = fopen(outFilePath,'w');
  fprintf(fid,'%18.8f %18.8f %18.14f %18.14f %18.14f %18.14f %18.14f\n',T);
  fclose(fid);
end
disp('Finished writing output.')

% END

