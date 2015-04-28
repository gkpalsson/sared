function handles = reduceData(handles)

h = waitbar(0,'Processing Data files...','WindowStyle','modal');

% Do the direct beam files.
if handles.listDirectExists

    N = length(handles.db);
    handles.duu       = zeros(N,1);
    handles.ddu       = zeros(N,1);
    handles.dud       = zeros(N,1);
    handles.ddd       = zeros(N,1);
    
    db = handles.db;
    for i = 1:length(db)
      db{i} = processImage(db{i});
      switch db{i}.SpinState
        case 'uu'
          handles.duu(i) = logical(true);
          db{i}.Monitor  = db{i}.M1;
        case 'du'
          handles.ddu(i) = logical(true);
          db{i}.Monitor  = db{i}.M4;
        case 'ud'
          handles.dud(i) = logical(true);
          db{i}.Monitor  = db{i}.M3;
        case 'dd'
          handles.ddd(i) = logical(true);
          db{i}.Monitor  = db{i}.M2;
      end
      handles.DI(i)   = db{i}.Integr;
      handles.sDI(i)  = db{i}.sIntegr;
      if db{i}.Monitor == 0
        db{i}.Monitor = db{i}.SumMonitor;
      end
      handles.DM(i)   = db{i}.Monitor;
      
      handles.sDM(i)  = sqrt(db{i}.Monitor);
  
      handles.DSampleSlit(i)  = db{i}.SampleSlit;
      handles.DMonoSlit(i)  = db{i}.MonoSlit;
      %db{i} = fitModel(db{i},handles);
%     db{i}.hwhm = 2*sqrt(2*log(2))*atand(db{i}.GaussPeak.c*mm_per_pixel/handles.settings.SD)/2;

    end
 
    handles.db = db;
    if handles.doMonitor
      
      handles.sDI = sqrt( ( 1./handles.DM .* handles.sDI ).^2 + ((-handles.DI./handles.DM.^2).*handles.sDM ).^2 );

      handles.DI  = handles.DI./handles.DM;
 
    end
 
    handles.duu = logical(handles.duu);
    handles.dud = logical(handles.dud);
    handles.ddu = logical(handles.ddu);
    handles.ddd = logical(handles.ddd);    

end
  

experiment = handles.experiment;

N = length(experiment);


handles.I        = zeros(N,1);
handles.sI       = zeros(N,1);
handles.Magn     = zeros(N,1);
handles.SampleSlit = zeros(N,1);
handles.Temp     = zeros(N,1);
handles.Time     = zeros(N,1);
handles.bI       = zeros(N,1);
handles.sbI      = zeros(N,1);
handles.Q        = zeros(N,1);
handles.IG       = zeros(N,1);
handles.sIG      = zeros(N,1);
handles.M        = zeros(N,1);
handles.sM       = zeros(N,1);
handles.Theta    = zeros(N,1);
handles.TwoTheta = zeros(N,1);
handles.uu       = zeros(N,1);
handles.du       = zeros(N,1);
handles.ud       = zeros(N,1);
handles.dd       = zeros(N,1);

handles.unpolarized = zeros(N,1);
handles.IQ       = zeros(1,N);
handles.IQLog    = zeros(1,N);


handles.MonoSlit = zeros(N,1);
handles.div      = zeros(N,1);
handles.beamw    = zeros(N,1);
handles.overill  = zeros(N,1);
handles.newTheta    = zeros(N,1);
handles.COG    = zeros(N,1);


if N > 0
handles.IQ       = zeros(experiment{1}.imsize(1),N);
handles.IQLog    = zeros(experiment{1}.imsize(1),N);

    M = experiment{1}.imsize(1);

    handles.RTheta    = zeros(M,N);
    handles.RTwoTheta = zeros(M,N);
    handles.Qx        = zeros(M,N);
    handles.Qz        = zeros(M,N);
    handles.pixel_x   = zeros(M,N);
    handles.pixel_y   = zeros(M,N);


%h = waitbar(0,'Processing Data files...');
for i = 1:N
%  waitbar(i/N,h);
  datapoint = experiment{i};
  [m,n] = size(datapoint.im);
  
  datapoint = processImage(datapoint);
  if datapoint.hasGaussFit
    handles.IG(i)  = datapoint.GaussArea;
    handles.sIG(i) = datapoint.sGaussArea;
    %handles.Gauss_X0(i) = datapoint.GaussPeak.b;
    
    %S=confint(datapoint.GaussPeak,0.68);
    %handles.Gauss_sX0(i) = abs(datapoint.GaussPeak.b-S(1,2));
    
    datapoint.Integr = handles.IG(i);
  end
  
   Q(i)          = 4*pi/handles.settings.wavelength*sind(datapoint.Theta);
  
  switch datapoint.SpinState
    case 'uu'
      handles.uu(i) = logical(true);
      datapoint.Monitor = datapoint.M1;
    case 'du' % switched M3 for M4
      handles.du(i) = logical(true);
      datapoint.Monitor = datapoint.M3;
    case 'ud'
      handles.ud(i) = logical(true);
      datapoint.Monitor = datapoint.M4;
    case 'dd'
      handles.dd(i) = logical(true);
      datapoint.Monitor = datapoint.M2;
    otherwise
      handles.unpolarized(i) = logical(true);
  end
  if datapoint.Monitor == 0
    datapoint.Monitor = datapoint.SumMonitor;
  end
 
  handles.Q(i)   = Q(i);
  handles.I(i)   = datapoint.Integr;
  handles.sI(i)  = datapoint.sIntegr;
  handles.bI(i)  = datapoint.bIntegr;
  handles.sbI(i) = datapoint.sbIntegr;
  
  handles.M(i)        = datapoint.Monitor;
  handles.sM(i)       = sqrt(datapoint.Monitor);
  handles.Theta(i)    = datapoint.Theta;
  handles.TwoTheta(i) = datapoint.TwoTheta;
  handles.Temp(i)     = datapoint.Temp;
  handles.Magn(i)     = datapoint.Magn;
  handles.Time(i)     = datapoint.Time;

  handles.IQ(:,i)     = datapoint.allproject;
  pospoints = find(datapoint.allproject > 0);
  if ~isempty(pospoints)
    handles.theIQmin(i) = min(datapoint.allproject(pospoints));
  else 
    handles.theIQmin(i) = 0;
  end
  handles.theIQmax(i) = max(datapoint.allproject);
  handles.SampleSlit(i) = datapoint.SampleSlit;
  handles.MonoSlit(i)   = datapoint.MonoSlit;
  
  if datapoint.hasROI
    handles.ROI        = [datapoint.top,datapoint.bottom,datapoint.start,datapoint.end];
  else
  %  handles.ROI        = datapoint.ORIGROI; % 
  end
  
  handles.COG(i)     = datapoint.COG;
  
  % Old divergence.
  % handles.div(i)     = atand( (datapoint.SampleSlit/2 + datapoint.MonoSlit/2 )/handles.settings.MonoSlitSampleSlitD);
  handles.div(i)     = 180/pi*sqrt(1/12)*2*sqrt(2*log(2))*sqrt((datapoint.SampleSlit^2 + datapoint.MonoSlit^2)/handles.settings.MonoSlitSampleSlitD^2);
  handles.beamw(i)   = 2*handles.settings.SampleSlitSampleD*tand(handles.div(i))+datapoint.SampleSlit;
  %handles.overill(i) = SquareIntensity(datapoint.TwoTheta,handles.settings.length,handles.beamw(i));
 % handles.overill(i) = GaussIntensity(datapoint.Theta,handles.settings.length/2,handles.settings.length/2,handles.beamw(i));
  if handles.settings.doSquareBeam
    handles.footprint(i) = 1/sind(datapoint.Theta).*(datapoint.SampleSlit + handles.settings.SampleSlitSampleD/handles.settings.MonoSlitSampleSlitD*(datapoint.SampleSlit+datapoint.MonoSlit));
    handles.overill(i) = handles.settings.length/handles.footprint(i);
 %  handles.overill(i) = SquareIntensity(datapoint.Theta,handles.settings.length,handles.beamw(i));
  else
    handles.overill(i) = GaussIntensity_v2(handles.settings.length,datapoint.Theta*pi/180,handles.beamw(i)/2/sqrt(2*log(2)),3000);
  end
  experiment{i} = datapoint;
end


if handles.doBackground && handles.settings.doModel
  handles.sI = handles.sIG;
  handles.I  = handles.IG;
end

if handles.doMonitor
  handles.sI = sqrt( handles.sI.^2./handles.M.^2 + (handles.I./handles.M.^2.*handles.sM).^2 );
  handles.I  = handles.I./handles.M;
  Mall = repmat(handles.M,[1 experiment{1}.imsize(1)])';
  handles.IQ = handles.IQ./Mall;

  size(handles.theIQmin)
  size(handles.M)
  handles.theIQmin = handles.theIQmin(:)./handles.M(:);
  handles.theIQmax = handles.theIQmax(:)./handles.M(:);

  handles.sbI = sqrt( handles.sbI.^2./handles.M.^2 + (handles.bI./handles.M.^2.*handles.sM).^2 );
  handles.bI  = handles.bI./handles.M;
end

if handles.doOverIllumination

  handles.I = handles.I./(handles.overill+eps);
  handles.sI = handles.sI./(handles.overill+eps);
end

handles.uu = logical(handles.uu);
handles.ud = logical(handles.ud);
handles.du = logical(handles.du);
handles.dd = logical(handles.dd);

if handles.doNormalize
  
  suu  = handles.SampleSlit(handles.uu);
  Iuu  = handles.I(handles.uu);
  sIuu = handles.sI(handles.uu);
  bIuu  = handles.bI(handles.uu);
  sbIuu  = handles.sbI(handles.uu);
  
  sud  = handles.SampleSlit(handles.ud);  
  Iud = handles.I(handles.ud);
  sIud = handles.sI(handles.ud);
  bIud  = handles.bI(handles.ud);
  sbIud  = handles.sbI(handles.ud);

  sdu  = handles.SampleSlit(handles.du);  
  Idu = handles.I(handles.du);
  sIdu = handles.sI(handles.du);
  bIdu  = handles.bI(handles.du);
  sbIdu  = handles.sbI(handles.du);
  
  sdd  = handles.SampleSlit(handles.dd);  
  Idd = handles.I(handles.dd);
  sIdd = handles.sI(handles.dd);
  bIdd = handles.bI(handles.dd);
  sbIdd  = handles.sbI(handles.dd);
  
  Dsuu  = handles.DSampleSlit(handles.duu);
  DIuu  = handles.DI(handles.duu);
  sDIuu = handles.sDI(handles.duu);

  Dsud  = handles.DSampleSlit(handles.dud);  
  DIud = handles.DI(handles.dud);
  sDIud = handles.sDI(handles.dud);

  Dsdu  = handles.DSampleSlit(handles.ddu);  
  DIdu = handles.DI(handles.ddu);
  sDIdu = handles.sDI(handles.ddu);

  Dsdd  = handles.DSampleSlit(handles.ddd); 
  DIdd = handles.DI(handles.ddd);
  sDIdd = handles.sDI(handles.ddd);
  
  DIfuu = zeros(size(suu));
  sDIfuu = zeros(size(suu));
  DIfud = zeros(size(sud));
  sDIfud = zeros(size(sud));
  DIfdu = zeros(size(sdu));
  sDIfdu = zeros(size(sdu));
  DIfdd = zeros(size(sdd));
  sDIfdd = zeros(size(sdd));  
  

   
  % suu(i) is sample slit for each data point
  % Dsuu is Direct beam sample slit for each direct beam point
  % TODO: Make this work for all modes of polarization
  for i = 1:length(suu)
 % unique(Dsuu)
 % suu(i)
 % pause
    DIfuu(i)  = DIuu( unique(Dsuu) == suu(i));
    sDIfuu(i) = sDIuu(unique(Dsuu) == suu(i));

  end

  % TODO: What if a reduced polarization is measured, we have uu and du
  % which means uu + ud and du + dd but ud and du are zero
  if isempty(DIdd)
    DIdd = DIuu;
    sDIdd = sDIuu;
  end

  for i = 1:length(sdu)
    DIfdu(i)  = DIdd( unique(Dsdu) == sdu(i));
    sDIfdu(i) = sDIdd( unique(Dsdu) == sdu(i));    
  end

  for i = 1:length(sud)
    DIfud(i)  = DIuu( unique(Dsud) == sud(i));
    sDIfud(i) = sDIuu( unique(Dsud) == sud(i));
  end

  for i = 1:length(sdd)
    DIfdd(i)  = DIdd( unique(Dsdd) == sdd(i));
    sDIfdd(i) = sDIdd( unique(Dsdd) == sdd(i));  
  end
  
  
  sIuu = sqrt( sIuu(:).^2./DIfuu(:).^2 + (Iuu(:)./DIfuu(:).^2 .*sDIfuu(:) ).^2 );
  sIud = sqrt( sIud(:).^2./DIfud(:).^2 + (Iud(:)./DIfud(:).^2 .*sDIfud(:) ).^2 );
  sIdu = sqrt( sIdu(:).^2./DIfdu(:).^2 + (Idu(:)./DIfdu(:).^2 .*sDIfdu(:) ).^2 );
  sIdd = sqrt( sIdd(:).^2./DIfdd(:).^2 + (Idd(:)./DIfdd(:).^2 .*sDIfdd(:) ).^2 );
  
  sbIuu = sqrt( sbIuu(:).^2./DIfuu(:).^2 + (bIuu(:)./DIfuu(:).^2 .*sDIfuu(:) ).^2 );
  sbIud = sqrt( sbIud(:).^2./DIfud(:).^2 + (bIud(:)./DIfud(:).^2 .*sDIfud(:) ).^2 );
  sbIdu = sqrt( sbIdu(:).^2./DIfdu(:).^2 + (bIdu(:)./DIfdu(:).^2 .*sDIfdu(:) ).^2 );
  sbIdd = sqrt( sbIdd(:).^2./DIfdd(:).^2 + (bIdd(:)./DIfdd(:).^2 .*sDIfdd(:) ).^2 );
  
  handles.I(handles.uu)  = Iuu./DIfuu;
  handles.I(handles.ud)  = Iud./DIfud;
  handles.I(handles.du)  = Idu./DIfdu; % correct spinflip with number of dd spins?
  handles.I(handles.dd)  = Idd./DIfdd;
  
  handles.sI(handles.uu) = sIuu;
  handles.sI(handles.ud) = sIud;
  handles.sI(handles.du) = sIdu;
  handles.sI(handles.dd) = sIdd;
  
  handles.bI(handles.uu)  = bIuu./DIfuu;
  handles.bI(handles.ud)  = bIud./DIfud;
  handles.bI(handles.du)  = bIdu./DIfdu; % correct spinflip with number of dd spins?
  handles.bI(handles.dd)  = bIdd./DIfdd;
  
  handles.bsI(handles.uu) = sbIuu;
  handles.bsI(handles.ud) = sbIud;
  handles.bsI(handles.du) = sbIdu;
  handles.bsI(handles.dd) = sbIdd;


end

if handles.doThetaOffset
  mm_per_pixel = handles.settings.DW/1400; % m is number of pixels in the x direction, always 1400
  ROI = handles.ROI;
  % Assume Roi(1) =  x
        
        ROI_L   =  abs(ROI(3) - ROI(4));
        ROI_H    = abs(ROI(1) - ROI(2));

        ROI_center_x = ROI(3) + ROI_L/2;
        ROI_center_y = ROI(1) + ROI_H/2;
L_pixel        = handles.COG-ROI_center_x;
L_mm           = L_pixel*mm_per_pixel;

gamma = -atand(L_mm/handles.settings.SD);
% (COM - CENTEROFROI)/2
%handles.newTheta = handles.Theta + gamma/2;
handles.newTheta = handles.TwoTheta/2 + gamma/2;
cf  = fit(handles.Theta(handles.uu),handles.newTheta(handles.uu),'a*x+b');
handles.fitTheta = cf.a*handles.Theta(handles.uu)+cf.b;


figure
plot(handles.Theta(handles.uu),handles.newTheta(handles.uu),'o');
hold on;
plot(handles.Theta(handles.uu),handles.fitTheta,'-');

handles.Theta = handles.Theta - cf.b;
handles.ThetaOffset = cf.b;
handles.Q = handles.Q - sind(cf.b)*4*pi/handles.settings.wavelength;
end


handles.dII  = handles.sI./handles.I;
handles.newTime = (handles.dII./0.09).*handles.Time;


      

handles.experiment = experiment;


if ~isempty(handles.experiment)

      mm_per_pixel = handles.settings.DW/m; % m is number of pixels in the x direction, always 1400

        ROI = handles.ROI;
        
        ROI_L   =  abs(ROI(3) - ROI(4));
        ROI_H    = abs(ROI(1) - ROI(2));

        ROI_center_x = ROI(3) + ROI_L/2;
        ROI_center_y = ROI(1) + ROI_H/2;

      % The ROI center marks the center of the ROI that was used to align the
      % 2Theta axis. Therefore the horizontal pixel defined TwoTheta=0

      % We have 1400 pixels, which means -700,699 so we arbitrarily cut off one
      % at the far end.

    for i = 1:N

      H_pixel        = 1:1:experiment{1}.imsize(1);

      L_pixel        = H_pixel - ROI_center_x;
      L_mm           = L_pixel*mm_per_pixel;


      % L_pixel is the distance in pixels from TwoTheta=0
      % L_mm is the distance in mm from TwoTheta=0

      % twothetarange is the range of TwoTheta when the detector was measuring
      % the direct beam, with twotheta=0 at the ROI_center_x

      gamma = -atand(L_mm/handles.settings.SD);

      % The current TwoTheta range is Twotheta for the current point.
      % experiment{i}.TwoTheta is the motor position of twotheta, which we
      % assume was set to zero when the beam hit the ROI_center_x
      
      alpha     = experiment{i}.Theta+handles.ThetaOffset;
      
      beta = alpha + gamma;
   

      % experiment{i}.Theta is the motor position of the theta which may have
      % a slight offset because it is difficult to align. If we find the 
      % position of the center pixel with a Gauss fit for the CURRENT point
      % and we assume TwoTheta is calibrated, then Theta = TwoTheta/2 for that
      % point?

      handles.pixel_x(:,i)   = 1:1:M;

      handles.pixel_y(:,i)   = i*ones(size(handles.pixel_x(:,i)))';

      handles.RTheta(:,i)    = alpha*ones(size(beta));
     
      handles.RTwoTheta(:,i) = beta+alpha;
      
     
      handles.Qx(:,i) = 2*pi/handles.settings.wavelength*(cosd(alpha) - cosd(beta));
      handles.Qz(:,i) = 2*pi/handles.settings.wavelength*(sind(alpha) + sind(beta)); 
      
    
      k0     = 2*pi/handles.settings.wavelength;
      uk0    = -k0*0.005; % uk0 is k0*(delta Lambda/Lambda)
      % Our estimate at the moment is that deltaLambda = 0.005
      
      ualpha = handles.div*pi/180; % radians
     
      % 2.8 mm resolution of the detector but the pixel size is 0.6 mm/pixel.
      ubeta  = atan(2.8/handles.settings.SD); % radians
      
      handles.sQx(:,i) = sqrt( k0^2*(sind(alpha).^2.*ualpha(i).^2 + sind(beta).^2.*ubeta.^2) ...
                  + uk0^2.*(sind(alpha) - sind(beta)).^2 );
                
      handles.sQz(:,i) = sqrt( k0^2*(cosd(alpha).^2.*ualpha(i).^2 + cosd(beta).^2.*ubeta.^2) ...
                  + uk0^2.*(sind(alpha) + sind(beta)).^2 );
                
      handles.sQz_specular(i) = sqrt( k0^2.*cosd(alpha).^2.*(ualpha(i).^2 + ubeta.^2) ...
                  + 4*uk0^2.*sind(alpha).^2 );
                
      handles.sQx_specular(i) = sqrt( k0^2.*sind(alpha).^2.*(ualpha(i).^2 + ubeta.^2));
                
      handles.lx = 2*pi./handles.sQx_specular;
      handles.lz = 2*pi./handles.sQz_specular;
      
      
      
   

 
    end
    handles.IQLog = log10(handles.IQ+eps);
    A = handles.IQ(:,handles.uu);
   
    size(A)
   % theta = handles.Theta(handles.uu);
   save('Intensity.dat','A','-ascii');
   % save('Theta.dat','theta','-ascii');
    
    
    N  = length(handles.I);
    sqz = zeros(N,1);

    for k = 1:N
      id_x    = find(handles.Qx(:,k)>=0);
      cqx     = handles.Qx(id_x,k);
      csqz    = handles.sQz(id_x,k);
      
      [~,id] = min(cqx);
      
      sqz(k)   = csqz(id(1));
    end

    handles.dQZ  =  sqz;
 
 if 0
  Qxmin = -2e-5;
  Qxmax = -1e-5;
  
  %Qtest = find(handles.Qx >= Qxmin);
  %size(handles.Qx)
  %size(Qtest)
  %qt = handles.Qx(Qtest);
  %Qtest2 = find(handles.Qx <= Qxmax);
  %Qxindices= find(handles.Qx >= Qxmin & handles.Qx <= Qxmax);
  
  %size(Qxindices)
  [Qxbkgindices] = find(handles.Qx >= Qxmin & handles.Qx <= Qxmax);
  size(handles.Qx)
 % figure
  
  [Iqb,Jqb] = ind2sub(size(handles.Qx),Qxbkgindices);
  Iqb(1:100)
  min(Jqb)
  max(Jqb)
  min(Iqb)
  max(Iqb)
  %[Qxx,Qxy] = find(handles.Qx >= Qxmin & handles.Qx <= Qxmax);
  %[I,J] = ind2sub(Qxx,Qxy);
  
  Qxbkg = handles.Qx(Iqb,Jqb);
  size(Qxbkg)
  size(handles.IQ)
  size(handles.Qx)
  Ibkg = sum(handles.IQ(Iqb,Jqb),1);
  size(handles.Q)
  figure;
  ax = axes;
  hold(ax,'on');
  plot(Ibkg,'-o')
  pause
  [Qxspecularindices] = find(handles.Qx > Qxmax & handles.Qx < -Qxmax);
  [Iqs,Jqs] = ind2sub(size(handles.Qx),Qxspecularindices);
  handles.ISpecular = sum(handles.IQ(Iqs,Jqs),1);
  
  plot(handles.ISpecular,'-x')
  
  figure
  [Qxspecularindices] = find(handles.Qx > Qxmax & handles.Qx < -Qxmax);
  [Iqs,Jqs] = ind2sub(size(handles.Qx),Qxspecularindices);
  handles.ISpecular = sum(handles.IQ(Iqs,Jqs),1);
  for i = 1:400
   plot(handles.Qx(:,i),handles.IQ(:,i),'-')
   pause
  end
  size(handles.ISpecular)
  size(Ibkg)
  
  set(gca,'YScale','log');
  %handles.ISpecular = handles.ISpecular - Ibkg;

end
end


end
delete(h);


function datapoint = processImage(datapoint)

  if ~datapoint.hasROI
  
    datapoint.imLog    = log10(single(datapoint.im)+eps);

    datapoint.Integr   = sum(sum(datapoint.im));
    datapoint.sIntegr  = sqrt(datapoint.Integr);
    
    Xi  = sum(datapoint.im,1);
    sXi = sqrt(Xi);
    datapoint.bIntegr  = 0;
    datapoint.sbIntegr = 0;
    
    % probably don't need to repeat this code for every case, pretty
    % sloppy. TODO: refactor into function.
    
    if datapoint.hasBackROI
      datapoint.imb = datapoint.im(datapoint.btop:datapoint.bbottom,...
      datapoint.bstart:datapoint.bend);
      bpixelarea = abs(datapoint.btop-datapoint.bbottom)*abs(datapoint.bstart-datapoint.bend);
      dpixelarea = abs(datapoint.top-datapoint.bottom)*abs(datapoint.start-datapoint.end);
      
      datapoint.bIntegr  = sum(sum(datapoint.imb));
      datapoint.sbIntegr  = sqrt(datapoint.bIntegr);
      datapoint.Integr    = datapoint.Integr - datapoint.bIntegr*dpixelarea/bpixelarea;

      datapoint.sIntegr   = sqrt( (datapoint.sIntegr)^2 + (datapoint.sbIntegr*(dpixelarea/bpixelarea))^2 );   
    elseif datapoint.hasBackROI_2
      datapoint.imb1 = datapoint.im(datapoint.b21top:datapoint.b21bottom,...
      datapoint.b21start:datapoint.b21end);
      datapoint.imb2 = datapoint.im(datapoint.b22top:datapoint.b22bottom,...
      datapoint.b22start:datapoint.b22end);
  
      bpixelarea1 = abs(datapoint.b21top-datapoint.b21bottom)*abs(datapoint.b21start-datapoint.b21end);
      bpixelarea2 = abs(datapoint.b22top-datapoint.b21bottom)*abs(datapoint.b22start-datapoint.b22end);
      dpixelarea = abs(datapoint.top-datapoint.bottom)*abs(datapoint.start-datapoint.end);
      
      datapoint.bIntegr  = (sum(sum(datapoint.imb1)) + sum(sum(datapoint.imb2)))/2;
      datapoint.sbIntegr = sqrt( (0.5*sum(sum(datapoint.imb1))).^2 + (0.5*sum(sum(datapoint.imb2))).^2);
      datapoint.Integr   = datapoint.Integr - datapoint.bIntegr*dpixelarea/(bpixelarea1+bpixelarea2);
      datapoint.sIntegr  = sqrt( (datapoint.sIntegr)^2 + (datapoint.sbIntegr*(dpixelarea/(bpixelarea1+bpixelarea2)))^2 );     
        
    end
    
    datapoint.allproject = Xi;
    datapoint.project  = Xi;

    datapoint.uproject = sXi;
    datapoint.start    = 1;
    datapoint.end      = length(datapoint.project);
  else
    datapoint.imROI   = datapoint.im(datapoint.top:datapoint.bottom,...
       datapoint.start:datapoint.end);
   
    datapoint.imROILog    = datapoint.imLog(datapoint.top:datapoint.bottom,...
       datapoint.start:datapoint.end);
   %  datapoint.imROILog    = log10(datapoint.imROI);


    datapoint.project  = sum(datapoint.imROI,1)';
    datapoint.allproject  = sum(datapoint.im,1)';

    datapoint.uproject = sqrt( datapoint.project)';
    datapoint.Integr   = sum(sum(datapoint.imROI));
    datapoint.sIntegr  = sqrt(datapoint.Integr);
    datapoint.bIntegr  = 0;
    datapoint.sbIntegr = 0;
    

    if datapoint.hasBackROI
      datapoint.imROIb = datapoint.im(datapoint.btop:datapoint.bbottom,...
      datapoint.bstart:datapoint.bend);
  
      datapoint.bIntegr   = sum(sum(datapoint.imROIb));
      datapoint.sbIntegr  = sqrt(datapoint.bIntegr);
      bpixelarea = abs(datapoint.btop-datapoint.bbottom)*abs(datapoint.bstart-datapoint.bend);
      dpixelarea = abs(datapoint.top-datapoint.bottom)*abs(datapoint.start-datapoint.end);

      datapoint.Integr    = datapoint.Integr - datapoint.bIntegr*(dpixelarea/bpixelarea);
      datapoint.sIntegr   = sqrt( (datapoint.sIntegr)^2 + (datapoint.sbIntegr*(dpixelarea/bpixelarea))^2 );   
    elseif datapoint.hasBackROI_2
      datapoint.imb1 = datapoint.im(datapoint.b21top:datapoint.b21bottom,...
      datapoint.b21start:datapoint.b21end);
      datapoint.imb2 = datapoint.im(datapoint.b22top:datapoint.b22bottom,...
      datapoint.b22start:datapoint.b22end);
  
      bpixelarea1 = abs(datapoint.b21top-datapoint.b21bottom)*abs(datapoint.b21start-datapoint.b21end);
      bpixelarea2 = abs(datapoint.b22top-datapoint.b21bottom)*abs(datapoint.b22start-datapoint.b22end);
      dpixelarea = abs(datapoint.top-datapoint.bottom)*abs(datapoint.start-datapoint.end);
      
      datapoint.bIntegr  = (sum(sum(datapoint.imb1)) + sum(sum(datapoint.imb2)))/2;
      datapoint.sbIntegr = sqrt( (0.5*sum(sum(datapoint.imb1))).^2 + (0.5*sum(sum(datapoint.imb2))).^2);

      datapoint.Integr   = datapoint.Integr - datapoint.bIntegr*dpixelarea/(bpixelarea1+bpixelarea2);
      datapoint.sIntegr  = sqrt( (datapoint.sIntegr)^2 + (datapoint.sbIntegr*(dpixelarea/(bpixelarea1+bpixelarea2)))^2 );   
        
    end
   
    
    Xi  = sum(datapoint.imROI,1);
    sXi = sqrt(Xi);
    
    datapoint.project  = Xi;
    datapoint.uproject = sXi;
    

  end
  
  datapoint.pixel = datapoint.start:1:datapoint.end;
  datapoint.COG = trapz(datapoint.pixel,datapoint.project.*datapoint.pixel)./trapz(datapoint.pixel,datapoint.project);

end

end