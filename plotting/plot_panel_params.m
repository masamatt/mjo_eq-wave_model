%
%
% plot_panel_params.m - parameters for panel plot formatting, etc.
%
%

% sizes
xi_y_ratio=xiMax/yMax;
left_val=0;
bottom_val=0;
height_val=2;                       % y
width_val=xi_y_ratio * height_val;  % xi

padding_val=1;
sub_plot_num=3;
tot_height_val=height_val * sub_plot_num + padding_val;
%%%tot_height_val=height_val;


% color maps
% colormap - gray scale
gray_scale_map = [255 255 255
                  239 239 239
                  219 219 219
                  194 194 194
                  170 170 170
                  142 142 142
                  113 113 113
                   77  77  77] / 255;

