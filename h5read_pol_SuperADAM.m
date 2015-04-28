function experiment = h5read_SuperADAM(fname,plotIt)
disp('-Reading from h5 start')
tic

%userkeys      = {'/user/proposal','/user/namelocalcontact','/user/name'};
%samplekeys    = {'/sample/name'};
%processedkeys = {'/processed/burn','processed/iscan_dd','processed/iscan_du','processed/iscan_ud','processed/iscan_uu'};
%sourcekeys    = {'/instrument/source/name','/instrument/source/probe','/instrument/source/type'};
%detectorkeys  = {'/instrument/detectors/psd/data'};
%monochromatorkeys  = {'/instrument/monochromator/wavelenght'};

motorkeys  = {'/instrument/motors/SPEC_motor_mnemonics','/instrument/motors/SPEC_motor_names','/instrument/motors/data'};
scalerskeys  = {'/instrument/scalers/SPEC_counter_mnemonics','/instrument/scalers/SPEC_counter_names','/instrument/scalers/data','/instrument/scalers/roi/roi'};

fname = fname{1};
fname = char(fname);

Scanname = ['S',fname(end-7:end-3)];

%a = hdf5info(fname)
aname = h5info(fname,'/');
RunName = aname.Groups.Name;

inf = hdf5read(fname,[RunName,'/revision']);
if inf >= 1.9
  disp('Version 1.9')
  info = h5info(fname,[RunName,'/instrument/detectors']);
%/S00124/instrument/detectors/psd
dets = info.Groups;

%[Md,Nd]= size(dets.Name)
[Md,Nd]= size(dets);

inforoi = h5info(fname,[RunName,'/instrument/scalers/']);
[Mroi,Nroi] = size(inforoi.Groups);

%a.GroupHierarchy.Groups.Groups
if Md == 2
  Im_uu = hdf5read(fname,[Scanname,'/instrument/detectors/psd/data']);
  Im_ud = [];
  Im_du = [];
  Im_dd = [];
elseif Md == 3
  Im_du = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_du/data']));
  Im_uu = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_uu/data']));
  Im_ud = [];
  Im_dd = [];
%  Im_ud = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_ud/data']));
%  Im_uu = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_uu/data']));
 end
motors = hdf5read(fname,[Scanname,motorkeys{3}]);

idx = find(motors(13,:)>0);

inst.TwoTheta   = motors(1,idx);
inst.Theta      = motors(2,idx);
inst.SampleSlit = motors(13,idx);
inst.MonoSlit   = motors(12,idx);

scalers = hdf5read(fname,[Scanname,scalerskeys{3}]);

%if Mroi == 1 
  roi = hdf5read(fname,[Scanname,scalerskeys{4}]);
%else
%  roi = [1 1400 1 1400];
%end

toc
disp('-Reading from h5 finished')
tic





else

info = h5info(fname,[RunName,'/instrument/detectors']);
%/S00124/instrument/detectors/psd
dets = info.Groups;

%[Md,Nd]= size(dets.Name)
[Md,Nd]= size(dets);

inforoi = h5info(fname,[RunName,'/instrument/scalers/']);
[Mroi,Nroi] = size(inforoi.Groups);

%a.GroupHierarchy.Groups.Groups
if Md == 1
  Im_uu = hdf5read(fname,[Scanname,'/instrument/detectors/psd/data']);
  Im_ud = [];
  Im_du = [];
  Im_dd = [];
else
  Im_dd = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_dd/data']));
  Im_du = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_du/data']));
  Im_ud = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_ud/data']));
  Im_uu = uint8(hdf5read(fname,[Scanname,'/instrument/detectors/psd_uu/data']));
end
motors = hdf5read(fname,[Scanname,motorkeys{3}]);

idx = find(motors(13,:)>0);

inst.TwoTheta   = motors(1,idx);
inst.Theta      = motors(2,idx);
inst.SampleSlit = motors(13,idx);
inst.MonoSlit   = motors(12,idx);

scalers = hdf5read(fname,[Scanname,scalerskeys{3}]);

if Mroi == 1 
  roi = hdf5read(fname,[Scanname,scalerskeys{4}]);
else
  roi = [1 1400 1 1400];
end

toc
disp('-Reading from h5 finished')
end
tic


[M1,N1,O1] = size(Im_uu);
[M2,N2,O2] = size(Im_du);
[M3,N3,O3] = size(Im_ud);
[M4,N4,O4] = size(Im_dd);


if strcmp(Scanname(2:end),'00313') 
  correctdb = 1;
else
  correctdb = 0;
end


if strcmp(Scanname(2:end),'00368') || strcmp(Scanname(2:end),'00369')
  if O2 < max(idx)
    arrayidx = O2;
  else
    arrayidx = idx;
  end
  
  
  inst.im_uu   = Im_ud(:,:,arrayidx);
  if O1 < max(idx)
    arrayidx = O1;
  else
    arrayidx = idx;
  end
  inst.im_du   = Im_uu(:,:,arrayidx);
  if O3 < max(idx)
    arrayidx = O3;
  else
    arrayidx = idx;
  end
  inst.im_ud   = Im_du(:,:,arrayidx);
  if O4 < max(idx)
    arrayidx = O4;
  else
    arrayidx = idx;
  end
  inst.im_dd   = Im_dd(:,:,arrayidx);
else
  if O1 < max(idx)
    arrayidx = O1;
  else
    arrayidx = idx;
  end
  inst.im_uu   = Im_uu(:,:,arrayidx);
  if O2 < max(idx)
    arrayidx = O2;
  else
    arrayidx = idx;
  end
  inst.im_du   = Im_du(:,:,arrayidx);
  if O3 < max(idx)
    arrayidx = O3;
  else
    arrayidx = idx;
  end
  inst.im_ud   = Im_ud(:,:,arrayidx);
  if O4 < max(idx)
    arrayidx = O4;
  else
    arrayidx = idx;
  end
  inst.im_dd   = Im_dd(:,:,arrayidx);
end

[M1,N1,O1] = size(inst.im_uu);
[M2,N2,O2] = size(inst.im_du);
[M3,N3,O3] = size(inst.im_ud);
[M4,N4,O4] = size(inst.im_dd);


if O1 == 1
  O1 = 0;
end
if O2 == 1
  O2 = 0;
end
if O3 == 1
  O3 = 0;
end
if O4 == 1
  O4 = 0;
end


[~,N]        = size(scalers);


inst.Time    = scalers(1,idx);
inst.Monitor = scalers(5,idx);
inst.M1      = scalers(13,idx);
inst.M2      = scalers(14,idx);
inst.M3      = scalers(15,idx);
inst.M4      = scalers(16,idx);
inst.ROI     = roi;

polcount = 0;
% finding monitor values larger than zero because in case the measurement
% was aborted mid way the rest of the scan has zero in monitor.
% the Ms are set to zero so a trigger in reduceData will set the monitor
% to the sum monitor.
if sum(diff(inst.M1(inst.M1>0)))==0
  inst.M1 = zeros(size(inst.Time));
  polcount = polcount + 1;
end
if sum(diff(inst.M2(inst.M2>0)))==0
  inst.M2 = zeros(size(inst.Time));
  polcount = polcount + 1;
end
if sum(diff(inst.M3(inst.M3>0)))==0
  inst.M3 = zeros(size(inst.Time));
  polcount = polcount + 1;
end
if sum(diff(inst.M4(inst.M4>0)))==0
  inst.M4 = zeros(size(inst.Time));
  polcount = polcount + 1;
end

if polcount == 0
  polcount = 1;
end
% if polcount == 4 
%   %Found unpolarized measurement because all the M1-M4 monitors are
%   %constant.
%   %Then because powermon is defined as sum of M1-M4 and when 
%   %pol is off the powermon is 4 times too small?
%  inst.Monitor = inst.Monitor*polcount;
% end

inst.Temp    = zeros(size(inst.Time));
inst.Magn    = zeros(size(inst.Time));

experiment{O1+O2+O3+O4} = {};
datapoint.polcount = polcount;
 
for i = 1:O1
    
    datapoint.Theta    = inst.Theta(i);
    datapoint.TwoTheta = inst.TwoTheta(i);
    datapoint.SumMonitor  = inst.Monitor(i);
    datapoint.Time     = inst.Time(i);
    datapoint.Temp     = inst.Temp(i);
    datapoint.SpinState= 'uu';
%    if correctdb 
%      datapoint.SampleSlit  = 0.05;
%      datapoint.im          = inst.im_uu(:,:,i)'.*0.05/0.2;
%      datapoint.SumMonitor  = datapoint.SumMonitor.*0.05/0.2;
%    else
      datapoint.SampleSlit  = inst.SampleSlit(i);
      datapoint.im          = inst.im_uu(:,:,i)';
%    end
    datapoint.MonoSlit    = inst.MonoSlit(i);
    
    datapoint.imLog       = makeDataLogFriendly(datapoint.im);
    datapoint.ORIGROI     = inst.ROI;
    datapoint.bottom      = inst.ROI(2);
    datapoint.top         = inst.ROI(1);
    datapoint.end         = inst.ROI(4);
    datapoint.start       = inst.ROI(3);
    
    datapoint.hasROI      = 1;
    datapoint.hasGaussFit = 0;
    datapoint.hasBackROI  = 0;
    datapoint.hasBackROI_2 = 0;

    datapoint.Integr      = 0;
    datapoint.sIntegr     = 0;
    datapoint.header      = '';
    %datapoint.start       = 1;
    datapoint.Magn        = inst.Magn(i);
    datapoint.bIntegr     = 0;
    datapoint.M1  = inst.M1(i);
    datapoint.M2  = inst.M2(i);
    datapoint.M3  = inst.M3(i);
    datapoint.M4  = inst.M4(i);
    
    [m,n]= size(inst.im_uu(:,:,i));
    %datapoint.end         = m;
    %datapoint.bottom      = n;
    %datapoint.top         = 1;
    datapoint.imsize      = [m,n];
    
    experiment{i} = datapoint;
end
k = O1+1;





for i = 1:O3
  
    datapoint.Theta    = inst.Theta(i);
    datapoint.TwoTheta = inst.TwoTheta(i);
    datapoint.SumMonitor  = inst.Monitor(i);
    datapoint.Time     = inst.Time(i);
    datapoint.Temp     = inst.Temp(i);
    datapoint.SpinState= 'ud';
    datapoint.SampleSlit  = inst.SampleSlit(i);
    datapoint.MonoSlit    = inst.MonoSlit(i);
    
    datapoint.im          = inst.im_ud(:,:,i)';
    datapoint.imLog       = makeDataLogFriendly(datapoint.im);
    datapoint.ORIGROI     = inst.ROI;
    datapoint.bottom      = inst.ROI(2);
    datapoint.top         = inst.ROI(1);
    datapoint.end         = inst.ROI(4);
    datapoint.start       = inst.ROI(3);

    datapoint.hasROI      = 1;

    datapoint.hasGaussFit = 0;
    datapoint.hasBackROI  = 0;
    datapoint.hasBackROI_2 = 0;

    datapoint.Integr      = 0;
    datapoint.sIntegr     = 0;
    datapoint.header      = '';
   % datapoint.start       = 1;
    datapoint.Magn        = inst.Magn(i);
    datapoint.bIntegr     = 0;
    datapoint.M1  = inst.M1(i);
    datapoint.M2  = inst.M2(i);
    datapoint.M3  = inst.M3(i);
    datapoint.M4  = inst.M4(i);
    
    [m,n]= size(inst.im_ud(:,:,i));
    %datapoint.end         = m;
    %datapoint.bottom      = n;
    %datapoint.top         = 1;
    datapoint.imsize      = [m,n];
    
    experiment{k} = datapoint;
    k = k + 1;
end

for i = 1:O2
  
    datapoint.Theta    = inst.Theta(i);
    datapoint.TwoTheta = inst.TwoTheta(i);
    datapoint.SumMonitor  = inst.Monitor(i);
    datapoint.Time     = inst.Time(i);
    datapoint.Temp     = inst.Temp(i);
    datapoint.SpinState= 'du';
 %   if correctdb 
 %     datapoint.SampleSlit  = 0.05;
 %     datapoint.im          = inst.im_du(:,:,i)'.*0.05/0.2;
 %     datapoint.SumMonitor  = datapoint.SumMonitor.*0.05/0.2;
 %   else
      datapoint.SampleSlit  = inst.SampleSlit(i);
      datapoint.im          = inst.im_du(:,:,i)';
 %   end
   % datapoint.SampleSlit  = inst.SampleSlit(i);
    datapoint.MonoSlit    = inst.MonoSlit(i);
   % datapoint.im          = inst.im_du(:,:,i)';
    datapoint.imLog       = makeDataLogFriendly(datapoint.im);
    datapoint.ORIGROI     = inst.ROI;
    datapoint.bottom      = inst.ROI(2);
    datapoint.top         = inst.ROI(1);
    datapoint.end         = inst.ROI(4);
    datapoint.start       = inst.ROI(3);
    datapoint.hasROI      = 1;
    datapoint.hasGaussFit = 0;
    datapoint.hasBackROI  = 0;
    datapoint.hasBackROI_2 = 0;

    datapoint.Integr      = 0;
    datapoint.sIntegr     = 0;
    datapoint.header      = '';
  %  datapoint.start       = 1;
    datapoint.Magn        = inst.Magn(i);
    datapoint.bIntegr     = 0;
    datapoint.M1  = inst.M1(i);
    datapoint.M2  = inst.M2(i);
    datapoint.M3  = inst.M3(i);
    datapoint.M4  = inst.M4(i);
    
    [m,n]= size(inst.im_du(:,:,i));
   % datapoint.end         = m;
   % datapoint.bottom      = n;
   % datapoint.top         = 1;
    datapoint.imsize      = [m,n];
    
    experiment{k} = datapoint;
    k = k + 1;
end

for i = 1:O4
  
    datapoint.Theta    = inst.Theta(i);
    datapoint.TwoTheta = inst.TwoTheta(i);
    datapoint.SumMonitor  = inst.Monitor(i);
    datapoint.Time     = inst.Time(i);
    datapoint.Temp     = inst.Temp(i);
    datapoint.SpinState= 'dd';
    datapoint.SampleSlit  = inst.SampleSlit(i);
    datapoint.MonoSlit    = inst.MonoSlit(i);
    
   % datapoint.im          = inst.im_dd(:,:,i)';
    datapoint.im          = inst.im_dd(:,:,i)';
    datapoint.imLog       = makeDataLogFriendly(datapoint.im);
    
    datapoint.ORIGROI     = inst.ROI;
    datapoint.bottom      = inst.ROI(2);
    datapoint.top         = inst.ROI(1);
    datapoint.end         = inst.ROI(4);
    datapoint.start       = inst.ROI(3);
    
    datapoint.hasROI      = 1;
    datapoint.hasGaussFit = 0;
    datapoint.hasBackROI  = 0;
    datapoint.hasBackROI_2 = 0;

    datapoint.Integr      = 0;
    datapoint.sIntegr     = 0;
    datapoint.header      = '';
   % datapoint.start       = 1;
    datapoint.Magn        = inst.Magn(i);
    datapoint.bIntegr     = 0;
    datapoint.M1  = inst.M1(i);
    datapoint.M2  = inst.M2(i);
    datapoint.M3  = inst.M3(i);
    datapoint.M4  = inst.M4(i);
    
    [m,n]= size(inst.im_dd(:,:,i));
  %  datapoint.end         = m;
  %  datapoint.bottom      = n;
   % datapoint.top         = 1;
    datapoint.imsize      = [m,n];
    
    experiment{k} = datapoint;
    k = k + 1;
end

%uservalues = {name.Data,nlc.Data,np.Data};

%usermap = containers.Map(userkeys,uservalues);

%usermap('/user/proposal');


% inst.SpinState = char(vals(12));
% inst.SpinState = inst.SpinState(1:2);

% Im = reshape(data,dim(1),dim(2));
% Im = Im';
% 
% inst.project  = sum(Im,1);
toc

end