%
% save_current_fig.m - save fig to ./output folder.
%

% check output dir
if exist('./output') ~= 7
    mkdir output;
end

% file name for fig
figfname=getFigFilename(waves,a0_km,b0_km,y0_km);
figfname=['output/',figfname];


% saveFigType:  'eps' or 'png'
if strcmp(saveFigType,'eps')
    print(figfname,'-depsc'); % '-tiff'
    disp(['Current figure saved: ',figfname,'.eps']);
elseif strcmp(saveFigType,'png')
    set(gcf,'PaperPositionMode','auto');
    print(figfname,'-dpng','-r0');
    disp(['Current figure saved: ',figfname,'.png']);
else
    disp(['Bad figure export type [eps,png]: ',saveFigType,'.']);
end

