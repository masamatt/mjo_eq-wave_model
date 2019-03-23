function NU = getNu(m,n,r);
% GETNU - Calculates and returns nu(scalar,dimensionless frequency).
%         For valid values of indicies m,n,r, a valid value for nu
%         is returned. Otherwise, an error value: -9999 is returned.
%         (function) 
% 
% FILE:        getNu.m
% AUTHOR:      Matt Masarik
% DATE:        June 08 2006
% MODIFIED:    N/A
% CALL SYNTAX: NU = getNu(m,n,r);
%              m = -M..M, integer (dimensionless zonal wavenumber)
%              n = -1..(N+1), integer (dimensionless meridional mode)
%              r =  0,1,2, integer (root of dispersion relation)
% PRE:         CONSTANT_DEFINITIONS.m has been called.
% POST:        nu(m,n,r) has been returned.
%              

% Calculation of nu is divided into major blocks: m = 1..M,
% m = -1..-M, and m = 0. Of interest are the different roots (r)
% for specific n. These correspond to frequencys of certain 
% wave types.  A complication arises because for gravity waves,
% and the mixed rossby-gravity wave, the roots "switch" at 
% m = 0. Currently, by chosen convention, the classification
% of roots for the m > 0 is also used for the m = 0 case. 
%
% There are 4 different modes corresponding to different n,r.
% Kelvin Mode: n = -1, r = 2
% Rossby Mode: n = 1,2,3,...  r = 0
% Mixed Rossby-Gravity Mode: n = 0, r = 0
% Gravity Mode:  (1)  n = 0, r = 2
%                (2)  n = 1,2,3,...  r = 1 (west), 2 (east)


% global constants
global ep

% local variables
nu = -9999;
dif = 1;   % dif = difference variable for fixed-point iteration
tol = 1e-5;  % tolerance (error in fixed point iteration)
termI = m^2 + ep^(1/2)*(2*n+1);  % convenience, a common term
termII = m^2/(4*ep) + ep^(-1/2); % another common term


% m = 1..M
% --------
if m > 0
  
  if n > 0
    
    if r == 0      
      % ** Rossby mode **
      nu0 = -m / termI;
      while dif >= tol
        nu = (-m + ep*nu0^3) / termI;
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    elseif r == 1  
      % ** Westward Inertia-Gravity mode **
      nu0 = -ep^(-1/2)*sqrt(termI);
      while dif >= tol
        nu = -ep^(-1/2)*sqrt(termI + m/nu0);
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    elseif r == 2  
      % ** Eastward Inertia-Gravity mode **
      nu0 = ep^(-1/2)*sqrt(termI);
      while dif >= tol
        nu = ep^(-1/2)*sqrt(termI + m/nu0);
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    else           
      % ++ error case ++ --> -9999 is returned.
    end
    
  elseif n == 0
    
    if r == 0      
      % ** Mixed Rossby-Gravity mode **
      nu = m/(2*ep^(1/2)) - sqrt(termII);
      
    elseif r == 2
      % ** Eastward Gravity mode **
      nu = m/(2*ep^(1/2)) + sqrt(termII);
      
    else
      % ++ error case ++ --> -9999 is returned.
    end
    
  elseif n == -1
    
    if r == 2
      % ** Kelvin mode **
      nu = m*ep^(-1/2);
      
    else
      % ++ error case ++ --> -9999 is returned.
    end
    
  else
    % ++ error case ++ --> -9999 is returned.
  end
  
% m = -1..-M
% ----------
elseif m < 0
   
  if n > 0
    
    if r == 0      
      % ** Rossby mode **
      nu0 = -m / termI;
      while dif >= tol
        nu = (-m + ep*nu0^3) / termI;
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    elseif r == 1  
      % ** Westward Inertia-Gravity mode **
      nu0 = ep^(-1/2)*sqrt(termI);
      while dif >= tol
        nu = ep^(-1/2)*sqrt(termI + m/nu0);
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    elseif r == 2  
      % ** Eastward Inertia-Gravity mode **
      nu0 = -ep^(-1/2)*sqrt(termI);
      while dif >= tol
        nu = -ep^(-1/2)*sqrt(termI + m/nu0);
        dif = abs(nu-nu0);
        nu0 = nu;
      end
      
    else           
      % ++ error case ++ --> -9999 is returned.
    end
    
  elseif n == 0
    
    if r == 0      
      % ** Mixed Rossby-Gravity mode **
      nu = m/(2*ep^(1/2)) + sqrt(termII);
      
    elseif r == 2
      % ** Eastward Gravity mode **
      nu = m/(2*ep^(1/2)) - sqrt(termII);
      
    else
      % ++ error case ** --> -9999 is returned.
    end
    
  elseif n == -1
    
    if r == 2
      % ** Kelvin mode **
      nu = m*ep^(-1/2);
      
    else
      % ++ error case ++ --> -9999 is returned.
    end
    
  else
    % ++ error case ++ --> -9999 is returned.
  end
  
% m = 0
% -----
elseif m == 0
   
  if n > 0
    
    if r == 0      
      % ** Rossby mode **
      nu = 0;
      
    elseif r == 1  
      % ** Westward Inertia-Gravity mode **
      nu = -ep^(-1/2)*sqrt(ep^(1/2)*(2*n+1));
      
    elseif r == 2  
      % ** Eastward Inertia-Gravity mode **
      nu = ep^(-1/2)*sqrt(ep^(1/2)*(2*n+1));
      
    else           
      % ++ error case ++ --> -9999 is returned.
    end
    
  elseif n == 0
    
    if r == 0      
      % ** Mixed Rossby-Gravity mode **
      nu = -ep^(-1/4);
      
    elseif r == 2
      % ** Eastward Gravity mode **
      nu = ep^(-1/4);
      
    else
      % ++ error case ** --> -9999 is returned.
    end
    
  elseif n == -1
    
    if r == 2
      % ** Kelvin mode **
      nu = 0;
      
    else
      % ++ error case ++ --> -9999 is returned.
    end
    
  else
    % ++ error case ++ --> -9999 is returned.
  end
  
else
  % ++ error case ++ --> -9999 is returned.
end


% return NU
NU = nu;


% END

