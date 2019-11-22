%
% plotFields.m
%
% PURPOSE:  plot all field variables.
%

% declare plot variables
u_var      = 0;
v_var      = 0;
phi_var    = 0;
q_var      = 0;
omegaM_var = 0;
if applyNewPLevel == true
    p = newPLevel;
    apply_new_p_level;
else
    select_plot_vars;
end

% load plot parameters for formatting, colormaps, etc.
plot_panel_params;
plot_color_maps;


% coords
xi_Mm  = xiVec / 10^6;     % Mm = 10^6 m = 10^3 km
y_Mm   = yVec  / 10^6; 
XI_NUM = length(xi_Mm);
Y_NUM  = length(y_Mm);
[XI,Y] = meshgrid(xi_Mm, y_Mm);


% optional overlays
EQ = 0;
if overlayEquator == true
    EQ = calc_Equator(xiVec,yVec);
end

Qdiab=0;
if overlayForcing == true
    Qdiab = calc_DiabForcing(xiVec,yVec,Q0,a0,b0,y0);
end



figure('Units','inches','Position',[ left_val bottom_val width_val tot_height_val ]);

% TOP PANEL
subplot(3,1,1);
plot_PV;
main_fig_title;

% MIDDLE PANEL
subplot(3,1,2);
plot_phi_u_v;


% BOTTOM PANEL
subplot(3,1,3)
plot_omegaM;


%END
