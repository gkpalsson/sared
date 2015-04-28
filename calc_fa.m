function [fa,ufa] = calc_fa(I,uI)

  fa  = ( I(1) - I(2) - I(3) + I(4) ) / (2*(I(1) - I(3) ));
  
%   syms I1 I2 I3 I4
%   
%   fa = (I1 - I2 - I3 + I4)/ (2*(I1 - I3));
%   dI1 = diff(fa,I1)
%   dI2 = diff(fa,I2)
%   dI3 = diff(fa,I3)
%   dI4 = diff(fa,I4)
  
  dI1 = 1/(2*I(1) - 2*I(3)) - (2*(I(1) - I(2) - I(3) + I(4)))/(2*I(1) - 2*I(3))^2;
  dI2 = -1/(2*I(1) - 2*I(3));
  dI3 = (2*(I(1) - I(2) - I(3) + I(4)))/(2*I(1) - 2*I(3))^2 - 1/(2*I(1) - 2*I(3));
  dI4 = 1/(2*I(1) - 2*I(3));
  
  dsI1 = dI1^2;
  dsI2 = dI2^2;
  dsI3 = dI3^2;
  dsI4 = dI4^2;
  
  ufa = sqrt (  dsI1*uI(1)^2 + dsI2*uI(2)^2 + dsI3*uI(3)^2 + dsI4*uI(4)^2 );
  %ufa = abs(dI1)*sqrt(I(1)) + abs(dI2)*sqrt(I(2)) + abs(dI3)*sqrt(I(3)) + abs(dI4)*sqrt(I(4)) ;
end