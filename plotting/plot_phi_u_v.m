%
% plot_phi_u_v.m
%
% PURPOSE:  plot phi mass contours and (u,v) wind vectors.
%

% *****************  U,V QUIVER DENSITY PLOT PARAMETERS **************** %
ySkip          = vectorDensityStride;
xiSkip         = ySkip * round(XI_NUM/Y_NUM);

xiSkipVec      = xi_Mm(1:xiSkip:XI_NUM);
ySkipVec       = y_Mm(1:ySkip:Y_NUM);
[XISKIP,YSKIP] = meshgrid(xiSkipVec, ySkipVec);

USKIP          = u_var(1:ySkip:Y_NUM, 1:xiSkip:XI_NUM);
VSKIP          = v_var(1:ySkip:Y_NUM, 1:xiSkip:XI_NUM);
% ********************************************************************** %

% convert geopotential (phi, [m^2 s^-2]) to geopotential height (PHI, [m])
gravity_const = 9.81;  % [m s^-2]
PHI = phi_var / gravity_const;

% pressure level string
pUVPhiStr='';
if newPLevelUVPhiFlag == true
    pUVPhiStr=num2str(newPLevelUVPhiValue);
else
    pUVPhiStr=num2str(p);
end

% peak values string
peakWindHeightStr='';
if displayPeakValues == true
    maxHeight        = max(max(PHI));
    minHeight        = min(min(PHI));
    heightStr        = '';
    if abs(maxHeight) >= abs(minHeight)
        heightStr        = sprintf('%0.2f',maxHeight);
    else
        heightStr        = sprintf('%0.2f',minHeight);
    end
    windSpeed        = sqrt(u_var.^2 + v_var.^2);
    peakWind         = max(max(windSpeed)); 
    windStr          = sprintf('%0.2f',peakWind);
    peakWindHeightStr=['  [peak: $|V|$=',windStr,', $\Delta$z=',heightStr,']'];
end

%  PLOT
contourf(XI,Y,PHI);
hold on
uvphi_caxis_lims=caxis;
caxis([uvphi_caxis_lims(1),uvphi_caxis_lims(2)]);
colormap(gray_scale_map);
if displayColorBar == true
    cbh = colorbar;
    cbh.Label.String = '$\Delta$z (m)';
    cbh.Label.FontSize = 10;
    cbh.Label.FontName = 'FixedWidth';
    cbh.Label.Interpreter = 'latex';
end
if overlayEquator == true
    contour_Equator(XI,Y,EQ);
end
if overlayForcing == true
    contour_DiabForcing(XI,Y,Qdiab,forcingContourLevs);
end
quiver(XISKIP,YSKIP,USKIP,VSKIP,'Color','black','AutoScale','on', ...
    'AutoScaleFactor',vectorScaleFactor);
label_plot(['wind(m s$^{-1}$) height(m) anomaly p=',pUVPhiStr,'hPa',peakWindHeightStr]);
hold off
