function EQ = calc_Equator(xiVec,yVec)
    %
    %
    %
    xi_num = length(xiVec);
    y_num  = length(yVec);
    EQ     = zeros(y_num,xi_num);
    
    for i = 1:xi_num
        for j = 1:y_num
            if yVec(j) == 0
                EQ(j,i) = 1;
            end
        end
    end
end
