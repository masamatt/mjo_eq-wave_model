%
% plot_omegaM.m
% 
% PURPOSE: plot omegaM:=vertical pressure velocity contours.
%
omegaM_up   = zeros(Y_NUM,XI_NUM);
omegaM_down = zeros(Y_NUM,XI_NUM);

% partition up & down omegaM for plot formatting only
for xixi = 1:XI_NUM
    for yy = 1:Y_NUM
        if omegaM_var(yy,xixi) >= 0
            omegaM_down(yy,xixi) = omegaM_var(yy,xixi);
            omegaM_up(yy,xixi)   = NaN;
        else
            omegaM_down(yy,xixi) = NaN;
            omegaM_up(yy,xixi)   = omegaM_var(yy,xixi);
        end
    end
end

% Mixed Rossby-gravity wave for y0=0, response is zero.  The model in fact
% produces that result, though partitioning into omegaM_up/omegaM_down
% above (which is done solely to use different contour lineStyles for
% each), artificially introduces all NaNs for omegaM_down in this case.
% The assignment below corrects to the original result.
if (primitiveModel == 0) && (waves == 2) && (y0 == 0)
    omegaM_up   = zeros(Y_NUM,XI_NUM);
    omegaM_down = zeros(Y_NUM,XI_NUM);
end

% pressure level string
pOmegaMStr='';
if newPLevelOmegaMFlag == true
    pOmegaMStr=num2str(newPLevelOmegaMValue);
else
    pOmegaMStr=sprintf('%0.0f',pM);  % Z'(pM) = 1, max Zprime [default]
end

% peak values string
peakOmegaMStr='';
if displayPeakValues == true
    peakOmegaMDown = max(max(omegaM_down));
    peakOmegaMUp   = min(min(omegaM_up));
    downStr        = sprintf('%0.2f',peakOmegaMDown);
    upStr          = sprintf('%0.2f',peakOmegaMUp);
    peakOmegaMStr=['  [peak: $\omega_{up}$=',upStr,', $\omega_{down}$=',downStr,']'];
end

% PLOT
contourf(XI,Y,omegaM_down,'linestyle','-');
hold on
contourf(XI,Y,omegaM_up,'linestyle','--');
omegam_caxis_lims=caxis;
caxis([omegam_caxis_lims(1),omegam_caxis_lims(2)]);
colormap(gray_scale_map);
if displayColorBar == true
    cbh = colorbar;
    cbh.Label.String = '$\omega$ (hPa day$^{-1}$)';
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
label_plot(['vertical p-velocity(hPa day$^{-1}$) p=',pOmegaMStr,'hPa',peakOmegaMStr]);
hold off

%END
