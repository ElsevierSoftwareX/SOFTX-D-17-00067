function varargout = userRespInterface(varargin)
% USERRESPINTERFACE MATLAB code for userRespInterface.fig
%   function userRespInterface
%
%   This userRespInterface GUI is part of the AudExpCreator. It pops up 
%   messages to users with response input required during the process of
%   building a study experiment.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com
% Edit the above text to modify the response to help userRespInterface

% Last Modified by GUIDE v2.5 10-May-2017 14:19:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @userRespInterface_OpeningFcn, ...
    'gui_OutputFcn',  @userRespInterface_OutputFcn, ...
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


% --- Executes just before userRespInterface is made visible.
function userRespInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to userRespInterface (see VARARGIN)

% Choose default command line output for userRespInterface

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.message = varargin{2};
    handles.yesString = varargin{3};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    handles.message = 'There is no message.';
    handles.yesString = 1;
    
end

guidata(hObject, handles);

set(handles.text1,'String',handles.message, 'FontSize', 8, 'FontWeight', 'bold')

guidata(hObject, handles);
% UIWAIT makes userRespInterface wait for user response (see UIRESUME)
uiwait;



% --- Outputs from this function are returned to the command line.
function varargout = userRespInterface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
try
    varargout{1} = handles.userRes;
    close; %OMG this took forever to figure out!!!
catch
    varargout{1}=[];
end


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

yesString = handles.yesString;
studyInfo = handles.studyInfo;

switch yesString
    case 0 %For single numbers
        try
            userRes = str2double(get(handles.edit1,'String'));
            if isempty(userRes) || isnan(userRes)
                warningMessage = 'Please correctly fill in a response.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        catch
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    case 1 %For strings
        userRes = get(handles.edit1,'String');
        if isempty(userRes)
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    case 2 % For multiple numbers, no repeats
        userRes = get(handles.edit1,'String');
        if isempty(userRes)
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            userRes = textscan(userRes,'%f');
            userRes = userRes{1}';
            anyRepeated = ~all(diff(sort(userRes)));
            if isempty(userRes)
                warningMessage = 'Please correctly fill in a response with numbers.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                if any(userRes)==1
                    warningMessage =['This is a Neurophysiological Study. Your stim 1 is noise',...
                        ' therefore cannot be used in the actual stim array. But it will be added later on.'];
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            if anyRepeated==1
                warningMessage = 'You''ve repeated stims. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if any(userRes>studyInfo.stimNum) || any(userRes<1) || any(rem(userRes,1)~=0) || any(userRes==0)
                warningMessage = 'The response you entered is not valid. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    case 3 %For multiple numbers numbers for probability settings
        userRes = get(handles.edit1,'String');
        if isempty(userRes)
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            userRes = textscan(userRes,'%f');
            userRes = userRes{1}';
            if isempty(userRes)
                warningMessage = 'Please correctly fill in a response with numbers.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if ~isequal(single(sum(userRes)),1)
                warningMessage = 'The sum of your response must equal 1. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    case 4 % For multiple numbers, mandatory repeats
        userRes = get(handles.edit1,'String');
        if isempty(userRes)
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            userRes = textscan(userRes,'%f');
            userRes = userRes{1}';
            if isempty(userRes)
                warningMessage = 'Please correctly fill in a response with numbers.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                if any(userRes)==1
                    warningMessage =['This is a Neurophysiological Study. Your stim 1 is noise',...
                        ' therefore cannot be used in the actual stim array. But it will be added later on.'];
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            anyRepeated = ~all(diff(sort(userRes)));
            if anyRepeated==0
                warningMessage = 'You did not add any repetition to your stim array. Please try again or choose another option for stim array construction.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if any(userRes>studyInfo.stimNum) || any(userRes<1) || any(rem(userRes,1)~=0)
                warningMessage = 'The response you entered is not valid. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    case 5 % For pairings, no limits
        userRes = get(handles.edit1,'String');
        if isempty(userRes)
            warningMessage = 'Please correctly fill in a response.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            userRes = textscan(userRes,'%f');
            userRes = userRes{1}';
            if isempty(userRes)
                warningMessage = 'Please correctly fill in a response with numbers.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if length(userRes)>2 || length(userRes)<2
                warningMessage = 'Please fill in 2 numbers for the stim pairing.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if any(userRes>studyInfo.stimNum) || any(userRes<1) || any(rem(userRes,1)~=0)
                warningMessage = 'The response you entered is not valid. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
end

handles.userRes=userRes;
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


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

delete(handles.figure1);
