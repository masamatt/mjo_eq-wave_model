%
% plot_phi_u_v.m
%
% PURPOSE:  plot phi mass contours and (u,v) wind vectors.
%

contourf(XIVEC,YVEC,phi);
hold on
quiver(XIVEC,YVEC,u,v);
hold off

