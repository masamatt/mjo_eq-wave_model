function contour_DiabForcing(XI,Y,Qdf)
%
%
% plot_Q.m - plot contours of Q (diabatic heating)
%
%

Qmax = max(max(Qdf));

contour(XI,Y,Qdf, ...
    'LineStyle',':','LineColor','k','LineWidth',1.75, ...
    'LevelListMode','manual','LevelList',[0.5*Qmax 0.0625*Qmax]);

end