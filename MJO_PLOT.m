% MJO_PLOT    - Main script to plot all output fields.
%
% FILE:         MJO_PLOT.m
% AUTHOR:       Matt Masarik
% DATE:         October 22, 2019
% CALL SYNTAX:  MJO_PLOT;
%
%

% ***************** PLOT PARAMETERS ******************************** %
overlayEquator = false;
overlayForcing = true;
% ****************************************************************** %

yMax = (yHatMax*a) / ep^(1/4);


plotFields;
