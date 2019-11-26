% MJO_PLOT.m    - Main plot script with user available parameters.
%
% AUTHOR:       Matt Masarik
% DATE:         October 22, 2019
% CALL SYNTAX:  MJO_PLOT;
%
%


% ***************** USER PLOT PARAMETERS *************************** %
% GENERAL
% =======
overlayEquator        = false;
overlayForcing        = false;
displayColorBar       = true;
displayPeakValues     = true;

saveFigHardcopy       = false;
saveFigType           = 'pdf';    % pdf, eps, png


% [PANEL 1]:  POTENTIAL VORTICITY
% ===============================
newPLevelPVFlag       = false;
newPLevelPVValue      = 500;      % hPa


% [PANEL 2]:  U V PHI PLOT
% ========================
newPLevelUVPhiFlag    = false;
newPLevelUVPhiValue   = 500;      % hPa

vectorDensityStride   = 5;       % [integer, default=5]
vectorScaleFactor     = 0.9;     % [float, default=0.9]


% [PANEL 3]:  OMEGAM
% ==================
newPLevelOmegaMFlag    = false;
newPLevelOmegaMValue   = 500;      % hPa
% *********************** END PARAMETERS *************************** %



% the call
plotFields;


% END
