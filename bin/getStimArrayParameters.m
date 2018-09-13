function varargout = getStimArrayParameters(varargin)
% GETSTIMARRAYPARAMETERS MATLAB code for getStimArrayParameters.fig
%   function getStimArrayParameters
%
%   This getStimArrayParameters GUI requires users to determine two main
%   parameters on how they would like to build their stimulus array. The
%   first question being: would subjects be presented with all available
%   stimuli?. This asks if users would like to present all uploaded stimuli
%   to each subject, or maybe would some subject only hear a number of
%   those stimuli and others will hear a different set. The second question
%   asks users if subjects will be presented with non-repeating stimuli
%   within one round of presentation. This asks users if they would like
%   any of their stimuli to be repeated within one round. See the
%   AudExpCreator User's Guide for more detailed descriptions of the
%   options. The selection of these two options will lead to the available
%   options for stimulus array constructions in the next GUI:
%   getStimArrayConstruct.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com


% Edit the above text to modify the response to help getStimArrayParameters

% Last Modified by GUIDE v2.5 17-May-2017 14:48:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getStimArrayParameters_OpeningFcn, ...
    'gui_OutputFcn',  @getStimArrayParameters_OutputFcn, ...
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


% --- Executes just before getStimArrayParameters is made visible.
function getStimArrayParameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getStimArrayParameters (see VARARGIN)

% Choose default command line output for getStimArrayParameters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

allStim{1}='Yes';
allStim{2}='No';
set(handles.popupmenu1,'String',allStim);

noRepeat{1}='Yes';
noRepeat{2}='No';
set(handles.popupmenu2,'String',noRepeat);

guidata(hObject, handles);

% UIWAIT makes getStimArrayParameters wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getStimArrayParameters_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
try
    varargout{1} = handles.studyInfo;
    delete(hObject);
catch
    varargout{1} = [];
end

% --- Executes on button press in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
content=get(handles.popupmenu1,'String');
selected=get(handles.popupmenu1,'Value');

selectedType=content{selected};
handles.allStim = selectedType;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
content=get(handles.popupmenu2,'String');
selected=get(handles.popupmenu2,'Value');

selectedType=content{selected};
handles.noRepeat = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
studyInfo = handles.studyInfo;
stimStruct = studyInfo.stimStruct;

try
    allStim = handles.allStim;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    allStim=content{selected};
end

try
    noRepeat = handles.noRepeat;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    noRepeat=content{selected};
end

if strcmp(studyInfo.type, 'Neurophysiological Study')
    start=2;
    c=1;
    for i=start:length(stimStruct)
        titles{c}=stimStruct(i).title;
        artists{c}=stimStruct(i).artist;
        types{c}=stimStruct(i).type;
        conds{c}=stimStruct(i).cond;
        c=c+1;
    end
else
    for i=1:length(stimStruct)
        titles{i}=stimStruct(i).title;
        artists{i}=stimStruct(i).artist;
        types{i}=stimStruct(i).type;
        conds{i}=stimStruct(i).cond;
    end
end

uniSpecs.title = unique(titles,'stable');
uniSpecs.artist = unique(artists,'stable');
uniSpecs.type = unique(types,'stable');
uniSpecs.cond = unique(conds,'stable');

if strcmpi(allStim,'Yes') && strcmpi(noRepeat,'Yes')
    arraySit = 1;
    pause(0.1);
    [stimArray, studyInfo]=getStimArrayConstruct(studyInfo,arraySit,uniSpecs);
    drawnow
elseif strcmpi(allStim,'No') && strcmpi(noRepeat,'Yes')
    arraySit = 2;
    pause(0.1);
    [stimArray, studyInfo]=getStimArrayConstruct(studyInfo,arraySit,uniSpecs);
    drawnow
elseif strcmpi(allStim,'Yes') && strcmpi(noRepeat,'No')
    arraySit = 3;
    pause(0.1);
    [stimArray, studyInfo]=getStimArrayConstruct(studyInfo,arraySit,uniSpecs);
    drawnow
elseif strcmpi(allStim,'No') && strcmpi(noRepeat,'No')
    arraySit = 4;
    pause(0.1);
    [stimArray, studyInfo]=getStimArrayConstruct(studyInfo,arraySit,uniSpecs);
    drawnow
else
    warningMessage = sprintf(['You have entered the twilight zone.',...
        '\nHow in world did you get here?']);
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

if isempty(stimArray) || isempty(studyInfo)
    warningMessage = sprintf(['Your stimulus array was not built.',...
        '\nPlese try again or consider trying different array parameters.']);
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studyInfo.stimArray = stimArray;

studyInfo.stimArrayName=sprintf('%sStimArray', studyInfo.name);
eval([studyInfo.stimArrayName '= studyInfo.stimArray;']);
save([studyInfo.path filesep studyInfo.stimArrayName '.mat'],...
    studyInfo.stimArrayName);

studyInfo.uniSpecs=uniSpecs;
handles.studyInfo = studyInfo;

save studyInfo.mat studyInfo

guidata(hObject, handles);

uiresume;


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
