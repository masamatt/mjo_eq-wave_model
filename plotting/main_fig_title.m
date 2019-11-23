%
% main_fig_title.m
%

% select model string
modelTitleStr='';
if primitiveModel == 0
    if waves == 0
        modelTitleStr='---------------------- PRIMITIVE[TOTAL] MODEL -----------------------';
    elseif waves == 1
        modelTitleStr='---------------------- PRIMITIVE[ROSSBY] MODEL ----------------------';
    elseif waves == 2
        modelTitleStr='--------------------- PRIMITIVE[MIXED-RG] MODEL ---------------------';
    elseif waves == 3
        modelTitleStr='---------------------- PRIMITIVE[GRAVITY] MODEL ---------------------';
    elseif waves == 4
        modelTitleStr='---------------------- PRIMITIVE[KELVIN] MODEL ----------------------';
    else
        disp('Bad model ID.');
        return
    end
elseif balancedModel == 0
    modelTitleStr='-------------------------- BALANCED MODEL ---------------------------';
else
    disp('Bad model ID.');
    return
end


% nums to strs
Q0_cp = (Q0 * 86400) / cp;          % Q0/cp K day^-1
Q0_cpStr=sprintf('%0.2f',Q0_cp);   
a0Str=sprintf('%d',a0/1000);
b0Str=sprintf('%d',b0/1000);
y0Str=sprintf('%d',y0/1000);
cStr=sprintf('%0.1f',c);
mMaxStr=sprintf('%d',mMax);
nMaxStr=sprintf('%d',nMax);

% concatenate string
mainTitleStr=['Q$_0$/c$_p$:',Q0_cpStr,'K day$^{-1}$',', a$_0$:',a0Str,'km'];
mainTitleStr=[mainTitleStr,', b$_0$:',b0Str,'km, y$_0$:',y0Str,'km'];
mainTitleStr=[mainTitleStr,', c:',cStr,'m s$^{-1}$',', M:',mMaxStr,', N:',nMaxStr];

% display text
text(0.5,1.17,modelTitleStr,'units','normalized','HorizontalAlignment','center',...
    'fontsize',8,'fontname','fixedwidth');
text(0,1.27,mainTitleStr,'interpreter','latex','units','normalized',...
    'fontsize',12,'fontname','fixedwidth');
