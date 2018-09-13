function varargout = writeBehavRatingStudy(varargin)
% WRITEBEHAVRATINGSTUDY MATLAB code for writeBehavRatingStudy.fig
%   function writeBehavRatingStudy
%
%   This writeBehavRatingStudy GUI is the study specific GUI and last step
%   to creating a Behavioral Rating Study experiment. Here you will choose
%   various options to finalize the setup for your Behavioral Rating Study
%   experiment. For better instructions and details on each of these
%   options please use the AudExpCreator User's Guide as this space is
%   limited and cannot adequately provide the needed explanation. 
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help writeBehavRatingStudy

% Last Modified by GUIDE v2.5 08-May-2017 20:38:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @writeBehavRatingStudy_OpeningFcn, ...
    'gui_OutputFcn',  @writeBehavRatingStudy_OutputFcn, ...
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


% --- Executes just before writeBehavRatingStudy is made visible.
function writeBehavRatingStudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to writeBehavRatingStudy (see VARARGIN)

% Choose default command line output for writeBehavRatingStudy
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

ratingOpts{1}='Key press: 1-9 scale';
ratingOpts{2}='Key press: 1-5 scale';
ratingOpts{3}='Key press: 1-nth scale';
ratingOpts{4}='Mouse control: slider scale';
set(handles.popupmenu11,'String',ratingOpts);

questOpts{1}='Same question(s) for every stim';
questOpts{2}='Different question(s) based on groups';
questOpts{3}='Different question(s) for every stim';
set(handles.popupmenu2,'String',questOpts);

startSOpts{1}='Default "READY" screen';
startSOpts{2}='Customize screen text';
set(handles.popupmenu3,'String',startSOpts);

startSExitButton{1}='Default Enter key';
startSExitButton{2}='Alternative Space bar';
set(handles.popupmenu4,'String',startSExitButton);

endSOpts{1}='Default "End of Session" screen';
endSOpts{2}='Customize screen text';
set(handles.popupmenu5,'String',endSOpts);

endSExitButton{1}='Default Enter key';
endSExitButton{2}='Alternative Space bar';
set(handles.popupmenu6,'String',endSExitButton);

breakSOpts{1}='Default break text & exit button';
breakSOpts{2}='Customize break text only';
breakSOpts{3}='Customize exit button only';
breakSOpts{4}='Customize both text & exit button';
breakSOpts{5}='No "Break" Screen';
set(handles.popupmenu7,'String',breakSOpts);

stimSOpts{1}='Default "Listen" screen';
stimSOpts{2}='Customize screen text';
set(handles.popupmenu8,'String',stimSOpts);

blankSOpts{1}='Blank screen & default settings';
blankSOpts{2}='Stim screen & default settings';
blankSOpts{3}='Blank screen & customize settings';
blankSOpts{4}='Stim screen & customize settings';
set(handles.popupmenu9,'String',blankSOpts);

forceQExitButton{1}='Default Esc key';
forceQExitButton{2}='Alternative End key';
set(handles.popupmenu10,'String',forceQExitButton);

guidata(hObject, handles);

% UIWAIT makes writeBehavRatingStudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = writeBehavRatingStudy_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=[];
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11
content=get(handles.popupmenu11,'String');
selected=get(handles.popupmenu11,'Value');

selectedType=content{selected};
handles.ratingOpts = selectedType;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
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
handles.startSExitButton = selectedType;

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
handles.endSExitButton = selectedType;

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
handles.stimSOpts = selectedType;

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
handles.forceQExitButton = selectedType;

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
    beRaInfo.ratingOpts = handles.ratingOpts;
catch
    content=get(handles.popupmenu11,'String');
    selected=get(handles.popupmenu11,'Value');
    beRaInfo.ratingOpts=content{selected};
end

try
    beRaInfo.questOpts = handles.questOpts;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    beRaInfo.questOpts=content{selected};
end

try
    beRaInfo.startSOpts = handles.startSOpts;
catch
    content=get(handles.popupmenu3,'String');
    selected=get(handles.popupmenu3,'Value');
    beRaInfo.startSOpts=content{selected};
end

try
    beRaInfo.startSExitButton = handles.startSExitButton;
catch
    content=get(handles.popupmenu4,'String');
    selected=get(handles.popupmenu4,'Value');
    beRaInfo.startSExitButton=content{selected};
end

try
    beRaInfo.endSOpts = handles.endSOpts;
catch
    content=get(handles.popupmenu5,'String');
    selected=get(handles.popupmenu5,'Value');
    beRaInfo.endSOpts=content{selected};
end

try
    beRaInfo.endSExitButton = handles.endSExitButton;
catch
    content=get(handles.popupmenu6,'String');
    selected=get(handles.popupmenu6,'Value');
    beRaInfo.endSExitButton=content{selected};
end

try
    beRaInfo.breakSOpts = handles.breakSOpts;
catch
    content=get(handles.popupmenu7,'String');
    selected=get(handles.popupmenu7,'Value');
    beRaInfo.breakSOpts=content{selected};
end

try
    beRaInfo.stimSOpts = handles.stimSOpts;
catch
    content=get(handles.popupmenu8,'String');
    selected=get(handles.popupmenu8,'Value');
    beRaInfo.stimSOpts=content{selected};
end

try
    beRaInfo.blankSOpts = handles.blankSOpts;
catch
    content=get(handles.popupmenu9,'String');
    selected=get(handles.popupmenu9,'Value');
    beRaInfo.blankSOpts=content{selected};
end

try
    beRaInfo.forceQExitButton = handles.forceQExitButton;
catch
    content=get(handles.popupmenu10,'String');
    selected=get(handles.popupmenu10,'Value');
    beRaInfo.forceQExitButton=content{selected};
end

studyInfo.beRaInfo = beRaInfo;

save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if strcmp(beRaInfo.ratingOpts, 'Key press: 1-9 scale')
    rOpts=1;
elseif strcmp(beRaInfo.ratingOpts, 'Key press: 1-5 scale')
    rOpts=2;
elseif strcmp(beRaInfo.ratingOpts, 'Key press: 1-nth scale')

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
    
elseif strcmp(beRaInfo.ratingOpts, 'Mouse control: slider scale')
    rOpts=3;
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
    if strcmp(beRaInfo.questOpts,'Same question(s) for every stim')
        normalMessage = 'Let''s get some question info for all your stim.';
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
        normalMessage='How many questions will there be?';
        yesString=0;
        pause(0.1)
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
        
    elseif strcmp(beRaInfo.questOpts,'Different question(s) based on groups')
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
        
    elseif strcmp(beRaInfo.questOpts,'Different question(s) for every stim')
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
    ' If they are questions will be presented after your sets instead of after every stim. Please answer',...
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

studyInfo = wBuildStimWavSeq(studyInfo);
save studyInfo.mat studyInfo

handles.studyInfo = studyInfo;
guidata(hObject, handles);

if strcmp(beRaInfo.forceQExitButton,'Default Esc key')
    fQuitKey = 'ESCAPE';
else
    fQuitKey = 'End';
end
studyInfo.fQuitKey=fQuitKey;

yesData=1;

if rOpts==4
    studyInfo.questSOpts=questSOpts;
end

studyInfo=wQuestionTrial(studyInfo,rOpts,yesData);
save studyInfo.mat studyInfo


if strcmp(beRaInfo.startSOpts,'Default "READY" screen')
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
if strcmp(beRaInfo.startSExitButton,'Default Enter key')
    readyStruct.exitB='Return';
else
    readyStruct.exitB='space';
end

studyInfo=wReadyTrial(studyInfo,readyStruct);

studyInfo.readyStruct=readyStruct;
save studyInfo.mat studyInfo

if strcmp(beRaInfo.endSOpts,'Default "End of Session" screen')
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
if strcmp(beRaInfo.endSExitButton,'Default Enter key')
    endStruct.exitB='Return';
else
    endStruct.exitB='space';
end

studyInfo=wEndTrial(studyInfo,endStruct);

studyInfo.endStruct=endStruct;
save studyInfo.mat studyInfo

if strcmp(beRaInfo.breakSOpts,'No "Break" Screen')
    
else
    if strcmp(beRaInfo.breakSOpts,'Default break text & exit button')
        breakStruct.text='You are on a break. Press the space bar to continue.';
        breakStruct.exitB='Space';
    elseif strcmp(beRaInfo.breakSOpts,'Customize break text only')
        breakStruct.exitB='Space';
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
            warningMessage = 'You''ve entered the default text. Go back and choose "Default break text & exit button" instead.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    elseif  strcmp(beRaInfo.breakSOpts,'Customize exit button only')
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
                if strcmpi(breakStruct.exitB,'Space')
                    warningMessage = 'You''ve entered the default exit button. Go back and choose "Default break text & exit button" instead.';
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
        
    elseif strcmp(beRaInfo.breakSOpts,'Customize both text & exit button')
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
            warningMessage = 'You''ve used both default text and exit botton. Go back and select "Default break text & exit button" instead.';
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
            warningMessage = 'You''ve used the default exit button. Go back and select "Customize break text only';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end

    end
    
    studyInfo=wBreakTrial(studyInfo,breakStruct);
    studyInfo.breakStruct=breakStruct;
    save studyInfo.mat studyInfo
    
end

if strcmp(beRaInfo.stimSOpts,'Default "Listen" screen')
    stimSStruct.text='LISTEN';
else
    normalMessage='Please type in your stim screen text';
    yesString=1;
    pause(0.1);
    stimSStruct.text=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    if isempty(endStruct.text)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif strcmp(stimSStruct.text,'LISTEN')
        warningMessage = 'You''ve entered the default text. Go back and select "Default "Listen" screen" instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

studyInfo=wBeRaStimTrial(studyInfo,stimSStruct);
studyInfo.stimSStruct=stimSStruct;
save studyInfo.mat studyInfo

if strcmp(beRaInfo.blankSOpts,'Blank screen & default settings')
    blankStruct.text=' ';
    blankStruct.duration=[.5 1];
elseif strcmp(beRaInfo.blankSOpts,'Stim screen & default settings')
    blankStruct.text=stimSStruct.text;
    blankStruct.duration=[.5 1];
elseif strcmp(beRaInfo.blankSOpts,'Blank screen & customize settings')
    blankStruct.text=' ';
    
    normalMessage=['The default fixed screen duration between stim and question(s)',...
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
    elseif duration(1)==.5
        normalMessage=['The default fixed screen duration between break and stim',...
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
        elseif duration(2)==1
            warningMessage = ['You entered .5 for the first duration and 1 for the second duration',...
                ' which is the default values. Please go back and choose the "Blank screen & default settings" instead.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['The default fixed screen duration between break and stim',...
            ' is 1 sec. What is the time duration (in sec) you would like to use instead?'];
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
    
elseif strcmp(beRaInfo.blankSOpts,'Stim screen & customize settings')
    blankStruct.text=stimSStruct.text;
    
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
            ' is 2 sec. What is the time duration (in sec) you would like to use instead.'];
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
        elseif duration(2)==2
            warningMessage = ['You entered 1 for the first duration and 2 for the second duration',...
                ' which is the default values. Please go back and choose the "Stim screen & default settings" instead.'];
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['The default fixed screen duration between break and stim',...
            ' is 2 sec. What is the time duration (in sec) you would like to use instead?'];
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

studyInfo.yesData=1;

studyInfo=wBeRaMainExp(studyInfo);
save studyInfo.mat studyInfo

wUserGuide(studyInfo);
save studyInfo.mat studyInfo

copyfile([pwd filesep 'bin' filesep 'check.m'],[studyInfo.path]);
copyfile([pwd filesep 'bin' filesep 'check.fig'],[studyInfo.path]);
mkdir(studyInfo.path,'sup');
copyfile([pwd filesep 'bin' filesep 'sup'],[studyInfo.path filesep 'sup']);

studyInfo.lastComp='writeBehavRatingStudy(studyInfo)';
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
