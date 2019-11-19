function contour_Equator(XI,Y,Equator)
    %
    % contour_Equator.m - overlay equator line on plot.
    %
    contour(XI,Y,Equator, ...
        'LineStyle',':','LineColor','k', ...
        'LineWidth',0.5);

end