function Ifinal = GaussIntensity_v2(L,alpha,sigma,tm)
%TESTGAUSS
%    IFINAL = TESTGAUSS(L,ALPHA,SIGMA,TM)

%    This function was generated by the Symbolic Math Toolbox version 6.1.
%    23-Nov-2014 22:47:04

t2 = sqrt(2.0);
t3 = 1.0./sigma.^2;
t4 = sqrt(t3);
Ifinal = erf(L.*t2.*t4.*sin(alpha).*(1.0./4.0))./erf(t2.*t4.*tm.*(1.0./2.0));
Ifinal(Ifinal>1) = 1;
end
