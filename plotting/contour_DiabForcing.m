function contour_DiabForcing(XI,Y,Q_field,Q_levs)
%
%
% plot_Q.m - plot contours of Q_fields (diabatic heating), specified
%            by vector Q_levs.
%

% Qmax = max(max(Q_field));
% Q_levs = [0.5*Qmax 0.0625*Qmax];



contour(XI,Y,Q_field, ...
    'LineStyle',':','LineColor','k','LineWidth',1.75, ...
    'LevelListMode','manual','LevelList',Q_levs);

end