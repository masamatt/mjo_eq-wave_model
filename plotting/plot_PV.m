%
% plot_PV.m
% 
% PURPOSE: plot potential vorticity (PV) contours.
%

% colormap - gray scale
% gray_scale_map = [255 255 255
%                   239 239 239
%                   219 219 219
%                   194 194 194
%                   170 170 170
%                   142 142 142
%                   113 113 113
%                    77  77  77] / 255;

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
    plot_Q(XIVEC,YVEC,Q);
end
hold off
