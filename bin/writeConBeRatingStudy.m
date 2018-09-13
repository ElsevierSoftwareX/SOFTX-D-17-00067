function varargout = writeConBeRatingStudy(varargin)
% WRITECONBERATINGSTUDY MATLAB code for writeConBeRatingStudy.fig
%   function writeConBeRatingStudy
%
%   This writeConBeRatingStudy GUI is the study specific GUI and last step
%   to creating a Continuous Behavioral Rating Study experiment. Here you 
%   will choose various options to finalize the setup for your Continuous
%   Behavioral Rating Study experiment. For better instructions and details 
%   on each of these options please use the AudExpCreator User's Guide as 
%   this space is limited and cannot adequately provide the needed 
%   explanation. 
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help writeConBeRatingStudy

% Last Modified by GUIDE v2.5 07-Jun-2017 19:48:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @writeConBeRatingStudy_OpeningFcn, ...
    'gui_OutputFcn',  @writeConBeRatingStudy_OutputFcn, ...
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


% --- Executes just before writeConBeRatingStudy is made visible.
function writeConBeRatingStudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to writeConBeRatingStudy (see VARARGIN)

% Choose default command line output for writeConBeRatingStudy
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

instimOpts{1}='Same stim instruction for every stim';
instimOpts{2}='Different stim instruction based on groups';
instimOpts{3}='Different stim instruction for every stim';
set(handles.popupmenu1,'String',instimOpts);

questOpts{1}='No end question(s)';
questOpts{2}='Same question(s) for every stim';
questOpts{3}='Different question(s) based on groups';
questOpts{4}='Different question(s) for every stim';
set(handles.popupmenu2,'String',questOpts);

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

prepSOpts{1}='Default screen text';
prepSOpts{2}='Customize screen text';
set(handles.popupmenu3,'String',prepSOpts);

fixedSOpts{1}='Default screen settings';
fixedSOpts{2}='Customize screen settings';
set(handles.popupmenu4,'String',fixedSOpts);

blankSOpts{1}='Blank screen & default settings';
blankSOpts{2}='Blank screen & customize settings';
set(handles.popupmenu9,'String',blankSOpts);

forceQExitB{1}='Default Esc key';
forceQExitB{2}='Alternative End key';
set(handles.popupmenu10,'String',forceQExitB);

guidata(hObject, handles);
% UIWAIT makes writeConBeRatingStudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = writeConBeRatingStudy_OutputFcn(hObject, eventdata, handles)
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
handles.instimOpts = selectedType;

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
handles.prepSOpts = selectedType;

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
handles.fixedSOpts = selectedType;

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
    coBeInfo.instimOpts = handles.instimOpts;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    coBeInfo.instimOpts=content{selected};
end

try
    coBeInfo.questOpts = handles.questOpts;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    coBeInfo.questOpts=content{selected};
end

try
    coBeInfo.prepSOpts = handles.prepSOpts;
catch
    content=get(handles.popupmenu3,'String');
    selected=get(handles.popupmenu3,'Value');
    coBeInfo.prepSOpts=content{selected};
end

try
    coBeInfo.fixedSOpts = handles.fixedSOpts;
catch
    content=get(handles.popupmenu4,'String');
    selected=get(handles.popupmenu4,'Value');
    coBeInfo.fixedSOpts=content{selected};
end

try
    coBeInfo.startSOpts = handles.startSOpts;
catch
    content=get(handles.popupmenu5,'String');
    selected=get(handles.popupmenu5,'Value');
    coBeInfo.startSOpts=content{selected};
end

try
    coBeInfo.startSExitB = handles.startSExitB;
catch
    content=get(handles.popupmenu6,'String');
    selected=get(handles.popupmenu6,'Value');
    coBeInfo.startSExitB=content{selected};
end

try
    coBeInfo.endSOpts = handles.endSOpts;
catch
    content=get(handles.popupmenu7,'String');
    selected=get(handles.popupmenu7,'Value');
    coBeInfo.endSOpts=content{selected};
end

try
    coBeInfo.endSExitB = handles.endSExitB;
catch
    content=get(handles.popupmenu8,'String');
    selected=get(handles.popupmenu8,'Value');
    coBeInfo.endSExitB=content{selected};
end

try
    coBeInfo.blankSOpts = handles.blankSOpts;
catch
    content=get(handles.popupmenu9,'String');
    selected=get(handles.popupmenu9,'Value');
    coBeInfo.blankSOpts=content{selected};
end

try
    coBeInfo.forceQExitB = handles.forceQExitB;
catch
    content=get(handles.popupmenu10,'String');
    selected=get(handles.popupmenu10,'Value');
    coBeInfo.forceQExitB=content{selected};
end

studyInfo.coBeInfo = coBeInfo;

save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if isfield(studyInfo, 'insStruct')==1 && ~isempty(studyInfo.insStruct)==1
    normalMessage=sprintf(['It seems that you already have an stim instruction structure built.',...
        ' Do you want to replace it and build a different one? (Type ''yes'' or ''no''.)']);
    yesString=1;
    pause(0.1);
    reBuildinstimStruct=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(reBuildinstimStruct)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(reBuildinstimStruct,'yes')
        buildInstStruct=1;
    elseif strcmpi(reBuildinstimStruct,'no')
        buildInstStruct=0;
    else
        warningMessage = 'You did not give an acceptable answer. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
else
    buildInstStruct=1;
end

if buildInstStruct
    if strcmp(coBeInfo.instimOpts, 'Same stim instruction for every stim')
        
        normalMessage = ['Let''s set the stim instruction and its parameters for all',...
            ' your stims in order to build your stim instruction structure.'];
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
        normalMessage=sprintf(['Please type the stim instruction for all your stims.',...
            '\nExample: "Rate your level of engagement as the excerpt plays."']);
        yesString=1;
        pause(0.1);
        instruction=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(instruction)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        normalMessage=sprintf(['Please identify the main topic of your stim instruction.',...
            '\nExample: "Rate your level of engagement as the excerpt plays." ',...
            ' Main topic = "engagement".']);
        yesString=1;
        pause(0.1);
        task=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(task)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        normalMessage=sprintf(['Please define the main topic of your stim instruction.',...
            '\nPlease format the definition like the example below.',...
            '\nExample: "Engagement - being compelled, drawn in, connected to what is happening,',...
            ' and interested in what will happen next."']);
        yesString=1;
        pause(0.1);
        definition=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(definition)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        normalMessage=sprintf(['Please identify the low point of your stim instruction.',...
            '\nExample: "Rate your level of engagement as the excerpt plays." ',...
            ' Low point = "Not at all".']);
        yesString=1;
        pause(0.1);
        insLow=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(insLow)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        normalMessage=sprintf(['Please identify the high point of your stim instruction.',...
            '\nExample: "Rate your level of engagement as the excerpt plays." ',...
            ' High point = "Very engaged".']);
        yesString=1;
        pause(0.1);
        insHigh=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(insHigh)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        for i=1:studyInfo.stimNum
            insStruct(i).trigger=studyInfo.stimStruct(i).trigger;
            insStruct(i).task=task;
            insStruct(i).definition=definition;
            insStruct(i).instruction=instruction;
            insStruct(i).insLow = insLow;
            insStruct(i).insHigh = insHigh;
        end
        
    elseif strcmp(coBeInfo.instimOpts, 'Different stim instruction based on groups')
        normalMessage = 'First, let''s define the stimulus groups for your stim instructions.';
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
        
        normalMessage = sprintf(['Now let''s set stim instructions and their parameters',...
            ' for your specified groups %s in order to build your stim instruction structure.'], groupBy);
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
        for k=1:gNum
            normalMessage=sprintf(['For your "%s" stims:',...
                '\nPlease type the stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays."'], groupName{k});
            yesString=1;
            pause(0.1);
            instruction=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(instruction)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your "%s" stims:',...
                '\nPlease identify the main topic of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' Main topic = "engagement".'], groupName{k});
            yesString=1;
            pause(0.1);
            task=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(task)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your "%s" stims:',...
                '\nPlease define the main topic of your stim instruction.',...
                '\nPlease format the definition like the example below.',...
                '\nExample: "Engagement - being compelled, drawn in, connected to what is happening,',...
                ' and interested in what will happen next."'], groupName{k});
            yesString=1;
            pause(0.1);
            definition=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(definition)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your "%s" stims:',...
                '\nPlease identify the low point of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' Low point = "Not at all".'], groupName{k});
            yesString=1;
            pause(0.1);
            insLow=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(insLow)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your "%s" stims:',...
                '\nPlease identify the high point of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' High point = "Very engaged".'], groupName{k});
            yesString=1;
            pause(0.1);
            insHigh=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(insHigh)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end

            for i=1:length(group{k})
                indxStim = group{k}(i);
                insStruct(indxStim).trigger=studyInfo.stimStruct(indxStim).trigger;
                insStruct(indxStim).task=task;
                insStruct(indxStim).definition=definition;
                insStruct(indxStim).instruction=instruction;
                insStruct(indxStim).insLow = insLow;
                insStruct(indxStim).insHigh = insHigh;
            end
            clear task definition instruction insLow insHigh
        end
        
    elseif strcmp(coBeInfo.instimOpts, 'Different stim instruction for every stim')
        
        normalMessage = ['Let''s set the stim instruction and its parameters for each of',...
            ' your stims in order to build your stim instruction structure.'];
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
        for k=1:studyInfo.stimNum
            normalMessage=sprintf(['For your stim #d:',...
                '\nPlease type the stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays."'], k);
            yesString=1;
            pause(0.1);
            instruction=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(instruction)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your stim #d:',...
                '\nPlease identify the main topic of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' Main topic = "engagement".'], k);
            yesString=1;
            pause(0.1);
            task=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(task)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your stim #d:',...
                '\nPlease define the main topic of your stim instruction.',...
                '\nPlease format the definition like the example below.',...
                '\nExample: "Engagement - being compelled, drawn in, connected to what is happening,',...
                ' and interested in what will happen next."'], k);
            yesString=1;
            pause(0.1);
            definition=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(definition)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your stim #d:',...
                '\nPlease identify the low point of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' Low point = "Not at all".'], k);
            yesString=1;
            pause(0.1);
            insLow=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(insLow)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['For your stim #d:',...
                '\nPlease identify the high point of your stim instruction.',...
                '\nExample: "Rate your level of engagement as the excerpt plays." ',...
                ' High point = "Very engaged".'], k);
            yesString=1;
            pause(0.1);
            insHigh=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(insHigh)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            insStruct(k).trigger=studyInfo.stimStruct(k).trigger;
            insStruct(k).task=task;
            insStruct(k).definition=definition;
            insStruct(k).instruction=instruction;
            insStruct(k).insLow = insLow;
            insStruct(k).insHigh = insHigh;
            
            clear task definition instruction insLow insHigh
            
        end
    end
    
    studyInfo.insStruct = insStruct;
    
    studyInfo.insStructName=sprintf('%sInsStruct', studyInfo.name);
    eval([studyInfo.insStructName '= studyInfo.insStruct;']);
    save([studyInfo.path filesep studyInfo.insStructName '.mat'],...
        studyInfo.insStructName);
    
    save studyInfo.mat studyInfo
    
    normalMessage = sprintf('Your stim instruction structure was compiled and saved.');
    pause(0.1);
    messageInterface(studyInfo,normalMessage);
    drawnow
    
end

if strcmp(coBeInfo.questOpts,'No end question(s)')
    if isfield(studyInfo, 'qStruct')==1 || isfield(studyInfo, 'qStructName')==1 || isfield(studyInfo, 'qSettings')==1
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
            
            studyInfo=rmfield(studyInfo,{'qStruct','qStructName','qSettings'});
            studyInfo.fLine=rmfield(studyInfo.fLine,'qTrial');
            save studyInfo.mat studyInfo
            
        elseif strcmpi(remQStruct,'no')
            warningMessage = sprintf('Please go back and choose a different option \nother than "No end question(s)".');
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

    studyInfo = wBuildStimWavSeq(studyInfo);
    save studyInfo.mat studyInfo
    
    if strcmp(coBeInfo.forceQExitB,'Default Esc key')
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
    ratingOpts=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow

    if isempty(ratingOpts)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmp(ratingOpts,'9 scale')
        coBeInfo.ratingOpts='Key press: 1-9 scale';
        rOpts=1;
    elseif strcmp(ratingOpts,'5 scale')
        coBeInfo.ratingOpts='Key press: 1-5 scale';
        rOpts=2;
    elseif strcmp(ratingOpts,'slider scale')
        coBeInfo.ratingOpts='Mouse control: slider scale';
        rOpts=3;
    elseif strcmp(ratingOpts,'nth scale')
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
    
    studyInfo.coBeInfo = coBeInfo;
    
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
        if strcmp(coBeInfo.questOpts,'Same question(s) for every stim')
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
            
        elseif strcmp(coBeInfo.questOpts,'Different question(s) based on groups')
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
            
        elseif strcmp(coBeInfo.questOpts,'Different question(s) for every stim')
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
        ' If so you might want to set',...
        ' question(s) to appear after a certain number of stims to fit your sets. Please answer',...
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
        normalMessage=sprintf(['How many stims are in each your sets (i.e. after how many stims',...
            ' would you like to present the questions)? Please make sure that this reflects',...
            ' your stim array (i.e. there is an evenly division of sets for recording sessions,',...
            ' presentations, etc.).']);
        yesString=0;
        pause(0.1);
        qSettings=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(qSettings)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif qSettings==0
            warningMessage = '"0" is an invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif qSettings==1
            warningMessage = ['"1" stimulus does not consitute a stimulus set. Please go back,'...
                ' and type in "no" for the question asking you if your stims are in a set.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif rem(studyInfo.stimPerRec,qSettings)~=0
            warningMessage = sprintf(['The %d stims in your stim array per recording session was not evenly',...
                ' divided into "%d" sets. Please try over again.'], studyInfo.stimPerRec, qSettings);
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
    elseif strcmpi(yesSet,'no')
        qSettings = 1;
    else
        warningMessage = 'You entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    studyInfo.qSettings = qSettings;
    
    studyInfo = wBuildStimWavSeq(studyInfo);
    save studyInfo.mat studyInfo
    
    if strcmp(coBeInfo.forceQExitB,'Default Esc key')
        fQuitKey = 'ESCAPE';
    else
        fQuitKey = 'End';
    end
    studyInfo.fQuitKey=fQuitKey;

    handles.studyInfo = studyInfo;
    guidata(hObject, handles);

    yesData=1;
    
    if rOpts==4
        studyInfo.questSOpts=questSOpts;
    end

    studyInfo=wQuestionTrial(studyInfo,rOpts,yesData);
    save studyInfo.mat studyInfo
end

if strcmp(coBeInfo.startSOpts,'Default "READY" screen')
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
if strcmp(coBeInfo.startSExitB,'Default Enter key')
    readyStruct.exitB='Return';
else
    readyStruct.exitB='space';
end

studyInfo=wReadyTrial(studyInfo,readyStruct);

studyInfo.readyStruct=readyStruct;
save studyInfo.mat studyInfo


if strcmp(coBeInfo.endSOpts,'Default "End of Session" screen')
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
if strcmp(coBeInfo.endSExitB,'Default Enter key')
    endStruct.exitB='Return';
else
    endStruct.exitB='space';
end

studyInfo=wEndTrial(studyInfo,endStruct);

studyInfo.endStruct=endStruct;
save studyInfo.mat studyInfo


if strcmp(coBeInfo.prepSOpts,'Default screen text')
    prepSStruct.text{1}='Reposition your right hand over the mouse.';
    prepSStruct.text{2}='Using your left hand, press the space bar when you are ready to start the task.';
    prepSStruct.exitB='Space';
else
    normalMessage = ['The prep screen has two default texts to help prep the subject before the stim is presented.',...
        ' The first text: "Reposition your right hand over the mouse."',...
        ' The second text: "Using your left hand, press the space bar when you are ready to start the task."',...
        ' Please be prepared to enter two new texts to replace these two default texts.'];
    pause(0.1);
    messageInterface(studyInfo,normalMessage);
    drawnow
    
    for i=1:2
        normalMessage=sprintf('Please enter new prep text #%d:', i);
        yesString=1;
        pause(0.1);
        prepSStruct.text{i}=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        if isempty(prepSStruct.text{i})==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    prepSStruct.exitB='Space';
end

studyInfo=wPrepTrial(studyInfo,prepSStruct);

studyInfo.prepSStruct=prepSStruct;
save studyInfo.mat studyInfo

if strcmp(coBeInfo.fixedSOpts,'Default screen settings')
    fixedSStruct.duration=3;
elseif strcmp(coBeInfo.fixedSOpts,'Customize screen settings')
     normalMessage=['The default fixed screen duration between prep and stim',...
        ' is 3 sec. What is the time duration (in sec) you would like to use instead?'];
    yesString=0;
    pause(0.1);
    duration=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(duration)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if duration>5
        warningMessage = ['Anything that is greater than 5 seconds is quite a long time',...
            ' please try again with something more reasonable that is less than 5 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration<1
        warningMessage = ['Anything that is less than 1 seconds is too short for a cushion time',...
            ' please try again with something more reasonable that is greater than .2 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration==3
        warningMessage = ['You entered 3 for the fixed screen duration',...
            ' which is the default value. Please go back and choose the "Default screen settings" instead.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    fixedSStruct.duration=duration;
end

studyInfo=wfixedSliderTrial(studyInfo);

studyInfo.fixedSStruct=fixedSStruct;
save studyInfo.mat studyInfo

if strcmp(coBeInfo.blankSOpts,'Blank screen & default settings')
    blankStruct.text=' ';
    blankStruct.duration=[.5 1];
elseif strcmp(coBeInfo.blankSOpts,'Blank screen & customize settings')
    blankStruct.text=' ';
    
    normalMessage=['The default blank screen duration between stim and questions, and',...
        ' between question and question is .5 sec. What is the time duration (in sec) you would like to use instead?'];
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
        warningMessage = ['Anything that is less than .2 seconds is too short for a cushion time',...
            ' please try again with something more reasonable that is greater than .2 seconds.'];
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif duration(1)==.5
        normalMessage=['The default blank screen duration between break and stim, and',...
            ' after question to stim is 1 sec. What is the time duration (in sec) you would like to use instead.'];
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
        elseif duration(1)<.2
            warningMessage = ['Anything that is less than .2 seconds is too short for a cushion time',...
                ' please try again with something more reasonable that is greater than .2 seconds.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif duration(2)==1
            warningMessage = ['You entered .5 for the first duration and 1 for the second duration',...
                ' which is the default values. Please go back and choose the "Blank screen & customize settings" instead.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['The default blank screen duration between break and stim, and',...
            ' after question to stim is 1 sec. What is the time duration (in sec) would you like to use instead?'];
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
        elseif duration(1)<.2
            warningMessage = ['Anything that is less than .2 seconds is too short for a cushion time',...
                ' please try again with something more reasonable that is greater than .2 seconds.'];
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

insSStruct.exitB='Space';

studyInfo=wInstructionTrial(studyInfo,insSStruct);
studyInfo.insSStruct=insSStruct;
save studyInfo.mat studyInfo

studyInfo=wCoBeStimTrial(studyInfo);
save studyInfo.mat studyInfo

studyInfo.yesData=1;

studyInfo=wCoBeMainExp(studyInfo);
save studyInfo.mat studyInfo

wUserGuide(studyInfo);
save studyInfo.mat studyInfo

copyfile([pwd filesep 'bin' filesep 'check.m'],[studyInfo.path]);
copyfile([pwd filesep 'bin' filesep 'check.fig'],[studyInfo.path]);
mkdir(studyInfo.path,'sup');
copyfile([pwd filesep 'bin' filesep 'sup'],[studyInfo.path filesep 'sup']);

studyInfo.lastComp='writeConBeRatingStudy(studyInfo)';
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
