%
% plot_omegaM.m
% 
% PURPOSE: plot omegaM:=vertical pressure velocity contours.
%

% colormap - gray scale
gray_scale_map = [255 255 255
                  239 239 239
                  219 219 219
                  194 194 194
                  170 170 170
                  142 142 142
                  113 113 113
                   77  77  77] / 255;

% mesh grids
[XI, Y]  = meshgrid(xiVec, yVec);


for xixi = 1:length(xiVec)
    for yy = 1:length(yVec)
        if omegaM(yy,xixi) >= 0
            omegaM_down(yy,xixi) = omegaM(yy,xixi);
            omegaM_up(yy,xixi)   = NaN;
        else
            omegaM_down(yy,xixi) = NaN;
            omegaM_up(yy,xixi)   = omegaM(yy,xixi);
        end
    end
end

contourf(XI,Y,omegaM_down,'linestyle','-');
hold on
contourf(XI,Y,omegaM_up,'linestyle','--');
colormap(gray_scale_map);
if overlayForcing == true
    plot_Q(XI,Y,Q);
end
hold off

%END
