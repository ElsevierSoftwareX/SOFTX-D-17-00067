function varargout = getStructuralParameters(varargin)
% GETSTRUCTURALPARAMETERS MATLAB code for getStructuralParameters.fig
%   function getStructuralParameters
%
%   This getStructuralParameters GUI is the third step in AudExpCreator. It 
%   will help users set the structural parameters of their study
%   experiment.
%
%   This function requires the following input from you:
%         
%         1. # of auditory stimuli. Please fill in the number of auditory
%         stimuli that you would like to use for the study experiment.
%         
%         2. # of subjects. Please fill in the number of subjects that you
%         would like to run with this study experiment. Always add at least
%         10 extra subjects just in case. 
%         
%         3. # of presentations. One presentation is a round of all your
%         uploaded available stimuli. Therefore if you have more than one
%         round of presentation you are selecting to present a set of
%         stimuli multiple times to your subjects. 
%         
%         4. # of recording sessions. One round of presentation can be
%         divided up into multiple recording sessions. If there were 10 
%         stimuli at 5 minutes each it might be tiring for subjects to do 
%         50 minutes of stimuli in one sitting. Therefore you can break up
%         one round of presentation into 2 or more recording session to 
%         give subjects a bathroom or stretch break. This is especially
%         helpful during EEG recordings where it can be draining for
%         subjects. If the first recording session presents stimuli 1-5,
%         the second will presents stimuli 6-10, unless stimulus array was
%         design to have repetitions.
%         
%         5. Sanity check for EEG or Neurophysiological study. If your
%         study is not a EEG or Neurophysiological study, then you will not
%         have to worry about this option. However, if it is then you would
%         need to select between "Device Ready" v. "Device Not Ready"
%         options; these options will depend on whether TTL or TCP/IP
%         signal output method was selected at the very beginning. The
%         check GUI can also help you switch between the "Device Ready" and
%         "Device Not Ready" later on too.
%         
%         Finally, the AudExpCreator User's Guide carries a more detailed
%         description about the options available here. Please see that for
%         help.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getStructuralParameters

% Last Modified by GUIDE v2.5 08-May-2017 13:57:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getStructuralParameters_OpeningFcn, ...
    'gui_OutputFcn',  @getStructuralParameters_OutputFcn, ...
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


% --- Executes just before getStructuralParameters is made visible.
function getStructuralParameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getStructuralParameters (see VARARGIN)

% Choose default command line output for getStructuralParameters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    studyInfo=handles.studyInfo;
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

if strcmp(studyInfo.type,'EEG Study') || strcmp(studyInfo.type,'Neurophysiological Study')
    if strcmp(studyInfo.signalType, 'TTL')
        studyNIReady{1}='Not NI Device Ready';
        studyNIReady{2}='Yes NI Device Ready';
    elseif strcmp(studyInfo.signalType, 'TCP/IP')
        studyNIReady{1}='Not Ethernet Ready';
        studyNIReady{2}='Yes Ethernet Ready';
    end
else
    studyNIReady{1}='Not EEG or Neurophysiological';
end

set(handles.popupmenu2,'String',studyNIReady);

guidata(hObject, handles);

% UIWAIT makes getStructuralParameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getStructuralParameters_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.ouptut=[];
varargout{1} = handles.output;



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
handles.studyNIReady = selectedType;

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

studyStimNum = str2double(get(handles.edit1,'String'));
if isempty(studyStimNum) || isnan(studyStimNum)
    warningMessage = 'Please correctly fill in how many auditory stimuli there will be.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studySubNum = str2double(get(handles.edit2,'String'));
if isempty(studySubNum) || isnan(studySubNum)
    warningMessage = 'Please correctly fill in how many subjects there will be.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studyPresNum = str2double(get(handles.edit3,'String'));
if isempty(studyPresNum) || isnan(studyPresNum)
    warningMessage = 'Please correctly fill in how many times a stimulus will be presented.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end


studyRecNum = str2double(get(handles.edit4,'String'));
if isempty(studyRecNum) || isnan(studyRecNum)
    warningMessage = 'Please correctly fill in how many recording sessions there will be.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

try
    studyInfo.niReady = handles.studyNIReady;
catch
    content=get(handles.popupmenu2,'String');
    selected=get(handles.popupmenu2,'Value');
    studyInfo.niReady=content{selected};
end

studyInfo.stimNum = studyStimNum;
studyInfo.subNum = studySubNum;
studyInfo.presNum = studyPresNum;
studyInfo.recNum = studyRecNum;

if strcmp(studyInfo.type,'Neurophysiological Study')
    actualStimNum=studyStimNum-1;
    remSPR=mod(actualStimNum,studyRecNum);
else
    actualStimNum=studyStimNum;
    remSPR = mod(actualStimNum,studyRecNum);
end

if remSPR~=0
    warningMessage = ['The number of stims (without basline) must divide evenly',...
        ' into the number of recording sessions. It does not right now. Please try again.'];
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

studyStimPerRec = actualStimNum/studyRecNum;
studyInfo.stimPerRec = studyStimPerRec;

handles.studyInfo = studyInfo;
guidata(hObject, handles);

save studyInfo.mat studyInfo

if isfield(studyInfo, 'stimStruct')==1 && ~isempty(studyInfo.stimStruct)==1
    normalMessage=sprintf(['It seems that you already have a stimulus structure built.',...
        ' Do you want to replace it and build a different one? (Type ''yes'' or ''no''.)']);
    yesString=1;
    pause(0.1);
    reBuildStimStruct=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(reBuildStimStruct)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(reBuildStimStruct,'yes')
        buildStimStruct=1;
    elseif strcmpi(reBuildStimStruct,'no')
        
        buildStimStruct=0;
        
        studyInfo.stimNum=size(studyInfo.stimStruct,2);
        save studyInfo.mat studyInfo

    else
        warningMessage = 'You did not give an acceptable answer. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
else
    buildStimStruct=1;
end

if buildStimStruct
    if strcmp(studyInfo.niReady,'Yes NI Device Ready')
        normalMessage = sprintf(['The next step involves uploading your stim.',...
            '\n Please make sure they are ready in *.wav format.']);
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
        
        normalMessage = sprintf(['Since you''ve selected ''Yes NI Device Ready'',',...
            '\nplease make sure that your audio files is prepped for this.']);
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
    else
        normalMessage = sprintf(['The next step involves uploading your stim.',...
            '\nPlease make sure they are ready in *.wav format.']);
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
    end
    
    normalMessage = sprintf(['If you require special groupings of stims,',...
        ' please make sure that you label your stims to reflect this as it',...
        ' will be utilized in how your stimulus array is built.']);
    pause(0.1);
    messageInterface(studyInfo,normalMessage);
    drawnow
    
    for i=1:studyInfo.stimNum
        if i>1
            filepath = stimDir;
            pause(0.1);
            [stimStruct(i), ~] = getStimInfo(studyInfo,i,filepath);
            drawnow
        else
            pause(0.1);
            [stimStruct(i), stimDir] = getStimInfo(studyInfo,i);
            drawnow
        end
    end
    
    pause(0.1); drawnow
    
    if isempty(stimStruct)
        warningMessage = sprintf(['Something happened and your stimulus structure was not built.',...
            '\nPlease try again.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    else
        normalMessage = sprintf('Your stimulus structure was generated.');
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
    end
    
    studyInfo.stimStruct = stimStruct;
    studyInfo.stimStructName=sprintf('%sStimStruct', studyInfo.name);
    eval([studyInfo.stimStructName '= studyInfo.stimStruct;']);
    save([studyInfo.path filesep studyInfo.stimStructName '.mat'],...
        studyInfo.stimStructName);
    
    save studyInfo.mat studyInfo
end

normalMessage = sprintf(['The next step is to build your stimulus array.',...
    '\nPlease be prepared to specify your array specifics if needed.']);
pause(0.1);
messageInterface(studyInfo,normalMessage);
drawnow


if isfield(studyInfo, 'stimArray')==1 && ~isempty(studyInfo.stimArray)==1
    normalMessage=sprintf(['It seems that you already have a stimulus array built.',...
        ' Do you want to replace it and build a different one? (Type ''yes'' or ''no''.)',...
        ' Please consider rebuilding if you just rebuilt your stim structure.']);
    yesString=1;
    pause(0.1);
    reBuildStimArray=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(reBuildStimArray)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(reBuildStimArray,'yes')
        buildStimArray=1;
    elseif strcmpi(reBuildStimArray,'no')
        buildStimArray=0;

        try
            studyInfo.subNum=size(studyInfo.stimArray{2},1);
            studyInfo.recNum=size(studyInfo.stimArray{2},3);
            studyInfo.stimPerRec=size(studyInfo.stimArray{2},2);
            studyInfo.presNum=size(studyInfo.stimArray,2);
        catch
            studyInfo.subNum=size(studyInfo.stimArray,1);
            studyInfo.recNum=size(studyInfo.stimArray,3);
            studyInfo.stimPerRec=size(studyInfo.stimArray,2);
            studyInfo.presNum=1;
        end
        
        save studyInfo.mat studyInfo
        
    else
        warningMessage = 'You did not give an acceptable answer. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
else
    buildStimArray=1;
end

if buildStimArray
    if strcmp(studyInfo.type,'Comparison Behav. Rating Study')
        pause(0.1);
        studyInfo=getPairingStimArrayConstruct(studyInfo);
        drawnow
    else
        pause(0.1);
        studyInfo=getStimArrayParameters(studyInfo);
        drawnow
    end
    if isempty(studyInfo)
        warningMessage = sprintf(['You failed to build a stimulus array correctly.',...
            '\nPlese try again and consider your options carefully.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    else
        save studyInfo.mat studyInfo
    end
end

studyInfo.lastComp='getStructuralParameters';

if strcmp(studyInfo.type,'Behavioral Rating Study')
    studyInfo.nextStep='writeBehavRatingStudy(studyInfo)';
elseif strcmp(studyInfo.type,'Comparison Behav. Rating Study')
    studyInfo.nextStep='writeCompBeRaStudy(studyInfo)';
elseif strcmp(studyInfo.type,'Continuous Behav. Rating Study')
    studyInfo.nextStep='writeConBeRatingStudy(studyInfo)';
elseif strcmp(studyInfo.type,'EEG Study')
    studyInfo.nextStep='writeEEGStudy(studyInfo)';
elseif strcmp(studyInfo.type,'Neurophysiological Study')
    studyInfo.nextStep='writeNeurophysStudy(studyInfo)';
end

save studyInfo.mat studyInfo

clc;
close(handles.figure1);

if strcmp(studyInfo.type,'Behavioral Rating Study')
    pause(0.1);
    writeBehavRatingStudy(studyInfo);
    drawnow
elseif strcmp(studyInfo.type,'Comparison Behav. Rating Study')
    pause(0.1);
    writeCompBeRaStudy(studyInfo);
    drawnow
elseif strcmp(studyInfo.type,'Continuous Behav. Rating Study')
    pause(0.1);
    writeConBeRatingStudy(studyInfo);
    drawnow
elseif strcmp(studyInfo.type,'EEG Study')
    pause(0.1);
    writeEEGStudy(studyInfo);
    drawnow
elseif strcmp(studyInfo.type,'Neurophysiological Study')
    pause(0.1);
    writeNeurophysStudy(studyInfo);
    drawnow
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
