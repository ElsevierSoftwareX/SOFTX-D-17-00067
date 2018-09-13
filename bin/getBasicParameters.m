function varargout = getBasicParameters(varargin)
% GETBASICPARAMETERS MATLAB code for getBasicParameters.fig
%   function getBasicParameters
%
%   This getBasicParameters GUI is the second step in AudExpCreator. It 
%   requires some users input on some basic parameters regarding the "look
%   & feel" of the experiment.
%
%   To start with this function requires the following input from you:
%         
%         1. Screen Resolution. The screen resolution you want to project 
%         the study experiment with. The text on the left side of this 
%         input will auto-detect your primary monitor screen resolution 
%         for you. You are welcome to use this resolution or a anything 
%         smaller to project your study experiment display. 
%         
%         2. Background Color. Here you are required to input the RGB of
%         the background color of your choice. This input will take RGB in
%         the "0-1" scale or "0-255" scale.
%
%         3. Font Color. Here you are required to input the font color of
%         your choice in RGB color scale of "0-1" or "0-255". Just remember
%         that your font color should have a good contrast with your
%         background color or else text will appear hard to read for
%         subjects.
%
%         Note: There is a helpful check to make sure that your background 
%         color and font color does not match each other. 
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getBasicParameters

% Last Modified by GUIDE v2.5 12-May-2017 14:29:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getBasicParameters_OpeningFcn, ...
    'gui_OutputFcn',  @getBasicParameters_OutputFcn, ...
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


% --- Executes just before getBasicParameters is made visible.
function getBasicParameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getBasicParameters (see VARARGIN)

% Choose default command line output for getBasicParameters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat');
    handles.studyInfo = studyInfo;
end

scrnSize=get(0,'screensize');

message = sprintf(['What is the resolution of the screen you want to project?',...
'\n(Your screen resolution is %d x %d. Do not exceed this.)'], scrnSize(3), scrnSize(4));

set(handles.text2,'String',message, 'FontSize', 8, 'FontWeight', 'bold')

guidata(hObject, handles);

% UIWAIT makes getBasicParameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getBasicParameters_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=[];
varargout{1} = handles.output;



function editY_Callback(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editY as text
%        str2double(get(hObject,'String')) returns contents of editY as a double


% --- Executes during object creation, after setting all properties.
function editY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editX_Callback(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX as text
%        str2double(get(hObject,'String')) returns contents of editX as a double


% --- Executes during object creation, after setting all properties.
function editX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBGr_Callback(hObject, eventdata, handles)
% hObject    handle to editBGr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBGr as text
%        str2double(get(hObject,'String')) returns contents of editBGr as a double


% --- Executes during object creation, after setting all properties.
function editBGr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBGr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBGb_Callback(hObject, eventdata, handles)
% hObject    handle to editBGb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBGb as text
%        str2double(get(hObject,'String')) returns contents of editBGb as a double


% --- Executes during object creation, after setting all properties.
function editBGb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBGb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBGg_Callback(hObject, eventdata, handles)
% hObject    handle to editBGb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBGb as text
%        str2double(get(hObject,'String')) returns contents of editBGb as a double


% --- Executes during object creation, after setting all properties.
function editBGg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBGb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFCr_Callback(hObject, eventdata, handles)
% hObject    handle to editFCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFCr as text
%        str2double(get(hObject,'String')) returns contents of editFCr as a double


% --- Executes during object creation, after setting all properties.
function editFCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFCb_Callback(hObject, eventdata, handles)
% hObject    handle to editFCb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFCb as text
%        str2double(get(hObject,'String')) returns contents of editFCb as a double


% --- Executes during object creation, after setting all properties.
function editFCb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFCb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFCg_Callback(hObject, eventdata, handles)
% hObject    handle to editFCb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFCb as text
%        str2double(get(hObject,'String')) returns contents of editFCb as a double


% --- Executes during object creation, after setting all properties.
function editFCg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFCb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

x = str2double(get(handles.editX,'String'));
if isempty(x) || isnan(x)
    warningMessage = 'Please correctly fill in the width of the resolution.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

y = str2double(get(handles.editY,'String'));
if isempty(y) || isnan(y)
    warningMessage = 'Please correctly fill in the height of resolution.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studyInfo.res = [x y];

bgR = str2double(get(handles.editBGr,'String'));
if isempty(bgR) || isnan(bgR)
    warningMessage = 'Please correctly fill in the R of the background color.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

bgG = str2double(get(handles.editBGb,'String'));
if isempty(bgG) || isnan(bgG)
    warningMessage = 'Please correctly fill in the G of the background color.';
    pause(0.1);
    warningInterface(studyInfo, warningMessage);
    drawnow
    return;
end

bgB = str2double(get(handles.editBGb,'String'));
if isempty(bgB) || isnan(bgB)
    warningMessage = 'Please correctly fill in the B of the background color.';
    pause(0.1);
    warningInterface(studyInfo, warningMessage);
    drawnow
    return;
end

studyInfo.bgColor = [bgR bgG bgB];

if sum(studyInfo.bgColor)==0
    studyInfo.bgColor = studyInfo.bgColor;
elseif sum(studyInfo.bgColor)<3 && all(studyInfo.bgColor)>~1
    studyInfo.bgColor = studyInfo.bgColor * 255;
elseif sum(studyInfo.bgColor)==3 && all(studyInfo.bgColor)>~1
    normalMessage=['Your background color''s rgb vector is a little ambiguous.',...
        ' Is this vector in "0-1" scale or "0-255" scale? Please type "0-1" or',...
        ' "0-255"'];
    yesString=1;
    pause(0.1);
    rgbScale=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(rgbScale)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif strcmpi(rgbScale,'0-1')
        studyInfo.bgColor = studyInfo.bgColor * 255;
    elseif strcmpi(rgbScale,'0-255')
        studyInfo.bgColor = studyInfo.bgColor;
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

fcR = str2double(get(handles.editFCr,'String'));
if isempty(fcR) || isnan(fcR)
    warningMessage = 'Please correctly fill in the R of the font color.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

fcG = str2double(get(handles.editFCb,'String'));
if isempty(fcG) || isnan(fcG)
    warningMessage = 'Please correctly fill in the G of the font color.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

fcB = str2double(get(handles.editFCb,'String'));
if isempty(fcB) || isnan(fcB)
    warningMessage = 'Please correctly fill in the B of the font color.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studyInfo.fontColor = [fcR fcG fcB];

if sum(studyInfo.fontColor)==0
    studyInfo.fontColor = studyInfo.fontColor;
elseif sum(studyInfo.fontColor)<3 && all(studyInfo.fontColor)>~1
    studyInfo.fontColor = studyInfo.fontColor * 255;
elseif sum(studyInfo.fontColor)==3 && all(studyInfo.fontColor)>~1
    normalMessage=['Your font color''s rgb vector is a little ambiguous.',...
        ' Is this vector in "0-1" scale or "0-255" scale? Please type "0-1" or',...
        ' "0-255"'];
    yesString=1;
    pause(0.1);
    rgbScale=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(rgbScale)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif strcmpi(rgbScale,'0-1')
        studyInfo.fontColor = studyInfo.fontColor * 255;
    elseif strcmpi(rgbScale,'0-255')
        studyInfo.fontColor = studyInfo.fontColor;
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

if studyInfo.bgColor==studyInfo.fontColor
    warningMessage = ['You''ve pulled a Kristin Kueter. Please use a different',...
        ' font color from your background color. DOH!'];
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

handles.studyInfo = studyInfo;
guidata(hObject, handles);

clc;
close(handles.figure1);

studyInfo.lastComp='getBasicParameters';
studyInfo.nextStep='getStructuralParameters(studyInfo)';

save studyInfo.mat studyInfo

pause(0.1);
getStructuralParameters(studyInfo);
drawnow


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
