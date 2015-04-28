function [fp,ufp] = calc_fp(I,uI)
  fp = ( I(1) - I(2) - I(3) + I(4) ) / (2*(I(1) - I(2) ));
  
%  syms I1 I2 I3 I4
%   
%   fp = (I1 - I2 - I3 + I4)/ (2*(I1 - I2));
%   dI1 = diff(fa,I1)
%   dI2 = diff(fa,I2)
%   dI3 = diff(fa,I3)
%   dI4 = diff(fa,I4)
   
  dI1 = 1/(2*I(1) - 2*I(2)) - (2*(I(1) - I(2) - I(3) + I(4)))/(2*I(1) - 2*I(2))^2;
  dI2 = (2*(I(1) - I(2) - I(3) + I(4)))/(2*I(1) - 2*I(2))^2 - 1/(2*I(1) - 2*I(2));
  dI3 = -1/(2*I(1) - 2*I(2));
  dI4 = 1/(2*I(1) - 2*I(2));

  dsI1 = dI1^2;
  dsI2 = dI2^2;
  dsI3 = dI3^2;
  dsI4 = dI4^2;
  
  ufp = sqrt (  dsI1*uI(1)^2 + dsI2*uI(2)^2 + dsI3*uI(3)^2 + dsI4*uI(4)^2 );
  
end