function sim = model(p,S)
  
  handles = S.handles;
 
  
  % p is an assembly of [thick rough dens] but only those values that
  % should be varied according to fitThick,fitRough,fitDens.
  % makeVector inserts the new trial values into the the thick,rough and
  % dens vectors at the right positions. The mask keeps track of where
  % to put them since p is ordered.
  %origRough = handles.rough';
  %origThick = handles.d';
  %origDens = handles.dens';
  rep = handles.repMask;
  repSize = S.repSize;
  currentRough = makeVector(p,handles.rough,handles.roughMask,S.M,rep,repSize);
  currentThick = makeVector(p,handles.d,handles.thickMask,0,rep,repSize);
  currentDens  = makeVector(p,handles.dens,handles.densMask,S.M+S.N,rep,repSize);
  currentMagn  = makeVector(p,handles.magn,handles.magnMask,S.M+S.N+S.O,rep,repSize);
  currentMagnAngle  = makeVector(p,handles.magnAng,handles.magnAngMask,S.M+S.N+S.O+S.P,rep,repSize);

  currentDeltap = real((handles.sld+handles.sld_m)./(handles.dens+eps).*currentDens')./(2*pi)*handles.wavelength^2;
  currentDeltam = real((handles.sld-handles.sld_m)./(handles.dens+eps).*currentDens')./(2*pi)*handles.wavelength^2;
  currentBeta  = -imag(handles.sld./(handles.dens+eps).*currentDens')./(2*pi)*handles.wavelength^2;
  S.currentRough = currentRough;
  S.currentThick = currentThick;
  S.currentDens  = currentDens;
  S.currentSLD   = handles.sld./(handles.dens+eps).*currentDens';
  S.currentSLDM   = handles.sld_m./(handles.dens+eps).*currentDens';
  S.currentNdens = handles.ndens./(handles.dens+eps).*currentDens';
  
  pp = 2.695e-5; % Angstrom/mubohr 
  S.currentSld_m = S.currentNdens(:)*pp.*currentMagn(:);
   [simuu,~] = parratt(S.Q(:),handles.wavelength,currentDeltap(:),currentBeta(:),currentThick(:),currentRough(:));
   [simdd,~] = parratt(S.Q(:),handles.wavelength,currentDeltam(:),currentBeta(:),currentThick(:),currentRough(:));
  
%    a=S.currentSLD
%    b=S.currentSLDM
%    c=handles.theta
%    d = currentThick
%    e = currentRough
%    f = handles.wavelength
%    pause
%currentThick
%currentMagn
%currentDens

   [simRuu,simRud,simRdu,simRdd,simTuu,simTud,simTdu,simTdd,qu] = calc_spinrefl_v9(S.Q(:),S.currentSLD,S.currentSld_m',currentMagnAngle',...
        currentThick',currentRough',handles.wavelength,length(currentThick),length(S.Q));
     % handles.Qsim   = handles.Qsim(2:end);
      %handles.Ruu = handles.Ruu(2:end);
      %handles.Rud = handles.Rud(2:end);
      %handles.Rdu = handles.Rdu(2:end);
      %handles.Rdd = handles.Rdd(2:end);
      %handles.Res = handles.Res(2:end);
  
    % handles.BeamDivergence = get(handles.edtResolution,'String');

     simRuu = GaussConv(S.Q,simRuu,p(end)+eps);
     simRuu = simRuu.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     simRud = GaussConv(S.Q,simRud',p(end)+eps);
     simRud = simRud.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     simRdu = GaussConv(S.Q,simRdu',p(end)+eps);
     simRdu = simRdu.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     simRdd = GaussConv(S.Q,simRdd',p(end)+eps);
     simRdd = simRdd.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     
     simuu = GaussConv(S.Q,simuu,p(end)+eps);
     simuu = simuu.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     simdd = GaussConv(S.Q,simdd,p(end)+eps);
     simdd = simdd.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),handles.SampleLength,p(end-1)).*p(end-2);
     %SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),50,p(end-1));
 
% 0.98638
 % sim(1) = 1;
 
  %sim = sim.*SquareIntensity(asind(S.Q(:)*handles.wavelength/4/pi),50,p(end-1));

  %sim = GaussConv(S.Q(:),sim,p(end)+eps);
 
  sim(:,1) = simRuu;
  sim(:,2) = simRud+eps;
  sim(:,3) = simRdu+eps;
  sim(:,4) = simRdd;
  
  sim(:,1) = simuu;
   sim(:,2) = simRud+eps;
  sim(:,3) = simRdu+eps;
  sim(:,4) = simdd;
 %
 
end