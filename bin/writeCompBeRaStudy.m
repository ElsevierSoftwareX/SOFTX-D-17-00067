function varargout = writeCompBeRaStudy(varargin)
% WRITECOMPBERASTUDY MATLAB code for writeCompBeRaStudy.fig
%   function writeCompBeRaStudy
%
%   This writeCompBeRaStudy GUI is the study specific GUI and last step
%   to creating a Comparison Behavioral Rating Study experiment. Here you 
%   will choose various options to finalize the setup for your Comparison
%   Behavioral Rating Study experiment. For better instructions and details 
%   on each of these options please use the AudExpCreator User's Guide as 
%   this space is limited and cannot adequately provide the needed 
%   explanation. 
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help writeCompBeRaStudy

% Last Modified by GUIDE v2.5 12-Jun-2017 23:46:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @writeCompBeRaStudy_OpeningFcn, ...
                   'gui_OutputFcn',  @writeCompBeRaStudy_OutputFcn, ...
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


% --- Executes just before writeCompBeRaStudy is made visible.
function writeCompBeRaStudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to writeCompBeRaStudy (see VARARGIN)

% Choose default command line output for writeCompBeRaStudy
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

ratingOpts{1}='Mouse control: slider scale';
ratingOpts{2}='Mouse control: screen click';
set(handles.popupmenu1,'String',ratingOpts);

stimNameOpts{1}='Stim names: "1st Stim" & "2nd Stim"';
stimNameOpts{2}='Stim names: "Excerpt A" & "Excerpt B"';
stimNameOpts{3}='Stim names via grouping selection';
stimNameOpts{4}='Customized stim names';
set(handles.popupmenu2,'String',stimNameOpts);

questOpts{1}='Same question(s) for all pairs';
set(handles.popupmenu3,'String',questOpts);

breakSOpts{1}='Default screen text & exit button';
breakSOpts{2}='Customize screen text only';
breakSOpts{3}='Customize exit button only';
breakSOpts{4}='Customize both text & exit button';
set(handles.popupmenu4,'String',breakSOpts);

startSOpts{1}='Default "READY" screen';
startSOpts{2}='Customize screen text';
set(handles.popupmenu5,'String',startSOpts);

startSExitB{1}='Default Enter key';
startSExitB{2}='Alternative Space bar';
set(handles.popupmenu6,'String',startSExitB);

endSOpts{1}='Default "End of Session" screen';
endSOpts{2}='Customize screen text';
set(handles.popupmenu7,'String',endSOpts);

endSExitB{1}='Default Enter key';
endSExitB{2}='Alternative Space bar';
set(handles.popupmenu8,'String',endSExitB);

blankSOpts{1}='Fixed blank screen & default settings';
blankSOpts{2}='Fixed blank screen & customize settings';
set(handles.popupmenu9,'String',blankSOpts);

forceQExitB{1}='Default Esc key';
forceQExitB{2}='Alternative End key';
set(handles.popupmenu10,'String',forceQExitB);

guidata(hObject, handles);
% UIWAIT makes writeCompBeRaStudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = writeCompBeRaStudy_OutputFcn(hObject, eventdata, handles) 
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
handles.ratingOpts = selectedType;

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
handles.stimNameOpts = selectedType;

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
handles.questOpts = selectedType;

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
handles.breakSOpts = selectedType;

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
handles.startSOpts = selectedType;

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
handles.startSExitB = selectedType;

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
handles.endSOpts = selectedType;

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
handles.endSExitB = selectedType;

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
    compSInfo.ratingOpts = handles.ratingOpts;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    compSInfo.ratingOpts=content{selected};
end

try
    compSInfo.stimNameOpts = handles.stimNameOpts;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    compSInfo.stimNameOpts=content{selected};
end

try
    compSInfo.questOpts = handles.questOpts;
catch
    content=get(handles.popupmenu3,'String');
    selected=get(handles.popupmenu3,'Value');
    compSInfo.questOpts=content{selected};
end

try
    compSInfo.breakSOpts = handles.breakSOpts;
catch
    content=get(handles.popupmenu4,'String');
    selected=get(handles.popupmenu4,'Value');
    compSInfo.breakSOpts=content{selected};
end

try
    compSInfo.startSOpts = handles.startSOpts;
catch
    content=get(handles.popupmenu5,'String');
    selected=get(handles.popupmenu5,'Value');
    compSInfo.startSOpts=content{selected};
end

try
    compSInfo.startSExitB = handles.startSExitB;
catch
    content=get(handles.popupmenu6,'String');
    selected=get(handles.popupmenu6,'Value');
    compSInfo.startSExitB=content{selected};
end

try
    compSInfo.endSOpts = handles.endSOpts;
catch
    content=get(handles.popupmenu7,'String');
    selected=get(handles.popupmenu7,'Value');
    compSInfo.endSOpts=content{selected};
end

try
    compSInfo.endSExitB = handles.endSExitB;
catch
    content=get(handles.popupmenu8,'String');
    selected=get(handles.popupmenu8,'Value');
    compSInfo.endSExitB=content{selected};
end

try
    compSInfo.blankSOpts = handles.blankSOpts;
catch
    content=get(handles.popupmenu9,'String');
    selected=get(handles.popupmenu9,'Value');
    compSInfo.blankSOpts=content{selected};
end

try
    compSInfo.forceQExitB = handles.forceQExitB;
catch
    content=get(handles.popupmenu10,'String');
    selected=get(handles.popupmenu10,'Value');
    compSInfo.forceQExitB=content{selected};
end

studyInfo.compSInfo = compSInfo;

save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if strcmp(compSInfo.ratingOpts,'Mouse control: slider scale')
    rOpts=3;
elseif strcmp(compSInfo.ratingOpts,'Mouse control: screen click')
    rOpts=5;
end

if strcmp(compSInfo.stimNameOpts,'Stim names: "1st Stim" & "2nd Stim"')
    stimNStruct.stimAText='1st Stim';
    stimNStruct.stimBText='2nd Stim';
elseif strcmp(compSInfo.stimNameOpts,'Stim names: "Excerpt A" & "Excerpt B"')
    stimNStruct.stimAText='Excerpt A';
    stimNStruct.stimBText='Excerpt B';
elseif strcmp(compSInfo.stimNameOpts,'Stim names via grouping selection')
    [~, ~, ~, groupName]=getGroups(studyInfo,uniSpecs);
    if isempty(groupName)==1
        warningMessage = 'You exit before selecting. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    stimNStruct.stimAText=groupName{1};
    stimNStruct.stimBText=groupName{2};
elseif strcmp(compSInfo.stimNameOpts,'Customized stim names')
    normalMessage='Please type a name for the 1st stim.';
    yesString=1;
    pause(0.1);
    stimNStruct.stimAText=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(stimNStruct.stimAText)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage='Please type a name for the 2nd stim.';
    yesString=1;
    pause(0.1);
    stimNStruct.stimBText=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(stimNStruct.stimBText)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

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
    normalMessage = 'Let''s get some question info for all your pairs.';
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
        
    end
    
    for i=1:studyInfo.stimNum
        qStruct(i).trigger=studyInfo.stimStruct(i).trigger;
        qStruct(i).qNum=qNum;
        qStruct(i).question=question;
        qStruct(i).qLow = stimNStruct.stimAText;
        qStruct(i).qHigh = stimNStruct.stimBText;
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

studyInfo.stimInSet = 2;

studyInfo = wBuildStimWavSeq(studyInfo);
save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if strcmp(compSInfo.forceQExitB,'Default Esc key')
    fQuitKey = 'ESCAPE';
else
    fQuitKey = 'End';
end
studyInfo.fQuitKey=fQuitKey;

yesData=1;

studyInfo.stimNStruct=stimNStruct;
save studyInfo.mat studyInfo

studyInfo=wQuestionTrial(studyInfo,rOpts,yesData);
save studyInfo.mat studyInfo


if strcmp(compSInfo.breakSOpts,'Default screen text & exit button')
    breakStruct.text='You are on a break. Press the space bar to continue.';
    breakStruct.exitB='Space';

elseif strcmp(compSInfo.breakSOpts,'Customize screen text only')
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
    end
    breakStruct.exitB='Space';

elseif  strcmp(compSInfo.breakSOpts,'Customize exit button only')
    breakStruct.text='You are on a break. Press the space bar to continue.';
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
    catch
        if strcmpi(breakStruct.exitB,'Enter')
            breakStruct.exitB='Return';
        elseif strcmpi(breakStruct.exitB,'Space')
            warningMessage = 'The KbName you entered was already the default. Go and select "Default screen text & exit button" instead.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'The KbName you entered is invalid. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
        
elseif strcmp(compSInfo.breakSOpts,'Customize both text & exit button')
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
    end
    
    if strcmp(breakStruct.text,'You are on a break. Press the space bar to continue.')
        A=1;
    else
        A=0;
    end
    
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
        B=0;
    catch
        if strcmpi(breakStruct.exitB,'Enter')
            breakStruct.exitB='Return';
            B=0;
        elseif strcmpi(breakStruct.exitB,'Space')
            B=1;
        else
            warningMessage = 'The KbName you entered is invalid. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    if A==1 && B==1
        warningMessage = 'You''ve used both default text and exit botton. Go back and select "Default screen text & exit button" instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif A==1 && B==0
        warningMessage = 'You''ve used the default text. Go back and select "Customize exit button only" instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif A==0 && B==1
        warningMessage = 'You''ve used the default exit button. Go back and select "Customize screen text only';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

studyInfo=wBreakTrial(studyInfo,breakStruct);
studyInfo.breakStruct=breakStruct;
save studyInfo.mat studyInfo

if strcmp(compSInfo.startSOpts,'Default "READY" screen')
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
if strcmp(compSInfo.startSExitB,'Default Enter key')
    readyStruct.exitB='Return';
else
    readyStruct.exitB='space';
end

studyInfo=wReadyTrial(studyInfo,readyStruct);

studyInfo.readyStruct=readyStruct;
save studyInfo.mat studyInfo


if strcmp(compSInfo.endSOpts,'Default "End of Session" screen')
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
if strcmp(compSInfo.endSExitB,'Default Enter key')
    endStruct.exitB='Return';
else
    endStruct.exitB='space';
end

studyInfo=wEndTrial(studyInfo,endStruct);

studyInfo.endStruct=endStruct;
save studyInfo.mat studyInfo

if strcmp(compSInfo.blankSOpts,'Fixed blank screen & default settings')
    blankStruct.text=' ';
    blankStruct.duration=[.5 1];
elseif strcmp(compSInfo.blankSOpts,'Fixed blank screen & customize settings')
    blankStruct.text=' ';

    normalMessage=['The default fixed screen duration between 1st stim and 2nd stim',...
        ' is .5 sec. What is the time duration (in sec) you would like to use instead?'];
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
        
    if duration(1)>2
        warningMessage = ['Anything that is greater than 2 seconds is quite a long time',...
            ' please try again with something more reasonable that is less than 2 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration(1)<.2
        warningMessage = ['Anything that is less than .1 seconds is too short for a cushion time',...
            ' please try again with something more reasonable that is greater than .1 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration(1)==.5
        normalMessage=['The default fixed screen duration between break and noise stim',...
            ' is 1 sec. What is the time duration (in sec) you would like to use instead.'];
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
        
        if duration(2)>3
            warningMessage = ['Anything that is greater than 3 seconds is quite a long time',...
                ' please try again with something more reasonable that is less than 3 seconds.'];
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
        elseif duration(2)==1
            warningMessage = ['You entered .5 for the first duration and 1 for the second duration',...
                ' which are the default values. Please go back and choose the "Fixed blank screen & default settings" instead.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['The default fixed screen duration between break and noise stim',...
            ' is 1 sec. What is the time duration (in sec) would you like to use instead?'];
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
        
        if duration(2)>3
            warningMessage = ['Anything that is greater than 3 seconds is quite a long time',...
                ' please try again with something more reasonable that is less than 3 seconds.'];
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

studyInfo=wCompSStimTrial(studyInfo);
save studyInfo.mat studyInfo

if isfield(studyInfo, 'dataPath')
    studyInfo.yesData=1;
else
    studyInfo.yesData=0;
end
save studyInfo.mat studyInfo

studyInfo=wCompSMainExp(studyInfo);
save studyInfo.mat studyInfo

wUserGuide(studyInfo);
save studyInfo.mat studyInfo

copyfile([pwd filesep 'bin' filesep 'check.m'],[studyInfo.path]);
copyfile([pwd filesep 'bin' filesep 'check.fig'],[studyInfo.path]);
mkdir(studyInfo.path,'sup');
copyfile([pwd filesep 'bin' filesep 'sup'],[studyInfo.path filesep 'sup']);

studyInfo.lastComp='writeCompBeRaStudy(studyInfo)';
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
