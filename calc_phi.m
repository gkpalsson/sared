function [phi,uphi] = calc_phi(I,uI)

  phi = ( I(1) - I(2) ) * ( I(1) - I(3) ) / ( I(1)*I(4) - I(2)*I(3));
%   
%   syms phi I1 I2 I3 I4;
%   
%   phi = ( I1 - I2 ) * ( I1 - I3 ) / ( I1*I4 - I2*I3 );
%   
%   diff(phi,I1)
%   diff(phi,I2)
%   diff(phi,I3)
%   diff(phi,I4)
  
  dI1 = (I(1) - I(2))/(I(1)*I(4) - I(2)*I(3)) + (I(1) - I(3))/(I(1)*I(4) - I(2)*I(3)) - (I(4)*(I(1) - I(2))*(I(1) - I(3)))/(I(1)*I(4) - I(2)*I(3))^2;
  dI2 = (I(3)*(I(1) - I(2))*(I(1) - I(3)))/(I(1)*I(4) - I(2)*I(3))^2 - (I(1) - I(3))/(I(1)*I(4) - I(2)*I(3));
  dI3 = (I(2)*(I(1) - I(2))*(I(1) - I(3)))/(I(1)*I(4) - I(2)*I(3))^2 - (I(1) - I(2))/(I(1)*I(4) - I(2)*I(3));
  dI4 = -(I(1)*(I(1) - I(2))*(I(1) - I(3)))/(I(1)*I(4) - I(2)*I(3))^2;
  
  dsI1 = dI1^2;
  dsI2 = dI2^2;
  dsI3 = dI3^2;
  dsI4 = dI4^2;
  uphi = sqrt (  dsI1*uI(1)^2 + dsI2*uI(2)^2 + dsI3*uI(3)^2 + dsI4*uI(4)^2 );
 
end