% MJO_PLOT    - Main script to plot all output fields.
%
% FILE:         MJO_PLOT.m
% AUTHOR:       Matt Masarik
% DATE:         October 22, 2019
% CALL SYNTAX:  MJO_PLOT;
%
%

% ***************** PLOT PARAMETERS ******************************** %
overlayEquator    = false;
overlayForcing    = false;
displayColorBar   = true;
displayPeakValues = true;
applyNewPLevel    = false;
newPLevel         = p;
% ****************************************************************** %

% the call
plotFields;


% END
