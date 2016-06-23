close all;
clear all;

A=load('/Users/gkp/Desktop/test.dat');

%x = reshape(A(:,1),[1400,1400]);
%y = reshape(A(:,2),[1400,1400]);
%z = reshape(A(:,3),[1400,1400]);

%size(x)
%size(y)
%size(z)
fig = figure;
pcolor(reshape(A,[1400 1400]))
colorbar;
colormap('hot');
shading flat