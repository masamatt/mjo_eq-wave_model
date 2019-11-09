%
% plot_phi_u_v.m
%
% PURPOSE:  plot phi mass contours and (u,v) wind vectors.
%

y_incr_val=5;
xi_incr_val=y_incr_val * 4;

% skip points
xi_skip_vec = xiVec(1:xi_incr_val:length(xiVec));
y_skip_vec = yVec(1:y_incr_val:length(yVec));
u_skip_vec = u(1:y_incr_val:length(yVec), 1:xi_incr_val:length(xiVec));
v_skip_vec = v(1:y_incr_val:length(yVec),1:xi_incr_val:length(xiVec));
%phi_skip_vec = phi(1:xi_incr:length(xiVec), 1:y_incr:length(yVec));


% mesh grids
[XIVEC, YVEC]  = meshgrid(xiVec, yVec);
[XISKIP,YSKIP] = meshgrid(xi_skip_vec, y_skip_vec);

% for xixi = 1:length(xiVec)
%     for yy = 1:length(yVec)
%         uskip = 
%     end
% end

xi_y_ratio=length(xiVec)/length(yVec);
left_val=5;
bottom_val=5;
height_val=3;                       % y
width_val=xi_y_ratio * height_val;  % xi


%%%figure('Units','inches','Position', [left_val bottom_val width_val height_val]);
contourf(XIVEC,YVEC,phi);
hold on
quiver(XISKIP,YSKIP,u_skip_vec,v_skip_vec,'Color','black');
hold off
