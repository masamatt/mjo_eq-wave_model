function Equator = calc_Equator(xi,y)
    %
    %
    %
    xi_num  = length(xi);
    y_num   = length(y);
    Equator = zeros(y_num,xi_num);
    
    for i = 1:xi_num
        for j = 1:y_num
            if y(j) == 0
                Equator(j,i) = 1;
            end
        end
    end
end
