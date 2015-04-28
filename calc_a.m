function [a,ua] = calc_a(phi,uphi,p,up)
  %syms phi p a;
  %solve(phi==(2*p-1)*(2*a-1),a)
  %da1 = diff(a,phi)
  %da2 = diff(a,p)
  
  a = (2*p + phi - 1)/(4*p - 2);
  
  
  da1 = 1/(4*p - 2);
  da2 = 2/(4*p - 2) - (4*(2*p + phi - 1))/(4*p - 2)^2;
  
  dsa1 = da1^2;
  dsa2 = da2^2;
  
  ua = sqrt ( dsa1*uphi^2 + dsa2*up^2 );
end
