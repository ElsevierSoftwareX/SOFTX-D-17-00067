function varargout = getStimInfo(varargin)
% GETSTIMINFO MATLAB code for getStimInfo.fig
%   function getStimInfo
%
%   This getStimInfo GUI helps walk users through the process of uploading
%   their stimuli and labeling them accordingly for optional grouping
%   selections. See the AudExpCreator User's Guide for more detailed 
%   descriptions and examples on what you can do.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getStimInfo

% Last Modified by GUIDE v2.5 08-May-2017 13:56:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getStimInfo_OpeningFcn, ...
                   'gui_OutputFcn',  @getStimInfo_OutputFcn, ...
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


% --- Executes just before getStimInfo is made visible.
function getStimInfo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getStimInfo (see VARARGIN)

% Choose default command line output for getStimInfo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.stimInfo.num = varargin{2};
    handles.stimPath = varargin{3};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    
    handles.stimInfo.num = 1;
    handles.stimStruct = [];
end

guidata(hObject, handles);

if handles.stimInfo.num==1 && strcmp(handles.studyInfo.type,'Neurophysiological Study')
    stimMessage = sprintf('Stimulus Information - Stimulus %02d', handles.stimInfo.num);
    set(handles.text1,'String',stimMessage, 'FontSize', 10, 'FontWeight', 'bold')
    
    noteMessage = sprintf(['Note: This is the 1st stim of your Neurophysiological',...
        'Study.\nPlease upload the baseline stim here.']);
    set(handles.text2,'String',noteMessage, 'FontSize', 8, 'FontWeight', 'normal') 
    
    stimTypeString = 'noise';
    set(handles.edit3,'String',stimTypeString, 'FontSize', 8, 'FontWeight', 'normal')
    
    stimCondString = 'baseline';
    set(handles.edit4,'String',stimCondString, 'FontSize', 8, 'FontWeight', 'normal')
else
    stimMessage = sprintf('Stimulus Information - Stimulus %02d', handles.stimInfo.num);
    set(handles.text1,'String',stimMessage, 'FontSize', 10, 'FontWeight', 'bold')
end

handles.stimInfo.stimTrigger=handles.stimInfo.num+20;

stimNumString = sprintf('%d', handles.stimInfo.num);
set(handles.textStimNum,'String',stimNumString, 'FontSize', 8, 'FontWeight', 'normal')

handles.stimInfo.renameStim = sprintf('%02d.wav', handles.stimInfo.num);
set(handles.textRenamedFile,'String',handles.stimInfo.renameStim, 'FontSize', 8, 'FontWeight', 'normal')

stimTriggerString = sprintf('%d', handles.stimInfo.stimTrigger);
set(handles.textStimTrigger,'String',stimTriggerString, 'FontSize', 8, 'FontWeight', 'normal')

guidata(hObject, handles);

uiwait(handles.figure1);

% UIWAIT makes getStimInfo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);

if handles.stimInfo.num == 1
    [filename, pathname, ~] = uigetfile(...
        { '*.wav','Audio Wav (*.wav)'},...
        'Select Your Stimulus Wav File', ...
        'MultiSelect', 'off');
    
    handles.stimInfo.filename = filename;
    handles.stimInfo.pathname = pathname;
    
    noteMessage = sprintf('\n%s was loaded.', filename);
    set(handles.text2,'String',noteMessage, 'FontSize', 8, 'FontWeight', 'normal',...
        'HorizontalAlignment', 'center')
else
    [filename, pathname, ~] = uigetfile(...
        { '*.wav','Audio Wav (*.wav)'},...
        'Select Your Stimulus Wav File', ...
        'MultiSelect', 'off', handles.stimPath);
    
    handles.stimInfo.filename = filename;
    handles.stimInfo.pathname = pathname;
    
    noteMessage = sprintf('\n%s was loaded.', filename);
    set(handles.text2,'String',noteMessage, 'FontSize', 8, 'FontWeight', 'normal',...
        'HorizontalAlignment', 'center')
end

guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

studyInfo= handles.studyInfo;
stimInfo = handles.stimInfo;

if isfield(stimInfo, 'filename') == 0
    warningMessage = 'Please upload your auditory stim file.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
elseif stimInfo.filename == 0
    warningMessage = 'Please upload your auditory stim file.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

copyfile([stimInfo.pathname stimInfo.filename],[studyInfo.stimPath]);

try
movefile([studyInfo.stimPath filesep stimInfo.filename],[studyInfo.stimPath filesep stimInfo.renameStim]);
catch
end

stimFile=[studyInfo.stimPath filesep stimInfo.renameStim];

stimStruct.stim = stimInfo.num;
stimStruct.trigger = stimInfo.stimTrigger;

stimTitle = get(handles.edit1,'String');
if isempty(stimTitle)
    warningMessage = 'Please write in the title of the stim.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

stimStruct.title = stimTitle;

stimArtist = get(handles.edit2,'String');
if isempty(stimArtist)
    warningMessage = 'Please write in the artist of the stim.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

stimStruct.artist = stimArtist;

stimType = get(handles.edit3,'String');
if isempty(stimType)
    warningMessage = 'Please write in the type of the stim.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

stimStruct.type = stimType;

stimCond = get(handles.edit4,'String');
if isempty(stimCond)
    pause(0.1);
    warningMessage = 'Please write in the condition of the stim.';
    drawnow
    warningInterface(studyInfo,warningMessage);
    return;
end

stimStruct.cond = stimCond;
stimStruct.file = stimFile;
handles.stimStruct = stimStruct;
guidata(hObject, handles);

uiresume;

% --- Outputs from this function are returned to the command line.
function varargout = getStimInfo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

try
    varargout{1} = handles.stimStruct;
    varargout{2} = handles.stimInfo.pathname;
    delete(hObject);
catch
    varargout{1} = [];
end



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
warningMessage = sprintf(['You are trying to exit without filling in all the stim info.',...
    '\nPlease fill out the stim info unless this is an emergency.']);
pause(0.1);
warningInterface([],warningMessage);
drawnow

normalMessage=sprintf('Is this an emergency? Type ''yes'' or ''no''');
yesString=1;
pause(0.1);
e=userRespInterface([],normalMessage,yesString);
drawnow

if strcmpi(e,'yes')
    delete(hObject);
    error('Program was terminated due to an emergency');
end


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
pushbutton1_Callback(hObject, eventdata, handles);


% --- Executes on key press with focus on pushbutton2 and none of its controls.
function pushbutton2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
pushbutton2_Callback(hObject, eventdata, handles);