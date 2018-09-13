function varargout = getSpecializedRandArray(varargin)
% GETSPECIALIZEDRANDARRAY MATLAB code for getSpecializedRandArray.fig
%   function getSpecializedRandArray
%
%   This getSpecializedRandArray GUI will provide you options in which you
%   can specialized your randomization array even further than simply a
%   straight randomization. You can first select how you would like to
%   group your stimuli. Then you can select to randomize the stimuli within
%   each group, and then between the group and if you want these
%   randomization parameters to be done for each subject individually or
%   only once and then applied to all your subject. See AudExpCreator
%   User's Guide for more detailed descriptions on the available options.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getSpecializedRandArray

% Last Modified by GUIDE v2.5 22-May-2017 14:00:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getSpecializedRandArray_OpeningFcn, ...
    'gui_OutputFcn',  @getSpecializedRandArray_OutputFcn, ...
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


% --- Executes just before getSpecializedRandArray is made visible.
function getSpecializedRandArray_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getSpecializedRandArray (see VARARGIN)

% Choose default command line output for getSpecializedRandArray
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.uniSpecs = varargin{2};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    stimStruct = studyInfo.stimStruct;
    
    
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
        for i=start:length(stimStruct)
            titles{i}=stimStruct(i).title;
            artists{i}=stimStruct(i).artist;
            types{i}=stimStruct(i).type;
            conds{i}=stimStruct(i).cond;
        end
    end
    
    uniSpecs.title = unique(titles);
    uniSpecs.artist = unique(artists);
    uniSpecs.type = unique(types);
    uniSpecs.conds = unique(conds);
    
    handles.uniSpecs = uniSpecs;
end

groupBy{1}='via stim numbers (odd v. even)';
groupBy{2}='via stim numbers (split in half)';
groupBy{3}='via stim title';
groupBy{4}='via stim artist';
groupBy{5}='via stim type';
groupBy{6}='via stim conds';
groupBy{7}='via customized stim group';
set(handles.popupmenu3,'String',groupBy);

insideGroup{1}='Straight Randomization';
insideGroup{2}='None. Forward Order';
insideGroup{3}='None. Reverse Order';
set(handles.popupmenu4,'String',insideGroup);

outsideGroup{1}='Straight Randomization';
outsideGroup{2}='None. Forward Order';
outsideGroup{3}='None. Reverse Order';
set(handles.popupmenu5,'String',outsideGroup);

subRand{1}='Randomize for each subject';
subRand{2}='One randomization for all subjects';
set(handles.popupmenu6,'String',subRand);

guidata(hObject, handles);

% UIWAIT makes getSpecializedRandArray wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getSpecializedRandArray_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

try
    varargout{1} = handles.output;
    delete(hObject);
catch
    varargout{1}=[];
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
handles.groupBy = selectedType;

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
handles.insideGroup = selectedType;

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
handles.outsideGroup = selectedType;

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
handles.subRand = selectedType;

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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

studyInfo = handles.studyInfo;
uniSpecs = handles.uniSpecs;
stimStruct = studyInfo.stimStruct;

try
    groupBy = handles.groupBy;
catch
    content=get(handles.popupmenu3,'String');
    selected=get(handles.popupmenu3,'Value');
    groupBy=content{selected};
end

try
    insideGroup = handles.insideGroup;
catch
    content=get(handles.popupmenu4,'String');
    selected=get(handles.popupmenu4,'Value');
    insideGroup=content{selected};
end

try
    outsideGroup = handles.outsideGroup;
catch
    content=get(handles.popupmenu5,'String');
    selected=get(handles.popupmenu5,'Value');
    outsideGroup=content{selected};
end

try
    subRand = handles.subRand;
catch
    content=get(handles.popupmenu6,'String');
    selected=get(handles.popupmenu6,'Value');
    subRand=content{selected};
end

if strcmp(studyInfo.type,'Neurophysiological Study')
    stim=2:studyInfo.stimNum;
    stimNum = studyInfo.stimNum-1;
else
    stim=1:studyInfo.stimNum;
    stimNum = studyInfo.stimNum;
end


if strcmp(groupBy,'via stim numbers (odd v. even)')
    group{1} = stim(mod(stim,2)~=0);
    group{2} = stim(mod(stim,2)==0);
elseif strcmp(groupBy,'via stim numbers (split in half)')
    half=round(length(stim)/2);
    group{1} = stim(1:half);
    group{2} = stim(half+1:end);
elseif strcmp(groupBy,'via stim title')
    for i=1:length(uniSpecs.title)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.title{i},stimStruct(k).title)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
    end
elseif strcmp(groupBy,'via stim artist')
    for i=1:length(uniSpecs.artist)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.artist{i},stimStruct(k).artist)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
    end
elseif strcmp(groupBy,'via stim type')
    for i=1:length(uniSpecs.type)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.type{i},stimStruct(k).type)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
    end
elseif strcmp(groupBy,'via stim conds')
    for i=1:length(uniSpecs.cond)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.cond{i},stimStruct(k).cond)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
    end
elseif strcmp(groupBy,'via customized stim group')
    
    normalMessage='How many customized groups do you want?';
    yesString=0;
    pause(0.1);
    gNum=userRespInterface(studyInfo,normalMessage,yesString);
    drawnow
    
    if isempty(gNum)==1
        warningMessage = 'You exit before responding. Try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
    
    if strcmp(studyInfo.type,'Neurophysiological Study')
        normalMessage = sprintf(['Since your study is a ''Neurophysiological Study'',',...
            'please do not include stim ''1'' in any of the groups.']);
        pause(0.1);
        messageInterface(studyInfo,normalMessage);
        drawnow
    end
    
    for i=1:gNum
        normalMessage=sprintf(['Type the stims in group %d.',...
            ' (Ex. ''2 5 6'')\n(Please be sure not to duplicate stims',...
            ' inside the group or across groups.)'], i);
        yesString=2;
        pause(0.1);
        group{i}=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow
        if isempty(group{i})==1
            warningMessage = 'You exit before responding. Try over again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    stimSpec=[group{:}];
    anyRepeated = ~all(diff(sort(stimSpec)));
    if anyRepeated==1
        warningMessage = 'You repeated stims in your group. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stimSpec)<stimNum
        warningMessage = 'You''ve failed to use all available stimuli in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stimSpec)>stimNum
        warningMessage = 'You''ve exceeded the available stimuli total in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

fgroup=group;

try
    if studyInfo.presNum==1
        if strcmp(subRand,'Randomize for each subject')
            for i=1:studyInfo.subNum
                groupOrder = 1:length(group);
                for t=1:length(fgroup)
                    group{t}=fgroup{t};
                end
                if strcmp(insideGroup,'Straight Randomization')
                    for k=1:length(group)
                        for p=rand*100
                            z = randperm(length(group{k}));
                        end
                        group{k}=group{k}(z);
                    end
                elseif strcmp(insideGroup,'None. Forward Order')
                    for k=1:length(group)
                        group{k}=group{k};
                    end
                elseif strcmp(insideGroup,'None. Reverse Order')
                    for k=1:length(group)
                        group{k}=fliplr(group{k});
                    end
                end
                
                if strcmp(outsideGroup,'Straight Randomization')
                    for k=rand*100
                        z = randperm(length(group));
                    end
                    groupOrder = groupOrder(z);
                elseif strcmp(outsideGroup,'None. Forward Order')
                    groupOrder=groupOrder;
                elseif strcmp(outsideGroup,'None. Reverse Order')
                    groupOrder=fliplr(groupOrder);
                end
                indArray=[];
                for k=1:length(group)
                    indArray=[indArray group{groupOrder(k)}];
                end
                tempArray(i,:)=indArray;
            end
            randArray = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
        else
            groupOrder = 1:length(group);
            for t=1:length(fgroup)
                group{t}=fgroup{t};
            end
            if strcmp(insideGroup,'Straight Randomization')
                for k=1:length(group)
                    for p=rand*100
                        z = randperm(length(group{k}));
                    end
                    group{k}=group{k}(z);
                end
            elseif strcmp(insideGroup,'None. Forward Order')
                for k=1:length(group)
                    group{k}=group{k};
                end
            elseif strcmp(insideGroup,'None. Reverse Order')
                for k=1:length(group)
                    group{k}=fliplr(group{k});
                end
            end
            
            if strcmp(outsideGroup,'Straight Randomization')
                for k=rand*100
                    z = randperm(length(group));
                end
                groupOrder = groupOrder(z);
            elseif strcmp(outsideGroup,'None. Forward Order')
                groupOrder=groupOrder;
            elseif strcmp(outsideGroup,'None. Reverse Order')
                groupOrder=fliplr(groupOrder);
            end
            
            indArray=[];
            for k=1:length(group)
                indArray=[indArray group{groupOrder(k)}];
            end
            
            for i=1:studyInfo.subNum
                tempArray(i,:)=indArray;
            end
            
            randArray = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
        end
    else
        normalMessage=sprintf(['Do you want to randomize differently for each stim presentation?',...
            ' Please type ''yes'' or ''no''']);
        yesString=1;
        pause(0.1);
        randPres=userRespInterface(studyInfo,normalMessage,yesString);
        drawnow

        if strcmp(randPres,'yes')
            for pres=1:studyInfo.presNum
                if strcmp(subRand,'Randomize for each subject')
                    for i=1:studyInfo.subNum
                        groupOrder = 1:length(group);
                        for t=1:length(fgroup)
                            group{t}=fgroup{t};
                        end
                        if strcmp(insideGroup,'Straight Randomization')
                            for k=1:length(group)
                                for p=rand*100
                                    z = randperm(length(group{k}));
                                end
                                group{k}=group{k}(z);
                            end
                        elseif strcmp(insideGroup,'None. Forward Order')
                            for k=1:length(group)
                                group{k}=group{k};
                            end
                        elseif strcmp(insideGroup,'None. Reverse Order')
                            for k=1:length(group)
                                group{k}=fliplr(group{k});
                            end
                        end
                        
                        if strcmp(outsideGroup,'Straight Randomization')
                            for k=rand*100
                                z = randperm(length(group));
                            end
                            groupOrder = groupOrder(z);
                        elseif strcmp(outsideGroup,'None. Forward Order')
                            groupOrder=groupOrder;
                        elseif strcmp(outsideGroup,'None. Reverse Order')
                            groupOrder=fliplr(groupOrder);
                        end
                        indArray=[];
                        for k=1:length(group)
                            indArray=[indArray group{groupOrder(k)}];
                        end
                        tempArray(i,:)=indArray;
                    end
                    indPres = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                else
                    groupOrder = 1:length(group);
                    for t=1:length(fgroup)
                        group{t}=fgroup{t};
                    end
                    if strcmp(insideGroup,'Straight Randomization')
                        for k=1:length(group)
                            for p=rand*100
                                z = randperm(length(group{k}));
                            end
                            group{k}=group{k}(z);
                        end
                    elseif strcmp(insideGroup,'None. Forward Order')
                        for k=1:length(group)
                            group{k}=group{k};
                        end
                    elseif strcmp(insideGroup,'None. Reverse Order')
                        for k=1:length(group)
                            group{k}=fliplr(group{k});
                        end
                    end
                    
                    if strcmp(outsideGroup,'Straight Randomization')
                        for k=rand*100
                            z = randperm(length(group));
                        end
                        groupOrder = groupOrder(z);
                    elseif strcmp(outsideGroup,'None. Forward Order')
                        groupOrder=groupOrder;
                    elseif strcmp(outsideGroup,'None. Reverse Order')
                        groupOrder=fliplr(groupOrder);
                    end
                    
                    indArray=[];
                    for k=1:length(group)
                        indArray=[indArray group{groupOrder(k)}];
                    end
                    
                    for i=1:studyInfo.subNum
                        tempArray(i,:)=indArray;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
                end
                randArray{pres}=indPres;
            end
        elseif strcmp(randPres,'no')
            if strcmp(subRand,'Randomize for each subject')
                groupOrder = 1:length(group);
                for t=1:length(fgroup)
                    group{t}=fgroup{t};
                end
                for i=1:studyInfo.subNum
                    if strcmp(insideGroup,'Straight Randomization')
                        for k=1:length(group)
                            for p=rand*100
                                z = randperm(length(group{k}));
                            end
                            group{k}=group{k}(z);
                        end
                    elseif strcmp(insideGroup,'None. Forward Order')
                        for k=1:length(group)
                            group{k}=group{k};
                        end
                    elseif strcmp(insideGroup,'None. Reverse Order')
                        for k=1:length(group)
                            group{k}=fliplr(group{k});
                        end
                    end
                    
                    if strcmp(outsideGroup,'Straight Randomization')
                        for k=rand*100
                            z = randperm(length(group));
                        end
                        groupOrder = groupOrder(z);
                    elseif strcmp(outsideGroup,'None. Forward Order')
                        groupOrder=groupOrder;
                    elseif strcmp(outsideGroup,'None. Reverse Order')
                        groupOrder=fliplr(groupOrder);
                    end
                    indArray=[];
                    for k=1:length(group)
                        indArray=[indArray group{groupOrder(k)}];
                    end
                    tempArray(i,:)=indArray;
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            else
                groupOrder = 1:length(group);
                for t=1:length(fgroup)
                    group{t}=fgroup{t};
                end
                if strcmp(insideGroup,'Straight Randomization')
                    for k=1:length(group)
                        for p=rand*100
                            z = randperm(length(group{k}));
                        end
                        group{k}=group{k}(z);
                    end
                elseif strcmp(insideGroup,'None. Forward Order')
                    for k=1:length(group)
                        group{k}=group{k};
                    end
                elseif strcmp(insideGroup,'None. Reverse Order')
                    for k=1:length(group)
                        group{k}=fliplr(group{k});
                    end
                end
                
                if strcmp(outsideGroup,'Straight Randomization')
                    for k=rand*100
                        z = randperm(length(group));
                    end
                    groupOrder = groupOrder(z);
                elseif strcmp(outsideGroup,'None. Forward Order')
                    groupOrder=groupOrder;
                elseif strcmp(outsideGroup,'None. Reverse Order')
                    groupOrder=fliplr(groupOrder);
                end
                
                indArray=[];
                for k=1:length(group)
                    indArray=[indArray group{groupOrder(k)}];
                end
                for i=1:studyInfo.subNum
                    tempArray(i,:)=indArray;
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,studyInfo.stimPerRec,studyInfo.recNum]);
            end
            for pres=1:studyInfo.presNum
                randArray{pres} = indPresArray;
            end
        else
            warningMessage = 'You did not enter an acceptable response. Try again.';
            pause(0.1);
            warningInterface(studyInfo,warningMessage);
            drawnow
            return;
        end
    end
    if studyInfo.presNum==1
        randArray=double(randArray);
    else
        for i=1:studyInfo.presNum
            randArray{i}=double(randArray{i});
        end
    end
    handles.output=randArray;
    guidata(hObject, handles);
catch
    warningMessage = sprintf(['You were unable to correctly specify your stim array.',...
        '\nSomething went wrong during stimulus array generation.']);
    pause(0.1);
    warningInterface(studyInfo,warningMessage);
    drawnow
    return;
end

uiresume;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
