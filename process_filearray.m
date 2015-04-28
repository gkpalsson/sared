function [experiment] = process_filearray(fileList,handles)


N = length(fileList);

    datapoint = {};
    datapoint.Theta       = [];
    datapoint.TwoTheta    = [];
    datapoint.SumMonitor     = [];
    datapoint.Time        = -1;
    datapoint.Temp        = -1;
    datapoint.SpinState   = '';
    datapoint.im          = [];
    datapoint.hasROI      = 0;
    datapoint.hasBackROI  = 0;
    datapoint.hasBackROI_2 = 0;
    datapoint.hasGaussFit = 0;
    datapoint.Integr      = 0;
    datapoint.sIntegr     = 0;
    datapoint.header      = {};
    datapoint.start       = 1;
    datapoint.Magn        = 0;
    datapoint.end         = 500;
    datapoint.bottom      = 500;
    datapoint.top         = 1;
    datapoint.SampleSlit  = 0;
    datapoint.MonoSlit  = 0;
    datapoint.M1  = 0;
    datapoint.M2  = 0;
    datapoint.M3  = 0;
    datapoint.M4  = 0;
 %   experiment{N} = datapoint;
experiment = {};
exp = {};
%h = waitbar(0,'Reading Data files...','WindowStyle','modal');

switch handles.fileformat
      case 'h5' 
        experiment   = h5read_SuperADAM(fileList(end),0);
      case 'h5pol'
        for i = 1:length(fileList)
          exp   = h5read_pol_SuperADAM(fileList(i),0);
          N = length(experiment);
          M = length(exp);
  
         for j = (N+1):(N+M)
           experiment{j} = exp{j-N};
         end
        end

      case 'edf'
       
        for i = 1:N
          [im,header,inst]   = edfread_SuperADAM(fileList(i),0);
          
          datapoint.Theta    = inst.Theta;
          datapoint.TwoTheta = inst.TwoTheta;
          datapoint.SumMonitor  = inst.Monitor;
          datapoint.Time     = inst.Time;
          datapoint.Temp     = inst.Temp;
          datapoint.SpinState= inst.SpinState;
          datapoint.SampleSlit  = inst.SampleSlit;
          datapoint.MonoSlit    = inst.MonoSlit;
          datapoint.im          = im;
          datapoint.hasROI      = 0;
          datapoint.hasGaussFit = 0;
          datapoint.Integr      = 0;
          datapoint.sIntegr     = 0;
          datapoint.header      = header;
          datapoint.start       = 1;
          datapoint.Magn        = inst.Magn;
          datapoint.bIntegr     = 0;
          datapoint.M1  = inst.M1;
          datapoint.M2  = inst.M2;
          datapoint.M3  = inst.M3;
          datapoint.M4  = inst.M4;
          
          [m,n]= size(im);
          datapoint.end         = m;
          datapoint.bottom      = n;
          datapoint.top         = 1;
          datapoint.imsize      = [m,n];
          
          experiment{i} = datapoint;
        end
end



% close(h);