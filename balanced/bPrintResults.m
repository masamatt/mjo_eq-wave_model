% BPRINTRESULTS - "b"alanced model "Print" the "Results" to .txt file.
%                 This script loads all 5 balanced field variables of
%                 interest and prints them to a single text file to
%                 be used for plotting in IDL.
%
% FILE:         bPrintResults.m
% AUTHOR:       Matt Masarik
% DATE:         August 12 2005
% MODIFIED:     MM August 22 2005 - field b_w -> b_omegaM
%               MM - August 26 2006 - Reads from directory
%                                     matFiles vs. output
%               MM - August 28 2006 - added option for output in
%                                     binary or formatted text (ascii)
% 
% CALL SYNTAX:  bPrintResults;
%
% PRE: The following files must exist in a directory
%      "matFiles" located in the parent directory "models":
%      field_b_u.mat
%      field_b_v.mat
%      field_b_phi.mat
%      field_b_omegaM.mat
%      field_b_q.mat
%      These files must contain the following variables,
%      respectively: 
%      b_u b_v b_phi b_omegaM b_q
%
% POST: A text output file is stored in the directory "output"
%       which contains the 5 balanced fields and xi and y
%       coordinates in the following format:
%       
%       Columns:     1    2    3    4     5        6       7
%       Fields:      y   xi   b_u  b_v  b_phi  b_omegaM   b_q
%

% Start statement
disp('bPrintResults.m script')

% load balanced u(yHat,xi)
disp('Loading balanced u field...')
load ./matFiles/field_b_u.mat

% load balanced v(yHat,xi)
disp('Loading balanced v field...')
load ./matFiles/field_b_v.mat

% load balanced phi(yHat,xi)
disp('Loading balanced phi field...')
load ./matFiles/field_b_phi.mat

% load balanced omegaM(yHat,xi)
disp('Loading balanced omegaM field...')
load ./matFiles/field_b_omegaM.mat

% load balanced q(yHat,xi)
disp('Loading balanced q field...')
load ./matFiles/field_b_q.mat

% get dimensional meridional distance (y) from dimensionless (yHat)
yVec = (a/ep^(1/4))*yHatVec;

% get sizes of xi and y vectors
ySize = length(yVec);
xSize = length(xiVec);

% initialize "T"otal array. T is composed of y,xi,u,v,phi,omegaM,q.
T = zeros(7,xSize*ySize);

% count variable will index the columns
count = 0;

%                assemble T
% ---------------------------------------------
% row 1: y
% row 2: xi
% row 3: b_u
% row 4: b_v
% row 5: b_phi
% row 6: b_omegaM
% row 7: b_q

% y variable outer loop, xi variable inner loop.
for yy = 1:ySize
  for xx = 1:xSize
    count = count + 1;
    
    T(:,count)=[yVec(yy); xiVec(xx); b_u(yy,xx); b_v(yy,xx); ...
                b_phi(yy,xx); b_omegaM(yy,xx); b_q(yy,xx)];
    
  end
end


% clear unneeded variables
%%%clear b_u b_v b_phi b_omegaM b_q

% delete unneeded "field_b" .mat files
%%%delete('./matFiles/field_b*.mat');

% get balanced output file name
mName = 'bal';
waves = 0;     % waves is arbitrary for balanced model
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

