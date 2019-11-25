function currDateTimeStr = getDateTimeString()
%
% getDateTimeString() - returns datetime string: yyyy-MM-dd_hhmmss
%

currDT      = clock;
currYr      = currDT(1);
currMon     = currDT(2);
currDy      = currDT(3);
currHr      = currDT(4);
currMin     = currDT(5);
currSec     = currDT(6);  

% year string
yrStr       = num2str(currYr);

% month string
monStr      = '';
if currMon <= 9
  monStr    = ['0',num2str(currMon)];
else
  monStr    = num2str(currMon);
end

% day string
dyStr       = '';
if currDy  <= 9
  dyStr     = ['0',num2str(currDy)];
else
  dyStr     = num2str(currDy);
end

% hour string
hrStr       = '';
if currHr  <= 9
    hrStr   = ['0',num2str(currHr)];
else
    hrStr   = num2str(currHr);
end

% minute string
minStr      = '';
if currMin <= 9
  minStr    = ['0',num2str(currMin)];
else
  minStr    = num2str(currMin);
end

% second string
currSec     = round(currSec);
secStr      = '';
if currSec <= 9
  secStr = ['0',num2str(currSec)];
else
  secStr = num2str(currSec);
end

% date/time string
currDateTimeStr=[yrStr,'-',monStr,'-',dyStr,'_',hrStr,minStr,secStr];

end