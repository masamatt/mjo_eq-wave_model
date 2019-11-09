  function Q = get_Q(y,xi)
            Q0 = 1;
            y0 = 1000000;       % [m]
            b0 = 450000;  % [my
            a0 = 1000000; % [m]
             
            Y  = length(y);
            XI = length(xi);
            Q  = zeros(Y,XI);
            
            for i = 1:XI
                for j = 1:Y
                    if abs(xi(i)) <= a0
                        Q_merid = exp(-( (y(j)-y0)/b0 ).^2);
                        Q_zonal = (1 + cos((pi/a0)*xi(i)));
                        Q(j,i)  = (1/2) * Q0 * Q_merid * Q_zonal;
                    end
                end
            end
        end