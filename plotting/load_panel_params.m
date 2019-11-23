%
%
% load_panel_params.m - parameters for panel plot size / location
%
%

% size parameters
yMax         = (yHatMax*a)/ep^(1/4);
xi_y_ratio   = xiMax/yMax;
padding_val  = 1;
sub_plot_num = 3;
pan_hgt      = 2;

% figure location / size
fig_lft      = 0;
fig_bot      = 0;
fig_wdh      = xi_y_ratio   * pan_hgt;
fig_hgt      = sub_plot_num * pan_hgt + padding_val;


