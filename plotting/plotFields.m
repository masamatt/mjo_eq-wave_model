%
% plotFields.m
%
% PURPOSE:  plot all field variables.
%

% load plot parameters for formatting, etc.
plot_panel_params;


% if overlayEquator == true
%     Equator = get_EQ;
% end
Qdiab=0;
%y=0;
if overlayForcing == true
    y = (yHatVec*a) / ep^(1/4);
    Qdiab = calc_DiabForcing(xiVec,y,Q0,a0,b0,y0);
end



figure('Units','inches','Position',[ left_val bottom_val width_val tot_height_val ]);

% TOP PANEL
subplot(3,1,1);
plot_phi_u_v;

% MIDDLE PANEL
subplot(3,1,2);
plot_PV;

% BOTTOM PANEL
subplot(3,1,3)
plot_omegaM;

%END
