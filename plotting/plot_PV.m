%
% plot_PV.m
% 
% PURPOSE: plot potential vorticity (PV) contours.
%



% mesh grids
[XIVEC, YVEC]  = meshgrid(xiVec, yVec);


for xixi = 1:length(xiVec)
    for yy = 1:length(yVec)
        if q(yy,xixi) >= 0
            q_cyclonic(yy,xixi) = q(yy,xixi);
            q_anticyclonic(yy,xixi) = NaN;
        else
            q_cyclonic(yy,xixi) = NaN;
            q_anticyclonic(yy,xixi) = q(yy,xixi);
        end
    end
end


contourf(XIVEC,YVEC,q_cyclonic,'linestyle','-');
hold on
colormap(gray_scale_map);
contourf(XIVEC,YVEC,q_anticyclonic,'linestyle','--');
if overlayForcing == true
    contour_DiabForcing(XIVEC,YVEC,Qdiab);
end
hold off
