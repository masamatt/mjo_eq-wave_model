  function QQ = calc_DiabForcing(xi,y,Q0,a0,b0,y0)
      %
      % calc_DiabForcing.m - calculate the diabatic forcing (Q)
      %
      Y_NUM  = length(y);
      XI_NUM = length(xi);
      QQ     = zeros(Y_NUM,XI_NUM);
      
      for i = 1:XI_NUM
          for j = 1:Y_NUM
              if abs(xi(i)) <= a0
                  Q_merid = exp(-( (y(j)-y0)/b0 ).^2);
                  Q_zonal = (1 + cos((pi/a0)*xi(i)));
                  QQ(j,i)  = (1/2) * Q0 * Q_merid * Q_zonal;
              end
          end
      end
  end