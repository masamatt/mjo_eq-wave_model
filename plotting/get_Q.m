  function Q = get_Q(y,xi,Q0,a0,b0,y0)
            Y_VALS  = length(y);
            XI_VALS = length(xi);
            Q  = zeros(Y_VALS,XI_VALS);
            
            for i = 1:XI_VALS
                for j = 1:Y_VALS
                    if abs(xi(i)) <= a0
                        Q_merid = exp(-( (y(j)-y0)/b0 ).^2);
                        Q_zonal = (1 + cos((pi/a0)*xi(i)));
                        Q(j,i)  = (1/2) * Q0 * Q_merid * Q_zonal;
                    end
                end
            end
        end