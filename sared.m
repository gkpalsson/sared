function varargout = sared(varargin)
% SARED MATLAB code for sared.fig
%      SARED, by itself, creates a new SARED or raises the existing
%      singleton*.
%
%      H = SARED returns the handle to a new SARED or the handle to
%      the existing singleton*.
%
%      SARED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SARED.M with the given input arguments.
%
%      SARED('Property','Value',...) creates a new SARED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sared_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sared_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sared

% Last Modified by GUIDE v2.5 16-Jan-2015 14:37:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sared_OpeningFcn, ...
                   'gui_OutputFcn',  @sared_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

  function handles = reInitialize(handles,hObject)
    handles.preferences = preferences('Visible','off');
    settings            = load('settings.mat');
    
    handles.settings     = settings;
    
    handles.ReflPlot1    = 'Integrated Intensity';
    handles.ReflPlot2    = '';
    
    handles.ReflYScaleState = 'log';
    handles.ReflYScaleState2 = 'lin';
    handles.ReflXScaleState = 'Q_z';
    handles.ReflYLabel1     = 'Integrated intensity [counts]';
    handles.ReflYLabel2     = 'Integrated intensity [counts]';
    
    handles.ReflXLabel      = ['Q_z [',char(197),'^{-1}]'];
    handles.ReflXLabel1     = ['Q_z [',char(197),'^{-1}]'];
    %set(handles.secondaxes,'Visible','off');
    %set(handles.reflectivityaxes,'Visible','off');
    handles.ReflCurrentYData1 = [];
    handles.ReflCurrentXData1 = [];
    handles.ReflCurrentYData2 = [];
    handles.ReflCurrentXData2 = [];
    handles.ReflCurrentsYData1 = [];
    handles.ReflCurrentsYData2 = [];
    handles.ReflCurrentAllXData1 = [];
    handles.ReflCurrentAllXData2 = [];
    handles.ReflCurrentYData3 = [];
    handles.ReflCurrentsYData3 = [];
    handles.ReflCurrentAllYData3 = [];
    handles.ReflCurrentAllsYData3 = [];
    handles.ReflCurrentAllXData3 = [];
    
    handles.RawCurrentAllXData1 = [];
    handles.RawCurrentAllXData2 = [];
    handles.RawCurrentAllCData  = [];
    handles.RawCurrentXData1 = [];
    handles.RawCurrentXData2 = [];
    handles.RawCurrentCData  = [];
    handles.a = [];
    handles.p = [];
    
    handles.isMakingROI = 0;
    handles.isMakingBROI = 0;
   
    
    %handles.dropdReflString  = {'Integrated Intensity','Fitted Intensity','Monitor','Background','Gauss TwoTheta','Temperature','Magnetic Field'};
    handles.dropdReflString2  = {'None','Monitor','Time','ISpecular',...
      'Sample slit width','First slit width','Divergence','Beam width at sample',...
      'dq_x specular','dq_z specular','Coherence length x','Coherence length z'};
    
    handles.dropdMarkerString = {'Markers','Line','Markers+Line'};
    set(handles.dropdMarker,'String',handles.dropdMarkerString);
    %handles.dropdReflString2  = {'Monitor','Time','New Time','No background subtracted','dI/I','New Theta','Temperature','Magnetic Field',...
    %  'Sample Slit Width','mono slit width','Divergence','Beam width at sample',...
    %  'dq_x specular','dq_z specular','Coherence length x','Coherence length z'};
    handles.dropdReflString   = {''};
    handles.dropdReflString3   = {'None'};
    
    handles.kxkzXLabel      = ['Q_x [',char(197),'^{-1}]'];
    handles.kxkzYLabel      = ['Q_z [',char(197),'^{-1}]'];
    
    handles.rawXLabel      = 'Horizontal detector [pixel]';
    handles.rawYLabel      = 'Vertical detector [pixel]';
    
    %handles.projectedYLabel = 'intensity [counts]';
    %handles.projectedXLabel = handles.rawXLabel;
    handles.projectedYScaleState = 'lin';
    
    handles.KXKZXScaleState = 'Q_x, Q_z';
    handles.KXKZSpinState   = 'uu';
    handles.dropdKXKZString = {''};
    
    handles.DAT.ROI = -1;
    
    
    set(handles.dropdRefl,'String',handles.dropdReflString);
    set(handles.dropdRefl2,'String',handles.dropdReflString2);
    set(handles.dropdRefl3,'String',handles.dropdReflString3);
    set(handles.dropdXaxis1,'String',{'Q_z','Theta','TwoTheta'});
    set(handles.dropdXaxis2,'String',{'Q_x, Q_z','pixel, data points','Theta, TwoTheta/2'});
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    
    dropdkxkzColor = {'Autumn','Beach','BlackBodyRadiation','BlackBodyRadiation',...
      'BlueIn','BlueOut','BlueOut','BlueRed','BP','BPG','BWB','ColdFire','Colors',...
      'Cool','Gamma1','Gamma2','GreenIn','GreenOut','GreenToWhite','Grey','IDL-rainbow',...
      'Indigo','Jet','Lace','Rainbow','RBY','RedIn','RedOut','RosePetals','TouchOfBlues',...
      'Volcano','YellowToBlack'};
    
    themap = load('maps/ColdFire.map');
    handles.kxkzmap = colormap(themap/255);
    handles.SampleLength = handles.settings.length;
    set(handles.popColor,'String',dropdkxkzColor);
    set(handles.popColor','Value',12);
    axes(handles.rawaxes);
    xlabel('H Detector Position [pixel]');
    ylabel('V Detector Position [pixel]');
    handles.mnuFitDataString = {'None'};
    set(handles.mnuFit,'String',handles.mnuFitDataString);
    length(handles.mnuFitDataString)
    set(handles.mnuFit,'Value',length(handles.mnuFitDataString));
    %axes(handles.projectedaxes);
    %xlabel('H Detector Position [pixel]');
    %ylabel('Integrated Intensity [counts]');
    
    axes(handles.kxkzaxes)
    xlabel(handles.kxkzXLabel);
    ylabel(handles.kxkzYLabel);
    
    axes(handles.reflectivityaxes)
    %xlabel(handles.ReflXLabel);
    %ylabel(handles.ReflYLabel1);
    
    
    handles.rawcbar = [];
    
    handles.hasRunRaw    = 0;
    handles.listExists   = 0;
    handles.Qplotscale   = 1;
    handles.rawplotscale = 0;
    handles.hasPopulated_unpolarized = 0;
    handles.hasPopulated_uu = 0;
    handles.hasPopulated_dd = 0;
    handles.hasPopulated_ud = 0;
    handles.hasPopulated_du = 0;
    handles.hasSpinCorrected = 0;
    handles.listDirectExists = 0;
    handles.doMonitor    = 0;
    handles.doBackground = 0;
    handles.doThetaOffset = 0;
    handles.doOverIllumination = 0;
    handles.hasPopulated_bkg = 0;
    handles.currentList = 'data';
    handles.doNormalize = 0;
    handles.doPolarizationCorrection = 1;
    handles.ThetaOffset = 0;
    
    handles.experiment = {};
    handles.db         = {};
    
    handles.tabgp = uitabgroup(gcf,'Position',[0.00 0.00 1.00 1.00]);
    
    handles.tab1 = uitab(handles.tabgp,'Title','Raw Images');
    handles.tab2 = uitab(handles.tabgp,'Title','Reflectivity');
    handles.tab5 = uitab(handles.tabgp,'Title','Fitting');
    handles.tab3 = uitab(handles.tabgp,'Title','2D maps');
    handles.tab4 = uitab(handles.tabgp,'Title','Other Results');
 
    
    set(handles.pnlRaw,'Parent',handles.tab1);
    set(handles.tab1,'BackgroundColor','w');
    set(handles.tab2,'BackgroundColor','w');
    set(handles.tab3,'BackgroundColor','w');
    set(handles.tab4,'BackgroundColor','w');
    set(handles.tab5,'BackgroundColor','w');
    
    set(handles.pnlProcess,'Parent',handles.tab2);
    set(handles.pnl2D,'Parent',handles.tab3);
    set(handles.pnlMisc,'Parent',handles.tab4);
    set(handles.pnlFit,'Parent',handles.tab5);
    
    
    set(handles.pnlRaw,'Position',[0.0 0.0 1.0 1.0]);
    set(handles.pnlProcess,'Position',[0.0 0.0 1.0 1.0]);
    set(handles.pnl2D,'Position',[0.0 0.0 1.0 1.0]);
    set(handles.pnlMisc,'Position',[0.0 0.0 1.0 1.0]);
    
    set(handles.pnlFit,'Position',[0.0 0.0 1.0 1.0]);
    
    set(handles.secondaxes,'Position',get(handles.reflectivityaxes,'Position'));
    set(handles.pnlFileList,'Position',[0 0 0.1 1.0]);
    set(handles.rawaxes,'Position',[0.3 0.1 0.5 0.8]);
    handles.ProjectionVisible = 0;
    
    set(handles.axes3D,'Position',[0.35 0.2 0.5 0.5]);
    set(handles.axes3D,'Visible','on');
    set(handles.kxkzaxes,'Position',[0.3 0.1 0.5 0.8]);
    
    set(handles.chkProjection,'Position',[0.15 0.8 0.1 0.05]);
    
    set(handles.projectedaxes,'Visible','off');
    set(get(handles.projectedaxes,'Children'),'Visible','off');
    handles.ProjectionVisible = 0;
    %set(handles.projectedaxes,'Position',[0.1 0.1 0.9 0.2]);
    set(handles.rawaxes,'Position',[0.3 0.1 0.5 0.8]);
    set(handles.tglRawLog,'Position',[0.15 0.7 0.1 0.05]);
    set(handles.tglProjectedLog,'Position',[0.15 0.3 0.1 0.05]);
    
    set(handles.txtData,'Position',[0.0 0.95 1.0 0.04]);
    set(handles.txtDirect,'Position',[0.0 0.26 1.0 0.025]);
    %pos = get(handles.dropdRefl,'Position');
    %pos(3) = pos(3)/3;
    %set(handles.dropdRefl,'Position',pos);
    %pos(1) = pos(1) + pos(3)+0.01;
    
    %set(handles.dropdRefl3,'Position',pos);
    
    set(handles.dropdRefl3,'Value',1);
    set(handles.dropdRefl,'Position',[0.0 0.95 0.1 0.05]);
    set(handles.dropdRefl3,'Position',[0.15 0.95 0.1 0.05]);
    set(handles.btnAddLayer,'Position',[0.1 0.95 0.05 0.05]);
    set(handles.btnRemove,'Position',[0.1 0.90 0.05 0.05]);
    handles.hDetectorRect = [];
    handles.Refl1Marker = 'o';
    handles.Refl2Marker = 'o';
    handles.Refl3Marker = 'o';
    set(handles.dropdMarker,'Position',[0.3 0.95 0.11 0.05]);
    
  handles.ProjectionVisible = 1;
  set(handles.projectedaxes,'Visible','on');
   set(get(handles.projectedaxes,'Children'),'Visible','on');
 
  set(handles.rawaxes,'Position',[0.4 0.3 0.4 0.6]);
  set(handles.rawaxes,'Clipping','on');
  axis(handles.rawaxes,'tight');
  
  projPos = get(handles.rawaxes,'Position');
  projPos(4) = 0.2;
  projPos(2) = 0.05;
  %projPos(1) = 0.34;
  projPos(3) = 0.4;
  set(handles.rawaxes,'XTick',[]);
  xlabel(handles.rawaxes,'');
  %set(handles.projectedaxes,'DataAspectRatio',[1 14.5 1]);
  set(handles.projectedaxes,'Position',projPos);
  set(handles.chkProjection,'Value',1);
  
  % FITTING
  
  set(handles.edtChemical,'Position',[0.27 0.87 0.2 0.10]);
  set(handles.txtChemical,'Position',[0.0 0.85 0.25 0.10]);
  set(handles.txtIntegers,'Position',[0.48 0.85 0.25 0.10]);
  
  set(handles.edtDensity,'Position',[0.27 0.72 0.2 0.12]);
  set(handles.txtDensity,'Position',[0.0 0.74 0.22 0.10]);
  set(handles.chkDens,'Position',[0.03 0.67 0.2 0.1]);
  set(handles.btnFindDensity,'Position',[0.5 0.72 0.2 0.1]);
  
  set(handles.edtRoughness,'Position',[0.27 0.57 0.2 0.12]);
  set(handles.txtRoughness,'Position',[0.0 0.57 0.2 0.10]);
  set(handles.chkRough,'Position',[0.03 0.51 0.2 0.1]);
  
  set(handles.edtThickness,'Position',[0.27 0.42 0.2 0.12]);
  set(handles.txtThickness,'Position',[0.0 0.40 0.2 0.10]);
  set(handles.chkThick,'Position',[0.03 0.33 0.2 0.1]);
  
  set(handles.edtMagn,'Position',[0.75 0.57 0.2 0.12]);
  set(handles.txtMagnetisation,'Position',[0.5 0.48 0.2 0.20]);
  set(handles.chkMagn,'Position',[0.52 0.44 0.2 0.1]);

  
  set(handles.edtMagnAngle,'Position',[0.75 0.30 0.2 0.12]);
  set(handles.txtMagnetisationAngle,'Position',[0.48 0.25 0.25 0.20]);
  set(handles.chkMagnAng,'Position',[0.51 0.16 0.2 0.1]);

  
  set(handles.btnUpdateLayer,'Position',[0.70 0.05 0.3 0.1]);
  
  set(handles.edtSampleLength,'Position',[0.30 0.65 0.15 0.12]);
  set(handles.txtSampleLength,'Position',[0.03 0.65 0.25 0.12]);
  set(handles.edtI0,'Position',[0.30 0.80 0.15 0.12]);
  set(handles.txtI0,'Position',[0.03 0.80 0.25 0.12]);
  set(handles.edtBeamWidth,'Position',[0.75 0.80 0.25 0.12]);
  set(handles.txtBeamWidth,'Position',[0.48 0.80 0.25 0.12]);
  set(handles.edtResolution,'Position',[0.75 0.65 0.25 0.12]);
  set(handles.txtResolution,'Position',[0.48 0.65 0.25 0.12]);
  set(handles.mnuProbe,'Position',[0.28 0.45 0.25 0.12]);
  set(handles.txtProbe,'Position',[0.03 0.45 0.2 0.12]);
  set(handles.edtQ,'Position',[0.30 0.3 0.2 0.12]);
  set(handles.txtQ,'Position',[0.03 0.3 0.2 0.12]);
  set(handles.edtWavelength,'Position',[0.30 0.15 0.2 0.12]);
  set(handles.txtWavelength,'Position',[0.03 0.13 0.25 0.12]);
  set(handles.btnAddLayer,'Position',[0.01 0.905 0.11 0.08]);
  
  set(handles.btnAdd,'Position',[0.1 0.95 0.05 0.05]);
  set(handles.tglRawLog,'Position',[0.85 0.7 0.1 0.1]);
  set(handles.tglProjectedLog,'Position',[0.85 0.1 0.1 0.1]);
  set(handles.chkProjection,'Position',[0.85 0.9 0.2 0.1]);
%set(handles.lstLayers,'Value',2);
handles.N = 2;

theLayer.thick = 1e5;
theLayer.rough = 0;
theLayer.dens  = 3.58;
theLayer.chem  = 'Mg1O1';
handles.wavelength = handles.settings.wavelength;
handles.Probe = 2;

[theLayer.sld,theLayer.ndens] = getSLD(theLayer.chem,theLayer.dens,handles.wavelength,handles.Probe);
theLayer.magn       = 0;
theLayer.magnAngle  = 0;
theLayer.Rep        = 0;
theLayer.LinkIdx    = 0;
theLayer.fitRough   = 1;
theLayer.fitDens    = 1;
theLayer.fitThick   = 0;
theLayer.fitMagn    = 0;
theLayer.fitMagnAng = 0;

set(handles.chkRough,'Value',theLayer.fitRough);
set(handles.chkThick,'Value',theLayer.fitThick);
set(handles.chkDens,'Value',theLayer.fitDens);


set(handles.edtMagn,'String',num2str(theLayer.magn));
set(handles.edtMagnAngle,'String',num2str(theLayer.magnAngle));
set(handles.edtChemical,'String',num2str(theLayer.chem));
set(handles.edtDensity,'String',num2str(theLayer.dens));
set(handles.edtRoughness,'String',num2str(theLayer.rough));
set(handles.edtThickness,'String',num2str(theLayer.thick));

handles.LinkIdx = 1;

handles.TLayers{1} = theLayer;

theLayer.thick = 1e5;
theLayer.rough = 0;
theLayer.dens  = 0;
theLayer.chem  = 'N4O1';
[theLayer.sld,theLayer.ndens] = getSLD(theLayer.chem,theLayer.dens,handles.wavelength,handles.Probe);
theLayer.magn       = 0;
theLayer.magnAngle  = 0;
theLayer.Rep        = 0;
theLayer.fitRough   = 1;
theLayer.fitDens    = 1;
theLayer.fitThick   = 0;
theLayer.fitMagn    = 0;
theLayer.fitMagnAng = 0;

set(handles.chkRough,'Value',theLayer.fitRough);
set(handles.chkThick,'Value',theLayer.fitThick);
set(handles.chkDens,'Value',theLayer.fitDens);
set(handles.chkMagn,'Value',theLayer.fitMagn);
set(handles.chkMagnAng,'Value',theLayer.fitMagnAng);


handles.TLayers{2} = theLayer;

%handles = parseLayers(handles);
%set(handles.lstLayers,'String',handles.Layers);
handles.data = [];
handles.currentIndex = 2;

% Update handles structure

handles.tabgpFitting = uitabgroup(handles.pnlFit,'Position',[0.0 0.5 0.40 0.5]);

handles.tabFitting1 = uitab(handles.tabgpFitting,'Title','Layer');
handles.tabFitting2 = uitab(handles.tabgpFitting,'Title','Instrument');

set(handles.tabFitting1,'BackgroundColor','w');
set(handles.tabFitting2,'BackgroundColor','w');

set(handles.pnlMaterial,'Parent',handles.tabFitting1);
%set(handles.tab1,'BackgroundColor','w');
%set(handles.tab2,'BackgroundColor','w');
set(handles.pnlInstrument,'Parent',handles.tabFitting2);

set(handles.pnlMaterial,'Position',[0. 0. 1 1]);
set(handles.pnlInstrument,'Position',[0. 0. 1 1]);
handles.I0 = 1;
%handles.I0 = get(handles.edtI0,'Value');

handles.BeamWidth    = get(handles.edtBeamWidth,'Value');
handles.BeamDivergence    = get(handles.edtResolution,'Value');
handles.Probe    = get(handles.mnuProbe,'Value');
handles.Q = get(handles.edtQ,'Value');
handles.Checked = zeros(2,1);

handles.tabgpTable = uitabgroup(handles.pnlFit,'Position',[0.4 0.5 0.60 0.5]);

handles.tabtheTable = uitab(handles.tabgpTable,'Title','Parameters');
set(handles.tabtheTable,'BackgroundColor','w');

set(handles.pnlTable,'Parent',handles.tabtheTable);

set(handles.pnlTable,'Position',[0.0 0.0 1.0 1.0]);

set(handles.pnlFitAxes,'Parent',handles.pnlFit);
set(handles.pnlFitAxes,'Position',[0 0 1.0 1.0]);
set(handles.axesFit,'Parent',handles.pnlFitAxes);
set(handles.axesFit,'Position',[0.17 0.05 0.80 0.42]);
set(handles.mnuAllData,'Parent',handles.pnlFitAxes);
set(handles.mnuAllData,'Position',[0.0 0.35 0.14 0.12]);
set(handles.mnuFit,'Parent',handles.pnlFitAxes);
set(handles.mnuFit,'Position',[0.0 0.20 0.14 0.12]);
%set(handles.mnuFit,'String',' ');
%set(handles.mnuFit,'Value',1);
set(handles.mnuAllData,'String',' ');
set(handles.mnuAllData,'Value',1);
set(handles.btnAddtoFit,'Parent',handles.pnlFitAxes);
set(handles.btnAddtoFit,'Position',[0.0 0.34 0.06 0.05]);
set(handles.btnRemovefromFit,'Parent',handles.pnlFitAxes);
set(handles.btnRemovefromFit,'Position',[0.06 0.34 0.08 0.05]);
generateStack(hObject,handles);
    return;

    
function [tableData,chemStr,latexTable] = generateReducedStack(handles)


lay = handles.TLayers;

for i = 1:handles.N

  chemStr{i} = lay{i}.chem;
  link(i) = logical(handles.Checked(handles.N-i+1));
  d(i) = lay{i}.thick;
  rough(i) = lay{i}.rough;
  dens(i) = lay{i}.dens;
  ndens(i) = lay{i}.ndens;
  sld(i) = lay{i}.sld;

  magn(i) = lay{i}.magn;
  magnAngle(i) = lay{i}.magnAngle;
  Rep(i) = lay{i}.Rep;
  
  end
tableData = [num2cell(flip(link(:))) num2cell(flip(d(:))) num2cell(flip(rough(:))) num2cell(flip(dens(:))) ...
  num2cell(flip(ndens(:))) num2cell(real(flip(sld(:)))) num2cell(imag(flip(sld(:)))),num2cell(flip(magn(:))),num2cell(flip(magnAngle(:))),num2cell(flip(Rep(:)))];
 
  
  latexTable = [d(:),rough(:),real(sld(:))*1e6,imag(sld(:))*1e6,magn(:),magnAngle(:)];

return;


function [sld,chem,d,ndens,dens,rough,magn,magnAng,roughMask,thickMask,densMask,magnMask,magnAngMask] = populateStack(j,RepSize,lay)
  
% Populate from j to j+RepSize
roughMask = zeros(1,RepSize);
thickMask = zeros(1,RepSize);
densMask = zeros(1,RepSize);
magnMask = zeros(1,RepSize);
magnAngMask = zeros(1,RepSize);


for k = j:1:(j+RepSize-1)
  
  sld(k-j+1)     = lay{k}.sld;
  chem{k-j+1}    = lay{k}.chem;
  d(k-j+1)       = lay{k}.thick;
  ndens(k-j+1)   = lay{k}.ndens;
  dens(k-j+1)    = lay{k}.dens;
  rough(k-j+1)   = lay{k}.rough;
  magn(k-j+1)    = lay{k}.magn;
  magnAng(k-j+1) = lay{k}.magnAngle;
  
  if lay{k}.fitRough roughMask(k-j+1)   = 1; end
  if lay{k}.fitThick thickMask(k-j+1)   = 1; end
  if lay{k}.fitDens densMask(k-j+1)   = 1; end
  if lay{k}.fitMagn magnMask(k-j+1)   = 1; end
  if lay{k}.fitMagnAng magnAngMask(k-j+1)   = 1; end
end
%     if length(lay{j}.magn) > 1
%       if mod(i,2)
%         magn(2*i)   = lay{j+1}.magn(1,1);
%       else
%         magn(2*i)   = lay{j+1}.magn(1,2);
%       end
%     else
%       magn(2*i)   = lay{j+1}.magn(1,1);
%     end
%     if length(lay{j+1}.magn) > 1
%       if mod(i,2)
%         magn(2*i-1) = lay{j}.magn(1,1);
%       else
%         magn(2*i-1) = lay{j}.magn(1,2);
%       end
%     else
%       magn(2*i-1) = lay{j}.magn(1,1);
%     end
%     
%     
%     if length(lay{j+1}.magnAngle) > 1 
%       if mod(i,2)
%         theta(2*i)   = lay{j+1}.magnAngle(1,1);
%       else
%         theta(2*i)   = lay{j+1}.magnAngle(1,2);
%       end
%     else
%       theta(2*i)   = lay{j+1}.magnAngle(1,1);
%     end
%     if length(lay{j}.magnAngle) > 1
%       if mod(i,2)
%         theta(2*i-1) = lay{j}.magnAngle(1,1);
%       else
%         theta(2*i-1) = lay{j}.magnAngle(1,2);
%       end
%     else
%       theta(2*i-1) = lay{j}.magnAngle(1,1);
%     end
return;



    
function handles = generateStack(hObject,handles)

lay = handles.TLayers;

j = 1;
handles.sld   = [];
handles.d     = [];
handles.magn  = [];
handles.magnAng  = [];
handles.theta = [];
handles.rough = [];
handles.ndens = [];
handles.roughMask = [];
handles.thickMask = [];
handles.densMask = [];
handles.magnMask = [];
handles.magnAngMask = [];
handles.dens  = [];
handles.fitthickpars = []; 
handles.fitroughpars = [];
handles.fitdenspars  = [];
handles.fitmagnpars = [];
handles.fitmagnangpars = [];
handles.chem  = {};
handles.repMask = [];

% Go Through all the layers
while j<=handles.N 

  if lay{j}.Rep == 0
    sld   = lay{j}.sld;
    d     = lay{j}.thick;
    rough = lay{j}.rough;
    magn  = lay{j}.magn;
    magnAng = lay{j}.magnAngle;
    ndens = lay{j}.ndens;
    dens  = lay{j}.dens;
    chem  = lay{j}.chem;
    thickMask = 0;
    densMask = 0;
    roughMask = 0;
    magnMask = 0;
    magnAngMask = 0;
    repMask = 1;
    
   
    if lay{j}.fitThick 
      thickMask   = 1;
      handles.fitthickpars = [handles.fitthickpars d];
    end
    if lay{j}.fitDens  
       densMask    = 1;
       handles.fitdenspars = [handles.fitdenspars dens];
    end    
    if lay{j}.fitRough
      roughMask   = 1; 
      handles.fitroughpars = [handles.fitroughpars rough];
    end
    if lay{j}.fitMagn
      magnMask   = 1; 
      handles.fitmagnpars = [handles.fitmagnpars magn];
    end
    if lay{j}.fitMagnAng
      magnAngMask   = 1; 
      handles.fitmagnangpars = [handles.fitmagnangpars magnAng];
    end
    
  elseif lay{j}.Rep ~= 0

    RepSize = sum(handles.Checked);
%     sld   = zeros(1,RepSize*lay{j}.Rep);
%     magn  = zeros(1,RepSize*lay{j}.Rep);
%     magnAng = zeros(1,RepSize*lay{j}.Rep);
%     d     = zeros(1,RepSize*lay{j}.Rep);
%     rough = zeros(1,RepSize*lay{j}.Rep);
%     theta = zeros(1,RepSize*lay{j}.Rep);
%     ndens = zeros(1,RepSize*lay{j}.Rep);
%     thickMask = zeros(1,RepSize*lay{j}.Rep);
%     densMask = zeros(1,RepSize*lay{j}.Rep);
%     roughMask = zeros(1,RepSize*lay{j}.Rep);
    
      sld   = [];
    magn  = [];
    magnAng = [];
    d     = [];
    rough = [];
    dens = [];

    ndens = [];
    thickMask = [];
    densMask = [];
    roughMask = [];
    magnMask = [];
    magnAngMask = [];
    repMask = [];
    chem = {};
    
  for i = 1:lay{j}.Rep
    
   [sldc,chemc,dc,ndensc,densc,roughc,magnc,magnAngc,roughMaskc,thickMaskc,densMaskc,magnMaskc,magnAngMaskc] = populateStack(j,RepSize,lay);
  
   sld = [sld sldc];
   chem = [chem chemc];
   d    = [d dc];
   ndens = [ndens ndensc];
   dens  = [dens densc];
   rough = [rough roughc];
   magn  = [magn magnc];
   magnAng = [magnAng magnAngc];
   
   roughMask = [roughMask roughMaskc];
   thickMask = [thickMask thickMaskc];
   densMask  = [densMask densMaskc];
   magnMask  = [magnMask magnMaskc];
   magnAngMask = [magnAngMask magnAngMaskc];
   
   for m = 1:RepSize
     repMask   = [repMask lay{j}.Rep];
   end
  end
  
  for l =1:RepSize
     if thickMaskc(l)
       handles.fitthickpars = [handles.fitthickpars dc(l)];
     end
     if roughMaskc(l)
       handles.fitroughpars = [handles.fitroughpars roughc(l)];
     end
     if densMaskc(l)
       handles.fitdenspars = [handles.fitdenspars densc(l)];
     end
     if magnMaskc(l)
       handles.fitmagnpars = [handles.fitmagnpars magnc(l)];
     end
     if magnAngMaskc(l)
       handles.fitmagnangpars = [handles.fitmagnangpars magnAngc(l)];
     end
  end
 % if any([thickMaskc roughMaskc densMaskc])
 % end
  % jump one j since we have already used j and j+1
   j = j + (RepSize-1); 
  end
j = j + 1;
handles.sld   = [handles.sld sld ];
handles.d     = [handles.d d   ];
handles.magn  = [handles.magn magn ];
handles.magnAng  = [handles.magnAng magnAng ];

handles.rough = [handles.rough rough ];
handles.ndens = [handles.ndens ndens ];
handles.dens  = [handles.dens dens ];
handles.roughMask = [handles.roughMask roughMask ];
handles.densMask = [handles.densMask densMask ];
handles.thickMask = [handles.thickMask thickMask ];

handles.magnMask = [handles.magnMask magnMask ];
handles.magnAngMask = [handles.magnAngMask magnAngMask ];

handles.repMask   = [handles.repMask repMask];
handles.chem      = [handles.chem chem];


end

p = 2.695e-5; % Angstrom/mubohr
handles.wavelength = str2num(get(handles.edtWavelength,'String'));
handles.sld   = handles.sld(end:-1:1);
handles.d     = handles.d(end:-1:1);
handles.magn  = handles.magn(end:-1:1);
handles.magnAng  = handles.magnAng(end:-1:1);

handles.rough = handles.rough(end:-1:1);
handles.ndens = handles.ndens(end:-1:1);
handles.dens = handles.dens(end:-1:1);
handles.dens
handles.roughMask = handles.roughMask(end:-1:1);
handles.repMask = handles.repMask(end:-1:1);

handles.thickMask = handles.thickMask(end:-1:1);
handles.densMask = handles.densMask(end:-1:1);
handles.magnMask = handles.magnMask(end:-1:1);
handles.magnAngMask = handles.magnAngMask(end:-1:1);
handles.fitdenspars = handles.fitdenspars(end:-1:1);
handles.fitthickpars = handles.fitthickpars(end:-1:1);
handles.fitroughpars = handles.fitroughpars(end:-1:1);
handles.fitmagnpars = handles.fitmagnpars(end:-1:1);
handles.fitmagnangpars = handles.fitmagnangpars(end:-1:1);
handles.sld_m = handles.ndens*p.*handles.magn; % number of spins/A^2??

% handles.rough = single(handles.rough);
% handles.d     = single(handles.d);
% handles.ndens = single(handles.ndens);
% handles.dens  = single(handles.dens);
% handles.magn  = single(handles.magn);
% handles.magnAng = single(handles.magnAng);
% handles.theta   = diff(handles.magnAng);
% handles.sld_m   = single(handles.sld_m);
% handles.sld   = single(handles.sld);
% handles.wavelength = single(handles.wavelength);
% handles.Q          = single(handles.Q);
% 
% handles.rough = double(handles.rough);
% handles.d     = double(handles.d);
% handles.ndens = double(handles.ndens);
% handles.dens  = double(handles.dens);
% handles.magn  = double(handles.magn);
% handles.magnAng = double(handles.magnAng);
 handles.theta   = diff(handles.magnAng);
% handles.sld_m   = double(handles.sld_m);
% handles.sld   = double(handles.sld);
% handles.wavelength = double(handles.wavelength);
% handles.Q          = double(handles.Q);


cnames = {['Thickness [',char(197),']'],['Roughness [',char(197),']'],'Mass Density [g/cm^3]',...
  ['Number Density [#/',char(197),'^3]'],['Re SLD [',char(197),'^-2]'],...
  ['Im SLD [',char(197),'^-2]'],'Magn','MagnAng','Rep'};

columnname = ['Linked',cnames];
%handles.chem
[tableData,handles.chem,latexTab] = generateReducedStack(handles);
%chemstr = handles.chem
%tableData = [num2cell(false(size(handles.d(:)))) num2cell(handles.d(:)) num2cell(handles.rough(:)) num2cell(handles.dens(:)) ...
%  num2cell(handles.ndens(:)) num2cell(real(handles.sld(:))) num2cell(imag(handles.sld(:)))];

% input.data = latexTab;
% cname = {columnname{2},columnname{3},columnname{6},columnname{7},columnname{8},columnname{9}};
% input.tableColLabels = cname;%{'col1','col2','col3','col3','col3','col3'};
% 
% input.tableRowLabels = {'row1','row2'}';
% input.transposeTable = 0;
% input.dataFormatMode = 'column'; % use 'column' or 'row'. if not set 'colum' is used
% input.dataFormat = {'%.3f',6}; % three digits precision for first two columns, one digit for the last
% input.dataNanString = '-';
% input.tableColumnAlignment = 'c';
% input.tableBorders = 1;
% input.tableCaption = 'Fitting parameters.';
% input.tableLabel = 'FitTableLabel';
% input.makeCompleteLatexDocument = 1;
%latex = latexTable(input);


%class(tableData)
%tableData
%tableData = [num2cell(true(size(d))) handles.d(:) handles.rough(:) handles.dens(:) ...
%  handles.ndens(:) real(handles.sld(:)) imag(handles.sld(:))];
columnformat = {'logical','numeric','numeric','numeric','numeric','numeric','numeric'};
set(handles.theTable,'Data',tableData,...
  'ColumnWidth',{80,80,85,130,137,85,85,85,85,85},'ColumnName',columnname,...
  'RowName',flip(handles.chem),'FontSize',14,'ColumnFormat',columnformat,...
  'ColumnEditable',true(1,10));
%handles = drawSLD(handles);

%simulate(hObject,handles);
guidata(hObject, handles);


% --- Executes just before sared is made visible.
function sared_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sared (see VARARGIN)
  handles = reInitialize(handles,hObject);
  handles.output = hObject;
  guidata(hObject, handles);

% UIWAIT makes sared wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sared_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lstFiles.
function lstFiles_Callback(hObject, eventdata, handles)
% hObject    handle to lstFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentList = 'data';
handles = drawRaw(handles);
handles = drawRefl(handles);
handles = drawkxkz(handles);
guidata(hObject, handles);


% Hints: contents = cellstr(get(hObject,'String')) returns lstFiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstFiles


% --- Executes during object creation, after setting all properties.
function lstFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)

handles.ImageFolder = '.';


handles = LoadImageList(handles);
set(handles.pnlProcess,'Visible','on');
set(handles.pnlRaw,'Visible','on');
set(handles.pnlMisc,'Visible','on');
set(handles.pnlFit,'Visible','on');

handles = drawRaw(handles);
handles = drawkxkz(handles);
handles = drawRefl(handles);
guidata(hObject, handles);
%handles = updateGraphs(handles);




% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%=====================================================================
% --- Load up the listbox with image files in folder handles.ImageFolder
function handles = LoadImageList(handles)        
 
  switch handles.fileformat
    case 'edf'
     [cListOfImageNames,cListOfPathNames ] = uigetfile('*.edf',  'EDF Files','MultiSelect','on');
    case 'h5' 
     [cListOfImageNames,cListOfPathNames ] = uigetfile('*.h5',  'h5 Files','MultiSelect','on');
    case 'h5pol' 
     [cListOfImageNames,cListOfPathNames ] = uigetfile('*.h5',  'h5 Files','MultiSelect','on');
  end

  
  if handles.listExists

    handles.ListOfImageNames = [handles.ListOfImageNames cListOfImageNames];
    handles.ListOfPathNames  = [handles.ListOfPathNames cListOfPathNames];
    
    if ischar(class(handles.ListOfImageNames))
      handles.ListOfImageNames = cellstr(handles.ListOfImageNames);
    end

    if ischar(class(cListOfImageNames))
      cListOfImageNames = cellstr(cListOfImageNames);
    end
    
    for i = 1:length(cListOfImageNames)
      cFullFileList{i} = fullfile(cListOfPathNames,cListOfImageNames(i));
    end
    handles.FullFileList = [handles.FullFileList cFullFileList];

  else
    handles.ListOfImageNames = cListOfImageNames;
    handles.ListOfPathNames  = cListOfPathNames;

  
    if ischar(class(handles.ListOfImageNames))
      handles.ListOfImageNames = cellstr(handles.ListOfImageNames);
    end

    for i = 1:length(handles.ListOfImageNames)
      handles.FullFileList{i} = fullfile(handles.ListOfPathNames,handles.ListOfImageNames(i));
    end

    handles.listExists = 1;
  end
  handles = package_process(handles);
  %set(handles.lstFiles,'string',handles.ListOfImageNames);
  
  set(handles.lstFiles,'string',num2str(handles.Theta));
  get(handles.lstFiles,'value');
  set(handles.lstFiles,'value',get(handles.lstFiles,'value'));
  %a = handles.ListOfPathNames;
  %save('debug3.mat','a');
 % end

return;
    
% --- Executes on button press in processbutton.
function processbutton_Callback(hObject, eventdata, handles)
% hObject    handle to processbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.FullFileList = {};
set(handles.lstFiles,'string','');
handles = package_process(handles);
guidata(hObject, handles);


% --- Executes on button press in btnSelectROI.
function btnSelectROI_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doMainROI(handles,hObject);

return;



% --- Executes on button press in chkCurrentROI.
function chkCurrentROI_Callback(hObject, eventdata, handles)
% hObject    handle to chkCurrentROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkCurrentROI


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = reduceData(handles);
handles = change_states(handles);
FileName = uiputfile('*.dat');
data3(FileName,Q,I,UI,'Q [A^-1] Reflectivity    Error of R');
guidata(hObject, handles);


% --------------------------------------------------------------------
function uitoggletool1_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Zoom, off callback.')


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnkxkyconvert.
function btnkxkyconvert_Callback(hObject, eventdata, handles)
% hObject    handle to btnkxkyconvert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = drawkxkz(handles);
guidata(hObject, handles);
handles = updateGraphs(handles);


    
%     r = @(x) sqrt(x(:,1).^2 + x(:,2).^2);
%     w = @(x) atan2(x(:,2), x(:,1));
%     f = @(x) [sqrt(r(x)) .* cos(w(x)), sqrt(r(x)) .* sin(w(x))];
%     g = @(x, unused) f(x);
% 
%     tform2 = maketform('custom', 2, 2, [], g, []);
%     face2 = imtransform(newI, tform2, 'UData', [-1 1], 'VData', [-1 1], ...
%       'XData', [-1 1], 'YData', [-1 1]);
%     imshow(face2)
%    

% --- Executes on button press in chkAllGauss.
function chkAllGauss_Callback(hObject, eventdata, handles)
% hObject    handle to chkAllGauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkAllGauss


function handles = drawkxkz(handles)

axes(handles.kxkzaxes);
hold(handles.kxkzaxes,'on');

ch = get(handles.kxkzaxes,'Children');

if isempty(ch)
  h = pcolor(handles.kxkzaxes,handles.KXKZ_CurrentXData1,handles.KXKZ_CurrentXData2,handles.KXKZ_CurrentYData);
  set(h,'EdgeColor','none');
  colorbar('peer',handles.kxkzaxes);
  handles.thekxkzmap=colormap(handles.kxkzaxes,handles.kxkzmap);
%  set(handles.kxkzaxes,'Clim',[min(handles.theIQmin),max(handles.theIQmax)]);
  set(handles.kxkzaxes,'Clim',[log10(min(handles.theIQmin)/1000+eps), log10(max(handles.theIQmax))+eps]);
 
%   currentQx = handles.KXKZ_CurrentXData1;
%   currentQz = handles.KXKZ_CurrentXData2;
%   sQx = handles.sQx(:,handles.KXKZ_CurrentSpinhandle);
%   sQz = handles.sQz(:,handles.KXKZ_CurrentSpinhandle);
% 
%   [m,n] = size(currentQx);
%   %id = find(currentQx(:,40)>=0);
%   tid = find(currentQx(:,round(n/2))>=0);
%   cqx = currentQx(tid,round(n/2));
%   cqz = currentQz(tid,round(n/2));
% 
%   sqx = sQx(tid,round(n/2));
%   sqz = sQz(tid,round(n/2));
%   
%   [mi,id] = min(cqx);
%   %plot(handles.kxkzaxes,currentQx(:,40),currentQz(:,40),'-y','LineWidth',2);  
%   %plot(handles.kxkzaxes,cqx,cqz,'-r','LineWidth',2);  
% 
%   W = sqx(id(1))
%   H = sqz(id(1))
%   X = cqx(id(1));
%   Y = cqz(id(1));
%   X = cqx(id(1))-W/2
%   Y = cqz(id(1))-H/2
%   handles.resROI   = rectangle('Position',[X,Y,W,H],'Curvature',[1,1]);
%   set(handles.resROI,'EdgeColor','r','LineWidth',2);

else
  set(ch(end),'XData',handles.KXKZ_CurrentXData1,'YData',handles.KXKZ_CurrentXData2,'ZData',handles.KXKZ_CurrentYData,'CData',handles.KXKZ_CurrentYData);

  set(handles.kxkzaxes,'Clim',[log10(min(handles.theIQmin)/1000+eps), log10(max(handles.theIQmax))+eps]);
  %  set(ch(1),'XData',handles.KXKZ_CurrentXData1(:,handles.currentItem),'YData',handles.KXKZ_CurrentXData2(:,handles.currentItem));
end
%axis(handles.kxkzaxes,[-Inf Inf 0 0.6 ]);
xlabel(handles.kxkzaxes,handles.kxkzXLabel);
ylabel(handles.kxkzaxes,handles.kxkzYLabel);
handles.thekxkzmap=colormap(handles.kxkzaxes,handles.kxkzmap);
%daspect(handles.kxkzaxes,[1 10 1]);


%axis(handles.kxkzaxes,'auto');


function handles = drawRefl(handles)
    
  axes(handles.reflectivityaxes);
  
  X1 = handles.ReflCurrentXData1;
  X2 = handles.ReflCurrentXData2;
  X3 = handles.ReflCurrentXData3;
  
  Y1  = handles.ReflCurrentYData1;
  sY1 = handles.ReflCurrentsYData1;
  
  Y2  = handles.ReflCurrentYData2;
  sY2 = handles.ReflCurrentsYData2;
  
  Y3 = handles.ReflCurrentYData3;
  sY3 = handles.ReflCurrentsYData3;
  
  cla(handles.reflectivityaxes);
  cla(handles.secondaxes);
  

 
  hold(handles.reflectivityaxes,'off');
 
  h=ploterr(X1,Y1,[],sY1,handles.Refl1Marker,'logy','hhy',0.5); 
  
  if ~isempty(h)
  set(h(1),'MarkerFaceColor',get(h(1),'Color')), set(h(2),'Color',get(h(1),'Color'));
  end
  hold(handles.reflectivityaxes,'on');

  if ~isempty(Y3)
    h=ploterr(X3,Y3,[],sY3,handles.Refl3Marker,'logy','hhy',0.5); 
    size(h)
    if ~isempty(h)
      set(h(1),'MarkerFaceColor',get(h(1),'Color')), set(h(2),'Color',get(h(1),'Color'));
    end
  end
  set(handles.reflectivityaxes,'YScale',handles.ReflYScaleState);
  set(handles.reflectivityaxes,'box','off');
  set(handles.reflectivityaxes,'Color','none');
  set(handles.reflectivityaxes,'FontName','Lucida Grande','FontSize',13);
  
  pos = get(handles.reflectivityaxes,'Position');
  pos(1) = pos(1);
 
  if ~isempty(Y2)
    plot(handles.secondaxes,X2,Y2,handles.Refl2Marker);
  end
  set(handles.secondaxes,'Position',pos);
  set(handles.secondaxes,'box','off');
  set(handles.secondaxes,'Color','none');
  set(handles.secondaxes,'YAxisLocation','Right');
  set(handles.secondaxes,'FontName','Lucida Grande','FontSize',13);

 % hold(handles.secondaxes,'on');
  
  %set(handles.secondaxes,'YScale',handles.ReflYScaleState2);

 

  res1 = mean(abs(diff(X1)));
  res2 = mean(abs(diff(X2)));
  yres1 = mean(abs(diff(Y1)));
  yres2 = mean(abs(diff(Y2)));
  
  if (res1 ~= 0 && res2 ~= 0) && (yres1 ~= 0 && yres2 ~= 0) && ...
      (~isnan(res2) && ~isnan(res1)) && (~isnan(yres2) && ~isnan(yres1)) 
    %if strcmp(handles.ReflYScaleState2,'log')
    %  axis(handles.secondaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4]);
    %  axis(handles.reflectivityaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4]);
%           set(handles.secondaxes,'YTick',get(handles.reflectivityaxes,'YTick'));
    %   else
     axis(handles.secondaxes,[min(X1)-res1 max(X1)+res1 min(Y2(Y2>0))-min(Y2(Y2>0))*0.1 max(Y2).*1.1]);
     %axis(handles.reflectivityaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4]);
     mix = min( [min(X1) min(X3)] );
     mlx = max( [max(X1) max(X3)] );
     miy = min( [min(Y1) max(Y3)] );
     mly = max( [max(Y1) max(Y3)] );
     axis(handles.reflectivityaxes,[mix-res1 mlx+res1 miy-miy*0.4 mly*1.4]);
     axis(handles.secondaxes,[mix-res1 mlx+res1 min(Y2(Y2>0))-min(Y2(Y2>0))*0.1 max(Y2).*1.1]);
  end
%       end
%     else
%       if strcmp(handles.ReflYScaleState2,'log')
%         axis(handles.secondaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4+eps]);
%         axis(handles.reflectivityaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4]);
%            set(handles.secondaxes,'YTick',get(handles.reflectivityaxes,'YTick'));
%       else
%         axis(handles.secondaxes,[min(X1)-res1 max(X1)+res1 mean(Y2)-abs(0.1*mean(Y2))-eps mean(Y2)+abs(0.1*mean(Y2))+eps]);
%         axis(handles.reflectivityaxes,[min(X1)-res1 max(X1)+res1 min(Y1(Y1>0))-min(Y1(Y1>0))*0.4 max(Y1)*1.4]);
%                 set(handles.secondaxes,'YScale','lin');
%         set(handles.secondaxes,'YTickMode','auto');
% 
%       end
%       %axis(handles.reflectivityaxes,[mean(X1)-0.1*mean(X1) mean(X1)+0.1*mean(X1) mean(Y1(Y1>0))-0.1*mean(Y1(Y1>0)) mean(Y1)+0.1*mean(Y1)]);
%       %axis(handles.reflectivityaxes,'auto')
%       %axis(handles.secondaxes,'auto')
%     end
    %set(get(handles.secondaxes,'XLabel'),'String',handles.ReflXLabel1);
    set(get(handles.secondaxes,'XLabel'),'String',handles.ReflXLabel1);
    %axis(handles.reflectivityaxes,[0 max(X1)*1.1 -Inf Inf]);
   % get(handles.reflectivityaxes,'Xlim')
    %set(handles.secondaxes,'Xlim',get(handles.reflectivityaxes,'Xlim'));
    
    set(handles.reflectivityaxes,'XTick',[]);
    %set(handles.secondaxes,'XTickLabel',{});
   % set(handles.secondaxes,'YTickLabel',get(handles.reflectivityaxes,'YTickLabel'));
   
    ylabel(handles.reflectivityaxes,handles.ReflYLabel1);
    ylabel(handles.secondaxes,handles.ReflYLabel2);
   % set(handles.reflectivityaxes,'box','off');
   
    
return;


function handles = drawRaw(handles)


  switch handles.currentList
    case 'data'
      idx  = get(handles.lstFiles, 'value');
      texp = handles.experiment;
    case 'direct'
      idx  = get(handles.lstDirectBeam, 'value');
      texp = handles.db;
  end
  
  if idx <= length(texp)
    pixel  = texp{idx}.start:1:texp{idx}.end;
    vpixel = texp{idx}.top:1:texp{idx}.bottom;
    
    handles.RawCurrentAllXData1 = 1:1:texp{1}.imsize(1);
    handles.RawCurrentAllXData2 = 1:1:texp{1}.imsize(1);
    
    %handles.RawCurrentAllCData  = texp{idx}.im;
    handles.RawCurrentXData1    = pixel;
    handles.RawCurrentXData2    = vpixel;
    
    switch texp{idx}.hasROI
      case 0
        switch handles.rawplotscale
          case 0
            handles.RawCurrentCData  = texp{idx}.im;
          case 1
            handles.RawCurrentCData  = texp{idx}.imLog;
        end
      case 1
        switch handles.rawplotscale
          case 0
            handles.RawCurrentCData  = texp{idx}.im;
          case 1
            handles.RawCurrentCData  = texp{idx}.imLog;
        end
      otherwise
    end
    
    handles.currentItem = idx;
    axes(handles.projectedaxes);
    hold(handles.projectedaxes,'off');
    
    uproject = texp{idx}.uproject';
    y        = texp{idx}.project';
    
    nonexcluded = find(texp{idx}.project' > 0);
    
    xn = pixel(nonexcluded)';
    yn = y(nonexcluded);
    un = uproject(nonexcluded);
    
    ch = get(handles.projectedaxes,'children');
    
    if isempty(ch)
      %errorbar(xn,yn,un,'bo','MarkerFaceColor','b');
      % h=ploterr(X1,Y1,[],sY1,handles.Refl1Marker,'logy','hhy',0.5);
      h = ploterr(xn,yn,[],un,'-o','logy','hhy',0.5);
      set(h(1),'MarkerFaceColor',get(h(1),'Color')), set(h(2),'Color',get(h(1),'Color'));
      % set(h,'MarkerFaceColor',get(h,'Color'));
      % newErrorbar(xn,yn,un,'bo','MarkerFaceColor','b');
    else
      
      if ~texp{idx}.hasGaussFit && length(ch)>1
        delete(ch(1));
      end
      h = ploterr(xn,yn,[],un,'-o','logy','hhy',0.5);
      set(h(1),'MarkerFaceColor',get(h(1),'Color')), set(h(2),'Color',get(h(1),'Color'));
      %  h = get(h,'Color');
      % set(h,'MarkerFaceColor',h(end));
      % set(ch(end),'XData',xn,'YData',yn,'UData',un,'LData',un);
      % errorbar(ch(end));
      %    errorbar_tick(ch(end),0.0,'Units');
    end
    mm     = max(texp{idx}.project+texp{idx}.uproject);
    
    if mm ~= 0
      axis([-Inf Inf min(texp{idx}.project-texp{idx}.uproject) mm.*1.1]);
    end
    
    if texp{idx}.hasGaussFit
      S.X = xn;
      %model = feval(texp{idx}.GaussPeak,S);
      mod = model(texp{idx}.GaussPeak,S);
      title(['\chi^2/DOG = ',num2str(texp{idx}.redchisqr)]);
      
      ch = get(handles.projectedaxes,'children');
      [m,~] = size(ch);
      if m == 1
        plot(xn,mod,'-r');
      else
        set(ch(1),'XData',xn,'YData',mod);
      end
      
      axis([min(xn) max(xn) 0 max([max(yn) max(mod)])*1.2]);
    end
    
    set(handles.projectedaxes,'YScale',handles.projectedYScaleState);
    
    axes(handles.rawaxes);
    %hold(handles.rawaxes,'on');
    
    ch = get(handles.rawaxes,'Children');
    if isempty(ch)
      colormap(handles.rawaxes,handles.kxkzmap);
      %image(handles.RawCurrentXData1,handles.RawCurrentXData2,handles.RawCurrentCData);
      
      h=pcolor(handles.RawCurrentAllXData1,handles.RawCurrentAllXData2,handles.RawCurrentCData);
      set(h,'EdgeColor','none');
%       if handles.rawplotscale
%         set(handles.rawaxes,'Clim',[-1, max(max(handles.RawCurrentCData))+2]);
%        % set(handles.rawaxes,'Clim',[min(min(handles.RawCurrentCData)), max(max(handles.RawCurrentCData))]);
%       else
%         set(handles.rawaxes,'Clim',[0.0, max(max(handles.RawCurrentCData))*0.3]);
%       end
      %  axis(handles.rawaxes,[min(handles.RawCurrentXData1) max(handles.RawCurrentXData1) min(handles.RawCurrentXData2) max(handles.RawCurrentXData2)]);
      handles.rawcbar = colorbar('peer',handles.rawaxes,'Location','NorthOutside');
    else
      % set(ch(1),'XData',handles.RawCurrentXData1,'YData',handles.RawCurrentXData2,'CData',handles.RawCurrentCData);
     % cla(handles.rawaxes);
      colormap(handles.rawaxes,handles.kxkzmap);
      %for i = 1:length(ch)
   %   ch(1)
    %  ch(2)
      %delete(ch);
      % h=pcolor(handles.RawCurrentAllXData1,handles.RawCurrentAllXData2,handles.RawCurrentCData);
      %h=pcolor(handles.RawCurrentAllXData1,handles.RawCurrentAllXData2,handles.RawCurrentCData);
      %set(h,'EdgeColor','none');
      %handles.rawcbar = colorbar('peer',handles.rawaxes,'Location','NorthOutside');
    set(ch(end),'XData',handles.RawCurrentAllXData1,'YData',handles.RawCurrentAllXData2,'ZData',handles.RawCurrentCData,'CData',handles.RawCurrentCData);
      %if handles.rawplotscale
        %set(handles.rawaxes,'Clim',[-2, 1]);
      % set(handles.rawaxes,'Clim',[0, 4]);
     % else
      %  set(handles.rawaxes,'Clim',[0, 10]);
     % end
      % caxis(handles.rawaxes,[min(min(handles.RawCurrentCData)) max(max(handles.RawCurrentCData))]);
      %    set(handles.rawcbar,'CLim',[min(min(handles.RawCurrentCData)) max(max(handles.RawCurrentCData))+eps],'XLim',[min(min(handles.RawCurrentCData)) max(max(handles.RawCurrentCData))+eps]);
      %   axis(handles.rawaxes,[min(handles.RawCurrentXData1) max(handles.RawCurrentXData1) min(handles.RawCurrentXData2) max(handles.RawCurrentXData2)]);
      %  end
     %   h=pcolor(handles.RawCurrentAllXData1,handles.RawCurrentAllXData2,handles.RawCurrentCData);
     % set(h,'EdgeColor','none');
    %   handles.rawcbar = colorbar('peer',handles.rawaxes,'Location','NorthOutside');
       %set(handles.rawaxes,'CLim',[-1 max(max(handles.RawCurrentCData))]);
    end
    
    if handles.ProjectionVisible
      set(get(handles.projectedaxes,'Children'),'Visible','on');
      set(handles.projectedaxes,'Visible','on');
    else
      set(handles.projectedaxes,'Visible','off');
      set(get(handles.projectedaxes,'Children'),'Visible','off');
    end
    drawnow;
  end
return;
 
function handles = change_states(handles)
  
if any(handles.uu) && ~handles.hasPopulated_uu

  if strcmp(handles.dropdReflString,'')
    handles.dropdReflString = {};
    handles.dropdKXKZString = {};
  end
    handles.dropdReflString = ['uu', handles.dropdReflString];
    set(handles.dropdRefl,'String',handles.dropdReflString);
    %set(handles.dropdRefl3,'String',handles.dropdReflString);
    handles.dropdKXKZString = ['uu', handles.dropdKXKZString];
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    handles.hasPopulated_uu = 1;
end

if any(handles.du) && ~handles.hasPopulated_du
    handles.dropdReflString = ['du', handles.dropdReflString];
    set(handles.dropdRefl,'String',handles.dropdReflString);
    %set(handles.dropdRefl3,'String',handles.dropdReflString);
    handles.dropdKXKZString = ['du', handles.dropdKXKZString];
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    handles.hasPopulated_du = 1;
end

if any(handles.ud) && ~handles.hasPopulated_ud
    handles.dropdReflString = ['ud', handles.dropdReflString];
    set(handles.dropdRefl,'String',handles.dropdReflString);
   % set(handles.dropdRefl3,'String',handles.dropdReflString);
    handles.dropdKXKZString = ['ud', handles.dropdKXKZString];
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    handles.hasPopulated_ud = 1;
end

if any(handles.dd) && ~handles.hasPopulated_dd
    handles.dropdReflString = ['dd', handles.dropdReflString];
    set(handles.dropdRefl,'String',handles.dropdReflString);
   % set(handles.dropdRefl3,'String',handles.dropdReflString);
    handles.dropdKXKZString = ['dd', handles.dropdKXKZString];
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    handles.hasPopulated_dd = 1;
end

if any(handles.unpolarized) && ~handles.hasPopulated_unpolarized
    handles.dropdReflString = ['unpolarized', handles.dropdReflString];
    set(handles.dropdRefl,'String',handles.dropdReflString);
    %set(handles.dropdRefl3,'String',handles.dropdReflString);
    handles.dropdKXKZString = ['unpolarized', handles.dropdKXKZString];
    set(handles.dropdSpinStatekxkz,'String',handles.dropdKXKZString);
    handles.hasPopulated_unpolarized = 1;
end

  handles.ReflCurrentXData1     = handles.Q(handles.uu);
  handles.ReflCurrentAllXData1  = handles.Q;
  handles.ReflCurrentXData2     = handles.Q(handles.uu);
  
  handles.ReflCurrentAllXData2  = handles.Q;
  handles.ReflCurrentAllXData3  = handles.Q;
  
  handles.ReflCurrentYData1     = handles.I(handles.uu);
  handles.ReflCurrentsYData1    = handles.sI(handles.uu);
  handles.ReflSpinhandle = handles.uu';
  
 
  handles.ReflCurrentYData2     = handles.M(handles.uu);
  handles.ReflCurrentsYData2    = handles.sM(handles.uu);
  handles.ReflCurrentAllYData2  = handles.M;
  handles.ReflCurrentAllsYData2 = handles.sM;
  
  handles.ReflCurrentYData3  = [];
  handles.ReflCurrentsYData3 =  [];
  handles.ReflCurrentAllYData3  = [];
  handles.ReflCurrentAllsYData3 = [];
  handles.ReflCurrentXData3  = handles.Q(handles.uu);
  
  thestr = get(handles.dropdRefl2,'String');
  
  found = strfind(thestr,'Monitor');
  
  for i = 1:length(found)
      if ~isempty(found{i})
          set(handles.dropdRefl2,'Value',i);
      end
  end
  
 thestr = get(handles.dropdRefl,'String');
  
  found = strfind(thestr,'uu');
  
  for i = 1:length(found)
      if ~isempty(found{i})
          set(handles.dropdRefl,'Value',i);
      end
  end

  set(handles.dropdRefl3,'String',handles.dropdReflString3);
  set(handles.dropdRefl3,'Value',1);


  
 % set(handles.dropdRefl,'Value',1);
  handles.ReflXlabel = '';
  if ~isempty(handles.experiment)
    handles.KXKZ_CurrentSpinhandle = handles.uu';
    handles.KXKZ_CurrentAllXData1 = handles.Qx;
    handles.KXKZ_CurrentXData1    = handles.KXKZ_CurrentAllXData1(:,handles.KXKZ_CurrentSpinhandle);
    handles.KXKZ_CurrentAllXData2 = handles.Qz;
    handles.KXKZ_CurrentXData2    = handles.KXKZ_CurrentAllXData2(:,handles.KXKZ_CurrentSpinhandle);
    handles.KXKZ_CurrentYData     = handles.IQLog(:,handles.KXKZ_CurrentSpinhandle);
    handles.KXKZ_CurrentYDataLog  = handles.IQLog(:,handles.KXKZ_CurrentSpinhandle);
  end
  
  set(handles.edtThetaOffset,'String',num2str(handles.ThetaOffset));
  set(handles.edtWavelength,'String',handles.settings.wavelength);
  set(handles.edtSampleLength,'String',num2str(handles.SampleLength));
  
  set(handles.mnuFit,'String',handles.mnuFitDataString);
  set(handles.mnuFit,'Value',length(handles.mnuFitDataString));
  beamwstr = makeStr(handles.beamw(handles.uu)); 
  set(handles.edtBeamWidth,'String',beamwstr); % multiple beam widths are possible
  
  dQstr = makeStr(handles.sQz_specular(handles.uu));
  set(handles.edtResolution,'String',dQstr);
  handles.Res = handles.sQz_specular(handles.uu);
  Qstr = makeStr(handles.Q(handles.uu));
  set(handles.edtQ,'String',Qstr);
  
  set(handles.edtI0,'String',num2str(handles.I0));
  
  set(handles.mnuAllData,'String',handles.dropdReflString);
  set(handles.mnuAllData,'Value',1);

  
  return
  
  function str = makeStr(data)
     if length(data) == 1 || sum(diff(data)) == 0
       str = num2str(data(1));
     else
       if ~unique(diff(data))
         str = [num2str(min(data)),':',num2str(max(data))];
       else
         str = [num2str(min(data)),'-',num2str(max(data))];
       end
     end
  return;
  
function handles= package_process(handles)

if handles.listExists
  exp = process_filearray(handles.FullFileList(end:-1:1),handles);
  N = length(handles.experiment);
  M = length(exp);
  
  for i = (N+1):(N+M)
    handles.experiment{i} = exp{i-N};
  end
end



handles = reduceData(handles);
handles = change_states(handles);
return;
 
% --------------------------------------------------------------------
function File_1_Callback(hObject, eventdata, handles)
% hObject    handle to File_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function preferences_Callback(hObject, eventdata, handles)
% hObject    handle to preferences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.preferences,'Visible','on');
uiwait(handles.preferences);

handles.preferences = preferences('Visible','off');
set(handles.preferences,'Visible','off');
se = load('settings.mat');


handles.settings = se;
guidata(hObject, handles);



drawnow;


% --- Executes on button press in btnPolCor.
function btnPolCor_Callback(hObject, eventdata, handles)
% hObject    handle to btnPolCor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = doPolarizationCorrection(handles,hObject);
return;

function handles = doPolarizationCorrection(handles,hObject)
    
  if ~handles.isMakingROI && ~handles.isMakingBROI
    
    if handles.doPolarizationCorrection
      set(handles.mnuPolarizationLeakage,'Checked','on');
      handles.doPolarizationCorrection = 0;
      
      
      Iuu = handles.I(handles.uu);
      Iud = handles.I(handles.ud);
      Idu = handles.I(handles.du);
      Idd = handles.I(handles.dd);
      
      
      switch handles.settings.doPol
        case 0
          fa = handles.settings.fa;
          fp = handles.settings.fp;
          a  = handles.settings.a;
          p  = handles.settings.p;
          
          ufa = handles.settings.ufa;
          ufp = handles.settings.ufp;
          ua  = handles.settings.ua;
          up  = handles.settings.up;
        case 1
          
          DIuu  = handles.DI(handles.duu);
          sDIuu = handles.sDI(handles.duu);
          
          N = length(DIuu);
          
          DIud  = handles.DI(handles.dud);
          sDIud = handles.sDI(handles.dud);
          DIdu  = handles.DI(handles.ddu);
          sDIdu = handles.sDI(handles.ddu);
          DIdd  = handles.DI(handles.ddd);
          sDIdd = handles.sDI(handles.ddd);
          % ( DIuu(1) + DIuu(2) )/N
          
          DIuu_avg  = sum(DIuu)/N;
          sDIuu_avg = sqrt( sum ( ( 1/N*sDIuu ).^2 ) );
          
          DIud_avg  = sum(DIud)/N;
          sDIud_avg = sqrt( sum ( ( 1/N*sDIud ).^2 ) );
          
          DIdu_avg  = sum(DIdu)/N;
          sDIdu_avg = sqrt( sum ( ( 1/N*sDIdu ).^2 ) );
          
          DIdd_avg  = sum(DIdd)/N;
          sDIdd_avg = sqrt( sum ( ( 1/N*sDIdd ).^2 ) );
          
          %     DIuu_avg  = DIuu(1);
          %     sDIuu_avg = sDIuu(1);
          %
          %     DIud_avg  = DIud(1);
          %     sDIud_avg = sDIud(1);
          %
          %     DIdu_avg  = DIdu(1);
          %     sDIdu_avg = sDIdu(1);
          %
          %     DIdd_avg  = DIdd(1);
          %     sDIdd_avg = sDIdd(1);
          
          % Direct beam measurement yields fa,fp and phi
          [fa, ufa]   = calc_fa ([DIuu_avg DIud_avg DIdu_avg DIdd_avg],[sDIuu_avg sDIud_avg sDIdu_avg sDIdd_avg]);
          [fp, ufp]   = calc_fp ([DIuu_avg DIud_avg DIdu_avg DIdd_avg],[sDIuu_avg sDIud_avg sDIdu_avg sDIdd_avg]);
          [phi, uphi] = calc_phi([DIuu_avg DIud_avg DIdu_avg DIdd_avg],[sDIuu_avg sDIud_avg sDIdu_avg sDIdd_avg]);
          
          
          set(handles.edtPhi,'String',[num2str(phi),'?',num2str(uphi)]);
          set(handles.edtAFlip,'String',[num2str(fa),'?',num2str(ufa)]);
          set(handles.edtPFlip,'String',[num2str(fp),'?',num2str(ufp)]);
          
          % IT2 = [IT2_00 IT2_01 IT2_10 IT2_11];
          
          aIuu = handles.I(handles.uu);
          aIud = handles.I(handles.ud);
          aIdu = handles.I(handles.du);
          aIdd = handles.I(handles.dd);
          
          asIuu = handles.sI(handles.uu);
          asIud = handles.sI(handles.ud);
          asIdu = handles.sI(handles.du);
          asIdd = handles.sI(handles.dd);
          
          sIuu = handles.sI(handles.uu);
          sIud = handles.sI(handles.ud);
          sIdu = handles.sI(handles.du);
          sIdd = handles.sI(handles.dd);
          
          [tIuu,ti] = max(aIuu);
          tsIuu     = asIuu(ti);
          
          tIud  = aIud(ti);
          tsIud = asIud(ti);
          tIdu  = aIdu(ti);
          tsIdu = asIdu(ti);
          tIdd  = aIdd(ti);
          tsIdd = asIdd(ti);
          
          %     Iuu = 180;
          %     sIuu = sqrt(Iuu)
          %     Iud = 115;
          %     sIud = sqrt(Iud)
          %     Idu = 855;
          %     sIdu = sqrt(Idu)
          %     Idd =  6322;
          %     sIdd = sqrt(Idd)
          %
          %     Iuu = aIuu(ti)
          %     Iud = aIud(ti)
          %     Idu = aIdu(ti)
          %     Idd = aIdd(ti)
          
          [pmax,upmax] = calc_p([tIuu,tIud,tIdu,tIdd],[tsIuu,tsIud,tsIdu,tsIdd],phi,uphi,fa,ufa,fp,ufp);
          [amax,uamax] = calc_a(phi,uphi,pmax,upmax);
          
          set(handles.edtA,'String',[num2str(amax),'?',num2str(uamax)]);
          set(handles.edtP,'String',[num2str(pmax),'?',num2str(upmax)]);
          
          % [p,up] = calc_p([tIuu,tIud,tIdu,tIdd],[tsIuu,tsIud,tsIdu,tsIdd],phi,uphi,fa,ufa,fp,ufp);
          % [a,ua] = calc_a(phi,uphi,p,up);
          
          % set(handles.edtA,'String',[num2str(a),'?',num2str(ua)]);
          % set(handles.edtP,'String',[num2str(p),'?',num2str(up)]);
          
      end
      
      
      handles.S   = zeros(size(handles.I));
      handles.sS  = zeros(size(handles.I));
      
      uu = find(handles.uu == 1);
      ud = find(handles.ud == 1);
      du = find(handles.du == 1);
      dd = find(handles.dd == 1);
      
      
      for i = 1:length(handles.I)/4
        p(i) = pmax;
        up(i) = upmax;
        a(i) = amax;
        ua(i) = uamax;
        %[p(i),up(i)] = calc_p([Iuu(i),Iud(i),Idu(i),Idd(i)],[sIuu(i),sIud(i),sIdu(i),sIdd(i)],phi,uphi,fa,ufa,fp,ufp);
        %[a(i),ua(i)] = calc_a(phi,uphi,p(i),up(i));
        [S,dS] = correct_spinstates([Iuu(i) Iud(i) Idu(i) Idd(i)]',[sIuu(i) sIud(i) sIdu(i) sIdd(i)]',a(i),p(i),fa,fp,ua(i),up(i),ufa,ufp);
        %  [S,dS] = correct_spinstates([Iuu(i) Iud(i) Idu(i) Idd(i)]',a,p,fa,fp,ua,up,ufa,ufp);
        
        
        handles.S(uu(i)) = S(1);
        handles.S(ud(i)) = S(2);
        handles.S(du(i)) = S(3);
        handles.S(dd(i)) = S(4);
        
        handles.sS(uu(i)) = dS(1);
        handles.sS(ud(i)) = dS(2);
        handles.sS(du(i)) = dS(3);
        handles.sS(dd(i)) = dS(4);
        
      end
      handles.p = p;
      handles.a = a;
      handles.sp = up;
      handles.sa = ua;
      
      if any(handles.uu) && ~handles.hasSpinCorrected
        handles.dropdReflString1= ['suu', handles.dropdReflString3];
        set(handles.dropdRefl1,'String',handles.dropdReflString3);
        %set(handles.dropdRefl2,'String',handles.dropdReflString);
      end
      
      if any(handles.du) && ~handles.hasSpinCorrected
        handles.dropdReflString1 = ['sdu', handles.dropdReflString3];
        set(handles.dropdRefl1,'String',handles.dropdReflString3);
        % set(handles.dropdRefl2,'String',handles.dropdReflString);
      end
      
      if any(handles.du) && ~handles.hasSpinCorrected
        handles.dropdReflString1 = ['sud', handles.dropdReflString3];
        set(handles.dropdRefl1,'String',handles.dropdReflString3);
        %set(handles.dropdRefl2,'String',handles.dropdReflString);
      end
      
      if any(handles.dd) && ~handles.hasSpinCorrected
        handles.dropdReflString1 = ['sdd', handles.dropdReflString3];
        set(handles.dropdRefl1,'String',handles.dropdReflString3);
        %  set(handles.dropdRefl2,'String',handles.dropdReflString);
      end
      
      if any(handles.dd) && ~handles.hasSpinCorrected
        handles.dropdReflString1 = ['p','a', handles.dropdReflString3];
        set(handles.dropdRefl1,'String',handles.dropdReflString3);
        %  set(handles.dropdRefl2,'String',handles.dropdReflString);
      end
      
      handles.hasSpinCorrected = 1;
      
    else
      handles.doPolarizationCorrection = 1;
      set(handles.mnuPolarizationLeakage,'Checked','off');
      handles.dropdReflString1 = {''};
      set(handles.dropdRefl1,'String',{'None'});
      handles.hasSpinCorrected = 0;
    end
    handles = change_states(handles);
    handles = drawRefl(handles);
    
    guidata(hObject, handles);
  else
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    msgbox('Already making a ROI, please double click on the ROI to proceed');
  end
  return;

% --- Executes on button press in btnBackground.
function btnBackground_Callback(hObject, eventdata, handles)
% hObject    handle to btnBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles = doBackground(handles,hObject);





  
  function h = newErrorbar(varargin)
    h = errorbar(varargin{:});
    W = 0.0;
    
    errorbar_tick(h,W,'Units');
  return;

% --- Executes on button press in 1.
function tgl1_Callback(hObject, eventdata, handles)
% hObject    handle to tgl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tgl1
if strcmp(get(handles.tgl1,'String'),'Linear')
  handles.ReflYScaleState = 'lin';
  set(handles.tgl1,'String','Log');
elseif strcmp(get(handles.tgl1,'String'),'Log')
  handles.ReflYScaleState = 'log';
  set(handles.tgl1,'String','Linear');
end
handles = drawRefl(handles);
guidata(hObject, handles);


% --- Executes on button press in tgl2.
function tgl2_Callback(hObject, eventdata, handles)
% hObject    handle to tgl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tgl2
if strcmp(get(handles.tgl2,'String'),'Linear')
  set(handles.tgl2,'String','Log');
  handles.Qplotscale = 0;
  handles.KXKZ_CurrentYData = 10.^(handles.KXKZ_CurrentYData);
  handles = drawkxkz(handles);
elseif strcmp(get(handles.tgl2,'String'),'Log')
  set(handles.tgl2,'String','Linear');
  handles.Qplotscale = 1;
  handles.KXKZ_CurrentYData = handles.KXKZ_CurrentYDataLog;
  handles = drawkxkz(handles);
end
guidata(hObject, handles);

% --- Executes on button press in tglProjectedLog.
function tglRawLog_Callback(hObject, eventdata, handles)
% hObject    handle to tglProjectedLog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tglProjectedLog
if strcmp(get(handles.tglRawLog,'String'),'Linear')
  set(handles.tglRawLog,'String','Log');
  handles.rawplotscale = 0;
elseif strcmp(get(handles.tglRawLog,'String'),'Log')
  set(handles.tglRawLog,'String','Linear');
  handles.rawplotscale = 1;
end
handles = drawRaw(handles);
guidata(hObject, handles);

% --- Executes on button press in tglRawLog.
function tglProjectedLog_Callback(hObject, eventdata, handles)
% hObject    handle to tglRawLog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tglRawLog
if strcmp(get(handles.tglProjectedLog,'String'),'Linear')
  handles.projectedYScaleState = 'lin';
  set(handles.tglProjectedLog,'String','Log');
elseif strcmp(get(handles.tglProjectedLog,'String'),'Log')
  handles.projectedYScaleState = 'log';
  set(handles.tglProjectedLog,'String','Linear');
end
handles=drawRaw(handles);
guidata(hObject, handles);


% --- Executes on selection change in dropdRefl.
function dropdRefl_Callback(hObject, eventdata, handles)
% hObject    handle to dropdRefl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdRefl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdRefl

str = get(handles.dropdRefl,'String');
val = get(handles.dropdRefl,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}

%   case 'Integrated Intensity'
%     handles.ReflPlot1 = 'Integrated Intensity';
%     handles.ReflCurrentYData1  = handles.I;
%     handles.ReflCurrentsYData1 = handles.sI;
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Integrated intensity [counts]';
%   case 'Fitted Intensity'
%     handles.ReflPlot1 = 'Fitted Intensity';
%     handles.ReflCurrentYData1  = handles.IG;
%     handles.ReflCurrentsYData1 = handles.sIG;
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Fitted intensity [counts*pixel]';
%   case 'Monitor'
%     handles.ReflPlot1 = 'Monitor';
%     handles.ReflCurrentYData1  = handles.M;
%     handles.ReflCurrentsYData1 = handles.sM;
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Monitor intensity [counts]';
%   case 'Background'
%     handles.ReflPlot1 = 'Background';   
%     handles.ReflCurrentYData1  = handles.IG;
%     handles.ReflCurrentsYData1 = handles.sIG;
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Background intensity [counts]';
%   case 'Gauss TwoTheta'
%     handles.ReflPlot1 = 'Gauss TwoTheta'; 
%     handles.ReflCurrentYData1  = handles.GaussTwoTheta;
%     handles.ReflCurrentsYData1 = handles.sGaussTwoTheta;
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = '2\theta Gauss fit [degree]';
%   case 'Temperature'
%     handles.ReflPlot1 = 'Temperature';
%     handles.ReflCurrentYData1  = handles.Temp;
%     handles.ReflCurrentsYData1 = zeros(size(handles.Temp));
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Sample Temperature [K]';
%   case 'Magnetic Field'
%     handles.ReflPlot1 = 'Magnetic Field';
%     handles.ReflCurrentYData1  = handles.Magn;
%     handles.ReflCurrentsYData1 = zeros(size(handles.Magn));
%     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1;
%     handles.ReflYLabel1 = 'Sample Magnetic Field [mT]';
  case 'uu'
    handles.ReflPlot1 = 'uu';
    handles.ReflSpinhandle = handles.uu;
    handles.ReflCurrentYData1  = handles.I(handles.uu);
    handles.ReflCurrentsYData1 = handles.sI(handles.uu);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.uu);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'du'
    handles.ReflPlot1 = 'du';
    handles.ReflSpinhandle = handles.du;
    handles.ReflCurrentYData1  = handles.I(handles.du);
    handles.ReflCurrentsYData1 = handles.sI(handles.du);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.du);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'ud'
    handles.ReflPlot1 = 'ud';
    handles.ReflSpinhandle = handles.ud;
    handles.ReflCurrentYData1  = handles.I(handles.ud);
    handles.ReflCurrentsYData1 = handles.sI(handles.ud);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.ud);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'dd'
    handles.ReflPlot1 = 'dd';
    handles.ReflSpinhandle = handles.dd;
    handles.ReflCurrentYData1  = handles.I(handles.dd);
    handles.ReflCurrentsYData1 = handles.sI(handles.dd);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.dd);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'suu'
    handles.ReflPlot1 = 'suu';
    handles.ReflSpinhandle     = handles.uu;
    handles.ReflCurrentYData1  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData1 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.uu);
    handles.ReflYLabel1 = 'intensity [counts]';
  case 'sdu'
    handles.ReflPlot1 = 'du';
    handles.ReflSpinhandle = handles.du;
    handles.ReflCurrentYData1  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData1 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.du);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'sud'
    handles.ReflPlot1 = 'ud';
    handles.ReflSpinhandle = handles.ud;
    handles.ReflCurrentYData1  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData1 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.ud);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'sdd'
    handles.ReflPlot1 = 'dd';
    handles.ReflSpinhandle = handles.dd;
    handles.ReflCurrentYData1  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData1 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.dd);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
 case 'Background_uu'
     handles.ReflSpinhandle = handles.uu;
     handles.ReflPlot1 = 'Intensity [counts]'; 
     handles.ReflCurrentAllYData1  =  handles.bI;
     handles.ReflCurrentAllsYData1 =  handles.sbI;

     handles.ReflCurrentYData1  = handles.bI(handles.ReflSpinhandle);
     handles.ReflCurrentsYData1 = handles.sbI(handles.ReflSpinhandle);
     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1((handles.ReflSpinhandle));  
     handles.ReflYLabel1 = 'Background';
     handles.ReflYScaleState1 = 'log';
 case 'Background_ud'
     handles.ReflSpinhandle = handles.ud;
     handles.ReflPlot1 = 'Intensity [counts]'; 
     handles.ReflCurrentAllYData1  =  handles.bI;
     handles.ReflCurrentAllsYData1 =  handles.sbI;

     handles.ReflCurrentYData1  = handles.bI(handles.ReflSpinhandle);
     handles.ReflCurrentsYData1 = handles.sbI(handles.ReflSpinhandle);
     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1((handles.ReflSpinhandle));  
     handles.ReflYLabel1 = 'Background';
     handles.ReflYScaleState1 = 'log';
 case 'Background_du'
     handles.ReflSpinhandle = handles.du;
     handles.ReflPlot1 = 'Intensity [counts]'; 
     handles.ReflCurrentAllYData1  =  handles.bI;
     handles.ReflCurrentAllsYData1 =  handles.sbI;

     handles.ReflCurrentYData1  = handles.bI(handles.ReflSpinhandle);
     handles.ReflCurrentsYData1 = handles.sbI(handles.ReflSpinhandle);
     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1((handles.ReflSpinhandle));  
     handles.ReflYLabel1 = 'Background';
     handles.ReflYScaleState1 = 'log';
 case 'Background_dd'
     handles.ReflSpinhandle = handles.dd;
     handles.ReflPlot1 = 'Intensity [counts]'; 
     handles.ReflCurrentAllYData1  =  handles.bI;
     handles.ReflCurrentAllsYData1 =  handles.sbI;

     handles.ReflCurrentYData1  = handles.bI(handles.ReflSpinhandle);
     handles.ReflCurrentsYData1 = handles.sbI(handles.ReflSpinhandle);
     handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1((handles.ReflSpinhandle));  
     handles.ReflYLabel1 = 'Background';
     handles.ReflYScaleState1 = 'log';

  otherwise

end
%handles.ReflCurrentYData2  = handles.ReflCurrentAllYData2(handles.ReflSpinhandle);
%handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
%handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
handles = drawRefl(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dropdRefl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdRefl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dropdRefl2.
function dropdRefl2_Callback(hObject, eventdata, handles)
% hObject    handle to dropdRefl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdRefl2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdRefl2
str = get(handles.dropdRefl2,'String');
val = get(handles.dropdRefl2,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}

%   case 'Integrated Intensity'
%     handles.ReflPlot2 = 'Integrated Intensity';
%     handles.ReflCurrentYData2  = handles.I;
%     handles.ReflCurrentsYData2 = handles.sI;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2;
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'Fitted Intensity'
%     handles.ReflPlot2 = 'Fitted Intensity';
%     handles.ReflCurrentYData2  = handles.IG;
%     handles.ReflCurrentsYData2 = handles.sIG;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2;
%     handles.ReflYLabel2 = 'Fitted intensity [counts*pixel]';
  case 'None'
    handles.ReflPlot2 = 'None';
    handles.ReflCurrentAllYData2  =  [];
    handles.ReflCurrentAllsYData2 =  [];

    handles.ReflCurrentYData2  = [];
    handles.ReflCurrentsYData2 = [];
    handles.ReflCurrentXData2  = [];
    handles.ReflYScaleState2 = 'lin';
    handles.ReflYLabel2 = '';

  case 'Monitor'
    handles.ReflPlot2 = 'Monitor';
    handles.ReflCurrentAllYData2  =  handles.M;
    handles.ReflCurrentAllsYData2 =  handles.sM;

    handles.ReflCurrentYData2  = handles.M(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = handles.sM(handles.ReflSpinhandle);
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYScaleState2 = 'log';
    handles.ReflYLabel2 = 'Monitor intensity [counts]';
    
  case 'Time'
    handles.ReflPlot2 = 'Time';
    handles.ReflCurrentAllYData2  =  handles.Time;
    handles.ReflCurrentAllsYData2 =  zeros(size(handles.Time));
    
    handles.ReflCurrentYData2  = handles.Time(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYScaleState2 = 'lin';
    handles.ReflYLabel2 = 'Time [seconds]';
%   case 'Background'
%     handles.ReflPlot2 = 'Background';   
%     handles.ReflCurrentYData2  = handles.IG;
%     handles.ReflCurrentsYData2 = handles.sIG;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2;
%     handles.ReflYLabel2 = 'Background intensity [counts]';
  case 'Background'
     handles.ReflPlot2 = 'Intensity [counts]'; 
     handles.ReflCurrentAllYData2  =  handles.bI;
     handles.ReflCurrentAllsYData2 =  handles.sbI;

     handles.ReflCurrentYData2  = handles.bI(handles.ReflSpinhandle);
     handles.ReflCurrentsYData2 = handles.sbI(handles.ReflSpinhandle);
     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));  
     handles.ReflYLabel2 = 'Background';
     handles.ReflYScaleState2 = 'log';
     
   case 'dI/I'
     handles.ReflPlot2 = 'dI/I'; 
     handles.ReflCurrentAllYData2  =  handles.dII;
     handles.ReflCurrentAllsYData2 =  zeros(size(handles.dII));

     handles.ReflCurrentYData2  = handles.dII(handles.ReflSpinhandle);
     handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));  
     handles.ReflYLabel2 = 'dI/I';
     handles.ReflYScaleState2 = 'log';
     
     case 'New Time'
     handles.ReflPlot2 = 'New Time'; 
     handles.ReflCurrentAllYData2  =  handles.newTime;
     handles.ReflCurrentAllsYData2 =  zeros(size(handles.newTime));

     handles.ReflCurrentYData2  = handles.newTime(handles.ReflSpinhandle);
     handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));  
     handles.ReflYLabel2 = 'New Time';
     handles.ReflYScaleState2 = 'lin';
     case 'ISpecular'
     handles.ReflPlot2 = 'ISpecular'; 
     handles.ReflCurrentAllYData2  =  handles.ISpecular;
     handles.ReflCurrentAllsYData2 =  zeros(size(handles.ISpecular));

     handles.ReflCurrentYData2  = handles.ISpecular(handles.ReflSpinhandle);
     handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));  
     handles.ReflYLabel2 = 'ISpecular';
     handles.ReflYScaleState2 = 'lin';
     case 'New Theta'
     handles.ReflPlot2 = 'New Theta'; 
     handles.ReflCurrentAllYData2  =  handles.newTheta;
     handles.ReflCurrentAllsYData2 =  zeros(size(handles.newTheta));

     handles.ReflCurrentYData2  = handles.newTheta(handles.ReflSpinhandle);
     handles.ReflCurrentsYData2 = handles.ReflCurrentAllsYData2(handles.ReflSpinhandle);
     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));  
     handles.ReflYLabel2 = 'New Theta';
     handles.ReflYScaleState2 = 'lin';   
 
  case 'Temperature'
    handles.ReflPlot2 = 'Temperature';
    handles.ReflCurrentAllYData2  =  handles.Temp;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.Temp(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.0*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2((handles.ReflSpinhandle));
    handles.ReflYLabel2 = 'Sample Temperature [K]';
    handles.ReflYScaleState2 = 'lin';
  case 'Magnetic Field'
    handles.ReflPlot2 = 'Magnetic Field';
    handles.ReflCurrentAllYData2  =  handles.Magn;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.Magn(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Sample Magnetic Field [mT]';
    handles.ReflYScaleState2 = 'lin';
  case 'Sample slit width'
    handles.ReflPlot2 = 'Sample slit width';
    size(handles.SampleSlit)
    size( handles.SampleSlit(handles.ReflSpinhandle))
    
    handles.ReflCurrentAllYData2  =  handles.SampleSlit;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.SampleSlit(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Sample slit width [mm]';
    handles.ReflYScaleState2 = 'lin';
    case 'First slit width'
    handles.ReflPlot2 = 'First slit width';
    handles.ReflCurrentAllYData2  =  handles.MonoSlit;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.MonoSlit(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'First slit width [mm]';
    handles.ReflYScaleState2 = 'lin';
   case 'over illumination'
    handles.ReflPlot2 = 'over illumination';
    
    handles.ReflCurrentAllYData2  =  handles.overill;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.overill(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Over illumination correction';
    handles.ReflYScale2 = 'lin';
   case 'Divergence'
    handles.ReflPlot2 = 'divergence';

    handles.ReflCurrentAllYData2  =  handles.div;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.div(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Divergence [degrees]';   
    handles.ReflYScaleState2 = 'lin';
    case 'Beam width at sample'
    handles.ReflPlot2 = 'beam width at sample';
    handles.ReflCurrentAllYData2  =  handles.beamw;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.beamw(handles.ReflSpinhandle);
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Beam Width at sample [mm]';   
    handles.ReflYScaleState2 = 'lin';
  case 'dq_x specular'
    handles.ReflPlot2 = [char(916),' q_x specular'];
    
    handles.ReflCurrentAllYData2  =  handles.sQx_specular;
    
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.sQx_specular(handles.ReflSpinhandle');
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = [char(916),' dq_x [',char(916),char(197),'^{-1}]'];
   handles.ReflYScaleState2 = 'lin';
  case 'dq_z specular'
    handles.ReflPlot2 = [char(916),' q_z specular'];
    handles.ReflCurrentAllYData2  =  handles.sQz_specular;
    handles.ReflCurrentAllYData2 = handles.sQz_specular;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.ReflCurrentAllYData2(handles.ReflSpinhandle');
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = [char(916),' dq_z [',char(197),'^{-1}]'];
    handles.ReflYScaleState2 = 'lin';
  case 'Coherence length x'
    handles.ReflPlot2 = 'Coherence length x';
    
    handles.ReflCurrentAllYData2  =  handles.lx/1e4; % angstrom to micrometer

    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.lx(handles.ReflSpinhandle')/1e4;
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = 'Coherence length x [\mu m]';   
    handles.ReflYScaleState2 = 'lin';
    
   case 'Coherence length z'
    handles.ReflPlot2 = 'Coherence length z';
 
    handles.ReflCurrentAllYData2  =  handles.lz;
    handles.ReflCurrentAllsYData2 =  0.0*handles.ReflCurrentAllYData2;
    handles.ReflCurrentYData2  = handles.lz(handles.ReflSpinhandle');
    handles.ReflCurrentsYData2 = 0.*handles.ReflCurrentYData2;
    handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.ReflSpinhandle);
    handles.ReflYLabel2 = ['Coherence length z [',char(197),']'];   
    handles.ReflYScaleState2 = 'lin';
       
    
%   case 'uu'
%     handles.ReflPlot2 = 'uu';
%     handles.ReflCurrentYData2  = handles.I(handles.uu);
%     handles.ReflCurrentsYData2 = handles.sI(handles.uu);
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'du'
%     handles.ReflPlot2 = 'du';
%     handles.ReflCurrentYData2  = handles.I(handles.du);
%     handles.ReflCurrentsYData2 = handles.sI(handles.du);
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'ud'
%     handles.ReflPlot2 = 'ud';
%     handles.ReflCurrentYData2  = handles.I(handles.ud);
%     handles.ReflCurrentsYData2 = handles.sI(handles.ud);
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'dd'
%     handles.ReflPlot2 = 'dd';
%     handles.ReflCurrentYData2  = handles.I(handles.dd);
%     handles.ReflCurrentsYData2 = handles.sI(handles.dd);
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'suu'
%     handles.ReflPlot2 = 'suu';
%     handles.ReflCurrentYData2  = handles.Suu;
%     handles.ReflCurrentsYData2 = handles.sSuu;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'intensity [counts]';
%   case 'sdu'
%     handles.ReflPlot2 = 'du';
%     handles.ReflCurrentYData2  = handles.Sdu;
%     handles.ReflCurrentsYData2 = handles.sSdu;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'sud'
%     handles.ReflPlot2 = 'ud';
%     handles.ReflCurrentYData2  = handles.Sud;
%     handles.ReflCurrentsYData2 = handles.sSud;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
%   case 'sdd'
%     handles.ReflPlot2 = 'dd';
%     handles.ReflCurrentYData2  = handles.Sdd;
%     handles.ReflCurrentsYData2 = handles.sSdd;
%     handles.ReflCurrentXData2  = handles.ReflCurrentAllXData2(handles.uu);
%     handles.ReflYLabel2 = 'Integrated intensity [counts]';
  otherwise

end

handles = drawRefl(handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function dropdRefl2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdRefl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkCompare.
function chkCompare_Callback(hObject, eventdata, handles)
% hObject    handle to chkCompare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checked = get(handles.chkCompare,'Value');
% if checked 
%    str = get(handles.dropdRefl,'String');
% val = get(handles.dropdRefl,'Value');
% if strcmp(str{val},'Integrated Intensity')
%   handles.ReflPlot2 = 'Integrated Intensity';
%   handles.ReflYLabel = 'Integrated intensity [counts]';
% elseif strcmp(str{val},'Fitted Intensity')
%   handles.ReflPlot2 = 'Fitted Intensity';   
%   handles.ReflYLabel = 'Model fitted intensity [counts]';
% elseif strcmp(str{val},'Monitor')
%   handles.ReflPlot2 = 'Monitor';
%   handles.ReflYLabel = 'Monitor Intensity [counts]';
% elseif strcmp(str{val},'Background')
%   handles.ReflPlot2 = 'Background'; 
%   handles.ReflYLabel = 'Background Intensity [counts]';
% elseif strcmp(str{val},'Gauss TwoTheta')
%   handles.ReflPlot1 = 'Gauss TwoTheta';
%   handles.ReflYLabel = '2\theta from model [degrees]';
% elseif strcmp(str{val},'Temperature')
%   handles.ReflPlot1 = 'Temperature';
%   handles.ReflYLabel = 'Temperature [K]';
% elseif strcmp(str{val},'Magnetic Field')
%   handles.ReflPlot1 = 'Magnetic Field'; 
%   handles.ReflYLabel = 'Magnetic Field [mT]';
% end
% 
% elseif ~checked
%     handles.ReflPlot2 = '';
% end

handles = drawRefl(handles);
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of chkCompare


% --- Executes on selection change in dropdXaxis1.
function dropdXaxis1_Callback(hObject, eventdata, handles)
% hObject    handle to dropdXaxis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdXaxis1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdXaxis1
str = get(handles.dropdXaxis1,'String');
val = get(handles.dropdXaxis1,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}
    
  case 'Q_z'
    handles.ReflXScaleState   = 'Q_z';
    handles.ReflCurrentXData1    = handles.Q(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData1 = handles.Q;
    handles.ReflCurrentXData2    = handles.Q(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData2 = handles.Q;
    handles.ReflCurrentXData3    = handles.Q(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData3 = handles.Q;
    
    handles.ReflXLabel        = ['Q_z [',char(197),']^{-1}'];
    handles.ReflXLabel1       = ['Q_z [',char(197),']^{-1}'];
  case 'Theta'
    handles.ReflXScaleState = 'Theta';
    handles.ReflCurrentXData1 = handles.Theta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData1 = handles.Theta;
    handles.ReflCurrentXData2 = handles.Theta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData2 = handles.Theta;
    handles.ReflCurrentXData3 = handles.Theta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData3 = handles.Theta;
    handles.ReflXLabel = '\theta [degree]';
    handles.ReflXLabel1 = '\theta [degree]';
  case 'TwoTheta'
    handles.ReflXScaleState = 'TwoTheta';
    handles.ReflCurrentXData1 = handles.TwoTheta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData1 = handles.TwoTheta;
    handles.ReflCurrentXData2 = handles.TwoTheta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData2 = handles.TwoTheta;
    handles.ReflCurrentXData3 = handles.TwoTheta(handles.ReflSpinhandle);
    handles.ReflCurrentAllXData3 = handles.TwoTheta;

    handles.ReflXLabel = '2\theta [degree]';
    handles.ReflXLabel1 = '2\theta [degree]';
  otherwise
        
end

handles = drawRefl(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dropdXaxis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdXaxis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dropdXaxis2.
function dropdXaxis2_Callback(hObject, eventdata, handles)
% hObject    handle to dropdXaxis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdXaxis2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdXaxis2
str = get(handles.dropdXaxis2,'String');
val = get(handles.dropdXaxis2,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}
  case 'Q_x, Q_z'
    handles.KXKZXScaleState = 'Q_x, Q_z';
    handles.kxkzXLabel = ['Q_x [',char(197),'^{-1}]'];
    handles.kxkzYLabel = ['Q_z [',char(197),'^{-1}]'];
    
    handles.KXKZ_CurrentAllXData1 = handles.Qx;
    handles.KXKZ_CurrentAllXData2 = handles.Qz;
    
    switch handles.KXKZSpinState
      case 'uu'
        handles.KXKZ_CurrentSpinhandle = handles.uu;
        handles.KXKZ_CurrentXData1 = handles.Qx(:,handles.KXKZ_CurrentSpinhandle);
        handles.KXKZ_CurrentXData2 = handles.Qz(:,handles.KXKZ_CurrentSpinhandle);
      case 'du'
        handles.KXKZ_CurrentSpinhandle = handles.du;
        handles.KXKZ_CurrentXData1 = handles.Qx(:,handles.KXKZ_CurrentSpinhandle);
        handles.KXKZ_CurrentXData2 = handles.Qz(:,handles.KXKZ_CurrentSpinhandle);
      case 'ud'
        handles.KXKZ_CurrentSpinhandle = handles.ud;
        handles.KXKZ_CurrentXData1 = handles.Qx(:,handles.KXKZ_CurrentSpinhandle);
        handles.KXKZ_CurrentXData2 = handles.Qz(:,handles.KXKZ_CurrentSpinhandle);
      case 'dd'
        handles.KXKZ_CurrentSpinhandle = handles.dd;
        handles.KXKZ_CurrentXData1 = handles.Qx(:,handles.KXKZ_CurrentSpinhandle);
        handles.KXKZ_CurrentXData2 = handles.Qz(:,handles.KXKZ_CurrentSpinhandle);
    end
    axis(handles.kxkzaxes,'auto');
  case 'pixel, data points'
    handles.KXKZXScaleState = 'pixel, data points';
    handles.kxkzXLabel = handles.rawXLabel;
    handles.kxkzYLabel = 'Number of data points';
    handles.KXKZ_CurrentAllXData1 = handles.pixel_x;
    
   % [m,n] = size(handles.IQ);
   % pixel_y = 1:1:n;
   % pixel_y = repmat(pixel_y,[m 1]); 
   % handles.KXKZ_CurrentAllXData2 = pixel_y;
    handles.KXKZ_CurrentAllXData2 = handles.pixel_y;
%    handles.KXKZ_CurrentXData2 = pixel_y;
    handles.KXKZ_CurrentAllXData1 = handles.pixel_x;
 
    switch handles.KXKZSpinState
      case 'uu'
        handles.KXKZ_CurrentXData1 = handles.pixel_x(:,handles.uu);
        [m,n] = size(handles.pixel_x(:,handles.uu));
        handles.KXKZ_CurrentXData2 = repmat(1:n,[m 1]);
      case 'du'
        handles.KXKZ_CurrentXData1 = handles.pixel_x(:,handles.du);
        [m,n] = size(handles.pixel_x(:,handles.du));
        handles.KXKZ_CurrentXData2 = repmat(1:n,[m 1]);     
      case 'ud'
        handles.KXKZ_CurrentXData1 = handles.pixel_x(:,handles.ud);
        [m,n] = size(handles.pixel_x(:,handles.ud));
        handles.KXKZ_CurrentXData2 = repmat(1:n,[m 1]);
      case 'dd'
        handles.KXKZ_CurrentXData1 = handles.pixel_x(:,handles.dd);
        [m,n] = size(handles.pixel_x(:,handles.dd));
        handles.KXKZ_CurrentXData2 = repmat(1:n,[m 1]);     
    end
    axis(handles.kxkzaxes,'auto');
    
  case 'Theta, TwoTheta/2'
    handles.KXKZXScaleState = 'Theta, TwoTheta/2';
    handles.kxkzXLabel = '\theta [degrees]';
    handles.kxkzYLabel = '2\theta [degrees]';
    handles.KXKZ_XScaleState = 'TwoTheta';
    handles.KXKZ_CurrentAllXData1 = handles.RTheta;
    handles.KXKZ_CurrentAllXData2 = handles.RTwoTheta/2;
    switch handles.KXKZSpinState
      case 'uu'
        handles.KXKZ_CurrentXData1 = handles.RTheta(:,handles.uu);
        handles.KXKZ_CurrentXData2 = handles.RTwoTheta(:,handles.uu);
      case 'du'
        handles.KXKZ_CurrentXData1 = handles.RTheta(:,handles.du);
        handles.KXKZ_CurrentXData2 = handles.RTwoTheta(:,handles.du);
      case 'ud'
        handles.KXKZ_CurrentXData1 = handles.RTheta(:,handles.ud);
        handles.KXKZ_CurrentXData2 = handles.RTwoTheta(:,handles.ud);
      case 'dd'
        handles.KXKZ_CurrentXData1 = handles.RTheta(:,handles.dd);
        handles.KXKZ_CurrentXData2 = handles.RTwoTheta(:,handles.dd);
    end
    
end

handles = drawkxkz(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dropdXaxis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdXaxis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnLoadDAT.
function btnLoadDAT_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadDAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 handles = LoadDAT(handles);

 %set(handles.btnLoadDAT,'BackgroundColor',[0 1 0]);
 guidata(hObject, handles);
 
 return;
 
function handles = LoadDAT(handles)
  [cListOfImageNames,cListOfPathNames ] = uigetfile('*.dat',  'SADAM DAT File','MultiSelect','off');
  handles.DATFile_FullFile = fullfile(cListOfPathNames,cListOfImageNames);
  handles.DAT = process_filearray_DAT(handles.DATFile_FullFile);
return;


% --- Executes on selection change in dropdSpinStatekxkz.
function dropdSpinStatekxkz_Callback(hObject, eventdata, handles)
% hObject    handle to dropdSpinStatekxkz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdSpinStatekxkz contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdSpinStatekxkz
str = get(handles.dropdSpinStatekxkz,'String');
val = get(handles.dropdSpinStatekxkz,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}

  case 'uu'
    handles.KXKZ_Plot2 = 'uu';
    switch handles.Qplotscale
        case 0
          handles.KXKZ_CurrentYData   = handles.IQ(:,handles.uu');
        case 1
          handles.KXKZ_CurrentYData   = handles.IQLog(:,handles.uu');
    end
    handles.KXKZ_CurrentXData1  = handles.KXKZ_CurrentAllXData1(:,handles.uu');
    handles.KXKZ_CurrentXData2  = handles.KXKZ_CurrentAllXData2(:,handles.uu');
    handles.KXKZSpinState = 'uu';
  
  case 'du'
    handles.KXKZ_Plot2 = 'du';
    switch handles.Qplotscale
        case 0
          handles.KXKZ_CurrentYData   = handles.IQ(:,handles.du');
        case 1
          handles.KXKZ_CurrentYData   = handles.IQLog(:,handles.du');
    end
    handles.KXKZ_CurrentXData1  = handles.KXKZ_CurrentAllXData1(:,handles.du');
    handles.KXKZ_CurrentXData2  = handles.KXKZ_CurrentAllXData2(:,handles.du');
    handles.KXKZSpinState = 'du';
  case 'ud'
    handles.KXKZ_Plot2 = 'ud';
    switch handles.Qplotscale
        case 0
          handles.KXKZ_CurrentYData   = handles.IQ(:,handles.ud');
        case 1
          handles.KXKZ_CurrentYData   = handles.IQLog(:,handles.ud');
    end
    handles.KXKZ_CurrentXData1  = handles.KXKZ_CurrentAllXData1(:,handles.ud');
    handles.KXKZ_CurrentXData2  = handles.KXKZ_CurrentAllXData2(:,handles.ud');
    handles.KXKZSpinState = 'ud';
   case 'dd'
    handles.KXKZ_Plot2 = 'dd';
    switch handles.Qplotscale
        case 0
          handles.KXKZ_CurrentYData   = handles.IQ(:,handles.dd');
        case 1
          handles.KXKZ_CurrentYData   = handles.IQLog(:,handles.dd');
    end
    handles.KXKZ_CurrentXData1  = handles.KXKZ_CurrentAllXData1(:,handles.dd');
    size(handles.dd')
    size(handles.KXKZ_CurrentAllXData2)
 
    handles.KXKZ_CurrentXData2  = handles.KXKZ_CurrentAllXData2(:,handles.dd');
    handles.KXKZSpinState = 'dd';
 end
handles = drawkxkz(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dropdSpinStatekxkz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdSpinStatekxkz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on togglebutton6 and none of its controls.
function togglebutton6_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton15.
function togglebutton15_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton15


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over lstFiles.
function lstFiles_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to lstFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = doMonitor(handles,hObject);



% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
% hObject    handle to btnReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1:length(handles.experiment)
  handles.experiment{i}.hasROI = 0;
  handles.experiment{i}.start       = 1;
  handles.experiment{i}.end         = handles.experiment{1}.imsize(1);
  handles.experiment{i}.bottom      = handles.experiment{1}.imsize(1);
  handles.experiment{i}.top         = 1;
end

set(handles.btnSelectROI,'Value',0);
set(handles.btnBackground,'Value',0);
handles = reduceData(handles);
handles = change_states(handles);
handles = drawRaw(handles);
handles = drawRefl(handles);
handles = drawkxkz(handles);
guidata(hObject, handles);


% --------------------------------------------------------------------
function uitoggletool1_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('zoom')


% --------------------------------------------------------------------
function uitoggletool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 h = zoom;
 set(h,'ActionPreCallback',@myprecallback);
 set(h,'ActionPostCallback',@mypostcallback);
 set(h,'Enable','on');
 
function myprecallback(obj,evd)
 %   disp('A zoom is about to occur.');
 
function mypostcallback(obj,evd)
  
  newXLim = get(evd.Axes,'XLim');
  newYLim = get(evd.Axes,'YLim');
    
  
    %msgbox(sprintf('The new X-Limits are [%.2f %.2f].',newLim));


% --------------------------------------------------------------------
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uiputfile( ...
{'*.dat;','Reduced Reflectivity';...
 '*.dat','Raw Reflectivity (*.dat)';...
 '*.*',  'All Files (*.*)'},...
 'Save as');
% 
% [filename, pathname, filterindex] = uiputfile( ...
% {'*.m;*.fig;*.mat;*.slx;*.mdl',...
%  'MATLAB Files (*.m,*.fig,*.mat,*.slx,*.mdl)';
%  '*.m', 'program files (*.m)';...
%  '*.fig','Figures (*.fig)';...
%  '*.mat','MAT-files (*.mat)';...
%  '*.slx;*.mdl','Models (*.slx,*.mdl)';...
%  '*.*',  'All Files (*.*)'},...
%  'Save as');
file=fullfile(pathname,filename)
%makeNXRefscanSAD(file,handles);

%fid     = fopen(file,'w');


 % fprintf(fid,'%7.9f %7.9f %7.9f %7.9f\n',[handles.ReflCurrentXData1(:)'; handles.ReflCurrentYData1(:)';handles.ReflCurrentsYData1(:)';...
 %   sqz(handles.ReflSpinhandle')']);
 % fclose(fid);

 
 [Qsortuu,idxuu] = sort(handles.Q(handles.uu),'ascend');
 [Qsortud,idxud] = sort(handles.Q(handles.ud),'ascend');
 [Qsortdu,idxdu] = sort(handles.Q(handles.du),'ascend');
 [Qsortdd,idxdd] = sort(handles.Q(handles.dd),'ascend');
 
 sQz_uu = handles.sQz(handles.uu); sQz_uu = sQz_uu(idxuu);
 sQz_ud = handles.sQz(handles.ud); sQz_ud = sQz_ud(idxud);
 sQz_du = handles.sQz(handles.du); sQz_du = sQz_du(idxdu);
 sQz_dd = handles.sQz(handles.dd); sQz_dd = sQz_dd(idxdd);
 
 

 Isortuu = handles.I(handles.uu); Isortuu = Isortuu(idxuu);
 Isortud = handles.I(handles.ud); Isortud = Isortud(idxud);
 Isortdu = handles.I(handles.du); Isortdu = Isortdu(idxdu);
 Isortdd = handles.I(handles.dd); Isortdd = Isortdd(idxdd);
 
 sIsortuu = handles.sI(handles.uu); sIsortuu = sIsortuu(idxuu);
 sIsortud = handles.sI(handles.ud); sIsortud = sIsortud(idxud);
 sIsortdu = handles.sI(handles.du); sIsortdu = sIsortdu(idxdu);
 sIsortdd = handles.sI(handles.dd); sIsortdd = sIsortdd(idxdd);


  fid     = fopen([file(1:end-4),'_uu.dat'],'w');
%regexprep(sprintf('%8.2E',a),'E-0','E-')
  fprintf(fid,'%8.2E %8.2E %8.2E\n',[Qsortuu'; Isortuu'; sIsortuu']);
  %fprintf(fid,'%7.9f %7.9f %7.9f\n',[Qsortuu'; Isortuu'; sIsortuu']); %sqz(handles.uu')'
  fclose(fid);
  
  fid     = fopen([file(1:end-4),'_du.dat'],'w');
  fprintf(fid,'%8.2E %8.2E %8.2E\n',[Qsortdu'; Isortdu'; sIsortdu']);
  %fprintf(fid,'%7.9f %7.9f %7.9f \n',[Qsortdu'; Isortdu'; sIsortdu']);
  fclose(fid);
  
  fid     = fopen([file(1:end-4),'_ud.dat'],'w');
  fprintf(fid,'%8.2E %8.2E %8.2E\n',[Qsortud'; Isortud'; sIsortud']);
  %fprintf(fid,'%7.9f %7.9f %7.9f \n',[Qsortud'; Isortud';sIsortud']);
  fclose(fid);
 
  fid     = fopen([file(1:end-4),'_dd.dat'],'w');

 % fprintf(fid,'%7.9f %7.9f %7.9f \n',[Qsortdd'; Isortdd';sIsortdd']);
  fprintf(fid,'%8.2E %8.2E %8.2E\n',[Qsortdd'; Isortdd'; sIsortdd']);
  fclose(fid);
%savedata2('refl.dat',handles.ReflCurrentXData1,handles.ReflCurrentYData1,handles.ReflCurrentsYData1,sqz(handles.ReflSpinhandle'));
%dataset = {'north','south'; 'east','west'};

%testdata = uint8(magic(5));

%h5create(file,'/Scan',size(testdata));
%h5write(file,'/dataset1',testdata);
%fcpl = H5P.create('H5P_FILE_CREATE');
%fapl = H5P.create('H5P_FILE_ACCESS');
%fid = H5F.create(file,'H5F_ACC_TRUNC',fcpl,fapl);
%h5info(file)

%gid = createGroup(fid,'Scan')
%h5info(file)
%aid = write_attribute(fid,'NX_class');
%close(gid);
%h=h5read(file,'/dataset1')
%h5info(file)

%filename
%%pathname
%filterindex


% --- Executes on selection change in popColor.
function popColor_Callback(hObject, eventdata, handles)
% hObject    handle to popColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = get(handles.popColor,'String');
val = get(handles.popColor,'Value');

if ischar(class(str))
  str = cellstr(str);
end

axes(handles.kxkzaxes);

switch str{val}

  case 'Autumn'
      map = load('maps/Autumn.map');
  case 'Beach'
      map = load('maps/Beach.map');
  case 'BlackBodyRadiation'
      map = load('maps/BlackBodyRadiation.map');
  case 'BlueIn'
      map = load('maps/BlueIn.map');
  case 'BlueOut'
      map = load('maps/BlueOut.map');
  case 'BlueRed'
      map = load('maps/BlueRed.map');
  case 'BP'
      map = load('maps/BP.map');
  case 'BPG'
      map = load('maps/BPG.map');
  case 'BWB'
       map = load('maps/BWB.map');
  case 'ColdFire'
      map = load('maps/ColdFire.map');
  case 'Colors'
       map = load('maps/Colors.map');
  case 'Cool'
       map = load('maps/Cool.map');
  case 'Gamma1'
      map = load('maps/Gamma1.map');
  case 'Gamma2'
      map = load('maps/Gamma2.map');      
  case 'GreenIn'
       map = load('maps/GreenIn.map');
  case 'GreenOut'
      map = load('maps/GreenOut.map');
  case 'GreenToWhite'
       map = load('maps/GreenToWhite.map');
  case 'Grey'     
     map = load('maps/Grey.map');
  case 'IDL-rainbow'
       map = load('maps/IDL-rainbow.map');
  case 'Indigo'
      map = load('maps/Indigo.map');
  case 'Jet'
       map = load('maps/Jet.map');
  case 'Lace' 
       map = load('maps/Lace.map');
  case 'Rainbow' 
       map = load('maps/Rainbow.map');
  case 'RBY' 
         map = load('maps/RBY.map');
  case 'RedIn' 
      map = load('maps/RedIn.map');
  case 'RedOut' 
      map = load('maps/RedOut.map');
  case 'RosePetals'
      map = load('maps/RosePetals.map');
  case 'TouchOfBlues' 
      map = load('maps/TouchOfBlues.map');
  case 'Volcano'
      map = load('maps/Volcano.map');
  case 'YellowToBlack'
      map = load('maps/YellowToBlack.map');
        
  otherwise
end

handles.kxkzmap = colormap(map/255);
colormap(handles.kxkzaxes,handles.kxkzmap);
guidata(hObject, handles);


% Hints: contents = cellstr(get(hObject,'String')) returns popColor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popColor


% --- Executes during object creation, after setting all properties.
function popColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function loadDAT_Callback(hObject, eventdata, handles)
% hObject    handle to loadDAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = LoadDAT(handles);
% hObject    handle to btnLoadDAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [cListOfImageNames,cListOfPathNames ] = uigetfile('*.dat',  'SADAM DAT File','MultiSelect','off');
% handles.DATFile_FullFile = fullfile(cListOfPathNames,cListOfImageNames);
% handles.DAT = process_filearray_DAT(handles.DATFile_FullFile);

 %set(handles.btnLoadDAT,'BackgroundColor',[0 1 0]);
 guidata(hObject, handles);

% --------------------------------------------------------------------
function loadEDF_Callback(hObject, eventdata, handles)
% hObject    handle to loadEDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fileformat ='edf';
handles = LoadImageList(handles);
handles = drawRaw(handles);
handles = drawkxkz(handles);
handles = drawRefl(handles);
guidata(hObject, handles);

% --------------------------------------------------------------------
function loadDB_Callback(hObject, eventdata, handles)
% hObject    handle to loadDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  %[cListOfImageNames,cListOfPathNames ] = uigetfile('*.edf',  'EDF Files','MultiSelect','on');
  handles.fileformat ='h5';

    [cListOfImageNames,cListOfPathNames ] = uigetfile('*.h5',  'h5 Files','MultiSelect','on');

%  if cListOfImageNames ~= 0
a = handles.listDirectExists
  if handles.listDirectExists
    handles.ListOfDirectImageNames = [handles.ListOfDirectImageNames cListOfImageNames];
    handles.ListOfDirectPathNames  = [handles.ListOfDirectPathNames cListOfPathNames];
    b = handles.ListOfDirectImageNames
    c = handles.ListOfDirectPathNames
    if ischar(class(handles.ListOfDirectImageNames))
      
      handles.ListOfDirectImageNames = cellstr(handles.ListOfDirectImageNames);
      d = handles.ListOfDirectImageNames
    end
    
    if ischar(class(cListOfImageNames))
      cListOfImageNames = cellstr(cListOfImageNames);
      cListOfImageNames
    end
    
    for i = 1:length(cListOfImageNames)
      cFullFileList{i} = fullfile(cListOfPathNames,cListOfImageNames(i));
      cFullFileList{i}
    end
    handles.FullDirectFileList = [handles.FullDirectFileList cFullFileList];
    handles.listDirectExists = 1;
    e = handles.FullDirectFileList
  else
    handles.ListOfDirectImageNames = cListOfImageNames;
    handles.ListOfDirectPathNames  = cListOfPathNames;
 
    if ischar(class(handles.ListOfDirectImageNames))
      handles.ListOfDirectImageNames = cellstr(handles.ListOfDirectImageNames);
    end

    for i = 1:length(handles.ListOfDirectImageNames)
      handles.FullDirectFileList{i} = fullfile(handles.ListOfDirectPathNames,handles.ListOfDirectImageNames(i));
    end

    handles.listDirectExists = 1;
  end
  
  %set(handles.lstDirectBeam,'string',handles.ListOfDirectImageNames);
 
  if handles.listDirectExists
    handles.fileformat = 'h5pol';
    db = process_filearray(handles.FullDirectFileList,handles);
    N = length(handles.db);
    M = length(db);

    for i = (N+1):(N+M)
        handles.db{i} = db{i-N};
    end
  end
 handles = reduceData(handles);
  set(handles.lstDirectBeam,'string',num2str(handles.DSampleSlit(:)));
  set(handles.lstDirectBeam,'value',1);
 handles = change_states(handles);
 handles = drawRaw(handles);
 guidata(hObject, handles);
  
  

% --------------------------------------------------------------------
function edtMenu_Callback(hObject, eventdata, handles)
% hObject    handle to edtMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in lstDirectBeam.
function lstDirectBeam_Callback(hObject, eventdata, handles)
% hObject    handle to lstDirectBeam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstDirectBeam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstDirectBeam
handles.currentList = 'direct';
handles = drawRaw(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function lstDirectBeam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstDirectBeam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tglNormalize.
function tglNormalize_Callback(hObject, eventdata, handles)
% hObject    handle to tglNormalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tglNormalize
handles = doDBNormalize(handles,hObjecT);

return;



% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5
handles = doOverIllumination(handles,hObject);




% --------------------------------------------------------------------
function SaveSession_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uiputfile( ...
{'*.sad','SARED file (*.sad)';...
 '*.*',  'All Files (*.*)'},...
 'Save as');
file=fullfile(pathname,filename);
h = waitbar(0,'Saving session...','WindowStyle','modal');

state.experiment = handles.experiment;
state.db          = handles.db;
state.dropdReflString = handles.dropdReflString;
state.dropdRefl2  = get(handles.dropdRefl2,'String');
state.dropdRefl   = get(handles.dropdRefl,'String');
state.dropdRefl   = get(handles.dropdRefl,'String');
state.dropdXaxis1 = get(handles.dropdXaxis1,'Value');
state.dropdXaxis2 = get(handles.dropdXaxis2,'Value');
state.dropdSpinStatekxkz = get(handles.dropdSpinStatekxkz,'String');
state.popColor      = get(handles.popColor,'Value');

state.lstFiles      = get(handles.lstFiles,'String');
state.lstFilesValue = get(handles.lstFiles,'value');
state.lstDirectBeam = get(handles.lstDirectBeam,'String');
state.lstDirectBeamValue = get(handles.lstDirectBeam,'value');

% State variables
state.hasRunRaw  = handles.hasRunRaw;
state.listExists = handles.listExists;
state.Qplotscale = handles.Qplotscale; 
state.rawplotscale = handles.rawplotscale;
state.hasPopulated_unpolarized = handles.hasPopulated_unpolarized;
state.hasPopulated_uu = handles.hasPopulated_uu;
state.hasPopulated_dd = handles.hasPopulated_dd;
state.hasPopulated_ud = handles.hasPopulated_ud;
state.hasPopulated_du = handles.hasPopulated_du;
state.hasSpinCorrected = handles.hasSpinCorrected;
state.listDirectExists = handles.listDirectExists;
state.doMonitor = handles.doMonitor;
state.doBackground = handles.doBackground;
state.doOverIllumination = handles.doOverIllumination;
state.doNormalize = handles.doNormalize;
state.doPolarizationCorrection = handles.doPolarizationCorrection;
state.doThetaOffset = handles.doThetaOffset;

state.hasPopulated_bkg = handles.hasPopulated_bkg;
state.currentList = handles.currentList;

if handles.experiment{1}.hasROI
  state.hDetectorRectPos  = getPosition(handles.hDetectorRect);
end
if handles.experiment{1}.hasBackROI
  state.hBackgroundROI  = getPosition(handles.hBackgroundROI);
end

handles = generateStack(hObject,handles);

state.sld = handles.sld;
state.sld_m = handles.sld_m;
state.Q   = handles.Q;
state.sld_m = handles.sld_m;
state.theta = handles.theta;
state.d     = handles.d;
state.rough = handles.rough;
state.N         = handles.N;
state.TLayers    = handles.TLayers;
state.wavelength = handles.wavelength;
%state.Layers     = handles.Layers;
state.Checked     = handles.Checked;
state.mnuFitDataString = handles.mnuFitDataString;

state.dropdReflString  = handles.dropdReflString;
state.I0  = handles.I0;
state.BeamWidth =     handles.BeamWidth;
state.SampleLength =     handles.SampleLength;
state.Res = handles.Res;
state.wavelength = handles.wavelength;
state.Probe = handles.Probe;
state.Qstring = get(handles.edtQ,'String');
  
if ~isempty(handles.data)
  state.qdata      = handles.qdata;
  state.data       = handles.data;
else
  state.qdata = [];
  state.data = [];
end


save(file,'-struct','state','-v7.3');
delete(h);
% --------------------------------------------------------------------
function LoadSession_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[cFile,cPath ] = uigetfile('*.sad',  'SAD Files','MultiSelect','off');

filename =fullfile(cPath,cFile);
h = waitbar(0,'Loading session...','WindowStyle','modal');
state = load(filename,'-mat');

handles.experiment = state.experiment;
handles.db         = state.db;
set(handles.dropdRefl3,'String',state.dropdReflString);
set(handles.dropdRefl2,'String',state.dropdRefl2);
set(handles.dropdRefl,'String',state.dropdRefl);
set(handles.dropdRefl,'Value',1);
set(handles.dropdRefl2,'Value',1);
set(handles.dropdXaxis1,'Value',state.dropdXaxis1);
set(handles.dropdXaxis2,'Value',state.dropdXaxis2);

set(handles.popColor,'Value',state.popColor);
%set(handles.btnSelectROI,'Value',state.btnSelectROI);
%set(handles.togglebutton6,'Value',state.togglebutton6);
%set(handles.tglNormalize,'Value',state.tglNormalize);
%set(handles.btnBackground,'Value',state.btnBackground);
%set(handles.togglebutton5,'Value',state.togglebutton5);
set(handles.dropdSpinStatekxkz,'String',state.dropdSpinStatekxkz);
set(handles.dropdSpinStatekxkz,'Value',1);
set(handles.lstFiles,'String',state.lstFiles);
set(handles.lstFiles,'value',state.lstFilesValue);
set(handles.lstDirectBeam,'String',state.lstDirectBeam);
set(handles.lstDirectBeam,'Value',state.lstDirectBeamValue);

handles.mnuFitDataString = state.mnuFitDataString;

handles.dropdReflString = state.dropdReflString;
% State variables
handles.hasRunRaw    = state.hasRunRaw;
handles.listExists   = state.listExists;
handles.Qplotscale   = state.Qplotscale;
handles.rawplotscale = state.rawplotscale;
handles.hasPopulated_unpolarized = state.hasPopulated_unpolarized; 
handles.hasPopulated_uu  = state.hasPopulated_uu;
handles.hasPopulated_dd  = state.hasPopulated_dd;
handles.hasPopulated_ud  = state.hasPopulated_ud;
handles.hasPopulated_du  = state.hasPopulated_du;
handles.hasSpinCorrected = state.hasSpinCorrected;
handles.listDirectExists = state.listDirectExists;

handles.doMonitor          = state.doMonitor;
handles.doBackground       = state.doBackground;
handles.doOverIllumination = state.doOverIllumination;
handles.hasPopulated_bkg = state.hasPopulated_bkg;
handles.currentList = state.currentList;
handles.doNormalize = state.doNormalize;
handles.doMonitor = state.doMonitor;
handles.doBackground = state.doBackground;
handles.doThetaOffset = state.doThetaOffset;
handles.doOverIllumination = state.doOverIllumination;
handles.doPolarizationCorrection = state.doPolarizationCorrection;

delete(get(handles.rawaxes,'Children'));
delete(get(handles.projectedaxes,'Children'));
delete(get(handles.secondaxes,'Children'));
delete(get(handles.reflectivityaxes,'Children'));
delete(get(handles.kxkzaxes,'Children'));

handles.sld = state.sld;
handles.Q   = state.Q;
handles.sld_m = state.sld_m;
handles.theta = state.theta;
handles.d     = state.d;
handles.rough = state.rough;
handles.wavelength = state.wavelength;
handles.N = state.N;
handles.TLayers  = state.TLayers;

set(handles.edtWavelength,'String',num2str(handles.wavelength));
handles.qdata = state.qdata;
handles.data  = state.data;
handles.I0 = state.I0;
handles.BeamWidth =     state.BeamWidth;
handles.SampleLength =     state.SampleLength;
handles.Res = state.Res;
handles.Checked        = state.Checked;
 
handles.wavelength = state.wavelength;
handles.Probe = state.Probe;
%set(handles.mnuProbe,'Value',handles.Probe);
%set(handles.edtWavelength,'String',num2str(handles.wavelength));
%set(handles.edtRep,'String','1');
if handles.doNormalize
  set(handles.mnuDirectBeamNorm,'Checked','on');
end
if handles.doMonitor
  set(handles.mnuTime,'Checked','on');
end
if handles.experiment{1}.hasROI
  set(handles.mnuDetectorROI,'Checked','on');
end
if handles.doBackground
  set(handles.mnuBackground,'Checked','on');
end
if handles.doOverIllumination
  set(handles.mnuOverIllumination,'Checked','on');
end
if ~handles.doPolarizationCorrection
  set(handles.mnuPolarizationLeakage,'Checked','on');
end
if handles.doThetaOffset
  set(handles.mnuThetaOffset,'Checked','on');
end

generateStack(hObject,handles);

handles = reduceData(handles);

handles = change_states(handles);
set(handles.pnlRaw,'Visible','on');
set(handles.pnlProcess,'Visible','on');
set(handles.projectedaxes,'Visible','on');
set(handles.rawaxes,'Visible','on');
set(handles.tglProjectedLog,'Visible','on');
set(get(handles.projectedaxes,'Children'),'Visible','on');
set(handles.reflectivityaxes,'Visible','on');
handles = drawRaw(handles);
handles = drawRefl(handles);
handles = drawkxkz(handles);

if handles.experiment{1}.hasROI
 
handles.hDetectorRect   = imrect(handles.rawaxes,state.hDetectorRectPos);
setColor(handles.hDetectorRect,[0.5 0.5 0.5]);
setResizable(handles.hDetectorRect,0);
fcn = makeConstrainToRectFcn('imrect',[state.hDetectorRectPos(1) state.hDetectorRectPos(1)+state.hDetectorRectPos(3)],[state.hDetectorRectPos(2) state.hDetectorRectPos(2)+state.hDetectorRectPos(4)]);
setPositionConstraintFcn(handles.hDetectorRect,fcn);

end
if handles.experiment{1}.hasBackROI
  handles.hBackgroundROI   = imrect(handles.rawaxes,[state.hBackgroundROI]);
  setColor(handles.hBackgroundROI,[0.3 0.5 0.5]);
  setResizable(handles.hBackgroundROI,0);
  fcn = makeConstrainToRectFcn('imrect',[state.hBackgroundROI(1) state.hBackgroundROI(1)+state.hBackgroundROI(3)],[state.hBackgroundROI(2) state.hBackgroundROI(2)+state.hBackgroundROI(4)]);
  setPositionConstraintFcn(handles.hBackgroundROI,fcn);
end

guidata(hObject, handles);
delete(h);
return;
 
  


% --- Executes during object creation, after setting all properties.
function togglebutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnSelectROI.
function btnSelectROI_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnSelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function btnSelectROI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnSelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function mnuDetectorROI_Callback(hObject, eventdata, handles)
% hObject    handle to mnuDetectorROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doMainROI(handles,hObject);
return;

% --------------------------------------------------------------------
function mnuTime_Callback(hObject, eventdata, handles)
% hObject    handle to mnuTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doMonitor(handles,hObject);

% --------------------------------------------------------------------
function mnuDirectBeamNorm_Callback(hObject, eventdata, handles)
% hObject    handle to mnuDirectBeamNorm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = doDBNormalize(handles,hObject);
return;

% --------------------------------------------------------------------
function mnuBackground_Callback(hObject, eventdata, handles)
% hObject    handle to mnuBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doBackground(handles,hObject);

% --------------------------------------------------------------------
function mnuOverIllumination_Callback(hObject, eventdata, handles)
% hObject    handle to mnuOverIllumination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doOverIllumination(handles,hObject);

% --------------------------------------------------------------------
function mnuPolarizationLeakage_Callback(hObject, eventdata, handles)
% hObject    handle to mnuPolarizationLeakage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doPolarizationCorrection(handles,hObject);


% --- Executes on selection change in dropdRawAxes.
function dropdRawAxes_Callback(hObject, eventdata, handles)
% hObject    handle to dropdRawAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdRawAxes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdRawAxes


% --- Executes during object creation, after setting all properties.
function dropdRawAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdRawAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function handles = doDBNormalize(handles,hObject)

  if ~handles.isMakingROI && ~handles.isMakingBROI
    if ~handles.doNormalize
      set(handles.mnuDirectBeamNorm,'Checked','on');
      handles.doNormalize = 1;
    else
      handles.doNormalize = 0;
      set(handles.mnuDirectBeamNorm,'Checked','off');
    end

    handles = reduceData(handles);
    handles = change_states(handles);
    handles = drawRaw(handles);
    handles = drawRefl(handles);
    handles = drawkxkz(handles);
    guidata(hObject, handles);
  else
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    msgbox('Already making a ROI, please double click on the ROI to proceed');
  end
return;

function handles = doOverIllumination(handles,hObject)
  
  if ~handles.isMakingROI && ~handles.isMakingBROI
    if handles.doOverIllumination
      handles.doOverIllumination = 0;
      set(handles.mnuOverIllumination,'Checked','off');
      handles.dropdReflString2 = handles.dropdReflStringbackup2;
      set(handles.dropdRefl2,'String',handles.dropdReflString2);
    else
      handles.doOverIllumination = 1;
      set(handles.mnuOverIllumination,'Checked','on');
      handles.dropdReflStringbackup2 = handles.dropdReflString2;
      handles.dropdReflString2 = ['over illumination', handles.dropdReflString2];
      set(handles.dropdRefl2,'String',handles.dropdReflString2);
    end

    handles = reduceData(handles);
    handles = change_states(handles);
    handles = drawRaw(handles);
    handles = drawRefl(handles);
    handles = drawkxkz(handles);
    guidata(hObject, handles);
  else
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    msgbox('Already making a ROI, please double click on the ROI to proceed');
  end
return;


function handles = doMonitor(handles,hObject)
        
  if ~handles.isMakingROI && ~handles.isMakingBROI
    if handles.doMonitor
      handles.doMonitor = 0;
      set(handles.mnuTime,'Checked','off');
    else
      handles.doMonitor = 1;
      set(handles.mnuTime,'Checked','on');
    end
    handles = reduceData(handles);
    handles = change_states(handles);
    handles = drawRefl(handles);
    guidata(hObject, handles);
  else
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    msgbox('Already making a ROI, please double click on the ROI to proceed');
  end

return;


  function handles = doBackground(handles,hObject)
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    
    if ~handles.isMakingROI && ~handles.isMakingBROI
      idx     = get(handles.lstFiles, 'value');
      handles.isMakingBROI = 1;
      guidata(hObject, handles);
      if handles.doBackground
        handles.doBackground = 0;
        set(handles.mnuBackground,'Checked','off');
        if handles.settings.doROI1
          for i= 1:length(handles.experiment)
            handles.experiment{i}.hasBackROI  = 0;
          end
          delete(handles.hBackgroundROI);
          
        elseif handles.settings.doROI2
          for i= 1:length(handles.experiment)
            handles.experiment{i}.hasBackROI_2  = 0;
          end
          delete(handles.hBackgroundROI1);
          delete(handles.hBackgroundROI2);
        end
        
        handles.hasPopulated_bkg = 0;
        
        
        remstr = {'Background_uu','Background_ud','Background_du','Background_dd'};
        
        for j = 1:length(remstr)
          currentstr = get(handles.dropdRefl,'String');
          found = strfind(currentstr,remstr{j});
          k = 2;
          handles.dropdReflString = {};
          for i = 1:length(found)
            if isempty(found{i})
              handles.dropdReflString = [handles.dropdReflString,currentstr{i}];
              k = k + 1;
            end
          end
          set(handles.dropdRefl,'String',handles.dropdReflString);
          set(handles.dropdRefl,'Value',1);
        end
        
        
        for j = 1:length(remstr)
        currentstr = get(handles.dropdRefl3,'String');
        found = strfind(currentstr,remstr{j});
        k = 2;
        handles.dropdReflString3 = {'None'};
        for i = 2:length(found) % 2 so we don't get a double None
          if isempty(found{i})
            handles.dropdReflString3 = [handles.dropdReflString3,currentstr{i}];
            test = handles.dropdReflString3            
            k = k + 1;
          end
        end
        set(handles.dropdRefl3,'String',handles.dropdReflString3);
        set(handles.dropdRefl3,'Value',1);
        end

        
      else
        handles.doBackground = 1;
        set(handles.mnuBackground,'Checked','on');
        applyToAll = 0;
        
        if handles.settings.doModel
          
          if ~applyToAll
            h = waitbar(0,'Fitting Gaussian to projection');
            for i = 1:length(handles.experiment)
              handles.experiment{i} = fitModel_genetic(handles.experiment{i},handles);
              waitbar(i/length(handles.experiment),h);
            end
            close(h);
          else
            idx     = get(handles.lstFiles, 'value');
            handles = fitModel_genetic(handles,idx);
          end
          
        elseif handles.settings.doROI1
          
          axes(handles.rawaxes);
          
          if ~handles.experiment{idx}.hasROI || ~handles.experiment{idx}.hasBackROI
            
            if handles.experiment{idx}.hasROI
              X = handles.experiment{idx}.start;
              Y = handles.experiment{idx}.top;
              W = handles.experiment{idx}.end-X;
              H = handles.experiment{idx}.bottom - Y;
              X = X - W;
            elseif handles.DAT.ROI(1) == -1
              %             W = 20;
              %             H = 100;
              %             X = 250;
              %             Y = 250;
              W = 100;
              H = 500;
              X = 550;
              Y = 400;
            else
              ROI = handles.DAT.ROI/3;
              % ROI is (y,x) (y,x) and has been binned 3x times, so divide by 3.
              
              ROI_L = abs(ROI(2) - ROI(4));
              ROI_H = abs(ROI(1) - ROI(3));
              
              W = ROI_L;
              H = ROI_H;
              X = ROI(2) + 20;
              Y = ROI(1);
            end
            
            handles.hBackgroundROI   = imrect(handles.rawaxes,[X Y W H]);
            setColor(handles.hBackgroundROI,'r');
            fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
            setPositionConstraintFcn(handles.hBackgroundROI,fcn);
          end
          
          pos = wait(handles.hBackgroundROI);
          
          for i= 1:length(handles.experiment)
            handles.experiment{i}.hasBackROI  = 1;
            handles.experiment{i}.bstart   = round(pos(1));
            handles.experiment{i}.bend     = round(pos(1)+pos(3));
            handles.experiment{i}.btop     = round(pos(2));
            handles.experiment{i}.bbottom  = round(pos(2)+pos(4));
          end
          if  ~handles.hasPopulated_bkg
            if any(handles.uu)
              handles.dropdReflString = [handles.dropdReflString,'Background_uu'];
            end
            if any(handles.ud)
              handles.dropdReflString = [handles.dropdReflString,'Background_ud'];
            end
            if any(handles.du)
              handles.dropdReflString = [handles.dropdReflString,'Background_du'];
            end
            if any(handles.dd)
              handles.dropdReflString = [handles.dropdReflString,'Background_dd'];
            end
            
            set(handles.dropdRefl,'String',handles.dropdReflString);
            handles.hasPopulated_bkg = 1;
          end        
          setColor(handles.hBackgroundROI,[0.3 0.5 0.5]);
          setResizable(handles.hBackgroundROI,0);
          fcn = makeConstrainToRectFcn('imrect',[pos(1) pos(1)+pos(3)],[pos(2) pos(2)+pos(4)]);
          setPositionConstraintFcn(handles.hBackgroundROI,fcn);
          
        elseif handles.settings.doROI2
          axes(handles.rawaxes);
          
          if ~handles.experiment{idx}.hasROI || ~handles.experiment{idx}.hasBackROI_2
            if handles.experiment{idx}.hasROI
              X = handles.experiment{idx}.start;
              Y = handles.experiment{idx}.top;
              W = handles.experiment{idx}.end-X;
              H = handles.experiment{idx}.bottom - Y;
              X = X - W;
              
            elseif handles.DAT.ROI(1) == -1
              W = 100;
              H = 500;
              X = 500;
              Y = 400;
            else
              ROI = handles.DAT.ROI/3;
              % ROI is (y,x) (y,x) and has been binned 3x times, so divide by 3.
              
              ROI_L = abs(ROI(2) - ROI(4));
              ROI_H = abs(ROI(1) - ROI(3));
              
              W = ROI_L;
              H = ROI_H;
              X = ROI(2);
              Y = ROI(1);
            end
            
            handles.hBackgroundROI1   = imrect(handles.rawaxes,[X Y W H]);
            setColor(handles.hBackgroundROI1,'r');
            fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
            setPositionConstraintFcn(handles.hBackgroundROI1,fcn);
            handles.hBackgroundROI2   = imrect(handles.rawaxes,[X+2*W Y W H]);
            setColor(handles.hBackgroundROI2,'r');
            fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
            setPositionConstraintFcn(handles.hBackgroundROI2,fcn);
          end
          
          pos1 = wait(handles.hBackgroundROI1);
          pos2 = wait(handles.hBackgroundROI2);
          
          for i= 1:length(handles.experiment)
            handles.experiment{i}.hasBackROI_2 = 1;
            handles.experiment{i}.b21start   = round(pos1(1));
            handles.experiment{i}.b21end     = round(pos1(1)+pos1(3));
            handles.experiment{i}.b21top     = round(pos1(2));
            handles.experiment{i}.b21bottom  = round(pos1(2)+pos1(4));
            handles.experiment{i}.b22start   = round(pos2(1));
            handles.experiment{i}.b22end     = round(pos2(1)+pos2(3));
            handles.experiment{i}.b22top     = round(pos2(2));
            handles.experiment{i}.b22bottom  = round(pos2(2)+pos2(4));
          end
          if  ~handles.hasPopulated_bkg
            if any(handles.uu)
              handles.dropdReflString = [handles.dropdReflString,'Background_uu'];
            end
            if any(handles.ud)
              handles.dropdReflString = [handles.dropdReflString,'Background_ud'];
            end
            if any(handles.du)
              handles.dropdReflString = [handles.dropdReflString,'Background_du'];
            end
            if any(handles.dd)
              handles.dropdReflString = [handles.dropdReflString,'Background_dd'];
            end
            
            set(handles.dropdRefl,'String',handles.dropdReflString);
            handles.hasPopulated_bkg = 1;
          end
          
          setColor(handles.hBackgroundROI1,[0.3 0.5 0.5]);
          setColor(handles.hBackgroundROI2,[0.3 0.5 0.5]);
          setResizable(handles.hBackgroundROI1,0);
          setResizable(handles.hBackgroundROI2,0);
          fcn1 = makeConstrainToRectFcn('imrect',[pos1(1) pos1(1)+pos1(3)],[pos1(2) pos1(2)+pos1(4)]);
          fcn2 = makeConstrainToRectFcn('imrect',[pos2(1) pos2(1)+pos2(3)],[pos2(2) pos2(2)+pos2(4)]);
          setPositionConstraintFcn(handles.hBackgroundROI1,fcn1);
          setPositionConstraintFcn(handles.hBackgroundROI2,fcn2);
        end
      end
      
      
      handles = reduceData(handles);
      handles = change_states(handles);
      handles = drawRefl(handles);
      handles = drawkxkz(handles);
      handles = drawRaw(handles);
      handles.isMakingBROI = 0;
      guidata(hObject, handles);
      
      
    else
      msgbox('Already making a ROI, please double click on the ROI to proceed');
    end
    return;
  
  
  
  function handles = doMainROI(handles,hObject)
 
    set(handles.tabgp, 'SelectedTab',handles.tab1);

    if ~handles.isMakingROI && ~handles.isMakingBROI
      handles.isMakingROI = 1;
      guidata(hObject, handles);
      idx = get(handles.lstFiles, 'value');
      axes(handles.rawaxes);
      
      if idx <= length(handles.experiment)
        if ~handles.experiment{idx}.hasROI
          set(handles.mnuDetectorROI,'Checked','on');
          %  if handles.DAT.ROI(1) == -1
          
          %    W = 100;
          %    H = 500;
          %    X = 600;
          %    Y = 400;
          %  else
          ROI = handles.ROI;

          
          ROI_L   =  abs(ROI(3) - ROI(4));
          ROI_H    = abs(ROI(1) - ROI(2));
          
          ROI_center_x = ROI(3) + ROI_L/2;
          ROI_center_y = ROI(1) + ROI_H/2;
          
          X = ROI(3);
          Y = ROI(1);
          W = ROI_L;
          H = ROI_H;
          
          handles.hDetectorRect   = imrect(handles.rawaxes,[X Y W H]);
          setColor(handles.hDetectorRect,'y');
          fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
          setPositionConstraintFcn(handles.hDetectorRect,fcn);
          pos = wait(handles.hDetectorRect);
          applyToAll = 1;
          
          if applyToAll
            for i = 1:length(handles.experiment)
              handles.experiment{i}.hasROI  = 1;
              handles.experiment{i}.start   = round(pos(1));
              handles.experiment{i}.end     = round(pos(1)+pos(3));
              handles.experiment{i}.top     = round(pos(2));
              handles.experiment{i}.bottom  = round(pos(2)+pos(4));
              handles.ROI = [pos(2), pos(4) - pos(2), pos(1), pos(3) - pos(1)];
            end
            for i = 1:length(handles.db)
              handles.db{i}.hasROI  = 1;
              handles.db{i}.start   = round(pos(1));
              handles.db{i}.end     = round(pos(1)+pos(3));
              handles.db{i}.top     = round(pos(2));
              handles.db{i}.bottom  = round(pos(2)+pos(4));
              handles.ROI = [pos(2), pos(4) - pos(2), pos(1), pos(3) - pos(1)];
            end
          else
            
          end
          setColor(handles.hDetectorRect,[0.5 0.5 0.5]);
          setResizable(handles.hDetectorRect,0);
          fcn = makeConstrainToRectFcn('imrect',[pos(1) pos(1)+pos(3)],[pos(2) pos(2)+pos(4)]);
          setPositionConstraintFcn(handles.hDetectorRect,fcn);
        else % has a ROI already, lets remove it
          delete(handles.hDetectorRect);
          set(handles.mnuDetectorROI,'Checked','off');
          drawnow;
          for i = 1:length(handles.experiment)
            handles.experiment{i}.hasROI  = 0;
            handles.experiment{i}.start   = 1;
            handles.experiment{i}.end     = handles.experiment{1}.imsize(1);
            handles.experiment{i}.top     = 1;
            handles.experiment{i}.bottom  = handles.experiment{1}.imsize(1);
          end
          for i = 1:length(handles.db)
            handles.db{i}.hasROI  = 0;
            handles.db{i}.start   = 1;
            handles.db{i}.end     = handles.db{1}.imsize(1);
            handles.db{i}.top     = 1;
            handles.bd{i}.bottom  = handles.db{1}.imsize(1);
          end
          
        end
        
        handles = reduceData(handles);
        handles = change_states(handles);
        handles = drawRaw(handles);
        handles = drawkxkz(handles);
        handles = drawRefl(handles);
        handles.isMakingROI = 0;
        
        guidata(hObject, handles);
      end
    else
      msgbox('Already making a ROI, please double click on the ROI to proceed');
    end
    return;


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton17.
function togglebutton17_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton17


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Loadh5_Callback(hObject, eventdata, handles)
% hObject    handle to Loadh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fileformat ='h5';
handles = LoadImageList(handles);

handles = drawRaw(handles);
handles = drawkxkz(handles);
handles = drawRefl(handles);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Loadh5pol_Callback(hObject, eventdata, handles)
% hObject    handle to Loadh5pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fileformat ='h5pol';
handles = LoadImageList(handles);
set(handles.pnlRaw,'Visible','on');
set(handles.pnlProcess,'Visible','on');
set(handles.projectedaxes,'Visible','on');
set(handles.rawaxes,'Visible','on');
set(handles.tglProjectedLog,'Visible','on');
set(get(handles.projectedaxes,'Children'),'Visible','on');
set(handles.reflectivityaxes,'Visible','on');

handles = drawRaw(handles);

if handles.experiment{1}.hasROI && isempty(handles.hDetectorRect)
 hDetectorRectPos(1) = handles.ROI(3);
 hDetectorRectPos(2) = handles.ROI(1);
 hDetectorRectPos(3) = abs(handles.ROI(3) - handles.ROI(4));
 hDetectorRectPos(4) = abs(handles.ROI(2) - handles.ROI(1));

handles.hDetectorRect   = imrect(handles.rawaxes,hDetectorRectPos);
setColor(handles.hDetectorRect,[0.5 0.5 0.0]);
setResizable(handles.hDetectorRect,0);
fcn = makeConstrainToRectFcn('imrect',[hDetectorRectPos(1) hDetectorRectPos(1)+hDetectorRectPos(3)],[hDetectorRectPos(2) hDetectorRectPos(2)+hDetectorRectPos(4)]);
setPositionConstraintFcn(handles.hDetectorRect,fcn);
set(handles.mnuDetectorROI,'Checked','on');
end
handles = drawkxkz(handles);
handles = drawRefl(handles);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Help_1_Callback(hObject, eventdata, handles)
% hObject    handle to Help_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function About_2_Callback(hObject, eventdata, handles)
% hObject    handle to About_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Super Adam Data Reduction: v0.1 ');


% --- Executes on button press in chkProjection.
function chkProjection_Callback(hObject, eventdata, handles)
% hObject    handle to chkProjection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkProjection
if handles.ProjectionVisible
  set(handles.projectedaxes,'Visible','off');
  set(handles.tglProjectedLog,'Visible','off');
  set(get(handles.projectedaxes,'Children'),'Visible','off');
  handles.ProjectionVisible = 0;
  %set(handles.projectedaxes,'Position',[0.1 0.1 0.9 0.2]);
  set(handles.rawaxes,'Position',[0.3 0.1 0.5 0.8]);  
else
  handles.ProjectionVisible = 1;
  set(handles.projectedaxes,'Visible','on');
  set(handles.tglProjectedLog,'Visible','on');
  set(get(handles.projectedaxes,'Children'),'Visible','on');
 
  set(handles.rawaxes,'Position',[0.4 0.3 0.4 0.6]);
  set(handles.rawaxes,'Clipping','on');
  axis(handles.rawaxes,'tight');
  
  %pos = get(handles.rawaxes,'Position')
  %rpos = get(handles.rawaxes,'OuterPosition')
  %pAxsRatio = get(handles.rawaxes,'PlotBoxAspectRatio')
  %dAxsRatio = get(handles.rawaxes,'DataAspectRatio')
  
  
  %topAxsRatio = photoAxsRatio;
  %topAxsRatio(2) = photoAxsRatio(2)/3.8;    % NOTE: not exactly 3...
  projPos = get(handles.rawaxes,'Position');
  projPos(4) = 0.2;
  projPos(2) = 0.05;
  %projPos(1) = 0.34;
  projPos(3) = 0.4;
  set(handles.rawaxes,'XTick',[]);
  xlabel(handles.rawaxes,'');
  %set(handles.projectedaxes,'DataAspectRatio',[1 14.5 1]);
  set(handles.projectedaxes,'Position',projPos);
 % set(handles.projectedaxes,'OuterPosition',outerPos);
 % set(handles.projectedaxes,'PlotBoxAspectRatio', pAxsRatio/10);
 % set(handles.projectedaxes,'DataAspectRatio', dAxsRatio/10);
  
 % axis(handles.projectedaxes,'tight');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function mnuThetaOffset_Callback(hObject, eventdata, handles)
% hObject    handle to mnuThetaOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = doThetaOffset(handles,hObject);
return;

function handles = doThetaOffset(handles,hObject)
        
  if ~handles.isMakingROI && ~handles.isMakingBROI
    if handles.doThetaOffset
      handles.doThetaOffset = 0;
      set(handles.mnuThetaOffset,'Checked','off');
    else
      handles.doThetaOffset = 1;
      set(handles.mnuThetaOffset,'Checked','on');
    end
    handles = reduceData(handles);
    handles = change_states(handles);
    handles = drawRefl(handles);
    guidata(hObject, handles);
  else
    set(handles.tabgp, 'SelectedTab',handles.tab1);
    msgbox('Already making a ROI, please double click on the ROI to proceed');       
  end

return;



function edtPFlip_Callback(hObject, eventdata, handles)
% hObject    handle to edtPFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtPFlip as text
%        str2double(get(hObject,'String')) returns contents of edtPFlip as a double


% --- Executes during object creation, after setting all properties.
function edtPFlip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtPFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtAFlip_Callback(hObject, eventdata, handles)
% hObject    handle to edtAFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtAFlip as text
%        str2double(get(hObject,'String')) returns contents of edtAFlip as a double


% --- Executes during object creation, after setting all properties.
function edtAFlip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtAFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtThetaOffset_Callback(hObject, eventdata, handles)
% hObject    handle to edtThetaOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtThetaOffset as text
%        str2double(get(hObject,'String')) returns contents of edtThetaOffset as a double


% --- Executes during object creation, after setting all properties.
function edtThetaOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtThetaOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtPhi_Callback(hObject, eventdata, handles)
% hObject    handle to edtPhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtPhi as text
%        str2double(get(hObject,'String')) returns contents of edtPhi as a double


% --- Executes during object creation, after setting all properties.
function edtPhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtPhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtP_Callback(hObject, eventdata, handles)
% hObject    handle to edtP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtP as text
%        str2double(get(hObject,'String')) returns contents of edtP as a double


% --- Executes during object creation, after setting all properties.
function edtP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtA_Callback(hObject, eventdata, handles)
% hObject    handle to edtA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtA as text
%        str2double(get(hObject,'String')) returns contents of edtA as a double


% --- Executes during object creation, after setting all properties.
function edtA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dropdRefl3.
function dropdRefl3_Callback(hObject, eventdata, handles)
% hObject    handle to dropdRefl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdRefl3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdRefl3
str = get(handles.dropdRefl3,'String');
val = get(handles.dropdRefl3,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}
 case 'suu'
    handles.ReflPlot3 = 'suu';
    handles.ReflSpinhandle     = handles.uu;
    handles.ReflCurrentYData3  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData3 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.uu);
    handles.ReflYLabel3 = 'intensity [counts]';
  case 'sdu'
    handles.ReflPlot3 = 'du';
    handles.ReflSpinhandle = handles.du;
    handles.ReflCurrentYData3  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData3 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.du);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'sud'
    handles.ReflPlot3 = 'ud';
    handles.ReflSpinhandle = handles.ud;
    handles.ReflCurrentYData3  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData3 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.ud);
    handles.ReflYLabel1 = 'Integrated intensity [counts]';
  case 'sdd'
    handles.ReflPlot3 = 'dd';
    handles.ReflSpinhandle = handles.dd;
    handles.ReflCurrentYData3  = handles.S(handles.ReflSpinhandle);
    handles.ReflCurrentsYData3 = handles.sS(handles.ReflSpinhandle);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.dd);
    handles.ReflYLabel3 = 'Integrated intensity [counts]';
   case 'uu'
    handles.ReflPlot3 = 'uu';
    handles.ReflSpinhandle3 = handles.uu;
    handles.ReflCurrentYData3  = handles.I(handles.uu);
    handles.ReflCurrentsYData3 = handles.sI(handles.uu);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData3(handles.uu);
    handles.ReflYLabel3 = 'Integrated intensity [counts]';
  case 'du'
    handles.ReflPlot3 = 'du';
    handles.ReflSpinhandle3 = handles.du;
    handles.ReflCurrentYData3  = handles.I(handles.du);
    handles.ReflCurrentsYData3 = handles.sI(handles.du);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData3(handles.du);
    handles.ReflYLabel3 = 'Integrated intensity [counts]';
  case 'ud'
    handles.ReflPlot1 = 'ud';
    handles.ReflSpinhandle3 = handles.ud;
    handles.ReflCurrentYData3  = handles.I(handles.ud);
    handles.ReflCurrentsYData3 = handles.sI(handles.ud);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData3(handles.ud);
    handles.ReflYLabel3 = 'Integrated intensity [counts]';
  case 'dd'
    handles.ReflPlot3 = 'dd';
    handles.ReflSpinhandle3 = handles.dd;
    handles.ReflCurrentYData3  = handles.I(handles.dd);
    handles.ReflCurrentsYData3 = handles.sI(handles.dd);
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData3(handles.dd);

    handles.ReflYLabel13 = 'Integrated intensity [counts]';
  case 'p'
    handles.ReflPlot3 = 'p';
    handles.ReflSpinhandle3 = handles.dd;
    handles.ReflCurrentYData3  = handles.p;
    handles.ReflCurrentsYData3 = handles.sp;
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.ReflSpinhandle3);
    handles.ReflYLabel3 = 'Integrated intensity [counts]';
   case 'a'
    handles.ReflPlot3 = 'a';
    handles.ReflSpinhandle3 = handles.dd;
    handles.ReflCurrentYData3  = handles.a;
    handles.ReflCurrentsYData3 = handles.sa;
    handles.ReflCurrentXData3  = handles.ReflCurrentAllXData1(handles.ReflSpinhandle3);

    handles.ReflYLabel3 = 'Integrated intensity [counts]';
  case 'Background_uu'
     handles.ReflPlot3 = 'Intensity [counts]'; 
     handles.ReflSpinhandle3       =  handles.uu;
     handles.ReflCurrentAllYData3  =  handles.bI;
     handles.ReflCurrentAllsYData3 =  handles.sbI;

     handles.ReflCurrentYData3  = handles.bI(handles.ReflSpinhandle3);
     handles.ReflCurrentsYData3 = handles.sbI(handles.ReflSpinhandle3);

     handles.ReflYLabel3 = 'Background';
     handles.ReflYScaleState3 = 'log';  
  case 'Background_ud'
     handles.ReflPlot3 = 'Intensity [counts]'; 
     handles.ReflSpinhandle3       =  handles.ud;
     handles.ReflCurrentAllYData3  =  handles.bI;
     handles.ReflCurrentAllsYData3 =  handles.sbI;

     handles.ReflCurrentYData3  = handles.bI(handles.ReflSpinhandle3);
     handles.ReflCurrentsYData3 = handles.sbI(handles.ReflSpinhandle3);

     handles.ReflYLabel3 = 'Background';
     handles.ReflYScaleState3 = 'log';  
  case 'Background_du'
     handles.ReflPlot3 = 'Intensity [counts]'; 
     handles.ReflSpinhandle3       =  handles.du;
     handles.ReflCurrentAllYData3  =  handles.bI;
     handles.ReflCurrentAllsYData3 =  handles.sbI;

     handles.ReflCurrentYData3  = handles.bI(handles.ReflSpinhandle3);
     handles.ReflCurrentsYData3 = handles.sbI(handles.ReflSpinhandle3);

     handles.ReflYLabel3 = 'Background';
     handles.ReflYScaleState3 = 'log';  
  case 'Background_dd'
     handles.ReflPlot3 = 'Intensity [counts]'; 
     handles.ReflSpinhandle3       =  handles.dd;
     handles.ReflCurrentAllYData3  =  handles.bI;
     handles.ReflCurrentAllsYData3 =  handles.sbI;

     handles.ReflCurrentYData3  = handles.bI(handles.ReflSpinhandle3);
     handles.ReflCurrentsYData3 = handles.sbI(handles.ReflSpinhandle3);

     handles.ReflYLabel3 = 'Background';
     handles.ReflYScaleState3 = 'log';  
  case 'None'
     handles.ReflPlot3 = ''; 
     handles.ReflCurrentAllYData3  =  [];
     handles.ReflCurrentAllsYData3 =  [];

     handles.ReflCurrentYData3  = [];
     handles.ReflCurrentsYData3 = [];
     handles.ReflYLabel3 = '';
     handles.ReflYScaleState3 = 'log';  
  otherwise

end
%handles.ReflCurrentYData3  = handles.ReflCurrentAllYData3(handles.ReflSpinhandle);
%handles.ReflCurrentsYData3 = handles.ReflCurrentAllsYData3(handles.ReflSpinhandle);

%handles.ReflCurrentXData1  = handles.ReflCurrentAllXData1(handles.ReflSpinhandle);
handles = drawRefl(handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function dropdRefl3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdRefl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btnAddLayer_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%rep1 = str2num(get(handles.edtRep1,'String'));
%rep2 = str2num(get(handles.edtRep2,'String'));

theLayer.thick = 0;
theLayer.rough = 0;
theLayer.dens  = 0;
theLayer.chem  = '';
theLayer.sld   = 0;
theLayer.ndens = 0;
theLayer.magn       = 0;
theLayer.magnAngle  = 0;
theLayer.Rep        = 0;
theLayer.LinkIdx    = 0;
theLayer.fitRough   = 1;
theLayer.fitThick   = 1;
theLayer.fitDens    = 1;
theLayer.fitMagn    = 1;
theLayer.fitMagnAng = 1;

oldchecked = handles.Checked;


% 
% chem  = get(handles.edtChemical,'String');
% dens  = str2double(get(handles.edtDensity,'String'));
% thick = str2double(get(handles.edtThickness,'String'));
% rough = str2double(get(handles.edtRoughness,'String'));
% 
% magn      = str2num(get(handles.edtMagn,'String'));
% magnAngle = str2num(get(handles.edtMagnAngle,'String'));
% 
% [sld,ndens]   = getSLD(chem,dens);
% 
% theLayer.thick = thick;
% theLayer.rough = rough;
% theLayer.dens  = dens;
% theLayer.chem  = chem;
% theLayer.sld   = sld;
% theLayer.ndens = ndens;
% 
% theLayer.magn      = magn;
% theLayer.magnAngle = magnAngle;
% theLayer.Rep       = 0;


%idx = get(handles.lstLayers,'Value');
idx = handles.currentIndex;


structureidx = handles.N-idx+1;

for i = handles.N:-1:(structureidx+1)
  handles.TLayers{i+1} = handles.TLayers{i};
  handles.Checked(i+1) = oldchecked(i);
end
handles.TLayers{structureidx+1} = theLayer;
handles.Checked(structureidx+1) = 0;

handles.N = handles.N + 1;

%handles = parseLayers(handles);
%set(handles.lstLayers,'String',handles.Layers);
set(handles.edtMagn,'String',num2str(handles.TLayers{structureidx+1}.magn));
set(handles.edtMagnAngle,'String',num2str(handles.TLayers{structureidx+1}.magnAngle));
set(handles.edtChemical,'String',num2str(handles.TLayers{structureidx+1}.chem));
set(handles.edtDensity,'String',num2str(handles.TLayers{structureidx+1}.dens));
set(handles.edtRoughness,'String',num2str(handles.TLayers{structureidx+1}.rough));
set(handles.edtThickness,'String',num2str(handles.TLayers{structureidx+1}.thick));
set(handles.chkRough,'Value',handles.TLayers{structureidx+1}.fitRough);
set(handles.chkThick,'Value',handles.TLayers{structureidx+1}.fitThick);
set(handles.chkDens,'Value',handles.TLayers{structureidx+1}.fitDens);
set(handles.chkMagn,'Value',handles.TLayers{structureidx+1}.fitMagn);
set(handles.chkMagnAng,'Value',handles.TLayers{structureidx+1}.fitMagnAng);
guidata(hObject, handles);


function btnAdd_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 idx = get(handles.dropdRefl,'Value');
 
 addstr = handles.dropdReflString{idx};
 
 currentstr = get(handles.dropdRefl3,'String');
 
 found = strfind(currentstr,addstr);
  hasIt = 0;
  
 for i = 1:length(found)
   if ~isempty(found{i})
     hasIt = 1;
   end
 end
 
 if ~hasIt
   handles.dropdReflString3 = [handles.dropdReflString3,addstr];

 end
 set(handles.dropdRefl3,'String',handles.dropdReflString3);
 set(handles.dropdRefl3,'Value',length(handles.dropdReflString3));
 dropdRefl3_Callback(hObject, eventdata, handles);
 %guidata(hObject, handles);

% --- Executes on button press in btnRemove.
function btnRemove_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 idx = get(handles.dropdRefl3,'Value');
 
 remstr = handles.dropdReflString3{idx};
 
 currentstr = get(handles.dropdRefl3,'String');
 
 found = strfind(currentstr,remstr);
 k = 2;
 handles.dropdReflString3 = {'None'};
 for i = 2:length(found) % 2 so we don't get a double None
   if isempty(found{i})
     handles.dropdReflString3 = [handles.dropdReflString3,currentstr{i}];

     k = k + 1;
   end
 end
 
 set(handles.dropdRefl3,'String',handles.dropdReflString3);
 set(handles.dropdRefl3,'Value',1);
 dropdRefl3_Callback(hObject, eventdata, handles);
 guidata(hObject, handles);
 return;


% --- Executes on selection change in dropdMarker.
function dropdMarker_Callback(hObject, eventdata, handles)
% hObject    handle to dropdMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdMarker contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdMarker
str = get(handles.dropdMarker,'String');
val = get(handles.dropdMarker,'Value');

if ischar(class(str))
  str = cellstr(str);
end

switch str{val}
  case 'Markers'
    handles.Refl1Marker = 'o';
    handles.Refl2Marker = 'o';  
    handles.Refl3Marker = 'o';  
  case 'Line'
    handles.Refl1Marker = '-';
    handles.Refl2Marker = '-';  
    handles.Refl3Marker = '-';  
  case 'Markers+Line'
    handles.Refl1Marker = '-o';
    handles.Refl2Marker = '-o';  
    handles.Refl3Marker = '-o';  

  otherwise
end
handles = drawRefl(handles);
guidata(hObject, handles);
return;


% --- Executes during object creation, after setting all properties.
function dropdMarker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function mnuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to mnuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuClearAll_Callback(hObject, eventdata, handles)
% hObject    handle to mnuClearAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.rawaxes);
cla(handles.projectedaxes);
cla(handles.reflectivityaxes);
cla(handles.secondaxes);
cla(handles.kxkzaxes);
set(handles.lstFiles,'String','');
set(handles.lstDirectBeam,'String','');
set(handles.mnuDetectorROI,'Checked','off');
handles = reInitialize(handles,hObject);

guidata(hObject, handles);


% --------------------------------------------------------------------
function mnuQuit_Callback(hObject, eventdata, handles)
% hObject    handle to mnuQuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = reInitialize(handles,hObject);
guidata(hObject, handles);
close(handles.figure1);
return;


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuExport2D_Callback(hObject, eventdata, handles)
% hObject    handle to mnuExport2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnMake.
function btnMake_Callback(hObject, eventdata, handles)
% hObject    handle to btnMake (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function handles = simulate(hObject,handles)

handles = generateStack(hObject,handles);

checkQ = get(handles.edtQ,'String');

if strfind(checkQ,':')
  handles.Qsim = str2num(get(handles.edtQ,'String'));
else
  handles.Qsim = handles.Q(handles.uu);
end

checkdQ = get(handles.edtResolution,'String');

if ~any(strfind(checkdQ,'-')) 
  handles.Res = str2num(get(handles.edtResolution,'String'));
else
  handles.Res = handles.dQZ(handles.uu);
end


checkBW= get(handles.edtBeamWidth,'String');
 
if ~any(strfind(checkBW,'-')) 
  handles.BeamWidth = str2num(get(handles.edtBeamWidth,'String'));
else
  handles.BeamWidth = handles.beamw(handles.uu);
end

deltap = real(handles.sld+handles.sld_m)./(2*pi)*handles.wavelength^2;
deltam = real(handles.sld-handles.sld_m)./(2*pi)*handles.wavelength^2;
% Imaginary part of SLD is negative.
% Parratt defines imaginary part as positive, hence - sign in defintion of
% beta.
beta  = -imag(handles.sld)./(2*pi)*handles.wavelength^2;
 

axes(handles.axesFit);
hold(handles.axesFit,'off');
handles.data = [];

handles.data(:,1) = handles.Qsim;

count = length(handles.mnuFitDataString);
checkCellString = @(x,y) any(cellfun(@any,regexp(x,y,'once')));
checkCellString(handles.mnuFitDataString,'du')
%any(checkCellString(handles.mnuFitDataString,'du'))

% count should be 5 for all spin states since we are counting None
if count == 5
  handles.data(:,2) = handles.I(handles.uu);
  handles.data(:,3) = handles.I(handles.ud);
  handles.data(:,4) = handles.I(handles.du);
  handles.data(:,5) = handles.I(handles.dd);
elseif count == 3 && checkCellString(handles.mnuFitDataString,'dd') && checkCellString(handles.mnuFitDataString,'uu')
  handles.data(:,2) = handles.I(handles.uu);
  handles.data(:,3) = ones(size(handles.I(handles.uu)));
  handles.data(:,4) = ones(size(handles.I(handles.dd))); % putting dd into dd place
  handles.data(:,5) = handles.I(handles.dd);
elseif count == 3 && checkCellString(handles.mnuFitDataString,'uu') && checkCellString(handles.mnuFitDataString,'du')
    % this is uu and dd actully
  handles.data(:,2) = handles.I(handles.uu);
  handles.data(:,3) = ones(size(handles.I(handles.uu)));
  handles.data(:,5) = ones(size(handles.I(handles.uu))); % putting du into dd place
  handles.data(:,4) = handles.I(handles.du).*1.8;
elseif count == 2 && checkCellString(handles.mnuFitDataString,'uu')
  handles.data(:,2) = handles.I(handles.uu);
  handles.data(:,3) = ones(size(handles.I(handles.uu)));
  handles.data(:,4) = ones(size(handles.I(handles.uu))); % putting du into dd place
  handles.data(:,5) = ones(size(handles.I(handles.uu)));
elseif count == 2 && checkCellString(handles.mnuFitDataString,'dd')
  handles.data(:,2) = handles.I(handles.dd);
  handles.data(:,3) = ones(size(handles.I(handles.dd)));
  handles.data(:,4) = ones(size(handles.I(handles.dd))); % putting du into dd place
  handles.data(:,5) = ones(size(handles.I(handles.dd)));
end
  
 

removefromleft = 11;


data(:,1) = handles.data(removefromleft:end,1);
data(:,2) = handles.data(removefromleft:end,2);
data(:,3) = handles.data(removefromleft:end,3);
data(:,4) = handles.data(removefromleft:end,4);
data(:,5) = handles.data(removefromleft:end,5);

handles.data = data;

%handles.data(:,4) = handles.I(handles.ud);
%handles.data(:,5) = handles.I(handles.du);
%plot(handles.theaxes,handles.Q,handles.Ruu,'-r','LineWidth',1.5);


%plot(handles.theaxes,handles.Q,handles.Rud./100,'-k','LineWidth',1.5);
%hold(handles.theaxes,'on');

%plot(handles.theaxes,handles.Q,handles.Rdu./100,'-.k','LineWidth',1.5);
%plot(handles.theaxes,handles.Q,handles.Rdd,'-r','LineWidth',1.5);
%plot(handles.theaxes,handles.Q,handles.Tuu,'--r','LineWidth',1.5);
%plot(handles.theaxes,handles.Q,1-handles.Ruu-handles.Tuu,'--k','LineWidth',1.5);


%plot(handles.theaxes,handles.Q(550),handles.Ruu(550),'go');

if ~isempty(handles.data)

  delete(get(handles.axesFit,'Children'));

  [handles.qdata,idx] = sort(handles.data(:,1),'ascend');
  handles.data(:,1) = handles.data(idx,1);
  handles.data(:,2) = handles.data(idx,2);
  handles.data(:,3) = handles.data(idx,3);
  handles.data(:,4) = handles.data(idx,4);
  handles.data(:,5) = handles.data(idx,5);
  handles.Qsim = handles.data(:,1);


  %handles.qdata = handles.data(:,1);
 % handles.qdata = 4*pi/handles.wavelength*sind(handles.data(:,1)/2);
  
  switch handles.Probe
    case 1
    [sim,~] = parratt(handles.qdata,handles.wavelength,delta(:),beta(:),handles.d(:),handles.rough(:));

    sim(1) = 1;
    sim = max(handles.data(:,2)).*1.*sim;
    sim = sim.*SquareIntensity(asind(handles.qdata*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth);

    sim = GaussConv(handles.qdata,sim,handles.BeamDivergence+eps);
    case 2
    
      [simuu,Qp] = parratt_v2(handles.Qsim(:),handles.wavelength,deltap(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
      [simdd,Qp] = parratt_v2(handles.Qsim(:),handles.wavelength,deltam(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
      [handles.Ruu,handles.Rud,handles.Rdu,handles.Rdd,handles.Tuu,handles.Tud,handles.Tdu,handles.Tdd,qu] = calc_spinrefl_v9(handles.Qsim(:),handles.sld,handles.sld_m,handles.theta,...
        handles.d,handles.rough,handles.wavelength,length(handles.d),length(handles.Qsim));
      handles.Qsim   = handles.Qsim(2:end);
      handles.Ruu = handles.Ruu(2:end);
      handles.Rud = handles.Rud(2:end);
      handles.Rdu = handles.Rdu(2:end);
      handles.Rdd = handles.Rdd(2:end);
      handles.Res = handles.Res(2:end);
  
      if length(handles.BeamWidth) > 1
        handles.BeamWidth = handles.BeamWidth(2:end);
      end
 
     handles.BeamDivergence = get(handles.edtResolution,'String');
   
     
     handles.Ruu = GaussConv(handles.Qsim,handles.Ruu,mean(handles.Res())+eps);
     %handles.Ruu = VaryingGaussConv(handles.Qsim,handles.Ruu,handles.Res()+eps);

     handles.Ruu = handles.Ruu.*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;
     handles.Rud = GaussConv(handles.Qsim,handles.Rud,mean(handles.Res())+eps);
     handles.Rud = handles.Rud.*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;
     handles.Rdu = GaussConv(handles.Qsim,handles.Rdu,mean(handles.Res())+eps);
     handles.Rdu = handles.Rdu.*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;
     handles.Rdd = GaussConv(handles.Qsim,handles.Rdd,mean(handles.Res())+eps);
     handles.Rdd = handles.Rdd.*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;

     simuu(2:end) = simuu(2:end).*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;
     simdd(2:end) = simdd(2:end).*SquareIntensity(asind(handles.Qsim(:)*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth(:)).*handles.I0;
     simuu(2:end) = GaussConv(handles.Qsim,simuu(2:end),mean(handles.Res())+eps);
     simdd(2:end) = GaussConv(handles.Qsim,simdd(2:end),mean(handles.Res())+eps);

%     ax = axes();
%      
%       plot(ax,handles.Q(2:end),handles.Ruu(2:end),'-b','LineWidth',1.5);
%        hold(ax,'on');
%       plot(ax,handles.Q(2:end),handles.Rdd(2:end),'-r','LineWidth',1.5);
%       plot(ax,handles.Q(2:end),handles.Rud(2:end)./1e3,'-m','LineWidth',1.5);
%       plot(ax,handles.Q(2:end),handles.Rdu(2:end)./1e3,'-m','LineWidth',1.5);
%       axis(ax,[-Inf Inf -Inf 10]);
%       set(gca,'YScale','log');
% xlabel(ax,['Q [',char(197),'^{(-1)}]']);
% ylabel(ax,'Reflectivity');
%        print -dpng -r300 Ruu.png
cla(handles.axesFit);
hold(handles.axesFit,'on');


if handles.data(:,2)~=ones(size(handles.data(:,2)))
%  plot(handles.axesFit,handles.Qsim(2:end),handles.Ruu(2:end),'-b','LineWidth',1.5);
  plot(handles.axesFit,handles.qdata,handles.data(:,2),'ob','MarkerFaceColor','b');
end
if handles.data(:,5)~=ones(size(handles.data(:,5)))
%  plot(handles.axesFit,handles.Qsim(2:end),handles.Rdd(2:end),'-r','LineWidth',1.5);
       plot(handles.axesFit,handles.qdata,handles.data(:,5),'or','MarkerFaceColor','r');
end
if handles.data(:,3)~=ones(size(handles.data(:,3)))
%  plot(handles.axesFit,handles.Qsim(2:end),handles.Rud(2:end),'-m','LineWidth',1.5);
  plot(handles.axesFit,handles.qdata,handles.data(:,3),'om','MarkerFaceColor','m');
end
if handles.data(:,4)~=ones(size(handles.data(:,4)))
%  plot(handles.axesFit,handles.Qsim(2:end),handles.Rdd(2:end),'-m','LineWidth',1.5);
  plot(handles.axesFit,handles.qdata,handles.data(:,4),'om','MarkerFaceColor','m');
end


plot(handles.axesFit,handles.Qsim,simuu(2:end),'-b','LineWidth',2);
plot(handles.axesFit,handles.Qsim,simdd(2:end),'-r','LineWidth',2);

      %    [sim,~] = parratt(handles.qdata,handles.wavelength,delta(:),beta(:),handles.d(:),handles.rough(:));
    %handles.I0 = get(handles.edtI0,'Value');

    %sim(1) = 1;
    %sim = max(handles.data(:,2)).*1.*sim;
   
    %b = get(handles.edtSampleLength,'Value')
    %sim = sim.*SquareIntensity(asind(handles.qdata*handles.wavelength/4/pi),get(handles.edtSampleLength,'Value'),handles.BeamWidth);

    %sim = GaussConv(handles.qdata,sim,mean(handles.Res)+eps);
 %     [handles.Ruu,handles.Rud,handles.Rdu,handles.Rdd,handles.Tuu,handles.Tud,handles.Tdu,handles.Tdd,qu] = calc_spinrefl_v4(handles.qdata,handles.sld,handles.sld_m,handles.theta,...
 %       handles.d,handles.rough,handles.wavelength);
 %     sim = handles.Ruu;
  end
      hold(handles.axesFit,'on');
 
  
%    plot(handles.axesFit,handles.qdata,sim,'-r','LineWidth',1.5);
else

  switch handles.Probe
    case 1
     [sim,Qp] = parratt(handles.Qsim(:),handles.wavelength,delta(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
     plot(handles.axesFit,handles.Qsim(:),sim,'-r','LineWidth',1.5);
     hold(handles.axesFit,'on');
    case 2

   % [sim,Qp] = parratt_v2(handles.Q(:),handles.wavelength,delta(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
   
      [handles.Ruu,handles.Rud,handles.Rdu,handles.Rdd,handles.Tuu,handles.Tud,handles.Tdu,handles.Tdd,qu] = calc_spinrefl_v9(handles.Qsim(:),handles.sld,handles.sld_m,handles.theta,...
        handles.d,handles.rough,handles.wavelength,length(handles.d),length(handles.Qsim));
      
      handles.Qsim   = handles.Qsim(2:end);
      handles.Ruu = handles.Ruu(2:end);
      handles.Rud = handles.Rud(2:end);
      handles.Rdu = handles.Rdu(2:end);
      handles.Rdd = handles.Rdd(2:end);
      handles.Res = handles.Res(2:end);
  
     handles.BeamDivergence = get(handles.edtResolution,'String');
     handles.Ruu = GaussConv(handles.Qsim,handles.Ruu,mean(handles.Res())+eps);
     handles.Ruu = handles.Ruu;
     handles.Rud = GaussConv(handles.Qsim,handles.Rud',mean(handles.Res())+eps);
     handles.Rud = handles.Rud;
     handles.Rdu = GaussConv(handles.Qsim,handles.Rdu',mean(handles.Res())+eps);
     handles.Rdu = handles.Rdu;
     handles.Rdd = GaussConv(handles.Qsim,handles.Rdd',mean(handles.Res())+eps);
     handles.Rdd = handles.Rdd;
    
     %handles.Ruu = handles.Ruu + handles.
    
%     figure;
%     ax = axes();
%      
%       plot(ax,handles.Q(2:end),handles.Ruu(2:end),'-b','LineWidth',1.5);
%        hold(ax,'on');
%       plot(ax,handles.Q(2:end),handles.Rdd(2:end),'-r','LineWidth',1.5);
%       plot(ax,handles.Q(2:end),handles.Rud(2:end)./1e3,'-m','LineWidth',1.5);
%       plot(ax,handles.Q(2:end),handles.Rdu(2:end)./1e3,'-m','LineWidth',1.5);
%       axis(ax,[-Inf Inf -Inf 10]);
%       set(gca,'YScale','log');
% xlabel(ax,['Q [',char(197),'^{(-1)}]']);
% ylabel(ax,'Reflectivity');
%        print -dpng -r300 Ruu.png
cla(handl.saxesFit);
hold(handles.axesFit,'on');
if handles.Ruu~=ones(size(handles.Ruu))
  plot(handles.axesFit,handles.Qsim(2:end),handles.Ruu(2:end),'-b','LineWidth',1.5);
end
if handles.Rdd~=ones(size(handles.Rdd))
  plot(handles.axesFit,handles.Qsim(2:end),handles.Rdd(2:end),'-r','LineWidth',1.5);
end
if handles.Rud~=ones(size(handles.Rud))
  plot(handles.axesFit,handles.Qsim(2:end),handles.Rud(2:end),'-m','LineWidth',1.5);
end
if handles.Rdu~=ones(size(handles.Rdu))
  plot(handles.axesFit,handles.Qsim(2:end),handles.Rdu(2:end),'-m','LineWidth',1.5);
end
  end
 
end

%plot(handles.theaxes,handles.Q,handles.Tud./100,'--k','LineWidth',1.5);
%plot(handles.theaxes,handles.Q,handles.Tdu./100,'--k','LineWidth',1.5);
%plot(handles.theaxes,handles.Q,handles.Tdd,'--b','LineWidth',1.5);


%plot(A(:,1),A(:,4),'-ro');
%plot(B(:,1),B(:,4),'-bo');
%plot(B(:,1),B(:,8),'-ro');
%themin = min([min(handles.Ruu) min(handles.Rud) min(handles.Rdu./100) min(handles.Rdd)]);
%themax = max([max(handles.Ruu) max(handles.Rud) max(handles.Rdu./100) max(handles.Rdd)]);

set(gca,'YScale','log');
xlabel(handles.axesFit,['Q [',char(197),'^{(-1)}]']);
ylabel(handles.axesFit,'Reflectivity');
%legend('uu','ud','du','dd','Location','NorthEast');
%axis(handles.theaxes,[min(handles.Q) max(handles.Q) themin - 0.1*themin themax + 0.4*themax]);

axis auto
%figure
%size(handles.Rdd)
%size(B(:,4))
%plot(B(:,4)-handles.Rdd(1:end-1))
guidata(hObject, handles);

% 
% if ~isempty(handles.data)
%   delete(get(handles.theaxes,'Children'));
%   handles.qdata = 4*pi/handles.wavelength*sind(handles.data(:,1)/2);
%   delta = real(handles.sld)./(2*pi)*handles.wavelength^2;
% % Imaginary part of SLD is negative.
% % Parratt defines imaginary part as positive, hence - sign in defintion of
% % beta.
%   beta  = -imag(handles.sld)./(2*pi)*handles.wavelength^2;
%   [sim,~] = parratt(handles.qdata,handles.wavelength,delta(:),beta(:),handles.d(:),handles.rough(:));
% 
% %handles.Probe    = str2num(get(handles.mnuProbe,'Value'));
%   sim(1) = 1;
%   sim = sim.*SquareIntensity(asind(handles.qdata*handles.wavelength/4/pi),handles.SampleLength,handles.BeamWidth);
% 
%   sim = GaussConv(handles.qdata,sim,handles.BeamDivergence+eps);
%  
%   sim = handles.I0.*sim;
% 
%   %[refl,Qp] = parratt(handles.qdata,handles.wavelength,delta(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
% 
%  hold(handles.theaxes,'on');
%   plot(handles.theaxes,handles.qdata,handles.data(:,2),'o');
%     plot(handles.theaxes,handles.qdata,sim,'-r','LineWidth',1.5);
% else
%    delta = real(handles.sld)./(2*pi)*handles.wavelength^2;
%    beta  = -imag(handles.sld)./(2*pi)*handles.wavelength^2;
%   [refl,Qp] = parratt(handles.Q(:),handles.wavelength,delta(1:end)',beta(1:end)',handles.d(1:end)',handles.rough(1:end)');
%   plot(handles.theaxes,handles.Q(:),refl,'-r','LineWidth',1.5);
%   hold(handles.theaxes,'on');
% end
% 
% %plot(handles.theaxes,handles.Q,handles.Tud./100,'--k','LineWidth',1.5);
% %plot(handles.theaxes,handles.Q,handles.Tdu./100,'--k','LineWidth',1.5);
% %plot(handles.theaxes,handles.Q,handles.Tdd,'--b','LineWidth',1.5);
% 
% 
% %plot(A(:,1),A(:,4),'-ro');
% %plot(B(:,1),B(:,4),'-bo');
% %plot(B(:,1),B(:,8),'-ro');
% %themin = min([min(handles.Ruu) min(handles.Rud) min(handles.Rdu./100) min(handles.Rdd)]);
% %themax = max([max(handles.Ruu) max(handles.Rud) max(handles.Rdu./100) max(handles.Rdd)]);
% 
% set(handles.theaxes,'YScale','log');
% xlabel(handles.theaxes,['Q [',char(197),'^{(-1)}]']);
% ylabel(handles.theaxes,'Reflectivity');

% --- Executes on button press in btnSimulate.
function btnSimulate_Callback(hObject, eventdata, handles)
% hObject    handle to btnSimulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = simulate(hObject,handles);


% --- Executes on button press in btnRemoveLayer.
function btnRemoveLayer_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = handles.currentIndex;

k = 1;
N = length(handles.TLayers);

if N~= 1 && idx ~= N

%emptylayer.thick = 0;
%newTLayers{N-1} = emptylayer;

for i = 1:N

  if i ~= (N-idx+1)
    newTLayers{k} = handles.TLayers{i};
    k = k + 1;
  end
end

handles.N = handles.N - 1;
handles.TLayers = newTLayers;

%handles = parseLayers(handles);
%set(handles.lstLayers,'String',handles.Layers);
generateStack(hObject,handles);
guidata(hObject,handles);
end

% --- Executes on button press in btnAddLayer.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnFit.
function btnFit_Callback(hObject, eventdata, handles)
% hObject    handle to btnFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

start = [handles.fitthickpars handles.fitroughpars handles.fitdenspars handles.fitmagnpars handles.fitmagnangpars];
dvar     = 0.3;
roughvar = 0.8;
densvar  = 0.1;
magnvar  = 0.3;
magnangvar = 1.0;

M = length(handles.fitthickpars);
N = length(handles.fitroughpars);
O = length(handles.fitdenspars);
P = length(handles.fitmagnpars);
Q = length(handles.fitmagnangpars);

minb  = [handles.fitthickpars.*(1-dvar) handles.fitroughpars.*(1-roughvar) handles.fitdenspars.*(1-densvar) handles.fitmagnpars.*(1-magnvar) handles.fitmagnangpars.*(1-magnangvar)];
maxb  = [handles.fitthickpars.*(1+dvar) handles.fitroughpars.*(1+roughvar) handles.fitdenspars.*(1+densvar) handles.fitmagnpars.*(1+magnvar) handles.fitmagnangpars.*(1+magnangvar)];
res   = 0.001.*ones(1,length(maxb));


% I0
start = [start handles.I0];
minb  = [minb start(end).*0.99];
maxb  = [maxb start(end).*1.01];
res   = [res 0.001];


% Beam width
start = [start handles.BeamWidth(1)];
minb  = [minb start(end).*1.3];
maxb  = [maxb start(end).*0.8];
res   = [res 0.0001];

% Resolution
start = [start min(handles.Res)];
minb  = [minb start(end)./100];
maxb  = [maxb start(end).*2];
res   = [res 0.00001];


stop         = -1;
F_VTR        = stop;   % At what value of chi^2 should the fitting stop
I_D          = length(start); % Parameter space dimension
I_bnd_constr = 1;      % Use constraints
I_NP         = 2*I_D;    % Population size
I_itermax    = 200;    % At what iteration should fitting stop if chi^2 has not reached VTR
F_weight     = 0.6;    % Mutation factor
F_CR         = 0.6;    % Cross over probability
I_strategy   = 3;      % Which strategy to use
I_refresh    = 1;      % Should plot and refresh
I_plotting   = 1;

removefromleft = 11;
S_struct.repSize      = sum(handles.Checked);
S_struct.M            = M;
S_struct.N            = N;
S_struct.O            = O;
S_struct.P            = P;
S_struct.Q            = handles.qdata;
S_struct.Iuu          = handles.data(:,2);
S_struct.Iud          = handles.data(:,3);
S_struct.Idu          = handles.data(:,4);
S_struct.Idd          = handles.data(:,5);
S_struct.uI           = handles.sI(handles.uu);
S_struct.Ndata        = length(S_struct.Q);
S_struct.I_NP         = I_NP;
S_struct.F_weight     = F_weight;
S_struct.F_CR         = F_CR;
S_struct.I_D          = I_D;
S_struct.FVr_minbound = minb;
S_struct.FVr_maxbound = maxb;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.I_itermax    = I_itermax;
S_struct.F_VTR        = F_VTR;
S_struct.I_strategy   = I_strategy;
S_struct.I_refresh    = I_refresh;
S_struct.I_plotting   = I_plotting;
S_struct.res          = log10(res);
S_struct.GKP_bestmem  = start;
S_struct.parallel     = 0;
S_struct.handles      = handles;
S_struct.currentThick = handles.d;
S_struct.currentDens = handles.dens;
S_struct.currentNdens = handles.ndens;
S_struct.currentSLD = handles.sld;
S_struct.currentRough = handles.rough;
S_struct.theaxis = handles.axesFit;


% start_mod = start;
% start_mod(1) = start_mod(1) + 10;
% S_struct.I = model(start_mod,S_struct);

PlotIt(start,1,S_struct);
%pause
[FVr_x,S_y,I_nf] = deopt_grid('objfun',S_struct);
p = FVr_x;
handles.p = p;

  S = S_struct;
  rep = handles.repMask;
  repSize = S.repSize;
  currentRough = makeVector(p,handles.rough,handles.roughMask,S.M,rep,repSize);
  currentThick = makeVector(p,handles.d,handles.thickMask,0,rep,repSize);
  currentDens  = makeVector(p(:),handles.dens,handles.densMask,S.M+S.N,rep,repSize);
  currentMagn  = makeVector(p,handles.magn,handles.magnMask,S.M+S.N+S.O,rep,repSize);
  currentMagnAngle  = makeVector(p,handles.magnAng,handles.magnAngMask,S.M+S.N+S.O+S.P,rep,repSize);

  
  S.currentRough = currentRough;
  S.currentThick = currentThick;
  S.currentDens  = currentDens;
  S.currentSLD   = handles.sld./(handles.dens+eps).*currentDens';
  S.currentSLDM   = handles.sld_m./(handles.dens+eps).*currentDens';
  S.currentNdens = handles.ndens./(handles.dens+eps).*currentDens';
  S.currentMagnAngle = currentMagnAngle;
  S.currentMagn  = currentMagn;
  
  pp = 2.695e-5; % Angstrom/mubohr 
  S.currentSld_m = S.currentNdens(:)*pp.*currentMagn(:);
  
  lay = handles.TLayers;
foundRep = 0;
l = 1;
NN = handles.N;
    for i = 1:handles.N
     
      if lay{i}.Rep == 0
        if foundRep
          l = l + repSize*currentRep - repSize;
          foundRep = 0;
        end
        lay{i}.sld = S.currentSLD(end - l +1);
        lay{i}.sld_m = S.currentSld_m(end - l +1);
        lay{i}.dens = S.currentDens(end - l +1);
        lay{i}.thick = S.currentThick(end - l +1);
        lay{i}.rough = S.currentRough(end - l +1);
        lay{i}.magn = S.currentMagn(end - l +1);
        lay{i}.magnAngle = S.currentMagnAngle(end - l +1);
        l = l + 1;

      else
        foundRep = 1;
        currentRep = rep(i);
        lay{i}.sld   = S.currentSLD(end - l +1);
        lay{i}.sld_m = S.currentSld_m(end - l +1);
        lay{i}.dens  = S.currentDens(end - l +1);
        lay{i}.thick = S.currentThick(end - l +1);
        lay{i}.rough = S.currentRough(end - l +1);
        lay{i}.magn = S.currentMagn(end - l +1);
        lay{i}.magnAngle = S.currentMagnAngle(end - l +1);
 
        l = l + 1;
      end
    end
    
    choice = questdlg('Would you like to save the fitted values?', ...
	'Fit Save Menu', ...
	'Yes','No','Yes');
% Handle response
switch choice
    case 'Yes'
      handles.TLayers = lay;
    
    set(handles.edtBeamWidth,'String',p(end-1));
   % set(handles.edtResolution,'String',p(end));
    set(handles.edtI0,'String',p(end-2));
    
    
    handles.I0 = str2num(get(handles.edtI0,'String'));
    handles.BeamWidth    = str2num(get(handles.edtBeamWidth,'String'));
    handles.BeamDivergence    = str2num(get(handles.edtResolution,'String'));
    case 'No'
   
end
    
 
   % handles.Res = p(end-2);
    guidata(hObject,handles);

    handles = generateStack(hObject,handles);
    
    guidata(hObject,handles);

% --- Executes on button press in btnStop.
function btnStop_Callback(hObject, eventdata, handles)
% hObject    handle to btnStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnLink.
function btnLink_Callback(hObject, eventdata, handles)
% hObject    handle to btnLink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Rep = str2double(get(handles.edtRep,'String'));
%    for i = 1:handles.N
%       if handles.Checked(handles.N-i + 1)
%         handles.TLayers{handles.N-i+1}.Rep = Rep;
%       else
%         handles.TLayers{handles.N-i+1}.Rep = 0;
%       end
%    end
   
 Rep = str2double(get(handles.edtRep,'String'));
   for i = 1:handles.N
      if handles.Checked(i)
        handles.TLayers{handles.N-i+1}.Rep = Rep;
      else
        handles.TLayers{handles.N-i+1}.Rep = 0;
      end
   end  
%idx = handles.currentIndex;

%idx = get(handles.lstLayers,'Value');
% foundNewLink = 0;
% [m,n] = size(idx);
% 
% if m~=0
%   N = length(idx);
%   Rep = str2double(get(handles.edtRep,'String'));
%   if N >= 2
%     for i = 1:length(idx)
%       links(i) = handles.TLayers{handles.N-idx(i)+1}.LinkIdx;
%     end
%     
%     for i = 1:length(idx)
%       
%       handles.TLayers{handles.N-idx(i)+1}.Rep = Rep;
%       if ~any(links)
%         foundNewLink = 1;
%         handles.TLayers{handles.N-idx(i)+1}.LinkIdx = handles.LinkIdx+1;
%       else
%         foundNewLink = 0;
%         a = handles.LinkIdx
%         links
%         found = find(links==handles.LinkIdx)
%         handles.TLayers{handles.N-idx(i)+1}.LinkIdx = handles.TLayers{handles.N-idx(found(1))+1}.LinkIdx;
%       end
%     end
%     if foundNewLink
%       handles.LinkIdx = handles.LinkIdx + 1;
%     end
%   end
%  handles = parseLayers(handles);
  handles = generateStack(hObject,handles);
 % set(handles.lstLayers,'String',handles.Layers);
  guidata(hObject,handles);


function edtRep_Callback(hObject, eventdata, handles)
% hObject    handle to edtRep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtRep as text
%        str2double(get(hObject,'String')) returns contents of edtRep as a double


% --- Executes during object creation, after setting all properties.
function edtRep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtRep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to edtWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtWavelength as text
%        str2double(get(hObject,'String')) returns contents of edtWavelength as a double


% --- Executes during object creation, after setting all properties.
function edtWavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtQ_Callback(hObject, eventdata, handles)
% hObject    handle to edtQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtQ as text
%        str2double(get(hObject,'String')) returns contents of edtQ as a double


% --- Executes during object creation, after setting all properties.
function edtQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtI0_Callback(hObject, eventdata, handles)
% hObject    handle to edtI0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtI0 as text
%        str2double(get(hObject,'String')) returns contents of edtI0 as a double


% --- Executes during object creation, after setting all properties.
function edtI0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtI0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSampleLength_Callback(hObject, eventdata, handles)
% hObject    handle to edtSampleLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSampleLength as text
%        str2double(get(hObject,'String')) returns contents of edtSampleLength as a double


% --- Executes during object creation, after setting all properties.
function edtSampleLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSampleLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtBeamWidth_Callback(hObject, eventdata, handles)
% hObject    handle to edtBeamWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtBeamWidth as text
%        str2double(get(hObject,'String')) returns contents of edtBeamWidth as a double


% --- Executes during object creation, after setting all properties.
function edtBeamWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtBeamWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtResolution_Callback(hObject, eventdata, handles)
% hObject    handle to edtResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtResolution as text
%        str2double(get(hObject,'String')) returns contents of edtResolution as a double


% --- Executes during object creation, after setting all properties.
function edtResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mnuProbe.
function mnuProbe_Callback(hObject, eventdata, handles)
% hObject    handle to mnuProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mnuProbe contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mnuProbe


% --- Executes during object creation, after setting all properties.
function mnuProbe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mnuProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtChemical_Callback(hObject, eventdata, handles)
% hObject    handle to edtChemical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtChemical as text
%        str2double(get(hObject,'String')) returns contents of edtChemical as a double


% --- Executes during object creation, after setting all properties.
function edtChemical_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtChemical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtDensity_Callback(hObject, eventdata, handles)
% hObject    handle to edtDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtDensity as text
%        str2double(get(hObject,'String')) returns contents of edtDensity as a double


% --- Executes during object creation, after setting all properties.
function edtDensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtThickness_Callback(hObject, eventdata, handles)
% hObject    handle to edtThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtThickness as text
%        str2double(get(hObject,'String')) returns contents of edtThickness as a double


% --- Executes during object creation, after setting all properties.
function edtThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtRoughness_Callback(hObject, eventdata, handles)
% hObject    handle to edtRoughness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtRoughness as text
%        str2double(get(hObject,'String')) returns contents of edtRoughness as a double


% --- Executes during object creation, after setting all properties.
function edtRoughness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtRoughness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtMagn_Callback(hObject, eventdata, handles)
% hObject    handle to edtMagn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtMagn as text
%        str2double(get(hObject,'String')) returns contents of edtMagn as a double


% --- Executes during object creation, after setting all properties.
function edtMagn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtMagn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtMagnAngle_Callback(hObject, eventdata, handles)
% hObject    handle to edtMagnAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtMagnAngle as text
%        str2double(get(hObject,'String')) returns contents of edtMagnAngle as a double


% --- Executes during object creation, after setting all properties.
function edtMagnAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtMagnAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnFindDensity.
function btnFindDensity_Callback(hObject, eventdata, handles)
% hObject    handle to btnFindDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
element = periodic_table


stElemProperty = pertable(sym2an(element{1}));
stElemProperty
density = str2double(stElemProperty.Density)/1000; % kg/m^3 -> g/cm^3
set(handles.edtDensity,'String',num2str(density));

% --- Executes on button press in btnUpdateLayer.
function btnUpdateLayer_Callback(hObject, eventdata, handles)
% hObject    handle to btnUpdateLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


chem  = get(handles.edtChemical,'String');
dens  = str2double(get(handles.edtDensity,'String'));
thick = str2double(get(handles.edtThickness,'String'));
rough = str2double(get(handles.edtRoughness,'String'));

magn      = str2num(get(handles.edtMagn,'String'));
magnAngle = str2num(get(handles.edtMagnAngle,'String'));

[sld,ndens]   = getSLD(chem,dens,handles.wavelength,handles.Probe);

theLayer.thick = thick;
theLayer.rough = rough;
theLayer.dens  = dens;
theLayer.chem  = chem;
theLayer.sld   = sld;
theLayer.ndens = ndens;

theLayer.magn      = magn;
theLayer.magnAngle = magnAngle;
theLayer.Rep       = 0;
theLayer.LinkIdx   = 0;
theLayer.fitThick  = get(handles.chkThick,'Value');
theLayer.fitRough  = get(handles.chkRough,'Value');
theLayer.fitDens   = get(handles.chkDens,'Value');
theLayer.fitMagn   = get(handles.chkMagn,'Value');
theLayer.fitMagnAng= get(handles.chkMagnAng,'Value');
%idx = get(handles.lstLayers,'Value');
idx = handles.currentIndex;

structureidx = handles.N-idx+1;
% We have are editing, we need to know the rep.
if handles.TLayers{structureidx}.Rep ~= 0
  theLayer.Rep = handles.TLayers{structureidx}.Rep;
  theLayer.LinkIdx = handles.TLayers{structureidx}.LinkIdx;
end

handles.I0 = str2num(get(handles.edtI0,'String'));

handles.SampleLength = str2num(get(handles.edtSampleLength,'String'));
handles.BeamWidth    = str2num(get(handles.edtBeamWidth,'String'));
handles.BeamDivergence    = str2num(get(handles.edtResolution,'String'));
handles.Probe    = get(handles.mnuProbe,'Value');
%handles.Q = get(handles.edtQ,'Value');


handles.TLayers{structureidx} = theLayer;

%handles = parseLayers(handles);

%set(handles.lstLayers,'String',handles.Layers);
guidata(hObject, handles);

handles = generateStack(hObject,handles);
%handles = simulate(hObject,handles);

guidata(hObject, handles);

% --- Executes on button press in chkRough.
function chkRough_Callback(hObject, eventdata, handles)
% hObject    handle to chkRough (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRough


% --- Executes on button press in chkThick.
function chkThick_Callback(hObject, eventdata, handles)
% hObject    handle to chkThick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkThick


% --- Executes on button press in chkDens.
function chkDens_Callback(hObject, eventdata, handles)
% hObject    handle to chkDens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkDens


% --- Executes when entered data in editable cell(s) in theTable.
function theTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to theTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
a = handles.Checked
if eventdata.NewData == 0
  handles.Checked(eventdata.Indices(1)) = 0;
else
  handles.Checked(eventdata.Indices(1)) = 1;
end
guidata(hObject,handles);


% --- Executes when selected cell(s) is changed in theTable.
function theTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to theTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
sel = eventdata.Indices;
if isempty(sel)
  idx = handles.currentIndex;
else
idx = sel(1);
end
structureidx = handles.N - idx(end) +1;
handles.currentIndex = idx;
set(handles.edtMagn,'String',num2str(handles.TLayers{structureidx}.magn));
set(handles.edtMagnAngle,'String',num2str(handles.TLayers{structureidx}.magnAngle));
set(handles.edtChemical,'String',num2str(handles.TLayers{structureidx}.chem));
set(handles.edtDensity,'String',num2str(handles.TLayers{structureidx}.dens));
set(handles.edtRoughness,'String',num2str(handles.TLayers{structureidx}.rough));
set(handles.edtThickness,'String',num2str(handles.TLayers{structureidx}.thick));
set(handles.chkRough,'Value',handles.TLayers{structureidx}.fitRough);
set(handles.chkThick,'Value',handles.TLayers{structureidx}.fitThick);
set(handles.chkDens,'Value',handles.TLayers{structureidx}.fitDens);
set(handles.chkMagn,'Value',handles.TLayers{structureidx}.fitMagn);
set(handles.chkMagnAng,'Value',handles.TLayers{structureidx}.fitMagnAng);
guidata(hObject,handles);


% --- Executes on button press in chkMagn.
function chkMagn_Callback(hObject, eventdata, handles)
% hObject    handle to chkMagn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMagn


% --- Executes on button press in chkMagnAng.
function chkMagnAng_Callback(hObject, eventdata, handles)
% hObject    handle to chkMagnAng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMagnAng


% --- Executes on button press in btnAddtoFit.
function btnAddtoFit_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddtoFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.mnuAllData,'Value');
 
 addstr = handles.dropdReflString{idx};
 
 currentstr = handles.mnuFitDataString;
 
 found = strfind(currentstr,addstr);
  hasIt = 0;
  
 for i = 1:length(found)
   if ~isempty(found{i})
     hasIt = 1;
   end
 end
 
 if ~hasIt
   handles.mnuFitDataString = [handles.mnuFitDataString,addstr];

 end
 set(handles.mnuFit,'String',handles.mnuFitDataString);
 set(handles.mnuFit,'Value',length(handles.mnuFitDataString));
 guidata(hObject,handles);
 %dropdRefl3_Callback(hObject, eventdata, handles);

% --- Executes on button press in btnRemovefromFit.
function btnRemovefromFit_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemovefromFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 idx = get(handles.mnuFit,'Value');
 
 remstr = handles.mnuFitDataString{idx};
 
 currentstr = handles.mnuFitDataString;
 
 found = strfind(currentstr,remstr);
 k = 2;
 handles.mnuFitDataString = {'None'};
 for i = 2:length(found) % 2 so we don't get a double None
   if isempty(found{i})
     handles.mnuFitDataString = [handles.mnuFitDataString,currentstr{i}];

     k = k + 1;
   end
 end
 
 set(handles.mnuFit,'String',handles.mnuFitDataString);
 set(handles.mnuFit,'Value',1);
% dropdRefl3_Callback(hObject, eventdata, handles);
 guidata(hObject, handles);
 return;

% --- Executes on selection change in mnuAllData.
function mnuAllData_Callback(hObject, eventdata, handles)
% hObject    handle to mnuAllData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mnuAllData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mnuAllData

 

% --- Executes during object creation, after setting all properties.
function mnuAllData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mnuAllData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mnuFit.
function mnuFit_Callback(hObject, eventdata, handles)
% hObject    handle to mnuFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mnuFit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mnuFit


% --- Executes during object creation, after setting all properties.
function mnuFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mnuFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
