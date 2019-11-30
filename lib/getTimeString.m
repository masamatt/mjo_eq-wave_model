function currentTimeString = getTimeString()
% GETTIMESTRING - gets the current time from the clock command
%                 and returns it as a string in the format
%                 hh:mm:ss.
%
% FILE:         getTimeString.m
% AUTHOR:       Matt Masarik
% DATE:         August 27, 2006
% MODIFIED:     N/A
% CALL SYNTAX:  currentTimeString = getTimeString();
%               
% PRE: N/A
% POST: A string containing the current time is returned.
%       The format is as follows:
%                       
%       hh:mm:ss
%
%       where,  h = hour
%               m = minute
%               s = second
%

% entry statement
%%%disp('Entering getTimeString.m function...')


% get hour, min, sec from clock command
currentTime = clock;
currentHour = currentTime(4);
currentMin = currentTime(5);
currentSec = currentTime(6);  

% get hour string
if currentHour <= 9
    hourString = ['0',num2str(currentHour)];
else
    hourString = num2str(currentHour);
end

% get min string
if currentMin <= 9
  minString = ['0',num2str(currentMin)];
else
  minString = num2str(currentMin);
end

% get sec string
currentSec = round(currentSec);
if currentSec <= 9
  secString = ['0',num2str(currentSec)];
else
  secString = num2str(currentSec);
end

% time string
currentTimeString = [hourString,':',minString,':',secString];


% Exit Statement
%%%disp('Exiting getTimeString.m function.')
%%%disp(' ')

% END

