%
% main_fig_title.m
%


Q0_cp = (Q0 * 86400) / cp;          % Q0 K day^-1
Q0_cpStr=sprintf('%0.2f',Q0_cp);   
a0Str=sprintf('%d',a0/1000);
b0Str=sprintf('%d',b0/1000);
y0Str=sprintf('%d',y0/1000);
cStr=sprintf('%0.1f',c);
mMaxStr=sprintf('%d',mMax);
nMaxStr=sprintf('%d',nMax);

mainTitleStr=['$\frac{Q_0}{c_p}$: ',Q0_cpStr,'K day$^{-1}$'];
mainTitleStr=[mainTitleStr,', a$_0$: ',a0Str,'km, b$_0$: ',b0Str,'km, y$_0$: ',y0Str,'km'];
mainTitleStr=[mainTitleStr,', c: ',cStr,'m s$^{-1}$',', M: ',mMaxStr,', N: ',nMaxStr];
text(-0.07,1.25,mainTitleStr,'interpreter','latex','units','normalized',...
    'fontsize',12,'fontweight','bold','fontname','fixedwidth');
