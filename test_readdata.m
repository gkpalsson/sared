
close all;
clear all;

theta = load('Theta.dat');
int   = load('Intensity.dat');

figure
pcolor(int)
shading flat

M = 1400;
ROI_center_x = 703;
handles.settings.DW = 300;
handles.settings.wavelength = 5.183;
handles.settings.SD = 2007;

mm_per_pixel = handles.settings.DW/1400;

H_pixel        = 1:1:M;

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
for i = 1:length(theta)
  alpha     = theta(i);
  
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
end

fig = figure;
pcolor(handles.Qx,handles.Qz,int);
shading flat;