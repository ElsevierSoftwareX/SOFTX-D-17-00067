function varargout = writeEEGStudy(varargin)
% WRITEEEGSTUDY MATLAB code for writeEEGStudy.fig
%   function writeEEGStudy
%
%   This writeEEGStudy GUI is the study specific GUI and last step
%   to creating an EEG Study experiment. Here you will choose various 
%   options to finalize the setup for your EEG Study experiment. For 
%   better instructions and details on each of these options please use the 
%   AudExpCreator User's Guide as this space is limited and cannot 
%   adequately provide the needed explanation. 
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help writeEEGStudy

% Last Modified by GUIDE v2.5 09-Jun-2017 22:06:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @writeEEGStudy_OpeningFcn, ...
                   'gui_OutputFcn',  @writeEEGStudy_OutputFcn, ...
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


% --- Executes just before writeEEGStudy is made visible.
function writeEEGStudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to writeEEGStudy (see VARARGIN)

% Choose default command line output for writeEEGStudy
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

studyInfo = handles.studyInfo;

stimSOpts{1}='Focus point: small cross';
stimSOpts{2}='Focus point: small dot';
stimSOpts{3}='Focus image for black bg';
stimSOpts{4}='Focus image for white bg';
stimSOpts{5}='Upload focus image (jpg)';
set(handles.popupmenu1,'String',stimSOpts);

if isfield(studyInfo, 'dataPath')
    questOpts{1}='Same question(s) for every stim';
    questOpts{2}='Different question(s) based on groups';
    questOpts{3}='Different question(s) for every stim';
else
    questOpts{1}='Same question(s) for every stim';
    questOpts{2}='Different question(s) based on groups';
    questOpts{3}='Different question(s) for every stim';
    questOpts{4}='No question(s)';
end
set(handles.popupmenu2,'String',questOpts);

startSOpts{1}='Default "READY" screen';
startSOpts{2}='Customize screen text';
set(handles.popupmenu3,'String',startSOpts);

startSExitB{1}='Default Enter key';
startSExitB{2}='Alternative Space bar';
set(handles.popupmenu4,'String',startSExitB);

endSOpts{1}='Default "End of Session" screen';
endSOpts{2}='Customize screen text';
set(handles.popupmenu5,'String',endSOpts);

endSExitB{1}='Default Enter key';
endSExitB{2}='Alternative Space bar';
set(handles.popupmenu6,'String',endSExitB);

breakSOpts{1}='Default screen text';
breakSOpts{2}='Customize screen text';
set(handles.popupmenu7,'String',breakSOpts);

breakSExitB{1}='Default Space bar';
breakSExitB{2}='Customize exit key';
set(handles.popupmenu8,'String',breakSExitB);

blankSOpts{1}='Fixed stim screen & default settings';
blankSOpts{2}='Fixed stim screen & customize settings';
set(handles.popupmenu9,'String',blankSOpts);

forceQExitB{1}='Default Esc key';
forceQExitB{2}='Alternative End key';
set(handles.popupmenu10,'String',forceQExitB);

guidata(hObject, handles);
% UIWAIT makes writeEEGStudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = writeEEGStudy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=[];
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
content=get(handles.popupmenu1,'String');
selected=get(handles.popupmenu1,'Value');

selectedType=content{selected};
handles.stimSOpts = selectedType;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
handles.questOpts = selectedType;

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


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
content=get(handles.popupmenu3,'String');
selected=get(handles.popupmenu3,'Value');

selectedType=content{selected};
handles.startSOpts = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
content=get(handles.popupmenu4,'String');
selected=get(handles.popupmenu4,'Value');

selectedType=content{selected};
handles.startSExitB = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
content=get(handles.popupmenu5,'String');
selected=get(handles.popupmenu5,'Value');

selectedType=content{selected};
handles.endSOpts = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
content=get(handles.popupmenu6,'String');
selected=get(handles.popupmenu6,'Value');

selectedType=content{selected};
handles.endSExitB = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
content=get(handles.popupmenu7,'String');
selected=get(handles.popupmenu7,'Value');

selectedType=content{selected};
handles.breakSOpts = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
content=get(handles.popupmenu8,'String');
selected=get(handles.popupmenu8,'Value');

selectedType=content{selected};
handles.breakSExitB = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9
content=get(handles.popupmenu9,'String');
selected=get(handles.popupmenu9,'Value');

selectedType=content{selected};
handles.blankSOpts = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10
content=get(handles.popupmenu10,'String');
selected=get(handles.popupmenu10,'Value');

selectedType=content{selected};
handles.forceQExitB = selectedType;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
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

studyInfo=handles.studyInfo;
uniSpecs=studyInfo.uniSpecs;

try
    eSInfo.stimSOpts = handles.stimSOpts;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    eSInfo.stimSOpts=content{selected};
end

try
    eSInfo.questOpts = handles.questOpts;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    eSInfo.questOpts=content{selected};
end

try
    eSInfo.startSOpts = handles.startSOpts;
catch
    content=get(handles.popupmenu3,'String');
    selected=get(handles.popupmenu3,'Value');
    eSInfo.startSOpts=content{selected};
end

try
    eSInfo.startSExitB = handles.startSExitB;
catch
    content=get(handles.popupmenu4,'String');
    selected=get(handles.popupmenu4,'Value');
    eSInfo.startSExitB=content{selected};
end

try
    eSInfo.endSOpts = handles.endSOpts;
catch
    content=get(handles.popupmenu5,'String');
    selected=get(handles.popupmenu5,'Value');
    eSInfo.endSOpts=content{selected};
end

try
    eSInfo.endSExitB = handles.endSExitB;
catch
    content=get(handles.popupmenu6,'String');
    selected=get(handles.popupmenu6,'Value');
    eSInfo.endSExitB=content{selected};
end

try
    eSInfo.breakSOpts = handles.breakSOpts;
catch
    content=get(handles.popupmenu7,'String');
    selected=get(handles.popupmenu7,'Value');
    eSInfo.breakSOpts=content{selected};
end

try
    eSInfo.breakSExitB = handles.breakSExitB;
catch
    content=get(handles.popupmenu8,'String');
    selected=get(handles.popupmenu8,'Value');
    eSInfo.breakSExitB=content{selected};
end

try
    eSInfo.blankSOpts = handles.blankSOpts;
catch
    content=get(handles.popupmenu9,'String');
    selected=get(handles.popupmenu9,'Value');
    eSInfo.blankSOpts=content{selected};
end

try
    eSInfo.forceQExitB = handles.forceQExitB;
catch
    content=get(handles.popupmenu10,'String');
    selected=get(handles.popupmenu10,'Value');
    eSInfo.forceQExitB=content{selected};
end

studyInfo.eSInfo = eSInfo;

save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if strcmp(eSInfo.stimSOpts,'Upload focus image (jpg)')
    
    stimSStruct.type = 'image';
    stimSStruct.name = 'fImage.jpg';
    
    imageName=[studyInfo.stimPath filesep stimSStruct.name];
    
    if exist(imageName,'file')==2
        normalMessage=sprintf(['It seems that you already have a focus image uploaded to',...
            ' your study. Would you like to upload a different one? (''yes'' or ''no'')']);
        yesString=1;
        pause(0.1);
        yesUpload=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesUpload)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(yesUpload,'yes')
            uploadI=1;
        elseif strcmpi(yesUpload,'no')
            uploadI=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        uploadI=1;
    end
    
    if uploadI
        [filename, pathname, ~] = uigetfile( ...
            { '*.jpg','Image File (*.jpg)'},...
            'Select Your Focus Image File', ...
            'MultiSelect', 'off');
        
        fImage.filename = filename;
        fImage.pathname = pathname;
        
        if fImage.filename == 0
            warningMessage = 'You cancel or exit without uploading an image. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        copyfile([fImage.pathname fImage.filename],[studyInfo.stimPath]);
        
        try
            movefile([studyInfo.stimPath filesep fImage.filename],[studyInfo.stimPath filesep stimSStruct.name]);
        catch
        end
    end
elseif strcmp(eSInfo.stimSOpts,'Focus image for black bg')
    stimSStruct.type = 'image';
    stimSStruct.name = 'fImage.jpg';
    
    imageName=[studyInfo.stimPath filesep stimSStruct.name];
    
    if exist(imageName,'file')==2
        normalMessage=sprintf(['It seems that you already have a focus image uploaded to',...
            ' your study. Would you like to replace that with a focus image for black bg? (''yes'' or ''no'')']);
        yesString=1;
        pause(0.1);
        yesUpload=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesUpload)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(yesUpload,'yes')
            uploadI=1;
        elseif strcmpi(yesUpload,'no')
            uploadI=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        uploadI=1;
    end
    
    if uploadI
        if ~isequal(studyInfo.bgColor,[0 0 0])
            if isequal(studyInfo.bgColor,[255 255 255])
                warningMessage = ['Your background color is not black, but white.',...
                    ' Please choose the option "Focus image for white bg".'];
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                warningMessage = ['Your background color is not black nor white.',...
                    ' Please choose "Focus point: small cross" or "Focus point: small dot" or "Upload focus image (jpeg)".'];
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end

        fImage.filename = '01.jpg';
        fImage.pathname = [pwd filesep 'bin'];
        
        copyfile([fImage.pathname filesep fImage.filename],[studyInfo.stimPath]);
        try
            movefile([studyInfo.stimPath filesep fImage.filename],[studyInfo.stimPath filesep stimSStruct.name]);
        catch
        end
    end
elseif strcmp(eSInfo.stimSOpts,'Focus image for white bg')
    stimSStruct.type = 'image';
    stimSStruct.name = 'fImage.jpg';
    
    imageName=[studyInfo.stimPath filesep stimSStruct.name];
    
    if exist(imageName,'file')==2
        normalMessage=sprintf(['It seems that you already have a focus image uploaded to',...
            ' your study. Would you like to replace that with a focus image for white bg? (''yes'' or ''no'')']);
        yesString=1;
        pause(0.1);
        yesUpload=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesUpload)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(yesUpload,'yes')
            uploadI=1;
        elseif strcmpi(yesUpload,'no')
            uploadI=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        uploadI=1;
    end
    
    if uploadI
        if ~isequal(studyInfo.bgColor,[255 255 255])
            if isequal(studyInfo.bgColor,[0 0 0])
                warningMessage = ['Your background color is not black, but white.',...
                    ' Please choose the option "Focus image for white bg".'];
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                warningMessage = ['Your background color is not black nor white.',...
                    ' Please choose "Focus point: small cross" or "Focus point: small dot" or "Upload focus image (jpeg)".'];
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
        
        fImage.filename = '02.jpg';
        fImage.pathname = [pwd filesep 'bin'];
        
        stimSStruct.type = 'image';
        stimSStruct.name = 'fImage.jpg';
        
        copyfile([fImage.pathname filesep fImage.filename],[studyInfo.stimPath]);
        try
            movefile([studyInfo.stimPath filesep fImage.filename],[studyInfo.stimPath filesep stimSStruct.name]);
        catch
        end
    end
elseif strcmp(eSInfo.stimSOpts,'Focus point: small cross')
    stimSStruct.type = 'image';
    stimSStruct.name = 'fImage.jpg';
    
    imageName=[studyInfo.stimPath filesep stimSStruct.name];
    
    if exist(imageName,'file')==2
        normalMessage=sprintf(['It seems that you already have a focus image uploaded to',...
            ' your study. Would you like to replace that with a focus point: small cross? (''yes'' or ''no'')']);
        yesString=1;
        pause(0.1);
        yesUpload=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesUpload)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(yesUpload,'yes')
            delete(imageName);
            uploadI=1;
        elseif strcmpi(yesUpload,'no')
            uploadI=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        uploadI=1;
    end
    
    if uploadI
        stimSStruct.type = 'cross';
        stimSStruct.name = 'cross';
    end

elseif strcmp(eSInfo.stimSOpts,'Focus point: small dot')
    stimSStruct.type = 'image';
    stimSStruct.name = 'fImage.jpg';
    
    imageName=[studyInfo.stimPath filesep stimSStruct.name];
    
    if exist(imageName,'file')==2
        normalMessage=sprintf(['It seems that you already have a focus image uploaded to',...
            ' your study. Would you like to replace that with a focus point: small dot? (''yes'' or ''no'')']);
        yesString=1;
        pause(0.1);
        yesUpload=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesUpload)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(yesUpload,'yes')
            delete(imageName);
            uploadI=1;
        elseif strcmpi(yesUpload,'no')
            uploadI=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        uploadI=1;
    end
    
    if uploadI
        stimSStruct.type = 'dot';
        stimSStruct.name = 'dot';
    end
end


if strcmp(eSInfo.questOpts,'No question(s)')
    if isfield(studyInfo, 'qStruct')==1 || isfield(studyInfo, 'qStructName')==1 
        normalMessage=sprintf(['It seems that there exists an end question struct in your study',...
            ' (maybe from a previous run of "writeConBeRatingStudy"). Would you like to remove it from your study?']);
        yesString=1;
        pause(0.1);
        remQStruct=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(remQStruct)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(remQStruct,'yes')
            
            fileName = [studyInfo.path filesep studyInfo.qStructName '.mat'];
            delete(fileName);
            
            fileName = [studyInfo.path filesep 'questionTrial.m'];
            delete(fileName);
            
            studyInfo=rmfield(studyInfo,{'qStruct','qStructName'});
            studyInfo.fLine=rmfield(studyInfo.fLine,'qTrial');
            save studyInfo.mat studyInfo
            
            yesData=0;
            
        elseif strcmpi(remQStruct,'no')
            warningMessage = sprintf('Please go back and choose a different option \nother than "No question(s)".');
            pause(0.1);
            messageInterface(studyInfo,warningMessage);
            drawnow
            return;
            
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    normalMessage=sprintf(['Are your stims presented in sets according to your stimulus array?',...
        ' If they are break screens will be presented after your sets instead of after every stim. Please answer',...
        ' with ''yes'' or ''no''.']);
    yesString=1;
    pause(0.1);
    yesSet=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSet)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSet,'yes')
        normalMessage=sprintf(['How many stims are in each stim set. Please make sure that this reflects',...
            ' your stim array (i.e. there is an even division of sets for recording sessions,',...
            ' presentations, etc.).']);
        yesString=0;
        pause(0.1);
        stimInSet=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(stimInSet)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif stimInSet==0
            warningMessage = '"0" is an invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif stimInSet==1
            warningMessage = ['"1" stimulus does not consitute a stimulus set. Please go back,'...
                ' and type in "no" for the question asking you if your stims are in a set.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif rem(studyInfo.stimPerRec,stimInSet)~=0
            warningMessage = sprintf(['The %d stims in your stim array per recording session was not evenly',...
                ' divided into "%d" sets. Please try over again.'], studyInfo.stimPerRec, stimInSet);
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
    elseif strcmpi(yesSet,'no')
        stimInSet = 1;
    else
        warningMessage = 'You entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end

    studyInfo.stimInSet = stimInSet;
    save studyInfo.mat studyInfo
    
    studyInfo = wBuildStimWavSeq(studyInfo);
    save studyInfo.mat studyInfo
    
    if strcmp(eSInfo.forceQExitB,'Default Esc key')
        fQuitKey = 'ESCAPE';
    else
        fQuitKey = 'End';
    end
    studyInfo.fQuitKey=fQuitKey;
    
else
    
    normalMessage=['What type of rating option would you like to choose?',...
        ' Key press: 1-9 scale? Key press: 1-5 scale? Key press: 1-nth scale? Mouse control: slider scale? Please',...
        ' respond with ''9 scale'', ''5 scale'', ''nth scale'' or ''slider scale''.'];
    yesString=1;
    pause(0.1);
    qOpts=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(qOpts)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmp(qOpts,'9 scale')
        eSInfo.ratingOpts='Key press: 1-9 scale';
        rOpts=1;
    elseif strcmp(qOpts,'5 scale')
        eSInfo.ratingOpts='Key press: 1-5 scale';
        rOpts=2;
    elseif strcmp(qOpts,'slider scale')
        eSInfo.ratingOpts='Mouse control: slider scale';
        rOpts=3;
        
        normalMessage = ['Because this is an EEG study, slider scale responses will be',...
            ' rescaled from 0-100 down to 1-10 to accomodate DINs output limitations.'];
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
    elseif strcmp(qOpts,'nth scale')
        normalMessage=sprintf(['The key press: 1-nth scale allows you to define the nth number response you would like to go to.',...
            ' Please choose the nth value from 2 - 9 as single keypress restrictions disallows two digit numbers.']);
        yesString=0;
        pause(0.1);
        nthNum=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(nthNum)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif nthNum<2
            warningMessage = 'Nth value cannot be less than 2. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif nthNum>9
            warningMessage = 'Nth vale cannot be greater than 9. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif mod(nthNum,1)~=0
            warningMessage = 'Nth vale cannot be a decimal value. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        rOpts=4;
        questSOpts.nthNum=nthNum;

    else
        warningMessage = 'You entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    studyInfo.eSInfo = eSInfo;
    
    if isfield(studyInfo, 'qStruct')==1 && ~isempty(studyInfo.qStruct)==1
        normalMessage=sprintf(['It seems that you already have a question structure built.',...
            ' Do you want to replace it and build a different one? (Type ''yes'' or ''no''.)']);
        yesString=1;
        pause(0.1);
        reBuildqStruct=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(reBuildqStruct)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(reBuildqStruct,'yes')
            buildQStruct=1;
        elseif strcmpi(reBuildqStruct,'no')
            buildQStruct=0;
        else
            warningMessage = 'You did not give an acceptable answer. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        buildQStruct=1;
    end
    
    if buildQStruct
        if strcmp(eSInfo.questOpts,'Same question(s) for every stim')
            normalMessage = 'Let''s get some question info for all your stim.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            normalMessage='How many questions will there be?';
            yesString=0;
            pause(0.1);
            qNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(qNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif qNum==0
                warningMessage = 'Sorry "0" is not allowed here.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            for i=1:qNum
                normalMessage=sprintf('Please type in question #%d', i);
                yesString=1;
                pause(0.1);
                question{i}=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(question{i})==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                normalMessage=sprintf(['For question #%d, please type the low point.',...
                    '\nEx. How fun was the excerpt? Low point = not at all.'], i);
                yesString=1;
                pause(0.1);
                qLow{i}=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(qLow{i})==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                normalMessage=sprintf(['For question #%d, please type the high point.',...
                    '\nEx. How fun was the excerpt? High point = very fun.'], i);
                yesString=1;
                pause(0.1);
                qHigh{i}=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(qHigh{i})==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            for i=1:studyInfo.stimNum
                qStruct(i).trigger=studyInfo.stimStruct(i).trigger;
                qStruct(i).qNum=qNum;
                qStruct(i).question=question;
                qStruct(i).qLow = qLow;
                qStruct(i).qHigh = qHigh;
            end
            
        elseif strcmp(eSInfo.questOpts,'Different question(s) based on groups')
            normalMessage = 'First, let''s define the stimulus groups for your questions.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            pause(0.1);
            [gNum, group, groupBy, groupName]=getGroups(studyInfo,uniSpecs);
            drawnow
            
            if isempty(gNum)==1
                warningMessage = 'You exit before selecting groups. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf('Let''s get some question info for your specified groups %s.', groupBy);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            for k=1:gNum
                
                normalMessage=sprintf('For your ''%s group'' how many questions would you like?',groupName{k});
                yesString=0;
                pause(0.1);
                qNum=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(qNum)==1
                    warningMessage = 'You exit before responding. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif qNum==0
                    warningMessage = 'Sorry "0" is not allowed here.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                for i=1:qNum
                    normalMessage=sprintf('Please type in question #%d for your %s group', i, groupName{k});
                    yesString=1;
                    pause(0.1);
                    question{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(question{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=sprintf(['For question #%d, please type the low point.',...
                        '\nEx. How fun was the excerpt? Low point = not at all.'], i);
                    yesString=1;
                    pause(0.1);
                    qLow{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(qLow{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=sprintf(['For question #%d, please type the high point.',...
                        '\nEx. How fun was the excerpt? High point = very fun.'], i);
                    yesString=1;
                    pause(0.1);
                    qHigh{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(qHigh{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                for i=1:length(group{k})
                    indxStim = group{k}(i);
                    qStruct(indxStim).trigger=studyInfo.stimStruct(indxStim).trigger;
                    qStruct(indxStim).qNum=qNum;
                    qStruct(indxStim).question=question;
                    qStruct(indxStim).qLow = qLow;
                    qStruct(indxStim).qHigh = qHigh;
                end
                clear question qLow qHigh
            end
            
        elseif strcmp(eSInfo.questOpts,'Different question(s) for every stim')
            normalMessage = 'Let''s get some question info for each of your stim.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            for k=1:studyInfo.stimNum
                normalMessage=sprintf('How many questions will there be for stim #%d?', k);
                yesString=0;
                pause(0.1);
                qNum=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(qNum)==1
                    warningMessage = 'You exit before responding. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif qNum==0
                    warningMessage = 'Sorry "0" is not allowed here.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                for i=1:qNum
                    normalMessage=sprintf('Please type in question #%d for stim #%d', i,k);
                    yesString=1;
                    pause(0.1);
                    question{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(question{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=sprintf(['For question #%d, please type the low point.',...
                        '\nEx. How fun was the excerpt? Low point = not at all.'], i);
                    yesString=1;
                    pause(0.1);
                    qLow{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(qLow{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=sprintf(['For question #%d, please type the high point.',...
                        '\nEx. How fun was the excerpt? High point = very fun.'], i);
                    yesString=1;
                    pause(0.1);
                    qHigh{i}=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(qHigh{i})==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                end
                
                qStruct(k).trigger=studyInfo.stimStruct(k).trigger;
                qStruct(k).qNum=qNum;
                qStruct(k).question=question;
                qStruct(k).qLow = qLow;
                qStruct(k).qHigh = qHigh;
                
                clear question qLow qHigh
            end
        end
        
        studyInfo.qStruct = qStruct;
        
        studyInfo.qStructName=sprintf('%sQStruct', studyInfo.name);
        eval([studyInfo.qStructName '= studyInfo.qStruct;']);
        save([studyInfo.path filesep studyInfo.qStructName '.mat'],...
            studyInfo.qStructName);
        
        save studyInfo.mat studyInfo
        
        normalMessage = sprintf('Your question structure was compiled and saved.');
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
    end

    normalMessage=sprintf(['Are your stims presented in sets according to your stimulus array?',...
        ' If they are break screens will be presented after your sets instead of after every stim. Please answer',...
        ' with ''yes'' or ''no''.']);
    yesString=1;
    pause(0.1);
    yesSet=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSet)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSet,'yes')
        normalMessage=sprintf(['How many stims are in each stim set. Please make sure that this reflects',...
            ' your stim array (i.e. there is an even division of sets for recording sessions,',...
            ' presentations, etc.).']);
        yesString=0;
        pause(0.1);
        stimInSet=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(stimInSet)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnown
            return;
        elseif stimInSet==0
            warningMessage = '"0" is an invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif stimInSet==1
            warningMessage = ['"1" stimulus does not consitute a stimulus set. Please go back,'...
                ' and type in "no" for the question asking you if your stims are in a set.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif rem(studyInfo.stimPerRec,stimInSet)~=0
            warningMessage = sprintf(['The %d stims in your stim array per recording session was not evenly',...
                ' divided into "%d" sets. Please try over again.'], studyInfo.stimPerRec, stimInSet);
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
    elseif strcmpi(yesSet,'no')
        stimInSet = 1;
    else
        warningMessage = 'You entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    studyInfo.stimInSet = stimInSet;
    save studyInfo.mat studyInfo
    
    studyInfo = wBuildStimWavSeq(studyInfo);
    save studyInfo.mat studyInfo
    
    if strcmp(eSInfo.forceQExitB,'Default Esc key')
        fQuitKey = 'ESCAPE';
    else
        fQuitKey = 'End';
    end
    studyInfo.fQuitKey=fQuitKey;

    handles.studyInfo = studyInfo;
    guidata(hObject, handles);

    if isfield(studyInfo, 'dataPath')
        yesData=1;
    else
        yesData=0;
    end
    
    if rOpts==4
        studyInfo.questSOpts=questSOpts;
    end
    
    studyInfo=wQuestionTrial(studyInfo,rOpts,yesData);
    save studyInfo.mat studyInfo
end

studyInfo.stimSStruct=stimSStruct;

if strcmp(eSInfo.startSOpts,'Default "READY" screen')
    readyStruct.text='READY';
else
    normalMessage='Please type in your start screen text';
    yesString=1;
    pause(0.1);
    readyStruct.text=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(readyStruct.text)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end
if strcmp(eSInfo.startSExitB,'Default Enter key')
    readyStruct.exitB='Return';
else
    readyStruct.exitB='space';
end

studyInfo=wReadyTrial(studyInfo,readyStruct);

studyInfo.readyStruct=readyStruct;
save studyInfo.mat studyInfo

if strcmp(eSInfo.endSOpts,'Default "End of Session" screen')
    endStruct.text='END OF SESSION';
else
    normalMessage='Please type in your end screen text';
    yesString=1;
    pause(0.1);
    endStruct.text=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(endStruct.text)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end
if strcmp(eSInfo.endSExitB,'Default Enter key')
    endStruct.exitB='Return';
else
    endStruct.exitB='space';
end

studyInfo=wEndTrial(studyInfo,endStruct);

studyInfo.endStruct=endStruct;
save studyInfo.mat studyInfo

if strcmp(eSInfo.breakSOpts,'Default screen text')
    breakStruct.text='You are on a break. Press the space bar to continue.';
else
    normalMessage=['Please type in your "Break" screen text. The default exit',...
        ' button for the "Break" screen is the "space" bar, so you might want to mention',...
        ' this in your text.'];
    yesString=1;
    pause(0.1);
    breakStruct.text=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(breakStruct.text)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif strcmp(breakStruct.text,'You are on a break. Press the space bar to continue.')
        warningMessage = 'The text you entered is the default text. Go choose "Default screen text" instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

if strcmp(eSInfo.breakSExitB,'Default Space bar')
    breakStruct.exitB='Space';
else
    normalMessage=['Please type in the KbName for your new exit button. If you don''t know',...
        ' the button''s KbName, type KbName into MATLAB command window follow by a key press',...
        ' of your new exit button. This will give you its KbName.'];
    yesString=1;
    pause(0.1);
    breakStruct.exitB=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(breakStruct.exitB)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    try
        KbName(breakStruct.exitB);
        
        if strcmpi(breakStruct.exitB,'Space')
            warningMessage = 'The KbName you entered is the default exit button. Go choose "Default Space bar" instead.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    catch
        if strcmpi(breakStruct.exitB,'Enter')
            breakStruct.exitB='Return';
        else
            warningMessage = 'The KbName you entered is invalid. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
end

studyInfo=wBreakTrial(studyInfo,breakStruct);

studyInfo.breakStruct=breakStruct;
save studyInfo.mat studyInfo

if strcmp(eSInfo.blankSOpts,'Fixed stim screen & default settings')
    blankStruct.type=stimSStruct.type;
    blankStruct.name=stimSStruct.name;
    blankStruct.duration=[1 3];
elseif strcmp(eSInfo.blankSOpts,'Fixed stim screen & customize settings')
    blankStruct.type=stimSStruct.type;
    blankStruct.name=stimSStruct.name;
    
    normalMessage=['The default fixed screen duration between stim and question(s)',...
        ' is 1 sec. What is the time duration (in sec) you would like to use instead?'];
    yesString=0;
    
    try
        pause(0.1);
        duration(1)=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
    catch
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
        
    if duration(1)>3
        warningMessage = ['Anything that is greater than 3 seconds is quite a long time',...
            ' please try again with something more reasonable that is less than 3 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration(1)<.2
        warningMessage = ['Anything that is less than .2 seconds is too short for a cushion time',...
            ' please try again with something more reasonable that is greater than .2 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration(1)==1
        normalMessage=['The default fixed screen duration between break and stim',...
            ' is 3 sec. What is the time duration (in sec) you would like to use instead.'];
        yesString=0;
        
        try
            pause(0.1);
            duration(2)=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
        catch
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if duration(2)>4
            warningMessage = ['Anything that is greater than 4 seconds is quite a long time',...
                ' please try again with something more reasonable that is less than 4 seconds.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif duration(1)<.5
            warningMessage = ['Anything that is less than .5 seconds is too short for a cushion time',...
                ' please try again with something more reasonable that is greater than .5 seconds.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif duration(2)==3
            warningMessage = ['You entered 1 for the first duration and 3 for the second duration',...
                ' which is the default values. Please go back and choose the "Fixed stim screen & default settings" instead.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['The default fixed screen duration between break and stim',...
            ' is 3 sec. What is the time duration (in sec) you would like to use instead?'];
        yesString=0;
        
        try
            pause(0.1);
            duration(2)=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
        catch
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if duration(2)>4
            warningMessage = ['Anything that is greater than 4 seconds is quite a long time',...
                ' please try again with something more reasonable that is less than 4 seconds.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif duration(1)<.5
            warningMessage = ['Anything that is less than .5 seconds is too short for a cushion time',...
                ' please try again with something more reasonable that is greater than .5 seconds.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
    end
    
    blankStruct.duration=duration;
end

studyInfo=wBlankTrial(studyInfo,blankStruct);

studyInfo.blankStruct=blankStruct;
save studyInfo.mat studyInfo

studyInfo=wMy_callback_fcn(studyInfo);
save studyInfo.mat studyInfo

studyInfo=wMy_callback_fcn1(studyInfo);
save studyInfo.mat studyInfo

if strcmp(studyInfo.signalType,'TTL')
    studyInfo=wStartNIDevice(studyInfo);
    save studyInfo.mat studyInfo
    
    studyInfo=wClearDin(studyInfo);
    save studyInfo.mat studyInfo
end

studyInfo=wESStimTrial(studyInfo);
save studyInfo.mat studyInfo

studyInfo.lastComp='write(studyInfo)';
studyInfo.nextStep='COMPLETED';

if isfield(studyInfo, 'dataPath')
    studyInfo.yesData=1;
else
    studyInfo.yesData=0;
end
save studyInfo.mat studyInfo

studyInfo=wESMainExp(studyInfo);
save studyInfo.mat studyInfo

wUserGuide(studyInfo);
save studyInfo.mat studyInfo

copyfile([pwd filesep 'bin' filesep 'check.m'],[studyInfo.path]);
copyfile([pwd filesep 'bin' filesep 'check.fig'],[studyInfo.path]);
mkdir(studyInfo.path,'sup');
copyfile([pwd filesep 'bin' filesep 'sup'],[studyInfo.path filesep 'sup']);

studyInfo.lastComp='writeEEGStudy(studyInfo)';
studyInfo.nextStep='COMPLETED';
save studyInfo.mat studyInfo

save([studyInfo.path filesep 'studyInfo.mat'],...
    'studyInfo');

handles.studyInfo=studyInfo;
guidata(hObject, handles);
close(handles.figure1);

message='CONGRATULATIONS! YOUR EXPERIMENT HAS NOW BEEN CREATED AND READY TO USE!';
pause(0.1);
messageInterface(studyInfo,message);
drawnow

delete('studyInfo.mat');

message=['Your studyInfo has been saved into your experiment folder.',...
    ' It will now be deleted from the Experiment Template folder.'];
pause(0.1);
messageInterface(studyInfo,message);
drawnow

message='GOODBYE.';
pause(0.1);
messageInterface(studyInfo,message);
drawnow

clc;


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
