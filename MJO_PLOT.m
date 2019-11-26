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
overlayEquator        = false;     %                 [default, false]
overlayForcing        = false;     %                 [default, false]
displayColorBar       = true;      %                 [default,  true]
displayPeakValues     = true;      %                 [default,  true]

saveFigHardcopy       = false;     %                 [default, false]
saveFigType           = 'pdf';     % pdf, eps, png   [default,   pdf]


% [PANEL 1]:  POTENTIAL VORTICITY
% ===============================
newPLevelPVFlag       = false;     %                 [default, false]
newPLevelPVValue      = 500;       % hPa


% [PANEL 2]:  U V PHI PLOT
% ========================
newPLevelUVPhiFlag    = false;     %                 [default, false]
newPLevelUVPhiValue   = 500;       % hPa

vectorDensityStride   = 5;         % (integer)       [default,     5]
vectorScaleFactor     = 0.9;       % (float)         [default,   0.9]


% [PANEL 3]:  OMEGAM
% ==================
newPLevelOmegaMFlag    = false;    %                 [default, false]
newPLevelOmegaMValue   = 500;      % hPa
% *********************** END PARAMETERS *************************** %



% the call
plotFields;


% END
