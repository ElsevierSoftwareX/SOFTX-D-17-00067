function varargout = getPairingStimArrayConstruct(varargin)
% GETPAIRINGSTIMARRAYCONSTRUCT MATLAB code for getPairingStimArrayConstruct.fig
%   function getPairingStimArrayConstruct
%
%   This getPairingStimArrayConstruct GUI will provide you options in which
%   you can select to build your stimulus array or pairs for the Comparison
%   Rating Study. See the AudExpCreator User's Guide for a more detailed
%   descriptions of the options available to you.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com


% Edit the above text to modify the response to help getPairingStimArrayConstruct

% Last Modified by GUIDE v2.5 12-Jun-2017 15:46:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getPairingStimArrayConstruct_OpeningFcn, ...
    'gui_OutputFcn',  @getPairingStimArrayConstruct_OutputFcn, ...
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


% --- Executes just before getPairingStimArrayConstruct is made visible.
function getPairingStimArrayConstruct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getPairingStimArrayConstruct (see VARARGIN)

% Choose default command line output for getPairingStimArrayConstruct
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
end

constructs{1}='Generate pairings from all stims, no repeat';
constructs{2}='Generate pairings from all stims, yes repeat';
constructs{3}='Gen. pairings from rand stim selection, no rep';
constructs{4}='Gen. pairings from rand stim selection, yes rep';
constructs{5}='Gen. pairings from prob. stim selection, no rep';
constructs{6}='Gen. pairings from prob. stim selection, yes rep';
constructs{7}='Gen. pairings from cust. stim selection, no rep';
constructs{8}='Gen. pairings from cust. stim selection, yes rep';
constructs{9}='Generate pairings from combin. of 2 goups';
constructs{10}='Customized pairings, no limitations';
set(handles.popupmenu1,'String',constructs);

guidata(hObject, handles);
% UIWAIT makes getPairingStimArrayConstruct wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getPairingStimArrayConstruct_OutputFcn(hObject, eventdata, handles)
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
handles.constructs = selectedType;

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

studyInfo = handles.studyInfo;
stimStruct = studyInfo.stimStruct;

for i=1:length(stimStruct)
    titles{i}=stimStruct(i).title;
    artists{i}=stimStruct(i).artist;
    types{i}=stimStruct(i).type;
    conds{i}=stimStruct(i).cond;
end

uniSpecs.title = unique(titles,'stable');
uniSpecs.artist = unique(artists,'stable');
uniSpecs.type = unique(types,'stable');
uniSpecs.cond = unique(conds,'stable');

try
    constructs = handles.constructs;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    constructs=content{selected};
end

rng('shuffle');

if strcmp(constructs,'Generate pairings from all stims, no repeat')
    tempStim=1:studyInfo.stimNum;
    tempArray=nchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    warningInterface(studyInfo,warningMessage);
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmp(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmp(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmp(yesOOrderS,'yes') && strcmp(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmp(yesOOrderS,'no') && strcmp(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Generate pairings from all stims, yes repeat')
    tempStim=1:studyInfo.stimNum;
    tempArray=nmchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects?. If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmp(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
elseif strcmp(constructs,'Gen. pairings from rand stim selection, no rep')
    normalMessage=sprintf(['Out of your total %d stimuli,',...
        '\nhow many stimuli do you want to randomly select to be put into pairing generation.'],...
        studyInfo.stimNum);
    yesString=0;
    pause(0.1);
    selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectStimNum)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==0
        warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==1
        warningMessage = sprintf('You entered "1" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==studyInfo.stimNum
        warningMessage = sprintf(['If you are using all stims please go back and select',...
            ' the option that corresponds to this.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        close;
    end
    
    orgStim=1:studyInfo.stimNum;
    tempStim=datasample(orgStim,selectStimNum,'Replace',false);
    tempArray=nchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInteface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Gen. pairings from rand stim selection, yes rep')
    normalMessage=sprintf(['Out of your total %d stimuli,',...
        '\nhow many stimuli do you want to randomly select to be put into pairing generation.'],...
        studyInfo.stimNum);
    yesString=0;
    pause(0.1);
    selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectStimNum)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==0
        warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==1
        warningMessage = sprintf('You entered "1" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==studyInfo.stimNum
        warningMessage = sprintf(['If you are using all stims please go back and select',...
            ' the option that corresponds to this.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        close;
    end
    
    orgStim=1:studyInfo.stimNum;
    tempStim=datasample(orgStim,selectStimNum,'Replace',false);
    tempArray=nmchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Gen. pairings from prob. stim selection, no rep')
    normalMessage=sprintf(['Out of your total %d stimuli,',...
        '\nhow many stimuli do you want select via probability to be put into pairing generation.'],...
        studyInfo.stimNum);
    yesString=0;
    pause(0.1);
    selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectStimNum)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==0
        warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==1
        warningMessage = sprintf('You entered "1" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==studyInfo.stimNum
        warningMessage = sprintf(['If you are using all stims please go back and select',...
            ' the option that corresponds to this.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        close;
    end
    
    normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d stims.'...
        ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
        studyInfo.stimNum, studyInfo.stimNum);
    yesString=3;
    pause(0.1);
    selectW=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectW)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif ~isequal(length(selectW), studyInfo.stimNum)
        warningMessage = 'Your vector did not have enough elements. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    orgStim=1:studyInfo.stimNum;
    tempStim=datasample(orgStim,selectStimNum,'Replace',false,'Weights',selectW);
    tempArray=nchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Gen. pairings from prob. stim selection, yes rep')
    normalMessage=sprintf(['Out of your total %d stimuli,',...
        '\nhow many stimuli do you want select via probability to be put into pairing generation.'],...
        studyInfo.stimNum);
    yesString=0;
    pause(0.1);
    selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectStimNum)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==0
        warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==1
        warningMessage = sprintf('You entered "1" which is an unacceptable response.\nPlease try again.');
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif selectStimNum==studyInfo.stimNum
        warningMessage = sprintf(['If you are using all stims please go back and select',...
            ' the option that corresponds to this.']);
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        close;
    end
    
    normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d stims.'...
        ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
        studyInfo.stimNum, studyInfo.stimNum);
    yesString=3;
    pause(0.1);
    selectW=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(selectW)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif ~isequal(length(selectW), studyInfo.stimNum)
        warningMessage = 'Your vector did not have enough elements. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    orgStim=1:studyInfo.stimNum;
    tempStim=datasample(orgStim,selectStimNum,'Replace',false,'Weights',selectW);
    tempArray=nmchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Gen. pairings from cust. stim selection, no rep')
    
    normalMessage=sprintf(['Out of your %d stims, please type in the stims you would like to use for pairing generation.',...
        ' Please do not duplicate stims and you must use more than one stim for pairings.'], studyInfo.stimNum);
    yesString=2;
    pause(0.1);
    tempStim=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(tempStim)
        warningMessage = 'You exited before responding. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(tempStim)==studyInfo.stimNum
        warningMessage = 'You used all available stims here. Please go and choose that construction option instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(tempStim)==1
        warningMessage = 'One stim cannot be paired. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    tempArray=nchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Gen. pairings from cust. stim selection, yes rep')
    normalMessage=sprintf(['Out of your %d stims, please type in the stims you would like to use for pairing generation.',...
        ' Please do not duplicate stims and you must use more than one stim for pairings.'], studyInfo.stimNum);
    yesString=2;
    pause(0.1);
    tempStim=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(tempStim)
        warningMessage = 'You exited before responding. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(tempStim)==studyInfo.stimNum
        warningMessage = 'You used all available stims here. Please go and choose that construction option instead.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(tempStim)==1
        warningMessage = 'One stim cannot be paired. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    tempArray=nmchoosek(tempStim,2);
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            pause(0.1);
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
elseif strcmp(constructs,'Generate pairings from combin. of 2 goups')
    
    pause(0.1);
    [~, group, ~, ~]=getGroups(studyInfo,uniSpecs);
    drawnow
    
    tempArray = comb2groups(group{1},group{2});
    
    if ~mod(size(tempArray,1),studyInfo.recNum)==0
        normalMessage=sprintf(['%d pairs was generated. However this does not evenly divide into your %d recording sessions.',...
            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
            size(tempArray,1), studyInfo.recNum);
        yesString=1;
        pause(0.1);
        yesChange=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesChange)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        elseif strcmpi(yesChange,'yes')
            normalMessage=sprintf('How many recording sessions would you like to divide your %d pairs into?',...
                size(tempArray,1));
            yesString=0;
            recNum=userRespInterface(studyInfo,normalMessage,yesString);
            
            if isempty(recNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif recNum==0
                warningMessage = '"0" is an invalid response. Please try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(size(tempArray,1),recNum)==0
                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,1));
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            stimPerRec=(size(tempArray,1)*2)/recNum;
            studyInfo.recNum=recNum;
            studyInfo.stimPerRec=stimPerRec;
            
        elseif strcmpi(yesChange,'no')
            warningMessage = 'Please choose a different construction option as you are unwilling to change the number of recording sessions.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        else
            warningMessage = 'Invalid response. Please try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    
    stimPerRec=(size(tempArray,1)*2)/studyInfo.recNum;
    studyInfo.stimPerRec=stimPerRec;
    
    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesOOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesIOrderS)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
    yesString=1;
    pause(0.1);
    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(yesSAll)==1
        warningMessage = 'You exit before responding. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmpi(yesSAll,'yes')
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        r=randperm(size(tempArray,2));
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentation rounds. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'Invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    elseif strcmpi(yesSAll,'no')
        if studyInfo.presNum==1
            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = randArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                for t=1:rand*100
                    z=randperm(size(tempArray,1));
                    randArray = tempArray(z,:);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                for k=1:size(tempArray,1)
                    for t=1:rand*100
                        r=randperm(size(tempArray,2));
                    end
                    randArray(k,:) = tempArray(k,r);
                end
                stim = reshape(randArray',1,[]);
            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                randArray=tempArray;
                stim = reshape(randArray',1,[]);
            else
                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            for i=1:studyInfo.subNum
                indArray(i,:)=stim;
            end
            try
                stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            catch
                warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        else
            normalMessage=['Would you like to apply shuffling settings to each individual presentation?',...
                'If no, one shuffling will be used for all presentations. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(randPres)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(randPres,'yes')
                for p=1:studyInfo.presNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        stimArray{p}=indPres;
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
            elseif strcmpi(randPres,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    for p=studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        end
    else
        warningMessage = 'You''ve entered an invalid response. Try over again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
elseif strcmp(constructs,'Customized pairings, no limitations')
    if studyInfo.presNum==1
        normalMessage=['Would you like to customize pairings for each individual subject?',...
            ' If no, you will input only one pairing stim array, but you can choose to shuffle',...
            ' that for each individual subject. Shuffling choice not available for ''yes''. Type ''yes'' or ''no''.'];
        yesString=1;
        pause(0.1);
        yesCAll=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(yesCAll)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        if strcmpi(yesCAll,'no')
            normalMessage=sprintf(['How many pairs are in your stim array? Please make sure that this can be',...
                ' evenly divided into your %d recording sessions.'], studyInfo.recNum);
            yesString=0;
            pause(0.1);
            pairNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(pairNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif pairNum==0
                warningMessage = '"0" is unacceptable. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(pairNum,studyInfo.recNum)==0
                warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
            
            for i=1:pairNum
                normalMessage=sprintf(['For pair #%d:',...
                    '\nType in your 2 stims.'], i);
                yesString=5;
                try
                    pause(0.1);
                    tempArray(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                catch
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
                ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesOOrderS)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
                ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesIOrderS)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
                ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesSAll)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            if strcmpi(yesSAll,'yes')
                for i=1:studyInfo.subNum
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            r=randperm(size(tempArray,2));
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    indArray(i,:)=stim;
                end
                try
                    stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            elseif strcmpi(yesSAll,'no')
                if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = randArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                    for t=1:rand*100
                        z=randperm(size(tempArray,1));
                        randArray = tempArray(z,:);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randArray(k,:) = tempArray(k,r);
                    end
                    stim = reshape(randArray',1,[]);
                elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                    randArray=tempArray;
                    stim = reshape(randArray',1,[]);
                else
                    warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                for i=1:studyInfo.subNum
                    indArray(i,:)=stim;
                end
                try
                    stimArray=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                catch
                    warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            else
                warningMessage = 'You''ve entered an invalid response. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        elseif strcmp(yesCAll,'yes')
            normalMessage=sprintf(['How many pairs are in your stim array for all your subjects? Please make sure that this can be',...
                ' evenly divided into your %d recording sessions. (The same number of pairs,',...
                ' must be used for all subjects to make the stim array balanced.)'], studyInfo.recNum);
            yesString=0;
            pause(0.1);
            pairNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(pairNum)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif pairNum==0
                warningMessage = '"0" is unacceptable. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~mod(pairNum,studyInfo.recNum)==0
                warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
            
            for i=1:studyInfo.subNum
                for k=1:pairNum
                    normalMessage=sprintf(['For subject #%d, pair #%d:',...
                        '\nType in your 2 stims.'], i, k);
                    yesString=5;
                    try
                        pause(0.1);
                        tempArray(k,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                    catch
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                stim = reshape(tempArray',1,[]);
                randArray(i,:)=stim;
            end
            stimArray=reshape(randArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
        else
            warningMessage = 'Your response was invalid. Please try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    else
        normalMessage=['Would you like to customize pairing arrays for each individual presentation?',...
            ' If no, you will have to customize one presentation, but you can choose to shuffle',...
            ' that for the other presentations. Shuffling choice not available for ''yes''. Type ''yes'' or ''no''.'];
        yesString=1;
        pause(0.1);
        randPres=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        
        if isempty(randPres)==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
        
        if strcmpi(randPres,'no')
            
            normalMessage=['For one presentation: Would you like to customize pairings for each individual subject?',...
                ' If no, you will input only one pairing stim array, but you can choose to shuffle',...
                ' that for each individual subject. Shuffling choice not available for ''yes''. Type ''yes'' or ''no''.'];
            yesString=1;
            pause(0.1);
            yesCAll=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesCAll)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if strcmpi(yesCAll,'no')
                normalMessage=sprintf(['How many pairs are in your stim array? Please make sure that this can be',...
                    ' evenly divided into your %d recording sessions.'], studyInfo.recNum);
                yesString=0;
                pause(0.1);
                pairNum=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(pairNum)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif pairNum==0
                    warningMessage = '"0" is unacceptable. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif ~mod(pairNum,studyInfo.recNum)==0
                    warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
                
                for i=1:pairNum
                    normalMessage=sprintf(['For pair #%d:',...
                        '\nType in your 2 stims.'], i);
                    yesString=5;
                    try
                        pause(0.1);
                        tempArray(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                    catch
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
                    ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
                yesString=1;
                pause(0.1);
                yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(yesOOrderS)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
                    ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
                yesString=1;
                pause(0.1);
                yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(yesIOrderS)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
                    ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
                yesString=1;
                pause(0.1);
                yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if isempty(yesSAll)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                if strcmpi(yesSAll,'yes')
                    for i=1:studyInfo.subNum
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                r=randperm(size(tempArray,2));
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                elseif strcmpi(yesSAll,'no')
                    if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = randArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                        for t=1:rand*100
                            z=randperm(size(tempArray,1));
                            randArray = tempArray(z,:);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                        for k=1:size(tempArray,1)
                            for t=1:rand*100
                                r=randperm(size(tempArray,2));
                            end
                            randArray(k,:) = tempArray(k,r);
                        end
                        stim = reshape(randArray',1,[]);
                    elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                        randArray=tempArray;
                        stim = reshape(randArray',1,[]);
                    else
                        warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    for i=1:studyInfo.subNum
                        indArray(i,:)=stim;
                    end
                    try
                        indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                    catch
                        warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                else
                    warningMessage = 'You''ve entered an invalid response. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            elseif srcmp(yesCAll,'yes')
                normalMessage=sprintf(['How many pairs are in your stim array for all your subjects? Please make sure that this can be',...
                    ' evenly divided into your %d recording sessions. (The same number of pairs,',...
                    ' must be used for all subjects to make the stim array balanced.)'], studyInfo.recNum);
                yesString=0;
                pause(0.1);
                pairNum=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                if isempty(pairNum)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif pairNum==0
                    warningMessage = '"0" is unacceptable. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                elseif ~mod(pairNum,studyInfo.recNum)==0
                    warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
                
                for i=1:studyInfo.subNum
                    for k=1:pairNum
                        normalMessage=sprintf(['For subject #%d, pair #%d:',...
                            '\nType in your 2 stims.'], i, k);
                        yesString=5;
                        try
                            pause(0.1);
                            tempArray(k,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                        catch
                            warningMessage = 'You exit before responding. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    stim = reshape(tempArray',1,[]);
                    randArray(i,:)=stim;
                end
                indPres=reshape(randArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            else
                warningMessage = 'Your response was invalid. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage='Now using that one presentation would you like to shuffle it for your others? Type ''yes'' or ''no''.';
            yesString=1;
            pause(0.1);
            presShuf=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            if isempty(presShuf)==1
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            if strcmpi(presShuf,'yes')
                for p=1:studyInfo.presNum
                    for t=1:rand*100
                        z=randperm(size(indPres,1));
                        randPres = indPres(z,:,:);
                    end
                    for k=1:size(tempArray,1)
                        for t=1:rand*100
                            r=randperm(size(tempArray,2));
                        end
                        randPres(k,:,:) = randPres(k,:,r);
                    end
                    stimArray{p}=randPres;
                end
            elseif strcmpi(presShuf,'no')
                for p=1:studyInfo.presNum
                    stimArray{p}=indPres;
                end
            else
                warningMessage = 'You exit before responding. Try over again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
        elseif strcmpi(randPres,'yes')
            for p=1:studyInfo.presNum
                normalMessage=sprintf(['For presentation #%d: Would you like to customize pairings for each individual subject?',...
                    ' If no, you will input only one pairing stim array, but you can choose to shuffle',...
                    ' that for each individual subject. Shuffling choice not available for ''yes''. Type ''yes'' or ''no''.'],...
                    p);
                yesString=1;
                pause(0.1);
                yesCAll=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                if isempty(yesCAll)==1
                    warningMessage = 'You exit before responding. Try over again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                if strcmpi(yesCAll,'no')
                    normalMessage=sprintf(['How many pairs are in your stim array? Please make sure that this can be',...
                        ' evenly divided into your %d recording sessions.'], studyInfo.recNum);
                    yesString=0;
                    pause(0.1);
                    pairNum=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    if isempty(pairNum)==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    elseif pairNum==0
                        warningMessage = '"0" is unacceptable. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    elseif ~mod(pairNum,studyInfo.recNum)==0
                        warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
                    
                    for i=1:pairNum
                        normalMessage=sprintf(['For pair #%d:',...
                            '\nType in your 2 stims.'], i);
                        yesString=5;
                        try
                            pause(0.1);
                            tempArray(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                        catch
                            warningMessage = 'You exit before responding. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    
                    normalMessage=['Would you like to shuffle the ordering of the pairs. If not',...
                        ' pairings will appear in sorted ordering from (i.e. [1 2] [1 3] [1 4]). Type ''yes'' or ''no''.'];
                    yesString=1;
                    pause(0.1);
                    yesOOrderS=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(yesOOrderS)==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=['Would you like to shuffle the ordering inside pairs. If not',...
                        ' pairings will appear in sorted ordering with the small number first (i.e. [2 3] [3 6]). Type ''yes'' or ''no''.'];
                    yesString=1;
                    pause(0.1);
                    yesIOrderS=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(yesIOrderS)==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    normalMessage=['Would you like to apply shuffling to all individual subjects? If not',...
                        ' shuffling (or not) will only be apply once and all subject will have that pairing stim array. Type ''yes'' or ''no''.'];
                    yesString=1;
                    pause(0.1);
                    yesSAll=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(yesSAll)==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    if strcmpi(yesSAll,'yes')
                        for i=1:studyInfo.subNum
                            if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                                for t=1:rand*100
                                    z=randperm(size(tempArray,1));
                                    randArray = tempArray(z,:);
                                end
                                for k=1:size(tempArray,1)
                                    for t=1:rand*100
                                        r=randperm(size(tempArray,2));
                                    end
                                    randArray(k,:) = randArray(k,r);
                                end
                                stim = reshape(randArray',1,[]);
                            elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                                for t=1:rand*100
                                    z=randperm(size(tempArray,1));
                                    randArray = tempArray(z,:);
                                end
                                stim = reshape(randArray',1,[]);
                            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                                for k=1:size(tempArray,1)
                                    r=randperm(size(tempArray,2));
                                    randArray(k,:) = tempArray(k,r);
                                end
                                stim = reshape(randArray',1,[]);
                            elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                                randArray=tempArray;
                                stim = reshape(randArray',1,[]);
                            else
                                warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            indArray(i,:)=stim;
                        end
                        try
                            indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        catch
                            warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    elseif strcmpi(yesSAll,'no')
                        if strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'yes')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = randArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'yes') && strcmpi(yesIOrderS,'no')
                            for t=1:rand*100
                                z=randperm(size(tempArray,1));
                                randArray = tempArray(z,:);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'yes')
                            for k=1:size(tempArray,1)
                                for t=1:rand*100
                                    r=randperm(size(tempArray,2));
                                end
                                randArray(k,:) = tempArray(k,r);
                            end
                            stim = reshape(randArray',1,[]);
                        elseif strcmpi(yesOOrderS,'no') && strcmpi(yesIOrderS,'no')
                            randArray=tempArray;
                            stim = reshape(randArray',1,[]);
                        else
                            warningMessage = 'Somewhere you''ve entered an invalid response. Try over again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        for i=1:studyInfo.subNum
                            indArray(i,:)=stim;
                        end
                        try
                            indPres=reshape(indArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                        catch
                            warningMessage = 'Something went wrong and your pairing stim array was not made. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    else
                        warningMessage = 'You''ve entered an invalid response. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                elseif srcmp(yesCAll,'yes')
                    normalMessage=sprintf(['How many pairs are in your stim array for all your subjects? Please make sure that this can be',...
                        ' evenly divided into your %d recording sessions. (The same number of pairs,',...
                        ' must be used for all subjects to make the stim array balanced.)'], studyInfo.recNum);
                    yesString=0;
                    pause(0.1);
                    pairNum=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(pairNum)==1
                        warningMessage = 'You exit before responding. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    elseif pairNum==0
                        warningMessage = '"0" is unacceptable. Try over again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    elseif ~mod(pairNum,studyInfo.recNum)==0
                        warningMessage = sprintf('%d pairs could not be evenly divided into %d recording sessions. Try over again.', pairNum, studyInfo.recNum);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    
                    studyInfo.stimPerRec=(pairNum/studyInfo.recNum)*2;
                    
                    for i=1:studyInfo.subNum
                        for k=1:pairNum
                            normalMessage=sprintf(['For subject #%d, pair #%d:',...
                                '\nType in your 2 stims.'], i, k);
                            yesString=5;
                            try
                                pause(0.1);
                                tempArray(k,:)=userRespInterface(studyInfo,normalMessage,yesString);
                                drawnow
                            catch
                                warningMessage = 'You exit before responding. Try over again.';
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                        end
                        stim = reshape(tempArray',1,[]);
                        randArray(i,:)=stim;
                    end
                    indPres=reshape(randArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                else
                    warningMessage = 'Your response was invalid. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
               
                stimArray{p}=indPres;
            end
        else
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
end

try
    studyInfo.stimArray = stimArray;
    studyInfo.stimArrayName=sprintf('%sStimArray', studyInfo.name);
    eval([studyInfo.stimArrayName '= studyInfo.stimArray;']);
    save([studyInfo.path filesep studyInfo.stimArrayName '.mat'],...
        studyInfo.stimArrayName);
    
    studyInfo.uniSpecs=uniSpecs;
    handles.studyInfo = studyInfo;

catch
    warningMessage = 'Something went wrong. Your pairing stim array was not build. Try again.';
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

save studyInfo.mat studyInfo

handles.studyInfo=studyInfo;
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
