function currDateStr = getDateString()
%
% getDateString - returns 'yyyy-mm-dd'
%
currentDate   = clock;
currYear      = currentDate(1);
currMonth     = currentDate(2);
currDay       = currentDate(3);

% year string
yearStr       = num2str(currYear);

% month string
monthStr      = '';
if currMonth <= 9
  monthStr    = ['0',num2str(currMonth)];
else
  monthStr    = num2str(currMonth);
end

% day string
dayStr        = '';
if currDay   <= 9
  dayStr      = ['0',num2str(currDay)];
else
  dayStr      = num2str(currDay);
end

% date string
currDateStr   = [yearStr,'-',monthStr,'-',dayStr];

end
