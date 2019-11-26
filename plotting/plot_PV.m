%
% plot_PV.m
% 
% PURPOSE: plot potential vorticity (PV) contours.
%

q_mu           = q_var * 10^6;              % mu s^-1 = 10^-6 s^-1
q_cyclonic     = zeros(Y_NUM,XI_NUM);
q_anticyclonic = zeros(Y_NUM,XI_NUM);

for xixi = 1:XI_NUM
    for yy = 1:Y_NUM
        if q_mu(yy,xixi) >= 0
            q_cyclonic(yy,xixi) = q_mu(yy,xixi);
            q_anticyclonic(yy,xixi) = NaN;
        else
            q_cyclonic(yy,xixi) = NaN;
            q_anticyclonic(yy,xixi) = q_mu(yy,xixi);
        end
    end
end

% Kelvin wave PV is zero for all configurations.  The model in fact
% produces that result, though partitioning into q_cyclonic/q_anticyclonic 
% above (which is done solely to use different contour lineStyles for
% each), artificially introduces all NaNs for q_anticyclonic in this case.
% The assignment below corrects to the original result.
if (primitiveModel == 0) && (waves == 4)
    q_cyclonic     = zeros(Y_NUM,XI_NUM);
    q_anticyclonic = zeros(Y_NUM,XI_NUM);
end


% Mixed Rossby-gravity wave for y0=0, response is zero.  The model in fact
% produces that result, though partitioning into q_cyclonic/q_anticyclonic 
% above (which is done solely to use different contour lineStyles for
% each), artificially introduces all NaNs for q_anticyclonic in this case.
% The assignment below corrects to the original result.
if (primitiveModel == 0) && (waves == 2) && (y0 == 0)
    q_cyclonic     = zeros(Y_NUM,XI_NUM);
    q_anticyclonic = zeros(Y_NUM,XI_NUM);
end

% pressure level string
pPVStr='';
if newPLevelPVFlag == true
    pPVStr=num2str(newPLevelPVValue);
else
    pPVStr=num2str(p);
end

% peak value string
peakPVString='';
if displayPeakValues == true
    PVmax = max(max(q_cyclonic));
    PVmin = min(min(q_anticyclonic));
    PVmaxStr = sprintf('%0.2f',PVmax);
    PVminStr = sprintf('%0.2f',PVmin);
    peakPVString=[' [peak: q$_{+}$=',PVmaxStr,' q$_{-}$=',PVminStr,']'];
end

contourf(XI,Y,q_cyclonic,'linestyle','-');
hold on
contourf(XI,Y,q_anticyclonic,'linestyle','--');
q_caxis_lims=caxis;
caxis([q_caxis_lims(1),q_caxis_lims(2)]);
colormap(gray_scale_map);
if displayColorBar == true
    cbh = colorbar;
    cbh.Label.String = 'q (10$^{-6}$ s$^{-1}$)';
    cbh.Label.FontSize = 10;
    cbh.Label.FontName = 'FixedWidth';
    cbh.Label.Interpreter = 'latex';
end
if overlayEquator == true
    contour_Equator(XI,Y,EQ);
end
if overlayForcing == true
    contour_DiabForcing(XI,Y,Qdiab);
end
label_plot(['potential vorticity(10$^{-6}\,$ s$^{-1}$) anomaly p=',pPVStr,'hPa',peakPVString]);
hold off

% END
