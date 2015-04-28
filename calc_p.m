function [pout,upout] = calc_p(I,UI,phi,uphi,fa,ufa,fp,ufp)

%syms p fa fp I1 I2 I3 I4 phi
%sol = solve(phi*( ( (1-2*fa)*I(1) + (2*fa-1)*I(3) - I(2) + I(4) ) / ( (1-2*fp)*I(1) + (2*fp-1)*I(2) - I(3) + I(4) ) ) == 4*p^2-4*p+1,p)
 %     solve(phi*( ( (1-2*fa)*I1   + (2*fa-1)*I3   - I2   + I4   ) / ( (1-2*fp)*I1   + (2*fp-1)*I2   - I3   + I4   ) ) == 4*p^2-4*p+1,p)
      
%  p1 = ((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2)/2 + 1/2
%  p2 = 1/2 - ((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2)/2
%  
%  dI1 = diff(p1,'phi')
%  dI2 = diff(p1,'I1')
%  dI2 = diff(p1,'I2')
%  dI2 = diff(p1,'I3')
%  dI2 = diff(p1,'I4')
%  dI2 = diff(p1,'fa')
%  dI2 = diff(p1,'fp')
 
 p1 = ((phi*(I(1) - I(2) - I(3) + I(4) - 2*I(1)*fa + 2*I(3)*fa))/(I(1) - I(2) - I(3) + I(4) - 2*I(1)*fp + 2*I(2)*fp))^(1/2)/2 + 1/2;
 p2 = 1/2 - ((phi*(I(1) - I(2) - I(3) + I(4) - 2*I(1)*fa + 2*I(3)*fa))/(I(1) - I(2) - I(3) + I(4) - 2*I(1)*fp + 2*I(2)*fp))^(1/2)/2;

 I1 = I(1);
 I2 = I(2);
 I3 = I(3);
 I4 = I(4);
 
 dI1 = (I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa)/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2)*(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp));
 dI2 = -((phi*(2*fa - 1))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp) - (phi*(2*fp - 1)*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp)^2)/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2));
 dI3 = -(phi/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp) + (phi*(2*fp - 1)*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp)^2)/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2));
 dI4 = ((phi*(2*fa - 1))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp) + (phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp)^2)/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2));
 dI5 = (phi/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp) - (phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp)^2)/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2));
 dI6 = -(phi*(2*I1 - 2*I3))/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2)*(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp));
 dI7 = (phi*(2*I1 - 2*I2)*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(4*((phi*(I1 - I2 - I3 + I4 - 2*I1*fa + 2*I3*fa))/(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp))^(1/2)*(I1 - I2 - I3 + I4 - 2*I1*fp + 2*I2*fp)^2);
 
 dsI1 = dI1^2;
 dsI2 = dI2^2;
 dsI3 = dI3^2;
 dsI4 = dI4^2;
 dsI5 = dI5^2;
 dsI6 = dI6^2;
 dsI7 = dI7^2;
 
 
 pout  = p1; 
 
 upout = sqrt (  dsI2*UI(1)^2 + dsI3*UI(2)^2 + dsI4*UI(3)^2 + dsI5*UI(4)^2 + dsI1*uphi^2 + dsI6*ufa^2 + dsI7*ufp^2 );
 %upout =  abs(dI2)*sqrt(I(1)) + abs(dI3)*sqrt(I(2)) + abs(dI4)*sqrt(I(3)) + abs(dI5)*sqrt(I(4)) + abs(dI1)*uphi + abs(dI6)*ufa + abs(dI7)*ufp;
end