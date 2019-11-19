  function Qdiabatic = calc_DiabForcing(xi,y,Q0,a0,b0,y0)
      %
      % calc_DiabForcing.m - calculate the diabatic forcing (Q)
      %
      y_num     = length(y);
      xi_num    = length(xi);
      Qdiabatic = zeros(y_num,xi_num);
      
      for i = 1:xi_num
          for j = 1:y_num
              if abs(xi(i)) <= a0
                  Q_merid = exp(-( (y(j)-y0)/b0 ).^2);
                  Q_zonal = (1 + cos((pi/a0)*xi(i)));
                  Qdiabatic(j,i)  = (1/2) * Q0 * Q_merid * Q_zonal;
              end
          end
      end
  end