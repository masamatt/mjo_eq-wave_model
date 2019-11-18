%
% plot_phi_u_v.m
%
% PURPOSE:  plot phi mass contours and (u,v) wind vectors.
%

% *****************  U,V QUIVER PLOT PARAMETERS ***************** %
y_incr_val     = 5;
xi_incr_val    = y_incr_val * 4;

xi_skip_vec    = xiVec(1:xi_incr_val:length(xiVec));
y_skip_vec     = yVec(1:y_incr_val:length(yVec));
u_skip_vec     = u(1:y_incr_val:length(yVec), 1:xi_incr_val:length(xiVec));
v_skip_vec     = v(1:y_incr_val:length(yVec),1:xi_incr_val:length(xiVec));

[XISKIP,YSKIP] = meshgrid(xi_skip_vec, y_skip_vec);
% *************************************************************** %


% mesh grids
[XI,Y]         = meshgrid(xiVec, yVec);

contourf(XI,Y,phi);
hold on
if overlayForcing == true
    contour_DiabForcing(XI,Y,Qdiab);
end
quiver(XISKIP,YSKIP,u_skip_vec,v_skip_vec,'Color','black');
hold off
