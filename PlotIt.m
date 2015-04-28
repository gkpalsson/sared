function PlotIt(p,iter,S)
  
  handles = S.handles;
  
  redchi = redchisqr(p,S);
  sim    = model(p,S);
  ax = S.theaxis;
  %fig = figure(2);
  cla(ax);
  %ax1 = axes('Parent',fig,'Position',[0.1 0.4 0.8 0.5]);

  hold(ax,'on');
if handles.data(:,2)~=ones(size(handles.data(:,2)))
  plot(handles.axesFit,S.Q,sim(:,1),'-b','LineWidth',1.5);
  plot(handles.axesFit,handles.data(:,1),handles.data(:,2),'ob','MarkerFaceColor','b');
end
if handles.data(:,5)~=ones(size(handles.data(:,5)))
  plot(handles.axesFit,S.Q,sim(:,4),'-r','LineWidth',1.5);
  plot(handles.axesFit,handles.data(:,1),handles.data(:,5),'or','MarkerFaceColor','r');
end
if handles.data(:,3)~=ones(size(handles.data(:,3)))
  plot(handles.axesFit,S.Q,sim(:,2),'-m','LineWidth',1.5);
  plot(handles.axesFit,handles.data(:,1),handles.data(:,3),'om','MarkerFaceColor','m');
end
if handles.data(:,4)~=ones(size(handles.data(:,4)))
  plot(handles.axesFit,S.Q,sim(:,4),'-m','LineWidth',1.5);
  plot(handles.axesFit,handles.data(:,1),handles.data(:,4),'om','MarkerFaceColor','m');
end
  hold off;
  %axis([-Inf Inf 1e-7 1]);
 % plot(S.Q,S.I,'-o','MarkerSize',4);
 % hold on;
 % plot(S.Q,sim,'-r','LineWidth',2);
%  title(['\chi^2: ',num2str(redchi)]);
  set(gca,'YScale','log');
 % ax2 = axes('Parent',fig,'Position',[0.1 0.1 0.8 0.2]);
 % plot(ax2,S.Q,log10(S.I)-log10(sim),'-o','MarkerSize',4);
 % hold on;
 % plot(S.Q,zeros(size(S.Q)),'-r');
  drawnow;
  pause(0.001);
end