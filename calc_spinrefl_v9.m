function [Ruu,Rud,Rdu,Rdd,Tuu,Tud,Tdu,Tdd,qu] = calc_spinrefl_v9(Q,sld_n,sld_m,theta,d,rough,wavelength,N,L)

% Blundell states that if the angle (not theta) of the quantization axis
% CHANGES by an angle theta from region i to region j, R is given as
% cosd(theta/2) etc.

% absAngle is the actual angle of magnetization in layer i
% If the layer is nonmagnetic, the angle is zero.

% theta(1) is theta_(1,2), ... theta(N-1) is theta_(N-1,N)

Qsqr = Q.^2;

Qsqrr = repmat(Qsqr,[1 N]);

k0 = 2*pi/wavelength;
%sld_m
%sld_n + sld_m
%sld_n - sld_m
np = 1-2*pi/k0^2.*(sld_n + sld_m);
nm = 1-2*pi/k0^2.*(sld_n - sld_m);

Qcpsqr = 4*k0^2.*(1-np.^2);
Qcmsqr = 4*k0^2.*(1-nm.^2);

Qcpsqrr = repmat(Qcpsqr,[L 1]);
Qcmsqrr = repmat(Qcmsqr,[L 1]);

qu = sqrt( Qsqrr - Qcpsqrr );
qd = sqrt( Qsqrr - Qcmsqrr );

dd    = repmat(d./2,[L 1]);
ttsin    = repmat(sind(theta./2),[L 1]);
ttcos    = repmat(cosd(theta./2),[L 1]);

rrsqr = repmat(rough.^2,[L 1]);


pum = exp(-1i*qu(:,2:N-1).*dd(:,2:N-1));
pup = exp(1i*qu(:,2:N-1).*dd(:,2:N-1));
pdp = exp(1i*qd(:,2:N-1).*dd(:,2:N-1));
pdm = exp(-1i*qd(:,2:N-1).*dd(:,2:N-1));

% pum = exp(-1i*qu.*dd);
% pup = exp(1i*qu.*dd);
% pdp = exp(1i*qd.*dd);
% pdm = exp(-1i*qd.*dd);

% PP = complex([1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1;]);
%   
% PP = repmat(PP,[1 1 1 L N]);
% PP(1,1,1,:,:) = pum;
% PP(2,2,1,:,:) = pup;
% PP(3,3,1,:,:) = pdm;
% PP(4,4,1,:,:) = pdp;

% roughness of the top layer (typically air) is not considered for the
% same reason the bottom of the substrate is not considered. These layers
% are infinitely thick. So rough should be of length (N) where rough(2)
% is rough_(1,2) interface, i.e. air_layer. rough(1) is never used.

% ru and rd are defined at the interface
% ru(1) is ru_(1,2), ... ru(N-1) is ru_(N-1,N)

% qu is of size L,N and qu(1) is Q in the air layer (vacuum or si for soft
% matter).

ru(:,1:(N-1)) = exp(-0.5*qu(:,2:N).*qu(:,1:(N-1)).*rrsqr(:,2:N));
rd(:,1:(N-1)) = exp(-0.5*qd(:,2:N).*qd(:,1:(N-1)).*rrsqr(:,2:N));


ruu = reshape(ru,[1 1 L (N-1)]);
rdd = reshape(rd,[1 1 L (N-1)]);

DDin = [1/2 1/(2*1) 0 0; 1/2 -1/(2*1) 0 0; 0 0 1/2 1/(2*1); 0 0 1/2 -1/(2*1);];
DDin = repmat(DDin,[1 1 1 L 1]);
DDin(1,1,1,:,1) =  0.5;
DDin(1,2,1,:,1) = 1./(2*qu(:,1));
DDin(2,1,1,:,1) =  0.5;
DDin(2,2,1,:,1) = -1./(2*qu(:,1));
DDin(3,3,1,:,1) =  0.5;
DDin(3,4,1,:,1) = 1./(2*qd(:,1));
DDin(4,3,1,:,1) =  0.5;
DDin(4,4,1,:,1) = -1./(2*qd(:,1));

% RR is only defined at the interface, so it has length (N-1)
   RR = [1  0  0 0;...
         0  1  0 0;...
         0  0  1 0;...
         0  0  0 1];
       
RR = repmat(RR,[1 1 1 L 1]);

RR(1,1,1,:,1) = ttcos(:,1);
RR(2,2,1,:,1) = ttcos(:,1);
RR(3,3,1,:,1) = ttcos(:,1);
RR(4,4,1,:,1) = ttcos(:,1);
RR(1,3,1,:,1) = ttsin(:,1);
RR(2,4,1,:,1) = ttsin(:,1);
RR(3,1,1,:,1) = -ttsin(:,1);
RR(4,2,1,:,1) = -ttsin(:,1);


DD = [1 1 0 0; 1 -1 0 0; 0 0 1 1; 0 0 1 -1;];

DD = repmat(DD,[1 1 1 L 2]);
DD(2,1,1,:,2) =  qu(:,2);
DD(2,2,1,:,2) = -qu(:,2);
DD(4,3,1,:,2) =  qd(:,2);
DD(4,4,1,:,2) = -qd(:,2);





%m = DD(:,:,1,:,N);
% mm = DD(:,:,1,:,N);
% 
% 
% DPIR(:,:,1,:,N) = m;
% 
% DPIR(1,1,1,:,2:N-1) = (ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) - sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2 + (ru(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) + sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2;
% DPIR(1,2,1,:,2:N-1) = -(sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1).*1i)./qu(:,2:N-1);
% DPIR(1,3,1,:,2:N-1) = (ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) - sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2 + (ru(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) + sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2;
% DPIR(1,4,1,:,2:N-1) = -(sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1).*1i)./qu(:,2:N-1);
%                      %(quN1        *cos(t)         *(cos(dN1*quN1                ) - sin(dN1*quN1                )*i  ))/2  - (quN1        *ru          *cos(t)         *(cos(dN1*quN1                ) + sin(dN1*quN1                )*i  ))/2
% DPIR(2,1,1,:,2:N-1) = (qu(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) - sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2 - (qu(:,2:N-1).*ru(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) + sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2;
% DPIR(2,2,1,:,2:N-1) =   cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1);
% DPIR(2,3,1,:,2:N-1) = (qu(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) - sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2 - (qu(:,2:N-1).*ru(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qu(:,2:N-1)) + sin(dd(:,2:N-1).*qu(:,2:N-1)).*1i))./2;
% DPIR(2,4,1,:,2:N-1) =  cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1);
% 
% DPIR(3,1,1,:,2:N-1) = - (ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) - sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2 - (rd(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) + sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2;
% DPIR(3,2,1,:,2:N-1) = (sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1).*1i)./qd(:,2:N-1);
% DPIR(3,3,1,:,2:N-1) = (ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) - sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2 + (rd(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) + sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2;
% DPIR(3,4,1,:,2:N-1) = -(sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1).*1i)./qd(:,2:N-1);
% 
% DPIR(4,1,1,:,2:N-1) = - (qd(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) - sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2 + (qd(:,2:N-1).*rd(:,2:N-1).*ttsin(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) + sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2;
% DPIR(4,2,1,:,2:N-1) =  -cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1);
% DPIR(4,3,1,:,2:N-1) = (qd(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) - sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2 - (qd(:,2:N-1).*rd(:,2:N-1).*ttcos(:,2:N-1).*(cos(dd(:,2:N-1).*qd(:,2:N-1)) + sin(dd(:,2:N-1).*qd(:,2:N-1)).*1i))./2;
% DPIR(4,4,1,:,2:N-1) = cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1);
% 
% 
% %[             (cos(t)*(cos(dN1*quN1) - sin(dN1*quN1)*i))/2 + (ru*cos(t)*(cos(dN1*quN1) + sin(dN1*quN1)*i))/2, -(sin(dN1*quN1)*cos(t)*i)/quN1,           (sin(t)*(cos(dN1*quN1) - sin(dN1*quN1)*i))/2 + (ru*sin(t)*(cos(dN1*quN1) + sin(dN1*quN1)*i))/2, -(sin(dN1*quN1)*sin(t)*i)/quN1]
% %[   (quN1*cos(t)*(cos(dN1*quN1) - sin(dN1*quN1)*i))/2 - (quN1*ru*cos(t)*(cos(dN1*quN1) + sin(dN1*quN1)*i))/2,           cos(dN1*quN1)*cos(t), (quN1*sin(t)*(cos(dN1*quN1) - sin(dN1*quN1)*i))/2 - (quN1*ru*sin(t)*(cos(dN1*quN1) + sin(dN1*quN1)*i))/2,           cos(dN1*quN1)*sin(t)]
% %[           - (sin(t)*(cos(dN1*qdN1) - sin(dN1*qdN1)*i))/2 - (rd*sin(t)*(cos(dN1*qdN1) + sin(dN1*qdN1)*i))/2,  (sin(dN1*qdN1)*sin(t)*i)/qdN1,           (cos(t)*(cos(dN1*qdN1) - sin(dN1*qdN1)*i))/2 + (rd*cos(t)*(cos(dN1*qdN1) + sin(dN1*qdN1)*i))/2, -(sin(dN1*qdN1)*cos(t)*i)/qdN1]
% %[ - (qdN1*sin(t)*(cos(dN1*qdN1) - sin(dN1*qdN1)*i))/2 + (qdN1*rd*sin(t)*(cos(dN1*qdN1) + sin(dN1*qdN1)*i))/2,          -cos(dN1*qdN1)*sin(t), (qdN1*cos(t)*(cos(dN1*qdN1) - sin(dN1*qdN1)*i))/2 - (qdN1*rd*cos(t)*(cos(dN1*qdN1) + sin(dN1*qdN1)*i))/2,           cos(dN1*qdN1)*cos(t)]
%  
% 
% %c(2,1,:) = c(2,1,:).*ru(:,:,:,jn(j));
% %  c(2,3,:) = c(2,3,:).*ru(:,:,:,jn(j));
% %  c(4,1,:) = c(4,1,:).*rd(:,:,:,jn(j));
% %  c(4,3,:) = c(4,3,:).*rd(:,:,:,jn(j));
% DPI(:,:,1,:,N) = m;
% DPI(1,1,1,:,2:N-1) = cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1);
% DPI(1,2,1,:,2:N-1) = -(sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1).*1i)./qu(:,2:N-1);
% DPI(1,3,1,:,2:N-1) = cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1);
% DPI(1,4,1,:,2:N-1) =  -(sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1).*1i)./qu(:,2:N-1);
% 
% DPI(2,1,1,:,2:N-1) = -qu(:,2:N-1).*sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1).*1i;
% DPI(2,2,1,:,2:N-1) = cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttcos(:,2:N-1);
% DPI(2,3,1,:,2:N-1) = -qu(:,2:N-1).*sin(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1).*1i;
% DPI(2,4,1,:,2:N-1) = cos(dd(:,2:N-1).*qu(:,2:N-1)).*ttsin(:,2:N-1);
% 
% DPI(3,1,1,:,2:N-1) = -cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1);
% DPI(3,2,1,:,2:N-1) = (sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1).*1i)./qd(:,2:N-1);
% DPI(3,3,1,:,2:N-1) = (cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1));
% DPI(3,4,1,:,2:N-1) = -(sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1).*1i)./qd(:,2:N-1);
%  
% DPI(4,1,1,:,2:N-1) = qd(:,2:N-1).*sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1).*1i;
% DPI(4,2,1,:,2:N-1) = -cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttsin(:,2:N-1);
% DPI(4,3,1,:,2:N-1) = -qd(:,2:N-1).*sin(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1).*1i;
% DPI(4,4,1,:,2:N-1) =  cos(dd(:,2:N-1).*qd(:,2:N-1)).*ttcos(:,2:N-1);
% 
%quN  -> qu(:,3:N)
%quN1 -> qu(:,2:N-1)
invQu = 1./(2.*qu(:,2:N-1));
invQd = 1./(2.*qd(:,2:N-1));

PrIDRD = zeros(4,4,1,L,N);

PrIDRD(1,1,1,:,3:N) =  (pum.*ttcos(:,2:N-1).*(qu(:,3:N) + qu(:,2:N-1))).*invQu;
PrIDRD(1,2,1,:,3:N) = -(pum.*ttcos(:,2:N-1).*(qu(:,3:N) - qu(:,2:N-1))).*invQu;
PrIDRD(1,3,1,:,3:N) = (pum.*ttsin(:,2:N-1).*(qd(:,3:N) + qu(:,2:N-1))).*invQu;
PrIDRD(1,4,1,:,3:N) = -(pum.*ttsin(:,2:N-1).*(qd(:,3:N) - qu(:,2:N-1))).*invQu;
                
PrIDRD(2,1,1,:,3:N) = -(pup.*ttcos(:,2:N-1).*(qu(:,3:N) - qu(:,2:N-1))).*invQu;
PrIDRD(2,2,1,:,3:N) = (pup.*ttcos(:,2:N-1).*(qu(:,3:N) + qu(:,2:N-1))).*invQu;
PrIDRD(2,3,1,:,3:N) = -(pup.*ttsin(:,2:N-1).*(qd(:,3:N) - qu(:,2:N-1))).*invQu;
PrIDRD(2,4,1,:,3:N) = (pup.*ttsin(:,2:N-1).*(qd(:,3:N) + qu(:,2:N-1))).*invQu;

PrIDRD(3,1,1,:,3:N) =  -(pdm.*ttsin(:,2:N-1).*(qd(:,2:N-1) + qu(:,3:N))).*invQd;
PrIDRD(3,2,1,:,3:N) = -(pdm.*ttsin(:,2:N-1).*(qd(:,2:N-1) - qu(:,3:N))).*invQd;
PrIDRD(3,3,1,:,3:N) = (pdm.*ttcos(:,2:N-1).*(qd(:,3:N) + qd(:,2:N-1))).*invQd;
PrIDRD(3,4,1,:,3:N) = -(pdm.*ttcos(:,2:N-1).*(qd(:,3:N) - qd(:,2:N-1))).*invQd;
%rd(:,2:N-1).*
%rd(:,2:N-1).*
PrIDRD(4,1,1,:,3:N) =  -(pdp.*ttsin(:,2:N-1).*(qd(:,2:N-1) - qu(:,3:N))).*invQd;
PrIDRD(4,2,1,:,3:N) =  -(pdp.*ttsin(:,2:N-1).*(qd(:,2:N-1) + qu(:,3:N))).*invQd;
PrIDRD(4,3,1,:,3:N) = -(pdp.*ttcos(:,2:N-1).*(qd(:,3:N) - qd(:,2:N-1))).*invQd;
PrIDRD(4,4,1,:,3:N) = (pdp.*ttcos(:,2:N-1).*(qd(:,3:N) + qd(:,2:N-1))).*invQd;

% 
% PrIDRD(1,1,1,:,3:N) =  (exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qu(:,3:N) + qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(1,2,1,:,3:N) = -(exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qu(:,3:N) - qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(1,3,1,:,3:N) = (exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,3:N) + qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(1,4,1,:,3:N) = -(exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,3:N) - qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% 
% PrIDRD(2,1,1,:,3:N) = -(exp(dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qu(:,3:N) - qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(2,2,1,:,3:N) = (exp(dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qu(:,3:N) + qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(2,3,1,:,3:N) = -(exp(dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,3:N) - qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% PrIDRD(2,4,1,:,3:N) = (exp(dd(:,2:N-1).*qu(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,3:N) + qu(:,2:N-1)))./(2.*qu(:,2:N-1));
% 
% PrIDRD(3,1,1,:,3:N) =  -(exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,2:N-1) + qu(:,3:N)))./(2.*qd(:,2:N-1));
% PrIDRD(3,2,1,:,3:N) = -(exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,2:N-1) - qu(:,3:N)))./(2.*qd(:,2:N-1));
% PrIDRD(3,3,1,:,3:N) = (exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qd(:,3:N) + qd(:,2:N-1)))./(2.*qd(:,2:N-1));
% PrIDRD(3,4,1,:,3:N) = -(exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qd(:,3:N) - qd(:,2:N-1)))./(2.*qd(:,2:N-1));
% %rd(:,2:N-1).*
% %rd(:,2:N-1).*
% PrIDRD(4,1,1,:,3:N) =  -(exp(dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,2:N-1) - qu(:,3:N)))./(2.*qd(:,2:N-1));
% PrIDRD(4,2,1,:,3:N) =  -(exp(dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttsin(:,2:N-1).*(qd(:,2:N-1) + qu(:,3:N)))./(2.*qd(:,2:N-1));
% PrIDRD(4,3,1,:,3:N) = -(exp(dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qd(:,3:N) - qd(:,2:N-1)))./(2.*qd(:,2:N-1));
% PrIDRD(4,4,1,:,3:N) = (exp(dd(:,2:N-1).*qd(:,2:N-1).*1i).*ttcos(:,2:N-1).*(qd(:,3:N) + qd(:,2:N-1)))./(2.*qd(:,2:N-1));

% [    (exp(-dN1*quN1*i)*cos(t)*(quN + quN1))/(2*quN1), -(exp(-dN1*quN1*i)*cos(t)*(quN - quN1))/(2*quN1),    (exp(-dN1*quN1*i)*sin(t)*(qdN + quN1))/(2*quN1), -(exp(-dN1*quN1*i)*sin(t)*(qdN - quN1))/(2*quN1)]
% [ -(ru*exp(dN1*quN1*i)*cos(t)*(quN - quN1))/(2*quN1),   (exp(dN1*quN1*i)*cos(t)*(quN + quN1))/(2*quN1), -(ru*exp(dN1*quN1*i)*sin(t)*(qdN - quN1))/(2*quN1),   (exp(dN1*quN1*i)*sin(t)*(qdN + quN1))/(2*quN1)]
% [   -(exp(-dN1*qdN1*i)*sin(t)*(qdN1 + quN))/(2*qdN1), -(exp(-dN1*qdN1*i)*sin(t)*(qdN1 - quN))/(2*qdN1),    (exp(-dN1*qdN1*i)*cos(t)*(qdN + qdN1))/(2*qdN1), -(exp(-dN1*qdN1*i)*cos(t)*(qdN - qdN1))/(2*qdN1)]
% [ -(rd*exp(dN1*qdN1*i)*sin(t)*(qdN1 - quN))/(2*qdN1),  -(exp(dN1*qdN1*i)*sin(t)*(qdN1 + quN))/(2*qdN1), -(rd*exp(dN1*qdN1*i)*cos(t)*(qdN - qdN1))/(2*qdN1),   (exp(dN1*qdN1*i)*cos(t)*(qdN + qdN1))/(2*qdN1)]


% For inv(D)*R only
%iDR(:,:,1,:,N) = m;
% iDR = zeros(4,4,1,L,N-1);
% iDR(1,1,1,:,2:N-1) = ttcos(:,2:N-1)./2;
% iDR(1,2,1,:,2:N-1) = ttcos(:,2:N-1)./(2*qu(:,2:N-1));
% iDR(1,3,1,:,2:N-1) = ttsin(:,2:N-1)./2;
% iDR(1,4,1,:,2:N-1) = ttsin(:,2:N-1)./(2*qu(:,2:N-1));
% 
% iDR(2,1,1,:,2:N-1) = ttcos(:,2:N-1)/2;
% iDR(2,2,1,:,2:N-1) = -ttcos(:,2:N-1)./(2*qu(:,2:N-1));
% iDR(2,3,1,:,2:N-1) = ttsin(:,2:N-1)./2;
% iDR(2,4,1,:,2:N-1) = -ttsin(:,2:N-1)./(2*qu(:,2:N-1));
% 
% iDR(3,1,1,:,2:N-1) =  -ttsin(:,2:N-1)/2;
% iDR(3,2,1,:,2:N-1) = -ttsin(:,2:N-1)./(2*qd(:,2:N-1));
% iDR(3,3,1,:,2:N-1) = ttcos(:,2:N-1)/2;
% iDR(3,4,1,:,2:N-1) =  ttcos(:,2:N-1)./(2*qd(:,2:N-1));
% 
% iDR(4,1,1,:,2:N-1) = -ttsin(:,2:N-1)/2;
% iDR(4,2,1,:,2:N-1) = ttsin(:,2:N-1)./(2*qd(:,2:N-1));
% iDR(4,3,1,:,2:N-1) = ttcos(:,2:N-1)/2;
% iDR(4,4,1,:,2:N-1) = -ttcos(:,2:N-1)./(2*qd(:,2:N-1));
% 
% DP = zeros(4,4,1,L,N-1);
% DP(1,1,1,:,2:N-1) = pum(:,2:N-1);
% DP(1,2,1,:,2:N-1) = pup(:,2:N-1);
% %DP(1,3,1,:,2:N-1) = 0;
% %DP(1,4,1,:,2:N-1) = 0;
% 
% DP(2,1,1,:,2:N-1) = qu(:,2:N-1).*pum(:,2:N-1);
% DP(2,2,1,:,2:N-1) = -qu(:,2:N-1).*pup(:,2:N-1);
% %DP(2,3,1,:,2:N-1) = 0;
% %DP(2,4,1,:,2:N-1) = 0;
% 
% %DP(3,1,1,:,2:N-1) =  0;
% %DP(3,2,1,:,2:N-1) =  0;
% DP(3,3,1,:,2:N-1) =  pdm(:,2:N-1);
% DP(3,4,1,:,2:N-1) =  pdp(:,2:N-1);
% 
% %DP(4,1,1,:,2:N-1) = 0;
% %DP(4,2,1,:,2:N-1) = 0;
% DP(4,3,1,:,2:N-1) = qd(:,2:N-1).*pdm(:,2:N-1);
% DP(4,4,1,:,2:N-1) = -qd(:,2:N-1).*pdp(:,2:N-1);
% 
% DP(1,1,1,:,2:N-1) = exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i);
% DP(1,2,1,:,2:N-1) =exp(dd(:,2:N-1).*qu(:,2:N-1).*1i);
% DP(1,3,1,:,2:N-1) = 0;
% DP(1,4,1,:,2:N-1) = 0;
% 
% DP(2,1,1,:,2:N-1) = qu(:,2:N-1).*exp(-dd(:,2:N-1).*qu(:,2:N-1).*1i);
% DP(2,2,1,:,2:N-1) = -qu(:,2:N-1).*exp(dd(:,2:N-1).*qu(:,2:N-1).*1i);
% DP(2,3,1,:,2:N-1) = 0;
% DP(2,4,1,:,2:N-1) = 0;
% 
% DP(3,1,1,:,2:N-1) =  0;
% DP(3,2,1,:,2:N-1) = 0;
% DP(3,3,1,:,2:N-1) =  exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i);
% DP(3,4,1,:,2:N-1) =  exp(dd(:,2:N-1).*qd(:,2:N-1).*1i);
% 
% DP(4,1,1,:,2:N-1) = 0;
% DP(4,2,1,:,2:N-1) = 0;
% DP(4,3,1,:,2:N-1) = qd(:,2:N-1).*exp(-dd(:,2:N-1).*qd(:,2:N-1).*1i);
% DP(4,4,1,:,2:N-1) = -qd(:,2:N-1).*exp(dd(:,2:N-1).*qd(:,2:N-1).*1i);



% [      exp(-dN1*quN1*i),       exp(dN1*quN1*i),                     0,                     0]
% [ quN1*exp(-dN1*quN1*i), -quN1*exp(dN1*quN1*i),                     0,                     0]
% [                     0,                     0,      exp(-dN1*qdN1*i),       exp(dN1*qdN1*i)]
% [                     0,                     0, qdN1*exp(-dN1*qdN1*i), -qdN1*exp(dN1*qdN1*i)]

% [  cos(t)/2,  cos(t)/(2*quN1), sin(t)/2,  sin(t)/(2*quN1)]
% [  cos(t)/2, -cos(t)/(2*quN1), sin(t)/2, -sin(t)/(2*quN1)]
% [ -sin(t)/2, -sin(t)/(2*qdN1), cos(t)/2,  cos(t)/(2*qdN1)]
% [ -sin(t)/2,  sin(t)/(2*qdN1), cos(t)/2, -cos(t)/(2*qdN1)]

m = eye(4,4);
m = repmat(m,[1,1,1,L]);

for j = N:-1:3

  
  
  m = mtimesx(PrIDRD(:,:,1,:,j),m(:,:,1,:),'SPEEDOMP');
  % m =  sum(bsxfun(@times, PrIDRD(:,:,1,:,j), reshape(m,[1 4 4 L])), 2);
  %  m = reshape(m,[4 4 L]);
% %   
    m(2,1,:) = m(2,1,:).*ruu(:,:,:,j-1);
    m(2,3,:) = m(2,3,:).*ruu(:,:,:,j-1);
    m(4,1,:) = m(4,1,:).*rdd(:,:,:,j-1);
    m(4,3,:) = m(4,3,:).*rdd(:,:,:,j-1);
  %  m = reshape(m,[1 4 4 L]);
  %PrIDRD(:,:,1,9000,j)
%   
%   m3 = reshape(m,[4,4,1,L]);
%   m3(:,:,1,9000)
% 
%   
%   e = sum(bsxfun(@times, DD(:,:,1,:,j), reshape(m2,[1 4 4 L])), 2);
%   d = sum(bsxfun(@times, RR(:,:,1,:,j-1), reshape(e,[1 4 4 L])), 2);
%   c = sum(bsxfun(@times, DDin(:,:,1,:,j-1), reshape(d,[1 4 4 L])), 2);
%   c = reshape(c,[4 4 L]);
%   
%   c(2,1,:) = c(2,1,:).*ruu(:,:,:,j-1);
%   c(2,3,:) = c(2,3,:).*ruu(:,:,:,j-1);
%   c(4,1,:) = c(4,1,:).*rdd(:,:,:,j-1);
%   c(4,3,:) = c(4,3,:).*rdd(:,:,:,j-1);
%   m2 = sum(bsxfun(@times, PP(:,:,1,:,j-1), reshape(c,[1 4 4 L])), 2);
%   mm = reshape(m2,[4 4 1 L]);
%   mm(:,:,1,9000)
%   pause
%   rj = sum(bsxfun(@times, iDR(:,:,1,:,j), reshape(m,[1 4 4 L])), 2);
%   c = reshape(rj,[4 4 L]);
% 
%   c(2,1,:) = c(2,1,:).*ruu(:,:,:,j);
%   c(2,3,:) = c(2,3,:).*ruu(:,:,:,j);
%   c(4,1,:) = c(4,1,:).*rdd(:,:,:,j);
%   c(4,3,:) = c(4,3,:).*rdd(:,:,:,j);
% 
%   m = sum(bsxfun(@times, DP(:,:,1,:,j), reshape(c,[1 4 4 L])), 2);

end

a1 = sum(bsxfun(@times, DD(:,:,1,:,2), reshape(m,[1 4 4 L])), 2);
a2 = sum(bsxfun(@times, RR(:,:,1,:,1), reshape(a1,[1 4 4 L])), 2);
a3 = sum(bsxfun(@times, DDin(:,:,1,:,1), reshape(a2,[1 4 4 L])), 2);
M = reshape(a3,[4,4,L]);

DET = (M(1,1,:).*M(3,3,:)-M(1,3,:).*M(3,1,:));
%M(2,1,:) = M(2,1,:).*ruu(:,:,:,1);
%M(2,3,:) = M(2,3,:).*ruu(:,:,:,1);
%M(4,1,:) = M(4,1,:).*rdd(:,:,:,1);
%M(4,3,:) = M(4,3,:).*rdd(:,:,:,1);

ruu = (M(2,1,:).*M(3,3,:)-M(2,3,:).*M(3,1,:))./DET;
Ruu = abs(ruu).^2;
Ruu = reshape(Ruu,L,1,1);

tuu = M(3,3,:)./DET;
Tuu = abs(tuu).^2;
Tuu = reshape(Tuu,L,1,1);
Tuu = Tuu.*real(qu(:,end))./sqrt(Qsqr);

rud = (M(4,1,:).*M(3,3,:)-M(4,3,:).*M(3,1,:))./DET;
Rud = abs(rud).^2;
Rud = reshape(Rud,L,1,1);

tud = -M(3,1,:)./DET;
Tud = abs(tud).^2;
Tud = reshape(Tud,L,1,1);

rdu = (M(2,3,:).*M(1,1,:)-M(2,1,:).*M(1,3,:))./DET;
Rdu = abs(rdu).^2;
Rdu = reshape(Rdu,L,1,1);

tdu = -M(1,3,:)./DET;
Tdu = abs(tdu).^2;
Tdu = reshape(Tdu,L,1,1);

rdd = (M(4,3,:).*M(1,1,:)-M(4,1,:).*M(1,3,:))./DET;

Rdd = abs(rdd).^2;
Rdd = reshape(Rdd,L,1,1);

tdd = M(1,1,:)./DET;
Tdd = abs(tdd).^2;
Tdd = reshape(Tdd,L,1,1);

end
