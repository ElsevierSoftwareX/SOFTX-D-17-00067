function varargout = warningInterface(varargin)
% WARNINGINTERFACE MATLAB code for warningInterface.fig
%   function warningInterface
%
%   This warningInterface GUI is part of the AudExpCreator. It pops up 
%   warnings to users during the process of building a study experiment.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com


% Edit the above text to modify the response to help warningInterface

% Last Modified by GUIDE v2.5 08-May-2017 13:54:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @warningInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @warningInterface_OutputFcn, ...
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


% --- Executes just before warningInterface is made visible.
function warningInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to warningInterface (see VARARGIN)

% Choose default command line output for warningInterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.warning = varargin{2};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    handles.warning = 'There is no message.';
end
guidata(hObject, handles);

set(handles.text1,'String',handles.warning, 'FontSize', 8, 'FontWeight', 'normal')

% UIWAIT makes warningInterface wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = warningInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=[];
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);


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
