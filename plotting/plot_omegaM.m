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
        if omegaM(yy,xixi) >= 0
            omegaM_down(yy,xixi) = omegaM(yy,xixi);
            omegaM_up(yy,xixi)   = NaN;
        else
            omegaM_down(yy,xixi) = NaN;
            omegaM_up(yy,xixi)   = omegaM(yy,xixi);
        end
    end
end

% PLOT
contourf(XI,Y,omegaM_down,'linestyle','-');
hold on
contourf(XI,Y,omegaM_up,'linestyle','--');
colormap(gray_scale_map);
if displayColorBar == true
    colorbar;
end
if overlayEquator == true
    contour_Equator(XI,Y,EQ);
end
if overlayForcing == true
    contour_DiabForcing(XI,Y,Qdiab);
end
label_plot('vertical p-velocity (hPa day$^{-1}$) at p=395 hPa');
hold off

%END
