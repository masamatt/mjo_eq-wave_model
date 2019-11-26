%
% plotFields.m
%
% PURPOSE:  plot all field variables.
%


% Coordinates
yVec   = (a/ep^(1/4))*yHatVec;
xi_Mm  = xiVec / 10^6;          % Mm = 10^6 m = 10^3 km
y_Mm   = yVec  / 10^6; 
XI_NUM = length(xi_Mm);
Y_NUM  = length(y_Mm);
[XI,Y] = meshgrid(xi_Mm, y_Mm);


% Potential Vorticity (q)
q_var          = 0;
if newPLevelPVFlag == true
    q_var      = qf_hor * structureZ(newPLevelPVValue);
else
    q_var      = qf;
end

% Zonal Wind (u), Meridional Wind (v), Geopotential (phi)
u_var          = 0;
v_var          = 0;
phi_var        = 0;
if newPLevelPVFlag == true
    u_var      = uf_hor   * structureZ(newPLevelUVPhiValue);
    v_var      = vf_hor   * structureZ(newPLevelUVPhiValue);
    phi_var    = phif_hor * structureZ(newPLevelUVPhiValue);
else
    u_var      = uf;
    v_var      = vf;
    phi_var    = phif;
end

% Vertical p-Velocity (omegaM)
omegaM_var     = 0;
if newPLevelOmegaMFlag == true
    omegaM_var = omegaMf_hor * structureZprime(newPLevelOmegaMValue);
else
    omegaM_var = omegaMf;
end


% Optional:  Equator (EQ) Overlay
EQ = 0;
if overlayEquator == true
    EQ = calc_Equator(xiVec,yVec);
end

% Optional:  Diabatic Forcing (Q) Overlay
Qdiab=0;
if overlayForcing == true
    Qdiab = calc_DiabForcing(xiVec,yVec,Q0,a0,b0,y0);
end




% CREATE FIGURE
load_panel_params;
figure('Units','inches','Position',[ fig_lft fig_bot fig_wdh fig_hgt ]);
load_color_maps;

    % PANEL 1
    subplot(3,1,1);
    plot_PV;
    main_fig_title;

    % PANEL 2
    subplot(3,1,2);
    plot_phi_u_v;


    % PANEL 3
    subplot(3,1,3)
    plot_omegaM;

% save hardcopy
if saveFigHardcopy == true
    save_current_fig;
end
    
%END
