function varargout = getGroups(varargin)
% GETGROUPS MATLAB code for getGroups.fig
%   function getGroups
%
%   This getGroups GUI will provide you options in which you can organize
%   your groups. Once you've selected an option this GUI will automatically
%   sort your stimuli into those groups and label accordingly for you. See
%   AudExpCreator User's Guide for a more detailed description of the
%   grouping options available to you.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getGroups

% Last Modified by GUIDE v2.5 30-May-2017 13:17:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getGroups_OpeningFcn, ...
    'gui_OutputFcn',  @getGroups_OutputFcn, ...
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


% --- Executes just before getGroups is made visible.
function getGroups_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getGroups (see VARARGIN)

% Choose default command line output for getGroups
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.uniSpecs = varargin{2};
    
    studyInfo=handles.studyInfo;
    uniSpecs=handles.uniSpecs;
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    
    for i=start:length(studyInfo.stimStruct)
        titles{i}=studyInfo.stimStruct(i).title;
        artists{i}=studyInfo.stimStruct(i).artist;
        types{i}=studyInfo.stimStruct(i).type;
        conds{i}=studyInfo.stimStruct(i).cond;
    end
    
    uniSpecs.title = unique(titles,'stable');
    uniSpecs.artist = unique(artists,'stable');
    uniSpecs.type = unique(types,'stable');
    uniSpecs.cond = unique(conds,'stable');
    
    handles.uniSpecs=uniSpecs;
end

if strcmp(studyInfo.type,'Comparison Behav. Rating Study')
        message='Options with 2 groups, select your option...';
        set(handles.text1,'String',message, 'FontSize', 12, 'FontWeight', 'bold')
        
        groupBy{1}='via stim numbers (odd v. even)';
        groupBy{2}='via stim numbers (split in half)';
        c=3;
        if size(uniSpecs.title,2)==2
            groupBy{c}='via stim title';
            c=c+1;
        end
        if size(uniSpecs.artist,2)==2
            groupBy{c}='via stim artist';
            c=c+1;
        end
        if size(uniSpecs.type,2)==2
            groupBy{c}='via stim type';
            c=c+1;
        end
        if size(uniSpecs.cond,2)==2
            groupBy{c}='via stim conds';
            c=c+1;
        end
        groupBy{c}='via customize 2 stim groups';
        set(handles.popupmenu1,'String',groupBy);
    
elseif isfield(uniSpecs,'constructs')
    if strcmp(uniSpecs.constructs,'Rand. Select. via Exclusive Dual Conditions')
        groupBy{1}='via stim title';
        groupBy{2}='via stim artist';
        groupBy{3}='via stim type';
        groupBy{4}='via stim conds';
        set(handles.popupmenu1,'String',groupBy);
    end
else
    groupBy{1}='via stim numbers (odd v. even)';
    groupBy{2}='via stim numbers (split in half)';
    groupBy{3}='via stim title';
    groupBy{4}='via stim artist';
    groupBy{5}='via stim type';
    groupBy{6}='via stim conds';
    groupBy{7}='via customized stim grouping';
    set(handles.popupmenu1,'String',groupBy);
end

guidata(hObject, handles);
% UIWAIT makes getSpecializedQStruct wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getGroups_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

try
    varargout{1} = handles.gNum;
    varargout{2} = handles.group;
    varargout{3} = handles.groupBy;
    varargout{4} = handles.groupName;
    close;
catch
    varargout{1} = [];
    varargout{2} = [];
    varargout{3} = [];
    varargout{4} = [];
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
handles.groupBy = selectedType;

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

studyInfo=handles.studyInfo;
uniSpecs=handles.uniSpecs;
stimStruct=studyInfo.stimStruct;

try
    groupBy = handles.groupBy;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    groupBy=content{selected};
end

if strcmp(studyInfo.path,'Neurophysiological Study')
    stim=2:studyInfo.stimNum;
    stimNum=length(stim);
else
    stim=1:studyInfo.stimNum;
    stimNum=length(stim);
end

% try

if strcmp(groupBy,'via stim numbers (odd v. even)')
    gNum=2;
    group{1} = stim(mod(stim,2)~=0);
    group{2} = stim(mod(stim,2)==0);
    groupName{1}='odd';
    groupName{2}='even';
elseif strcmp(groupBy,'via stim numbers (split in half)')
    half=round(length(stim)/2);
    group{1} = stim(1:half);
    group{2} = stim(half+1:end);
    gNum=2;
    groupName{1}='1st half';
    groupName{2}='2nd half';
elseif strcmp(groupBy,'via stim title')
    for i=1:length(uniSpecs.title)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.title{i},stimStruct(k).title)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
        groupName{i}=uniSpecs.title{i};
    end
    gNum=length(uniSpecs.title);
elseif strcmp(groupBy,'via stim artist')
    for i=1:length(uniSpecs.artist)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.artist{i},stimStruct(k).artist)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
        groupName{i}=uniSpecs.artist{i};
    end
    gNum=length(uniSpecs.artist);
elseif strcmp(groupBy,'via stim type')
    for i=1:length(uniSpecs.type)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.type{i},stimStruct(k).type)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
        groupName{i}=uniSpecs.type{i};
    end
    gNum=length(uniSpecs.type);
elseif strcmp(groupBy,'via stim conds')
    for i=1:length(uniSpecs.cond)
        group{i}=[];
        for k=1:length(stimStruct)
            if strcmp(uniSpecs.cond{i},stimStruct(k).cond)
                stim = stimStruct(k).stim;
                group{i}=[group{i} stim];
            end
        end
        groupName{i}=uniSpecs.cond{i};
    end
    gNum=length(uniSpecs.cond);
    
elseif strcmp(groupBy,'via customized stim grouping')
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
    elseif gNum==0
        warningMessage = 'Sorry "0" is not allowed here.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
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
        
        group{i}=group{i}';
        groupName{i}=sprintf('cGroup%02d',i);
    end
    stim = [group{:}];
    anyRepeated = ~all(diff(sort(stim)));
    if anyRepeated==1
        warningMessage = 'You repeated stims in your group. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stim)<stimNum
        warningMessage = 'You''ve failed to use all available stimuli in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stim)>stimNum
        warningMessage = 'You''ve exceeded the available stimuli total in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
elseif strcmp(groupBy,'via customize 2 stim groups')
    gNum=2;
    
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
        
        group{i}=group{i}';
        groupName{i}=sprintf('cGroup%02d',i);
    end
    stim = [group{:}];
    anyRepeated = ~all(diff(sort(stim)));
    if anyRepeated==1
        warningMessage = 'You repeated stims in your group. Please try again.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stim)<stimNum
        warningMessage = 'You''ve failed to use all available stimuli in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    elseif length(stim)>stimNum
        warningMessage = 'You''ve exceeded the available stimuli total in your groups.';
        pause(0.1);
        warningInterface(studyInfo,warningMessage);
        drawnow
        return;
    end
end

handles.gNum = gNum;
handles.group = group;
handles.groupBy = groupBy;
handles.groupName = groupName;

guidata(hObject, handles);
% catch
% warningMessage = sprintf(['You were unable to correctly specify your stim groups.',...
%     '\nPlease try another option if this is too hard for you.']);
% warningInterface(studyInfo,warningMessage);
% end

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