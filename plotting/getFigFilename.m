function figFileName = getFigFilename(waveNum,a0km,b0km,y0km)
%
% getFigFilename.m - returns a string for figure filename.
%
%     Ex. PKa1250b450y450_2019-11-24_100656
%  
%     where, P='P'rimitive, K='K'elvin, a=a0, b=b0, y=y0, yyyy-MM-dd_hhmmss
%

modelStr='';
if waveNum >= 0
    if waveNum == 0
        modelStr='P_';
    elseif waveNum == 1
        modelStr='PR';
    elseif waveNum == 2
        modelStr='PM';
    elseif waveNum == 3
        modelStr='PG';
    elseif waveNum == 4
        modelStr='PK';
    end
else
    modelStr='B_';
end

a0Str=['a',num2str(a0km)];
b0Str=['b',num2str(b0km)];
y0Str=['y',num2str(y0km)];

figFileName = [modelStr,a0Str,b0Str,y0Str,'_',getDateTimeString()];

end
