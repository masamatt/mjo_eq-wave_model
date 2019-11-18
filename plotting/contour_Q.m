function contour_Q(xiVec,yVec,QMat)
xi_y_ratio=length(xiVec)/length(yVec);
left_val=0;
bottom_val=0;
height_val=2;                       % y
width_val=xi_y_ratio * height_val;  % xi

padding_val=1;
sub_plot_num=3;
%%%tot_height_val=height_val * sub_plot_num + padding_val;
tot_height_val=height_val;



figure('Units','inches','Position',[ left_val bottom_val width_val tot_height_val ]);

[XI,Y] = meshgrid(xiVec,yVec);


hold on
contour(XI,Y,QMat,'LineStyle','--','LineColor','b','LineWidth',1, ...
    'LevelListMode','manual','LevelList',[0.25])
hold off



end