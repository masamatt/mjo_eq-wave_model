%
% plot_q.m
% 
% PURPOSE: plot q:=potential vorticity, contours.
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

xi_y_ratio=length(xiVec)/length(yVec);
left_val=5;
bottom_val=5;
height_val=3;                       % y
width_val=xi_y_ratio * height_val;  % xi

%%%figure('Units','inches','Position', [left_val bottom_val width_val height_val]);
contourf(XIVEC,YVEC,q_cyclonic,'linestyle','-');
hold on
contourf(XIVEC,YVEC,q_anticyclonic,'linestyle','--');
colormap(gray_scale_map);
hold off

%END
