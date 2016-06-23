function varargout = preferences(varargin)
% PREFERENCES MATLAB code for preferences.fig
%      PREFERENCES, by itself, creates a new PREFERENCES or raises the existing
%      singleton*.
%
%      H = PREFERENCES returns the handle to a new PREFERENCES or the handle to
%      the existing singleton*.
%
%      PREFERENCES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREFERENCES.M with the given input arguments.
%
%      PREFERENCES('Property','Value',...) creates a new PREFERENCES or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before preferences_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to preferences_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help preferences

% Last Modified by GUIDE v2.5 15-Jul-2015 14:10:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @preferences_OpeningFcn, ...
                   'gui_OutputFcn',  @preferences_OutputFcn, ...
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

% --- Executes just before preferences is made visible.
function preferences_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to preferences (see VARARGIN)

% Choose default command line output for preferences
handles.output = hObject;
%if isdeployed
 %   se = load(fullfile(ctfroot,'Documents/cycle143/Reduction/v0.5_newh5','settings.mat'));
    
     if isdeployed
       se = load(fullfile(ctfroot,'sared','settings.mat'));
else
    se = load('settings.mat');
end

handles.settings = se;
set(handles.edtwavelength, 'String',num2str(se.wavelength));
set(handles.edtlength, 'String',num2str(se.length));

set(handles.chkSquareBeam,'Value',se.doSquareBeam);
set(handles.chkGaussBeam,'Value',se.doGaussBeam);

set(handles.chkROI1,'Value',se.doROI1);
set(handles.chkROI2,'Value',se.doROI2);
set(handles.chkModel,'Value',se.doModel);
set(handles.edtP,'String',num2str(se.p));
set(handles.edtA,'String',num2str(se.a));
set(handles.edtfp,'String',num2str(se.fp));
set(handles.edtfa,'String',num2str(se.fa));
set(handles.edtSD,'String',num2str(se.SD));
set(handles.edtDW,'String',num2str(se.DW));
set(handles.edtSSdistance,'String',num2str(se.SampleSlitSampleD));
set(handles.edtMSdistance,'String',num2str(se.MonoSlitSampleSlitD));


set(handles.edtup,'String',num2str(se.up));
set(handles.edtua,'String',num2str(se.ua));
set(handles.edtufa,'String',num2str(se.fa));
set(handles.edtufp,'String',num2str(se.fp));
set(handles.rdoMonitor,'Value',se.doMonitorMonitor);
set(handles.rdoTime,'Value',se.doMonitorTime);
set(handles.chkShowFitting,'Value',se.doFitRefresh);



% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes preferences wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = preferences_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edtwavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtwavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtwavelength_Callback(hObject, eventdata, handles)
% hObject    handle to edtwavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtwavelength as text
%        str2double(get(hObject,'String')) returns contents of edtwavelength as a double

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edtlength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtlength_Callback(hObject, eventdata, handles)
% hObject    handle to edtlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtlength as text
%        str2double(get(hObject,'String')) returns contents of edtlength as a double

guidata(hObject,handles)

% --- Executes on button press in btndontsave.
function btndontsave_Callback(hObject, eventdata, handles)
% hObject    handle to btndontsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnsave.
function btnsave_Callback(hObject, eventdata, handles)
% hObject    handle to btnsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settings.wavelength = str2num(get(handles.edtwavelength, 'String'));
settings.length     = str2num(get(handles.edtlength, 'String'));

settings.doModel    = get(handles.chkModel,'Value'); 
settings.doROI1     = get(handles.chkROI1,'Value');
settings.doROI2     = get(handles.chkROI2,'Value');

settings.doSquareBeam = get(handles.chkSquareBeam,'Value');
settings.doGaussBeam  = get(handles.chkGaussBeam,'Value');

settings.doPol      = get(handles.chkCalc,'Value');
settings.p          = str2num(get(handles.edtP,'String')); 
settings.a          = str2num(get(handles.edtA,'String')); 
settings.fp         = str2num(get(handles.edtfp,'String')); 
settings.fa         = str2num(get(handles.edtfa,'String'));

settings.up          = str2num(get(handles.edtup,'String')); 
settings.ua          = str2num(get(handles.edtua,'String')); 
settings.ufp         = str2num(get(handles.edtufp,'String')); 
settings.ufa         = str2num(get(handles.edtufa,'String')); 

settings.SD         = str2num(get(handles.edtSD,'String')); 
settings.DW         = str2num(get(handles.edtDW,'String'));

settings.SampleSlitSampleD   = str2num(get(handles.edtSSdistance,'String'));
settings.MonoSlitSampleSlitD = str2num(get(handles.edtMSdistance,'String'));

settings.doMonitorMonitor = get(handles.rdoMonitor,'Value');
settings.doMonitorTime    = get(handles.rdoTime,'Value');
settings.doFitRefresh     = get(handles.chkShowFitting,'Value');
%if isdeployed
%    save(fullfile(ctfroot,'Documents/cycle143/Reduction/v0.5_newh5','settings.mat'),'-struct','settings');
if isdeployed
      save(fullfile(ctfroot,'sared','settings.mat'),'-struct','settings');
else
    save('settings.mat','-struct','settings');
end

close;

%initialize_gui(gcbf, handles, true);

% --- Executes when selected object changed in unitgroup.
function unitgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the btnsave flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to btnsave the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

% Update handles structure
guidata(handles.figure1, handles);





% --- Executes on button press in chkoverillumination.
function chkoverillumination_Callback(hObject, eventdata, handles)
% hObject    handle to chkoverillumination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkoverillumination



function edtSD_Callback(hObject, eventdata, handles)
% hObject    handle to edtSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSD as text
%        str2double(get(hObject,'String')) returns contents of edtSD as a double


% --- Executes during object creation, after setting all properties.
function edtSD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtDW_Callback(hObject, eventdata, handles)
% hObject    handle to edtDW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtDW as text
%        str2double(get(hObject,'String')) returns contents of edtDW as a double


% --- Executes during object creation, after setting all properties.
function edtDW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSL_Callback(hObject, eventdata, handles)
% hObject    handle to edtSL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSL as text
%        str2double(get(hObject,'String')) returns contents of edtSL as a double


% --- Executes during object creation, after setting all properties.
function edtSL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtfp_Callback(hObject, eventdata, handles)
% hObject    handle to edtfp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtfp as text
%        str2double(get(hObject,'String')) returns contents of edtfp as a double


% --- Executes during object creation, after setting all properties.
function edtfp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtfp (see GCBO)
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



function edtModel_Callback(hObject, eventdata, handles)
% hObject    handle to edtModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtModel as text
%        str2double(get(hObject,'String')) returns contents of edtModel as a double


% --- Executes during object creation, after setting all properties.
function edtModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtfa_Callback(hObject, eventdata, handles)
% hObject    handle to edtfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtfa as text
%        str2double(get(hObject,'String')) returns contents of edtfa as a double


% --- Executes during object creation, after setting all properties.
function edtfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkROI1.
function chkROI1_Callback(hObject, eventdata, handles)
% hObject    handle to chkROI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkROI1


% --- Executes on button press in chkModel.
function chkModel_Callback(hObject, eventdata, handles)
% hObject    handle to chkModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkModel


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edtup_Callback(hObject, eventdata, handles)
% hObject    handle to edtup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtup as text
%        str2double(get(hObject,'String')) returns contents of edtup as a double


% --- Executes during object creation, after setting all properties.
function edtup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtufa_Callback(hObject, eventdata, handles)
% hObject    handle to edtufa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtufa as text
%        str2double(get(hObject,'String')) returns contents of edtufa as a double


% --- Executes during object creation, after setting all properties.
function edtufa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtufa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtufp_Callback(hObject, eventdata, handles)
% hObject    handle to edtufp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtufp as text
%        str2double(get(hObject,'String')) returns contents of edtufp as a double


% --- Executes during object creation, after setting all properties.
function edtufp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtufp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtua_Callback(hObject, eventdata, handles)
% hObject    handle to edtua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtua as text
%        str2double(get(hObject,'String')) returns contents of edtua as a double


% --- Executes during object creation, after setting all properties.
function edtua_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edtP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtP as text
%        str2double(get(hObject,'String')) returns contents of edtP as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edtfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtfa as text
%        str2double(get(hObject,'String')) returns contents of edtfa as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edtfp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtfp as text
%        str2double(get(hObject,'String')) returns contents of edtfp as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtfp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edtA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtA as text
%        str2double(get(hObject,'String')) returns contents of edtA as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edtup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtup as text
%        str2double(get(hObject,'String')) returns contents of edtup as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edtufa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtufa as text
%        str2double(get(hObject,'String')) returns contents of edtufa as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtufa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edtufp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtufp as text
%        str2double(get(hObject,'String')) returns contents of edtufp as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtufp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edtua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtua as text
%        str2double(get(hObject,'String')) returns contents of edtua as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edtwavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtwavelength as text
%        str2double(get(hObject,'String')) returns contents of edtwavelength as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtwavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtMSdistance_Callback(hObject, eventdata, handles)
% hObject    handle to edtMSdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtMSdistance as text
%        str2double(get(hObject,'String')) returns contents of edtMSdistance as a double


% --- Executes during object creation, after setting all properties.
function edtMSdistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtMSdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSSdistance_Callback(hObject, eventdata, handles)
% hObject    handle to edtSSdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSSdistance as text
%        str2double(get(hObject,'String')) returns contents of edtSSdistance as a double


% --- Executes during object creation, after setting all properties.
function edtSSdistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSSdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkSquareBeam.
function chkSquareBeam_Callback(hObject, eventdata, handles)
% hObject    handle to chkSquareBeam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkSquareBeam


% --- Executes on button press in chkGaussBeam.
function chkGaussBeam_Callback(hObject, eventdata, handles)
% hObject    handle to chkGaussBeam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkGaussBeam


% --- Executes on button press in chkShowFitting.
function chkShowFitting_Callback(hObject, eventdata, handles)
% hObject    handle to chkShowFitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkShowFitting
