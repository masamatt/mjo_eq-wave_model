function contour_DiabForcing(XI_MAT,Y_MAT,Q_MAT)
%
%
% plot_Q.m - plot contours of Q (diabatic heating)
%
%

Qmax = max(max(Q_MAT));

contour(XI_MAT,Y_MAT,Q_MAT, ...
    'LineStyle',':','LineColor','k', ...
    'LineWidth',1.75,'LevelListMode','manual', ...
    'LevelList',[0.5*Qmax 0.0625*Qmax]);

end