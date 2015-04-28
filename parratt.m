function [RR,Qp]=parratt(Q,p_wavelength,p_delta,p_beta,p_thick,p_rough)
%
% MATLAB function from:
% "Elements of Modern X-ray Physics" by Jens Als-Nielsen and Des McMorrow
%
% Calculates: Parratt reflectivity of a multilayer
% Inputs: Q      wavevector transfer                1/Angs
%         lambda wavelength of radiation            Angs
%         sld    scattering length density          1/Angs^2
%                sld=[sld1+i*mu1 sld2+i*mu2 ....]
%         d      thickness of layer                 Angs
%                d=[d1 d2 .....];
%         sigma  rouhgness                          Angs
% Outputs:R      Intensity reflectivity

lambda= p_wavelength;
k=2*pi/lambda;
d= p_thick;
sigma= p_rough;

%----- Calculate refractive index n of each layer

delta=p_delta;
beta=p_beta;
n=size(delta,1);
%nu=1-delta+i*beta;
%----- Wavevector transfer in each layer

Q=reshape(Q,1,length(Q));
x=asin(Q/2/k);


for j=1:n
   Qp(j,:)=sqrt(Q.^2-8*k^2*delta(j)+i*8*k^2*beta(j));
end
Qp=[Q;Qp];


%----- Reflection coefficients (no multiple scattering)

for j=1:n
   r(j,:)=((Qp(j,:)-Qp(j+1,:))./(Qp(j,:)+Qp(j+1,:))).*...
      exp(-0.5*(Qp(j,:).*Qp(j+1,:))*sigma(j)^2);
end


%----- Reflectivity from first layer

RR=r(1,:);
if n>1
   R(1,:)=(r(n-1,:)+r(n,:).*...
      exp(i*Qp(n,:)*d(n-1)))./(1+r(n-1,:).*r(n,:).*exp(i*Qp(n,:)*d(n-1)));
end

%----- Reflectivity from more layers

if n>2
  for j=2:n-1
     R(j,:)=(r(n-j,:)+R(j-1,:).*...
        exp(i*Qp(n-j+1,:)*d(n-j)))./(1+r(n-j,:).*R(j-1,:).*exp(i*Qp(n-j+1,:)*d(n-j)));
  end
end

%------ Intensity reflectivity

if n==1
  RR=r(1,:);
else
  RR=R(n-1,:);
end

RR=(abs(RR).^2)';
end