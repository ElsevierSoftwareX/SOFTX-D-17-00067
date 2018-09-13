function varargout = getStimArrayConstruct(varargin)
% GETSTIMARRAYCONSTRUCT MATLAB code for getStimArrayConstruct.fig
%   function getStimArrayConstruct
%
%   Based on your selections in the getStimArrayParameters GUI, this
%   getStimArrayConstruct GUI will provide you with options in which you 
%   can construct your stimulus array. Please see AudExpCreator User's 
%   Guide for more detailed descriptions and help with the options as it 
%   can be complicated.
%             
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help getStimArrayConstruct

% Last Modified by GUIDE v2.5 18-May-2017 15:50:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @getStimArrayConstruct_OpeningFcn, ...
    'gui_OutputFcn',  @getStimArrayConstruct_OutputFcn, ...
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


% --- Executes just before getStimArrayConstruct is made visible.
function getStimArrayConstruct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getStimArrayConstruct (see VARARGIN)

% Choose default command line output for getStimArrayConstruct
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    handles.studyInfo = varargin{1};
    handles.arraySit = varargin{2};
    handles.uniSpecs = varargin{3};
catch
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
    handles.arraySit = 1;
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
        for i=1:length(stimStruct)
            titles{i}=stimStruct(i).title;
            artists{i}=stimStruct(i).artist;
            types{i}=stimStruct(i).type;
            conds{i}=stimStruct(i).cond;
        end
    end
    
    uniSpecs.title = unique(titles,'stable');
    uniSpecs.artist = unique(artists,'stable');
    uniSpecs.type = unique(types,'stable');
    uniSpecs.cond = unique(conds,'stable');
    
    handles.uniSpecs = uniSpecs;
end

arraySit = handles.arraySit;

switch arraySit
    case 1
        constructs{1}='Forward Presentation Order';
        constructs{2}='Reverse Presentation Order';
        constructs{3}='Straight Randomization';
        constructs{4}='Customized Randomization';
        constructs{5}='Customized Array of All Stims, No Repetition';
        set(handles.popupmenu1,'String',constructs);
    case 2
        constructs{1}='Randomized Selection of Stims';
        constructs{2}='Randomized Selection via Groups';
        constructs{3}='Probability Selection of Stims';
        constructs{4}='Probability Selection via Groups';
        constructs{5}='Rand. Select. via Exclusive Dual Conditions';
        constructs{6}='Customized Selection of Stims, No Repetition';
        set(handles.popupmenu1,'String',constructs);
    case 3
        constructs{1}='Uniform Repetition of All Stims';
        constructs{2}='Randomized Repetition of All Stims';
        constructs{3}='Probability Repetition of All Stims';
        constructs{4}='Customized Repetition of All Stims';
        constructs{5}='Customized Array of All Stims, Repetition Allowed';
        set(handles.popupmenu1,'String',constructs);
    case 4
        constructs{1}='Randomized Selection + Uniform Repetition';
        constructs{2}='Randomized Selection via Groups + Unifom Repetition';
        constructs{3}='Randomized Selection + Customized Repetition';
        constructs{4}='Randomized Selection via Groups + Customized Repetition';
        constructs{5}='Probability Selection, Repetition Allowed';
        constructs{6}='Probability Selection via Groups, Repetition Allowed';
        constructs{7}='Customized Selections of Stims, Repetition Allowed';
        set(handles.popupmenu1,'String',constructs);
end

guidata(hObject, handles);

% UIWAIT makes getStimArrayConstruct wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getStimArrayConstruct_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

try
    varargout{1} = handles.stimArray;
    varargout{2} = handles.studyInfo;
    delete(hObject);
catch
    varargout{1}=[];
    varargout{2}=[];
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
uniSpecs = handles.uniSpecs;
arraySit = handles.arraySit;

try
    constructs = handles.constructs;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    constructs=content{selected};
end

rng('shuffle');

switch arraySit
    case 1
        if strcmp(constructs,'Forward Presentation Order')
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum=studyInfo.stimNum-1;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            else
                stimNum=studyInfo.stimNum;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            arrayType=2;
            
            normalMessage = ['Please wait while your stimulus arrray via forward',...
                ' presentation order is generated.'];
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            stimArray = generateRandArray(studyInfo,arrayType,studyInfo.presNum,studyInfo.subNum,...
                studyInfo.stimNum,studyInfo.recNum,stimPerRec);
            
            normalMessage = 'Your stimulus array via forward presentation order was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Reverse Presentation Order')
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum=studyInfo.stimNum-1;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            else
                stimNum=studyInfo.stimNum;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            arrayType=3;
            
            normalMessage = ['Please wait while your stimulus array via reverse',...
                ' presentation order is generated.'];
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            stimArray = generateRandArray(studyInfo,arrayType,studyInfo.presNum,studyInfo.subNum,...
                studyInfo.stimNum,studyInfo.recNum, stimPerRec);
            
            normalMessage = 'Your stimulus array via reverse presentation order was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Straight Randomization')
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum=studyInfo.stimNum-1;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            else
                stimNum=studyInfo.stimNum;
                stimPerRec=stimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            arrayType=1;
            
            normalMessage = ['Please wait while your stimulus array ',...
                'via straight randomization is generated.'];
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            stimArray = generateRandArray(studyInfo,arrayType,studyInfo.presNum,studyInfo.subNum,...
                studyInfo.stimNum,studyInfo.recNum, stimPerRec);
            
            normalMessage = 'Your stimulus array via straight randomization was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Customized Randomization')
            
            pause(0.1);
            stimArray = getSpecializedRandArray(studyInfo,uniSpecs);
            drawnow
            
            if isempty(stimArray)
                warningMessage = sprintf(['Your stimulus array was not built.',...
                    '\nPlese try again or consider trying a different method.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                normalMessage = sprintf('Your stimlus array via specified randomization was generated.');
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
            end
            
        elseif strcmp(constructs,'Customized Array of All Stims, No Repetition')
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if studyInfo.presNum==1
                normalMessage = sprintf(['As you''ve selected to customize your stimulus array with no repetition',...
                    ' please be prepared to input stims for all %d of your subjects.',...
                    ' All the available %d stimuli must be used for all subjects.',...
                    ' The length of the stim array should be divisible by %d recording session(s).'],...
                    studyInfo.subNum, stimNum, studyInfo.recNum);
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
                
                for i=1:studyInfo.subNum
                    normalMessage=sprintf(['For subject %d, please input their stim array.',...
                        ' Please use all %d available stimuli.',...
                        ' Repetition of stims is not allowed here.'], i, stimNum);
                    yesString=2;
                    
                    try
                        pause(0.1);
                        selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                        
                        if length(selectedStims(i,:))~=stimNum
                            warningMessage = sprintf(['If you are not using all stims please go back and select "No"',...
                                '\nfor the first stim array parameter question.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        
                    catch
                        warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                            '\nTry again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                tempArray = double(selectedStims);
                
                if mod(size(tempArray,2),studyInfo.recNum)~=0
                    warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                else
                    stimPerRec=size(tempArray,2)/studyInfo.recNum;
                    studyInfo.stimPerRec = stimPerRec;
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
            else
                normalMessage=sprintf(['Do you want to customize stim array for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                
                if strcmp(randPres,'yes')
                    for r=1:studyInfo.presNum
                        normalMessage = sprintf(['As you''ve selected to customize your stimulus array with no repetition',...
                            ' please be prepared to input stims for all %d of your subjects for their %d presentations.',...
                            ' All the available %d stimuli must be used for all subjects.',...
                            ' The length of the stim array should be divisible by %d recording session(s).'],...
                            studyInfo.subNum, studyInfo.presNum, stimNum, studyInfo.recNum);
                        pause(0.1);
                        messageInterface(studyInfo,normalMessage);
                        drawnow
                        
                        for i=1:studyInfo.subNum
                            normalMessage=sprintf(['For subject %d, please input their stim array.',...
                                ' Please use all %d available stimuli.',...
                                ' Repetition of stims is not allowed here.'], i, stimNum);
                            yesString=2;
                            
                            try
                                pause(0.1);
                                selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                                drawnow
                                if length(selectedStims(i,:))~=stimNum
                                    warningMessage = sprintf(['If you are not using all stims please go back and select "No"',...
                                        '\nfor the first stim array parameter question.']);
                                    pause(0.1);
                                    warningInterface(studyInfo,warningMessage);
                                    drawnow
                                    return;
                                end
                                
                            catch
                                warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                    '\nTry again.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                        end
                        
                        tempArray = double(selectedStims);
                        
                        if mod(size(tempArray,2),studyInfo.recNum)~=0
                            warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        else
                            stimPerRec=size(tempArray,2)/studyInfo.recNum;
                            studyInfo.stimPerRec = stimPerRec;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r}= indPres;
                    end
                else
                    normalMessage = sprintf(['As you''ve selected to customize your stimulus array with no repetition',...
                        ' please be prepared to input stims for all %d of your subjects.',...
                        ' All the available %d stimuli must be used for all subjects.',...
                        ' The length of the stim array should be divisible by %d recording session(s).'],...
                        studyInfo.subNum, stimNum, studyInfo.recNum);
                    pause(0.1);
                    messageInterface(studyInfo,normalMessage);
                    drawnow
                    
                    for i=1:studyInfo.subNum
                        normalMessage=sprintf(['For subject %d, please input their stim array.',...
                            ' Please use all %d available stimuli.',...
                            ' Repetition of stims is not allowed here.'], i, stimNum);
                        yesString=2;
                        
                        try
                            pause(0.1);
                            selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                            
                            if length(selectedStims(i,:))~=stimNum
                                warningMessage = sprintf(['If you are not using all stims please go back and select "Yes"',...
                                    '\nfor the first stim array parameter question.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            
                        catch
                            warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                '\nTry again.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    
                    tempArray = double(selectedStims);
                    
                    if mod(size(tempArray,2),studyInfo.recNum)~=0
                        warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    else
                        stimPerRec=size(tempArray,2)/studyInfo.recNum;
                        studyInfo.stimPerRec = stimPerRec;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    
                    for r=1:studyInfo.presNum
                        stimArray{r}= indPres;
                    end
                end
                
            end
        end
        
    case 2
        if strcmp(constructs,'Randomized Selection of Stims')
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                '\nhow many stimuli do you want to randomly select?',...
                '\nPlease remember that you must evenly split your stimuli across %d recording sessions.'], stimNum, studyInfo.recNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nvia randomed selection out of your total of %d usable stims is generated.'], selectStimNum, stimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 1;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, [], []);
            
            normalMessage = 'Your stimulus array via randomized selection was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Randomized Selection via Groups')
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
            
            dString=[];
            for i=1:gNum
                stimInGroup(i)= size(group{i},2);
                dString = ['%d ' dString];
            end
            
            normalMessage = sprintf(['You are grouping your stims %s.',...
                '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy,...
                size(group,2), stimInGroup);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            for i=1:gNum
                normalMessage=sprintf(['From your first group: "%s" with %d stims,',...
                    '\nhow many stim would you like to select?'], groupName{i}, stimInGroup(i));
                yesString=0;
                try
                    pause(0.1);
                    selectStimNum(i)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                catch
                    warningMessage = 'You exit before responding. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            if mod(sum(selectStimNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['You''ve selected %d stimuli to be randomly selected via groups.',...
                    '\nHowever this cannot be evenly divided into %d recording sessions.',...
                    '\nPlease try again.'], sum(selectStimNum),studyInfo.recNum);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif sum(selectStimNum)==studyInfo.stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif sum(selectStimNum)==0
                warningMessage = 'You entered all "0"''s which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=sum(selectStimNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nby randomized selection via group is generated.'], sum(selectStimNum));
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 2;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, gNum, group);
            
            normalMessage = 'Your stimulus array by randomized selection via group was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            
        elseif strcmp(constructs,'Probability Selection of Stims')
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                '\nhow many stimuli do you want to randomly select?',...
                '\nPlease remember that you must evenly split your stimuli across %d recording sessions.'], stimNum, studyInfo.recNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif selectStimNum>stimNum
                warningMessage = sprintf(['The response you entered is greater than the available stimuli total.',...'
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d stims.'...
                ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
                stimNum, stimNum);
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
            elseif ~isequal(length(selectW),stimNum)
                warningMessage = 'Your vector did not have enough elements. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nvia probability selection out of your total of %d stims is generated.'], selectStimNum, studyInfo.stimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 3;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, selectW, []);
            
            normalMessage = 'Your stimulus array via probability selection was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            
        elseif strcmp(constructs,'Probability Selection via Groups')
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
            
            dString=[];
            for i=1:gNum
                stimInGroup(i)= size(group{i},2);
                dString = ['%d ' dString];
            end
            
            normalMessage = sprintf(['You are grouping your stims %s.',...
                '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy,...
                size(group,2), stimInGroup);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            normalMessage=sprintf(['How many stimuli do you want to randomly select total from your groups?',...
                ' Please remember that you must evenly split your stimuli across %d recording sessions.'],studyInfo.recNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d groups.'...
                ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
                gNum, gNum);
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
            elseif ~isequal(length(selectW),gNum)
                warningMessage = 'Your vector did not have enough elements. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nby probability selection via groups is generated.'], selectStimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 4;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, selectW, group);
            
            normalMessage = 'Your stimulus array by probability selection via groups was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Rand. Select. via Exclusive Dual Conditions')
            
            normalMessage = sprintf(['Stims selected here will not duplicate on either conditions. Example:',...
                ' cond. 1: "original" or "mixed"; cond. 2: "hiphop" or "pop" therefore',...
                ' stims selection can only be ["original&pop" "mixed&hiphop"] or ["mixed&pop" "orignal&hiphop"]',...
                ' but never \n["original&pop" "original&hiphop"], etc.']);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            normalMessage = sprintf(['Therefore stims in each conditions must be balanced and dual conditions',...
                ' must only ever be exclusive to a single stim. Example: 16 stims, cond. 1: 4 features,',...
                ' cond. 2: 4 features, therefore only 4 stims would be selected. If unbalanced the number of'...
                ' stims selected will be based off the condition with fewer features.']);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            normalMessage='Would you still like to proceed with this construction option? (''yes'' or ''no'')';
            yesString=1;
            pause(0.1);
            contOn=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(contOn)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(contOn,'no')
                warningMessage = 'Please select a different construction option and try again.';
                pause(0.1);
                messageInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            for i=1:2
                normalMessage = sprintf('Please select your #%d grouping condition.', i);
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
                
                uniSpecs.constructs='Rand. Select. via Exclusive Dual Conditions';
                
                pause(0.1);
                [gNum{i}, group{i}, groupBy{i}, groupName{i}]=getGroups(studyInfo,uniSpecs);
                drawnow
                
                if isempty(gNum)==1
                    warningMessage = 'You exit before selecting groups. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
                
                dString=[];
                for k=1:gNum{i}
                    stimInGroup{i}(k)=size(group{i}{k},2);
                    dString = ['%d ' dString];
                end
                
                normalMessage = sprintf(['You are grouping your stims %s.',...
                    '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy{i},...
                    gNum{i}, stimInGroup{i}(:));
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
            end
            
            if studyInfo.presNum==1
                for i=1:studyInfo.subNum
                    rng('shuffle');
                    for k=rand*100
                        z=randperm(gNum{1});
                        r=randperm(gNum{2});
                    end
                    if length(z)<length(r)
                        for s=1:length(z)
                            noStim=1;
                            while noStim
                                for t=1:length(r)
                                    dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                    temp = dCondStims(diff(dCondStims)==0);
                                    if ~isempty(temp)
                                        if length(temp)>1
                                            stim(s)=datasample(temp,1);
                                        else
                                            stim(s)=temp;
                                        end
                                        noStim=0;
                                    end
                                end
                            end
                        end
                    elseif length(r)<length(z)
                        for s=1:length(r)
                            noStim=1;
                            while noStim
                                for t=1:length(z)
                                    dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                    temp = dCondStims(diff(dCondStims)==0);
                                    if ~isempty(temp)
                                        if length(temp)>1
                                            stim(s)=datasample(temp,1);
                                        else
                                            stim(s)=temp;
                                        end
                                        noStim=0;
                                    end
                                end
                            end
                        end
                    else
                        f=ceil(rand*100);
                        if mod(f,2)==0
                            for s=1:length(z)
                                noStim=1;
                                while noStim
                                    for t=1:length(r)
                                        dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                        temp = dCondStims(diff(dCondStims)==0);
                                        if ~isempty(temp)
                                            if length(temp)>1
                                                stim(s)=datasample(temp,1);
                                            else
                                                stim(s)=temp;
                                            end
                                            noStim=0;
                                        end
                                    end
                                end
                            end
                        elseif mod(f,2)==1
                            for s=1:length(r)
                                noStim=1;
                                while noStim
                                    for t=1:length(z)
                                        dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                        temp = dCondStims(diff(dCondStims)==0);
                                        if ~isempty(temp)
                                            if length(temp)>1
                                                stim(s)=datasample(temp,1);
                                            else
                                                stim(s)=temp;
                                            end
                                            noStim=0;
                                        end
                                    end
                                end
                            end
                        end
                    end
                    tempArray(i,:)=stim;
                end
                
                if mod(size(tempArray,2),studyInfo.recNum)~=0
                    normalMessage=sprintf(['%d stims were randomly selected for each subject. However this does not evenly divide into',...
                        ' your %d recording sessions.',...
                        ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
                        size(tempArray,2), studyInfo.recNum);
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
                        normalMessage=sprintf('How many recording sessions would you like to divide your %d stims into?',...
                            size(tempArray,2));
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
                        elseif ~mod(size(tempArray,2),recNum)==0
                            warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                                ' Pleast try over again or consider a different option.'], recNum, size(tempArray,2));
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        
                        stimPerRec=size(tempArray,2)/recNum;
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
                else
                    stimPerRec=size(tempArray,2)/studyInfo.recNum;
                    studyInfo.stimPerRec = stimPerRec;
                end
                
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomized selection for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmp(randPres,'yes')
                    for p=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            rng('shuffle');
                            for k=rand*100
                                z=randperm(gNum{1});
                                r=randperm(gNum{2});
                            end
                            if length(z)<length(r)
                                for s=1:length(z)
                                    noStim=1;
                                    while noStim
                                        for t=1:length(r)
                                            dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                            temp = dCondStims(diff(dCondStims)==0);
                                            if ~isempty(temp)
                                                if length(temp)>1
                                                    stim(s)=datasample(temp,1);
                                                else
                                                    stim(s)=temp;
                                                end
                                                noStim=0;
                                            end
                                        end
                                    end
                                end
                            elseif length(r)<length(z)
                                for s=1:length(r)
                                    noStim=1;
                                    while noStim
                                        for t=1:length(z)
                                            dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                            temp = dCondStims(diff(dCondStims)==0);
                                            if ~isempty(temp)
                                                if length(temp)>1
                                                    stim(s)=datasample(temp,1);
                                                else
                                                    stim(s)=temp;
                                                end
                                                noStim=0;
                                            end
                                        end
                                    end
                                end
                            else
                                f=ceil(rand*100);
                                if mod(f,2)==0
                                    for s=1:length(z)
                                        noStim=1;
                                        while noStim
                                            for t=1:length(r)
                                                dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                                temp = dCondStims(diff(dCondStims)==0);
                                                if ~isempty(temp)
                                                    if length(temp)>1
                                                        stim(s)=datasample(temp,1);
                                                    else
                                                        stim(s)=temp;
                                                    end
                                                    noStim=0;
                                                end
                                            end
                                        end
                                    end
                                elseif mod(f,2)==1
                                    for s=1:length(r)
                                        noStim=1;
                                        while noStim
                                            for t=1:length(z)
                                                dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                                temp = dCondStims(diff(dCondStims)==0);
                                                if ~isempty(temp)
                                                    if length(temp)>1
                                                        stim(s)=datasample(temp,1);
                                                    else
                                                        stim(s)=temp;
                                                    end
                                                    noStim=0;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            tempArray(i,:)=stim;
                        end
                        
                        if mod(size(tempArray,2),studyInfo.recNum)~=0
                            normalMessage=sprintf(['%d stims were randomly selected for each subject. However this does not evenly divide into',...
                                ' your %d recording sessions.',...
                                ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
                                size(tempArray,2), studyInfo.recNum);
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
                                normalMessage=sprintf('How many recording sessions would you like to divide your %d stims into?',...
                                    size(tempArray,2));
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
                                elseif ~mod(size(tempArray,2),recNum)==0
                                    warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                                        ' Pleast try over again or consider a different option.'], recNum, size(tempArray,2));
                                    pause(0.1);
                                    warningInterface(studyInfo,warningMessage);
                                    drawnow
                                    return;
                                end
                                
                                stimPerRec=size(tempArray,2)/recNum;
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
                        else
                            stimPerRec=size(tempArray,2)/studyInfo.recNum;
                            studyInfo.stimPerRec = stimPerRec;
                        end
                        
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        
                        stimArray{p}=indPres;
                    end
                else
                    for i=1:studyInfo.subNum
                        rng('shuffle');
                        for k=rand*100
                            z=randperm(gNum{1});
                            r=randperm(gNum{2});
                        end
                        if length(z)<length(r)
                            for s=1:length(z)
                                noStim=1;
                                while noStim
                                    for t=1:length(r)
                                        dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                        temp = dCondStims(diff(dCondStims)==0);
                                        if ~isempty(temp)
                                            if length(temp)>1
                                                stim(s)=datasample(temp,1);
                                            else
                                                stim(s)=temp;
                                            end
                                            noStim=0;
                                        end
                                    end
                                end
                            end
                        elseif length(r)<length(z)
                            for s=1:length(r)
                                noStim=1;
                                while noStim
                                    for t=1:length(z)
                                        dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                        temp = dCondStims(diff(dCondStims)==0);
                                        if ~isempty(temp)
                                            if length(temp)>1
                                                stim(s)=datasample(temp,1);
                                            else
                                                stim(s)=temp;
                                            end
                                            noStim=0;
                                        end
                                    end
                                end
                            end
                        else
                            f=ceil(rand*100);
                            if mod(f,2)==0
                                for s=1:length(z)
                                    noStim=1;
                                    while noStim
                                        for t=1:length(r)
                                            dCondStims = sort([group{1}{z(s)} group{2}{r(t)}]);
                                            temp = dCondStims(diff(dCondStims)==0);
                                            if ~isempty(temp)
                                                if length(temp)>1
                                                    stim(s)=datasample(temp,1);
                                                else
                                                    stim(s)=temp;
                                                end
                                                noStim=0;
                                            end
                                        end
                                    end
                                end
                            elseif mod(f,2)==1
                                for s=1:length(r)
                                    noStim=1;
                                    while noStim
                                        for t=1:length(z)
                                            dCondStims = sort([group{2}{r(s)} group{1}{z(t)}]);
                                            temp = dCondStims(diff(dCondStims)==0);
                                            if ~isempty(temp)
                                                if length(temp)>1
                                                    stim(s)=datasample(temp,1);
                                                else
                                                    stim(s)=temp;
                                                end
                                                noStim=0;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        tempArray(i,:)=stim;
                    end
                    
                    if mod(size(tempArray,2),studyInfo.recNum)~=0
                        normalMessage=sprintf(['%d stims were randomly selected for each subject. However this does not evenly divide into',...
                            ' your %d recording sessions.',...
                            ' Would you like to change the number of recording sessions in your study? Type ''yes'' or ''no''.'],...
                            size(tempArray,2), studyInfo.recNum);
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
                            normalMessage=sprintf('How many recording sessions would you like to divide your %d stims into?',...
                                size(tempArray,2));
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
                            elseif ~mod(size(tempArray,2),recNum)==0
                                warningMessage = sprintf(['You entered "%d" which %d pairs is still not evenly divided into.',...
                                    ' Pleast try over again or consider a different option.'], recNum, size(tempArray,2));
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            
                            stimPerRec=size(tempArray,2)/recNum;
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
                    else
                        stimPerRec=size(tempArray,2)/studyInfo.recNum;
                        studyInfo.stimPerRec = stimPerRec;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    
                    for p=1:studyInfo.presNum
                        stimArray{p}=indPres;
                    end
                end
            end
            
        elseif strcmp(constructs,'Customized Selection of Stims, No Repetition')
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if studyInfo.presNum==1
                normalMessage = sprintf(['As you''ve selected to customize your selection of stims with no repetition',...
                    ' please be prepared to input stims for all %d of your subjects.',...
                    ' All subjects should have the the same length for',...
                    ' their stim array and that length should be divisible by %d recording session(s).'],...
                    studyInfo.subNum, studyInfo.recNum);
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
                
                for i=1:studyInfo.subNum
                    normalMessage=sprintf(['For subject %d, please input their stim array.',...
                        ' Please keep the stim array the same length for all subjects.',...
                        ' Repetition of stims is not allowed here.'], i);
                    yesString=2;
                    
                    try
                        pause(0.1);
                        selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                        
                        if length(selectedStims(i,:))==stimNum
                            warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                '\nfor the first stim array parameter question.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                        
                    catch
                        warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                            '\nTry again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                tempArray = double(selectedStims);
                
                if mod(size(tempArray,2),studyInfo.recNum)~=0
                    warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                else
                    stimPerRec=size(tempArray,2)/studyInfo.recNum;
                    studyInfo.stimPerRec = stimPerRec;
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
            else
                normalMessage=sprintf(['Do you want to customize stim array for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmp(randPres,'yes')
                    for r=1:studyInfo.presNum
                        normalMessage = sprintf(['As you''ve selected to customize your selection of stims with no repetition',...
                            ' please be prepared to input stims for all %d of your subjects in their presention #%d.',...
                            ' All subjects should have the the same length for',...
                            ' their stim array for all presentations and that length should be divisible by %d recording session(s).'],...
                            studyInfo.subNum, studyInfo.presNum, studyInfo.recNum);
                        pause(0.1);
                        messageInterface(studyInfo,normalMessage);
                        drawnow
                        
                        for i=1:studyInfo.subNum
                            normalMessage=sprintf(['For subject %d, please input their stim array.',...
                                ' Please keep the stim array the same length for all subjects.',...
                                ' Repetition of stims is not allowed here.'], i);
                            yesString=2;
                            
                            try
                                pause(0.1);
                                selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                                drawnow
                                
                                if length(selectedStims(i,:))==stimNum
                                    warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                        '\nfor the first stim array parameter question.']);
                                    pause(0.1);
                                    warningInterface(studyInfo,warningMessage);
                                    drawnow
                                    return;
                                end
                                
                            catch
                                warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                    '\nTry again.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                        end
                        
                        tempArray = double(selectedStims);
                        
                        if mod(size(tempArray,2),studyInfo.recNum)~=0
                            warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        else
                            stimPerRec=size(tempArray,2)/studyInfo.recNum;
                            studyInfo.stimPerRec = stimPerRec;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r}= indPres;
                    end
                else
                    normalMessage = sprintf(['As you''ve selected to customize your selection of stims with no repetition',...
                        ' please be prepared to input stims for all %d of your subjects.',...
                        ' All subjects should have the the same length for',...
                        ' their stim array and that length should be divisible by %d recording session(s).'],...
                        studyInfo.subNum, studyInfo.recNum);
                    pause(0.1);
                    messageInterface(studyInfo,normalMessage);
                    drawnow
                    
                    for i=1:studyInfo.subNum
                        normalMessage=sprintf(['For subject %d, please input their stim array.',...
                            ' Please keep the stim array the same length for all subjects.',...
                            ' Repetition of stims is not allowed here.'], i);
                        yesString=2;
                        
                        try
                            pause(0.1);
                            selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                            
                            if length(selectedStims(i,:))==stimNum
                                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                    '\nfor the first stim array parameter question.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            
                        catch
                            warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                '\nTry again.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    
                    tempArray = double(selectedStims);
                    
                    if mod(size(tempArray,2),studyInfo.recNum)~=0
                        warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    else
                        stimPerRec=size(tempArray,2)/studyInfo.recNum;
                        studyInfo.stimPerRec = stimPerRec;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    
                    for r=1:studyInfo.presNum
                        stimArray{r}= indPres;
                    end
                end
            end
        end
    case 3
        if strcmp(constructs,'Uniform Repetition of All Stims')
            
            normalMessage=sprintf(['How many repetition(s) do you want for all stims?',...
                '\n''repetition'' means the number of uniformed repeat,',...
                '\ntherefore '' 1 '' repetition for [1 2] means [1 1 2 2].']);
            yesString=0;
            pause(0.1);
            repNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(repNum) || repNum<1
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif repNum==0
                warningMessage = 'You entered "0". It would be better if you choose another option without repetition.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum + 1;
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stim = 2:studyInfo.stimNum;
                stimNum = studyInfo.stimNum - 1;
            else
                stim = 1:studyInfo.stimNum;
                stimNum = studyInfo.stimNum;
            end
            
            if mod((repNum*stimNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['Repetition did not lend itself to an even division into recording sessions.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec = (repNum*stimNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            repStim = repmat(stim,[repNum 1]);
            repStim = repStim(:)';
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [1 1 2 2 3 3 nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to scramble for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r} = indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    for i=1:studyInfo.subNum
                        tempArray(i,:)=repStim;
                    end
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r}= indPres;
                    end
                end
            end
            
        elseif strcmp(constructs,'Randomized Repetition of All Stims')
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
                stim = 2:studyInfo.stimNum;
            else
                stimNum = studyInfo.stimNum;
                stim = 1:studyInfo.stimNum;
            end
            
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                '\nhow many stimuli do you want to randomly select for repetition? Keep in mind that',...
                ' the stimuli not selected will also be presented but just not repeated.'],...
                stimNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Uniform Repetition"',...
                    '\nas your stimulus array construction.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            nonselectStimNum=stimNum - selectStimNum;
            
            normalMessage=sprintf(['How many repetition(s) do you want for your randomly selected stims?',...
                ' ''repetition'' means the number of uniformed repeat,',...
                ' therefore '' 1 '' repetition for [1 2] means [1 1 2 2].',...
                ' Be sure to keep in mind that total length of the stim array (including the nonselected stims) should be divisible by %d recording session(s).'],...
                studyInfo.recNum);
            yesString=0;
            pause(0.1);
            repNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(repNum) || repNum<1
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif repNum==0
                warningMessage = 'You entered "0" which is not valid here. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum + 1;
            
            if mod((repNum*selectStimNum)+nonselectStimNum,studyInfo.recNum)~=0
                warningMessage = 'The length of your stim array was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=((repNum*selectStimNum)+nonselectStimNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [1 1 2 3 3 nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectStim = datasample(stim,selectStimNum,'Replace',false);
                        nonselectStim = setdiff(stim,selectStim);
                        
                        repSelect = repmat(selectStim,[repNum 1]);
                        repSelect = repSelect(:)';
                        
                        repStim = sort([nonselectStim repSelect]);
                        
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomly select for repetition for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectStim = datasample(stim,selectStimNum,'Replace',false);
                                nonselectStim = setdiff(stim,selectStim);
                                
                                repSelect = repmat(selectStim,[repNum 1]);
                                repSelect = repSelect(:)';
                                
                                repStim = sort([nonselectStim repSelect]);
                                
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r} = indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectStim = datasample(stim,selectStimNum,'Replace',false);
                            nonselectStim = setdiff(stim,selectStim);
                            
                            repSelect = repmat(selectStim,[repNum 1]);
                            repSelect = repSelect(:)';
                            
                            repStim = sort([nonselectStim repSelect]);
                            
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectStim = datasample(stim,selectStimNum,'Replace',false);
                        nonselectStim = setdiff(stim,selectStim);
                        
                        repSelect = repmat(selectStim,[repNum 1]);
                        repSelect = repSelect(:)';
                        
                        repStim = sort([nonselectStim repSelect]);
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomly select for repetition for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectStim = datasample(stim,selectStimNum,'Replace',false);
                                nonselectStim = setdiff(stim,selectStim);
                                
                                repSelect = repmat(selectStim,[repNum 1]);
                                repSelect = repSelect(:)';
                                
                                repStim = sort([nonselectStim repSelect]);
                                
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r} = indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectStim = datasample(stim,selectStimNum,'Replace',false);
                            nonselectStim = setdiff(stim,selectStim);
                            
                            repSelect = repmat(selectStim,[repNum 1]);
                            repSelect = repSelect(:)';
                            
                            repStim = sort([nonselectStim repSelect]);
                            
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            end
            
        elseif strcmp(constructs,'Probability Repetition of All Stims')
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            normalMessage=sprintf(['How many stimuli do you want in your stim array via probability repetition?',...
                ' Please remember that you must evenly split your stimuli across %d recording sessions.',...
                ' Number must be greater than the %d total stimuli available due to all stims being used and repetition being allowed.' ], studyInfo.recNum, stimNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d stims.'...
                ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
                stimNum, stimNum);
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
            elseif any(selectW)==0
                warningMessage = 'As all stims have to be present in the array, you cannot use a "0" probability weight.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif ~isequal(length(selectW),stimNum)
                warningMessage = 'Your vector did not have enough elements. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims with repetition',...
                '\nvia probability selection is generated.'], selectStimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 5;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, selectW, []);
            
            normalMessage = 'Your stimulus array with repetition via probability selection was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Customized Repetition of All Stims')
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stim = 2:studyInfo.stimNum;
                stimNum = studyInfo.stimNum-1;
            else
                stim = 1:studyInfo.stimNum;
                stimNum = studyInfo.stimNum;
            end
            
            for i=1:stimNum
                
                if strcmp(studyInfo.type, 'Neurophysiological Study')
                    normalMessage=sprintf(['How many repetition(s) do you want for stim #%d?',...
                        '\n''repetition'' means the number of uniformed repeat,',...
                        '\ntherefore '' 1 '' for stim %d means [...%d %d...]'], i+1, i+1, i+1, i+1);
                    yesString=0;
                else
                    normalMessage=sprintf(['How many repetition(s) do you want for stim #%d?',...
                        '\n''repetition'' means the number of uniformed repeat,',...
                        '\ntherefore '' 1 '' for stim %d means [...%d %d...]'], i, i, i, i);
                    yesString=0;
                end
                
                try
                    pause(0.1);
                    repNum(i)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(repNum(i))
                        warningMessage = sprintf(['You exit before responding.',...
                            '\nPlease try again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                catch
                    warningMessage = sprintf(['You exit before responding.',...
                        '\nPlease try again.']);
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            if sum(repNum)==0
                warningMessage = 'You entered all "0"''s. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum+1;
            
            if mod(sum(repNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['Customized repetition did not lend itself to an even division into recording sessions.',...
                    ' Please try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec = sum(repNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            %%% this is for customized repetition %%%
            index = accumarray(cumsum(repNum)'+1, 1);
            repStim = stim(cumsum(index(1:end-1))+1);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [1 2 2 3 3 3 nth nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to scramble for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r}=indPres;
                        end
                    end
                    
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    for i=1:studyInfo.subNum
                        tempArray(i,:)=repStim;
                    end
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r}=indPres;
                    end
                end
            end
            
        elseif strcmp(constructs,'Customized Array of All Stims, Repetition Allowed')
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if studyInfo.presNum==1
                normalMessage = sprintf(['As you''ve selected to customize your selection of stims with repetition',...
                    ' please be prepared to input stims for all %d of your subjects.',...
                    ' All subjects should have the the same length for',...
                    ' their stim array and that length should be divisible by %d recording session(s).'],...
                    studyInfo.subNum, studyInfo.recNum);
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
                
                for i=1:studyInfo.subNum
                    normalMessage=sprintf(['For subject %d, please input their stim array.',...
                        ' Please keep the stim array the same length for all subjects.',...
                        ' All available stims must be used. Repetition of stims is allowed here'], i);
                    yesString=4;
                    
                    try
                        pause(0.1);
                        selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                        
                        if length(unique(selectedStims(i,:)))~=stimNum
                            warningMessage = sprintf(['If you are not using all stims please go back and select "No"',...
                                '\nfor the first stim array parameter question.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            close;
                        end
                        
                    catch
                        warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                            '\nTry again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                tempArray = double(selectedStims);
                
                if mod(size(tempArray,2),studyInfo.recNum)~=0
                    warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                else
                    stimPerRec=size(tempArray,2)/studyInfo.recNum;
                    studyInfo.stimPerRec = stimPerRec;
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
            else
                normalMessage=sprintf(['Do you want to customize stim array for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmp(randPres,'yes')
                    for r=1:studyInfo.presNum
                        normalMessage = sprintf(['As you''ve selected to customize your selection of stims with repetition',...
                            ' please be prepared to input stims for all %d of your subjects in their presention #%d.',...
                            ' All subjects should have the the same length for',...
                            ' their stim array for all presentations and that length should be divisible by %d recording session(s).'],...
                            studyInfo.subNum, studyInfo.presNum, studyInfo.recNum);
                        pause(0.1);
                        messageInterface(studyInfo,normalMessage);
                        drawnow
                        
                        for i=1:studyInfo.subNum
                            normalMessage=sprintf(['For subject %d, please input their stim array.',...
                                ' Please keep the stim array the same length for all subjects.',...
                                ' All available stims must be used. Repetition of stims is allowed here.'], i);
                            yesString=4;
                            
                            try
                                pause(0.1);
                                selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                                drawnow
                                
                                if length(unique(selectedStims(i,:)))~=stimNum
                                    warningMessage = sprintf(['If you are not using all stims please go back and select "No"',...
                                        '\nfor the first stim array parameter question.']);
                                    pause(0.1);
                                    warningInterface(studyInfo,warningMessage);
                                    drawnow
                                    return;
                                end
                                
                            catch
                                warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                    '\nTry again.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                        end
                        
                        tempArray = double(selectedStims);
                        
                        if mod(size(tempArray,2),studyInfo.recNum)~=0
                            warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        else
                            stimPerRec=size(tempArray,2)/studyInfo.recNum;
                            studyInfo.stimPerRec = stimPerRec;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r}= indPres;
                    end
                else
                    normalMessage = sprintf(['As you''ve selected to customize your selection of stims with no repetition',...
                        ' please be prepared to input stims for all %d of your subjects.',...
                        ' All subjects should have the the same length for',...
                        ' their stim array and that length should be divisible by %d recording session(s).'],...
                        studyInfo.subNum, studyInfo.recNum);
                    pause(0.1);
                    messageInterface(studyInfo,normalMessage);
                    drawnow
                    
                    for i=1:studyInfo.subNum
                        normalMessage=sprintf(['For subject %d, please input their stim array.',...
                            ' Please keep the stim array the same length for all subjects.',...
                            ' All available stims must be used. Repetition of stims is allowed here.'], i);
                        yesString=4;
                        
                        try
                            pause(0.1);
                            selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                            
                            if length(unique(selectedStims(i,:)))~=stimNum
                                warningMessage = sprintf(['If you are not using all stims please go back and select "No"',...
                                    '\nfor the first stim array parameter question.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            
                        catch
                            warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                '\nTry again.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    
                    tempArray = double(selectedStims);
                    
                    if mod(size(tempArray,2),studyInfo.recNum)~=0
                        warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    else
                        stimPerRec=size(tempArray,2)/studyInfo.recNum;
                        studyInfo.stimPerRec = stimPerRec;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    
                    for r=1:studyInfo.presNum
                        stimArray{r}= indPres;
                    end
                end
                
            end
        end
        
    case 4
        if strcmp(constructs,'Randomized Selection + Uniform Repetition')
            
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                '\nhow many stimuli do you want to randomly select?'],...
                studyInfo.stimNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum -1;
                stim = 2:studyInfo.stimNum;
            else
                stimNum = studyInfo.stimNum;
                stim = 1:studyInfo.stimNum;
            end
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            end
            
            normalMessage=sprintf(['How many repetition(s) do you want for your selected stims?',...
                ' ''repetition'' means the number of uniform repeat,',...
                ' therefore '' 1 '' repetition for [2 3] means [2 2 3 3].',...
                ' Please remember that your stim array must evenly divide across %d recording sessions.'], studyInfo.recNum);
            yesString=0;
            pause(0.1);
            repNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(repNum) || repNum<1
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif repNum==0
                warningMessage = 'You entered "0" which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum + 1;
            
            if mod((repNum*selectStimNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['Repetition did not lend itself to an even division into recording sessions.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec = (repNum*selectStimNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [2 2 3 3 nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectedStim = datasample(stim,selectStimNum,'Replace',false);
                        repStim = repmat(selectedStim,[repNum 1]);
                        repStim = repStim(:)';
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomized selection for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectedStim = datasample(stim,selectStimNum,'Replace',false);
                                repStim = repmat(selectedStim,[repNum 1]);
                                repStim = repStim(:)';
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r} = indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectedStim = datasample(stim,selectStimNum,'Replace',false);
                            repStim = repmat(selectedStim,[repNum 1]);
                            repStim = repStim(:)';
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectedStim = datasample(stim,selectStimNum,'Replace',false);
                        repStim = repmat(selectedStim,[repNum 1]);
                        repStim = repStim(:)';
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomized selection for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectedStim = datasample(stim,selectStimNum,'Replace',false);
                                repStim = repmat(selectedStim,[repNum 1]);
                                repStim = repStim(:)';
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r} = indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectedStim = datasample(stim,selectStimNum,'Replace',false);
                            repStim = repmat(selectedStim,[repNum 1]);
                            repStim = repStim(:)';
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            end
            
        elseif strcmp(constructs,'Randomized Selection via Groups + Unifom Repetition')
            
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
            
            dString=[];
            for i=1:gNum
                stimInGroup(i)= size(group{i},2);
                dString = ['%d ' dString];
            end
            
            normalMessage = sprintf(['You are grouping your stims %s.',...
                '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy,...
                size(group,2), stimInGroup);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            for i=1:gNum
                normalMessage=sprintf(['From your group: "%s" with %d stims,',...
                    '\nhow many stim would you like to select?'], groupName{i}, stimInGroup(i));
                yesString=0;
                try
                    pause(0.1);
                    selectStimNum(i)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if selectStimNum(i)>stimInGroup(i)
                        warningMessage = 'You cannot select more stims than there are in the group.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                catch
                    warningMessage = 'You exit before responding. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum -1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if sum(selectStimNum)==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif sum(selectStimNum)==0
                warningMessage = 'You entered all "0"''s which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage=sprintf(['How many repetition(s) do you want for your selected stims?',...
                ' ''repetition'' means the number of uniform repeat,',...
                ' therefore '' 1 '' repetition for [2 3] means [2 2 3 3].',...
                ' Please remember that your stim array must evenly divide across %d recording sessions.'], studyInfo.recNum);
            yesString=0;
            pause(0.1);
            repNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(repNum) || repNum<1
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif repNum==0
                warningMessage = 'You entered "0" which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum + 1;
            
            if mod(repNum*sum(selectStimNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['You''ve selected %d stimuli to be randomly selected via groups.',...
                    '\nHowever this cannot be evenly divided into %d recording sessions.',...
                    '\nPlease try again.'], sum(selectStimNum),studyInfo.recNum);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=repNum*sum(selectStimNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [2 2 3 3 nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        stim=[];
                        for g=1:gNum
                            selected = datasample(group{g},selectStimNum(g),'Replace', false);
                            stim=[stim selected];
                        end
                        repStim = repmat(stim,[repNum 1]);
                        repStim = repStim(:)';
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Do you want to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                stim=[];
                                for g=1:gNum
                                    selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                    stim=[stim selected];
                                end
                                repStim = repmat(stim,[repNum 1]);
                                repStim = repStim(:)';
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            stim=[];
                            for g=1:gNum
                                selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                stim=[stim selected];
                            end
                            repStim = repmat(stim,[repNum 1]);
                            repStim = repStim(:)';
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r}=indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        stim=[];
                        for g=1:gNum
                            selected = datasample(group{g},selectStimNum(g),'Replace', false);
                            stim=[stim selected];
                        end
                        repStim = repmat(stim,[repNum 1]);
                        repStim = repStim(:)';
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                stim=[];
                                for g=1:gNum
                                    selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                    stim=[stim selected];
                                end
                                repStim = repmat(stim,[repNum 1]);
                                repStim = repStim(:)';
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            stim=[];
                            for g=1:gNum
                                selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                stim=[stim selected];
                            end
                            repStim = repmat(stim,[repNum 1]);
                            repStim = repStim(:)';
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            end
            
        elseif strcmp(constructs,'Randomized Selection + Customized Repetition')
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                '\nhow many stimuli do you want to randomly select?'],...
                studyInfo.stimNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum -1;
                stim = 2:studyInfo.stimNum;
            else
                stimNum = studyInfo.stimNum;
                stim = 1:studyInfo.stimNum;
            end
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif selectStimNum==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            end
            
            for i=1:selectStimNum
                
                if strcmp(studyInfo.type,'Neurophysiological Study')
                    normalMessage=sprintf(['How many repetition(s) do you want for selected stim #%d?',...
                        ' ''repetition'' means the number of uniformed repeat,',...
                        ' therefore '' 1 '' for stim %d means [...%d %d...]'], i+1, i+1, i+1, i+1);
                    yesString=0;
                else
                    normalMessage=sprintf(['How many repetition(s) do you want for selected stim #%d?',...
                        ' ''repetition'' means the number of uniformed repeat,',...
                        ' therefore '' 1 '' for stim %d means [...%d %d...]'], i, i, i, i);
                    yesString=0;
                end
                
                try
                    pause(0.1);
                    repNum(i)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if isempty(repNum(i))
                        warningMessage = sprintf(['You exit before responding.',...
                            '\nPlease try again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                catch
                    warningMessage = sprintf(['You exit before responding.',...
                        '\nPlease try again.']);
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            if sum(repNum)==0
                warningMessage = 'You entered all "0"''s which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum+1;
            
            if mod(sum(repNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['Customized repetition did not lend itself to an even division into recording sessions.',...
                    ' Please try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif length(unique(repNum))==1
                warningMessage = sprintf(['If you are using uniform repetition for all your selected stim,',...
                    '\nplease go back and choose that option for your stim array construction.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec = sum(repNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [2 2 3 3 nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectStim = datasample(stim,selectStimNum,'Replace', false);
                        
                        %%% this is for customized repetition %%%
                        index = accumarray(cumsum(repNum)'+1, 1);
                        repStim = selectStim(cumsum(index(1:end-1))+1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Do you want to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectStim = datasample(stim,selectStimNum,'Replace', false);
                                
                                %%% this is for customized repetition %%%
                                index = accumarray(cumsum(repNum)'+1, 1);
                                repStim = selectStim(cumsum(index(1:end-1))+1);
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectStim = datasample(stim,selectStimNum,'Replace', false);
                            
                            %%% this is for customized repetition %%%
                            index = accumarray(cumsum(repNum)'+1, 1);
                            repStim = selectStim(cumsum(index(1:end-1))+1);
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r}=indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        selectStim = datasample(stim,selectStimNum,'Replace', false);
                        
                        %%% this is for customized repetition %%%
                        index = accumarray(cumsum(repNum)'+1, 1);
                        repStim = selectStim(cumsum(index(1:end-1))+1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                selectStim = datasample(stim,selectStimNum,'Replace', false);
                                
                                %%% this is for customized repetition %%%
                                index = accumarray(cumsum(repNum)'+1, 1);
                                repStim = selectStim(cumsum(index(1:end-1))+1);
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            selectStim = datasample(stim,selectStimNum,'Replace', false);
                            
                            %%% this is for customized repetition %%%
                            index = accumarray(cumsum(repNum)'+1, 1);
                            repStim = selectStim(cumsum(index(1:end-1))+1);
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            end
            
        elseif strcmp(constructs,'Randomized Selection via Groups + Customized Repetition')
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
            
            dString=[];
            for i=1:gNum
                stimInGroup(i)= size(group{i},2);
                dString = ['%d ' dString];
            end
            
            normalMessage = sprintf(['You are grouping your stims %s.',...
                '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy,...
                size(group,2), stimInGroup);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            for i=1:gNum
                normalMessage=sprintf(['From your group: "%s" with %d stims,',...
                    '\nhow many stim would you like to select?'], groupName{i}, stimInGroup(i));
                yesString=0;
                try
                    pause(0.1);
                    selectStimNum(i)=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if selectStimNum(i)>stimInGroup(i)
                        warningMessage = 'You cannot select more stims than there are in the group.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                catch
                    warningMessage = 'You exit before responding. Try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                end
            end
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum -1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if sum(selectStimNum)==stimNum
                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                    '\nfor the first stim array parameter question.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                close;
            elseif sum(selectStimNum)==0
                warningMessage = 'You entered all "0"''s which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            k=1;
            for g=1:gNum
                for i=1:selectStimNum(g)
                    
                    if strcmp(studyInfo.type,'Neurophysiological Study')
                        normalMessage=sprintf(['How many repetition(s) do you want for selected stim #%d?',...
                            ' selected from your %s group. ''repetition'' means the number of uniformed repeat,',...
                            ' therefore '' 1 '' for stim %d means [...%d %d...]'], k+1, groupName{g}, k+1, k+1, k+1);
                        yesString=0;
                    else
                        normalMessage=sprintf(['How many repetition(s) do you want for stim #%d?',...
                            ' selected from your "%s group". ''repetition'' means the number of uniformed repeat,',...
                            ' therefore '' 1 '' for stim %d means [...%d %d...]'], k, groupName{g}, k, k, k);
                        yesString=0;
                    end
                    
                    
                    try
                        pause(0.1);
                        repNum(k)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                        
                        if isempty(repNum(k))
                            warningMessage = sprintf(['You exit before responding.',...
                                '\nPlease try again.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    catch
                        warningMessage = sprintf(['You exit before responding.',...
                            '\nPlease try again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                    k=k+1;
                end
            end
            
            if sum(repNum)==0
                warningMessage = 'You entered all "0"''s which is invalid. Please try again or consider a different option.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            repNum = repNum+1;
            
            if mod(sum(repNum),studyInfo.recNum)~=0
                warningMessage = sprintf(['Customized repetition did not lend itself to an even division into recording sessions.',...
                    ' Please try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif length(unique(repNum))==1
                warningMessage = sprintf(['If you are using uniform repetition for all your selected stim,',...
                    '\nplease go back and choose that option for your stim array construction.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec = sum(repNum)/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Would you like to scramble the repetition for each subject? (yes/no)',...
                '\nIf ''no'' stim array will look like this [2 2 3 3 nth nth].']);
            yesString=1;
            pause(0.1);
            yesScram=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if isempty(yesScram)
                warningMessage = sprintf(['Your response was not valid.',...
                    '\nPlease try again.']);
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif strcmp(yesScram,'yes')
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        stim=[];
                        for g=1:gNum
                            selected = datasample(group{g},selectStimNum(g),'Replace', false);
                            stim=[stim selected];
                        end
                        
                        %%% this is for customized repetition %%%
                        index = accumarray(cumsum(repNum)'+1, 1);
                        repStim = stim(cumsum(index(1:end-1))+1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        for k=rand*100
                            z = randperm(length(repStim));
                            repStim = repStim(z);
                        end
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Do you want to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                stim=[];
                                for g=1:gNum
                                    selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                    stim=[stim selected];
                                end
                                
                                %%% this is for customized repetition %%%
                                index = accumarray(cumsum(repNum)'+1, 1);
                                repStim = stim(cumsum(index(1:end-1))+1);
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                for k=rand*100
                                    z = randperm(length(repStim));
                                    repStim = repStim(z);
                                end
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            stim=[];
                            for g=1:gNum
                                selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                stim=[stim selected];
                            end
                            
                            %%% this is for customized repetition %%%
                            index = accumarray(cumsum(repNum)'+1, 1);
                            repStim = stim(cumsum(index(1:end-1))+1);
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            for k=rand*100
                                z = randperm(length(repStim));
                                repStim = repStim(z);
                            end
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r}=indPres;
                        end
                    end
                end
            else
                if studyInfo.presNum==1
                    for i=1:studyInfo.subNum
                        stim=[];
                        for g=1:gNum
                            selected = datasample(group{g},selectStimNum(g),'Replace', false);
                            stim=[stim selected];
                        end
                        
                        %%% this is for customized repetition %%%
                        index = accumarray(cumsum(repNum)'+1, 1);
                        repStim = stim(cumsum(index(1:end-1))+1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        tempArray(i,:)=repStim;
                    end
                    stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                else
                    normalMessage=sprintf(['Would you like to randomized selection via groups for each stim presentation?',...
                        ' Please type ''yes'' or ''no''.']);
                    yesString=1;
                    pause(0.1);
                    randPres=userRespInterface(studyInfo,normalMessage,yesString);
                    drawnow
                    
                    if strcmp(randPres,'yes')
                        for r=1:studyInfo.presNum
                            for i=1:studyInfo.subNum
                                stim=[];
                                for g=1:gNum
                                    selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                    stim=[stim selected];
                                end
                                
                                %%% this is for customized repetition %%%
                                index = accumarray(cumsum(repNum)'+1, 1);
                                repStim = stim(cumsum(index(1:end-1))+1);
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                tempArray(i,:)=repStim;
                            end
                            indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                            stimArray{r}=indPres;
                        end
                    else
                        for i=1:studyInfo.subNum
                            stim=[];
                            for g=1:gNum
                                selected = datasample(group{g},selectStimNum(g),'Replace', false);
                                stim=[stim selected];
                            end
                            
                            %%% this is for customized repetition %%%
                            index = accumarray(cumsum(repNum)'+1, 1);
                            repStim = stim(cumsum(index(1:end-1))+1);
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            tempArray(i,:)=repStim;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        for r=1:studyInfo.presNum
                            stimArray{r} = indPres;
                        end
                    end
                end
            end
            
        elseif strcmp(constructs,'Probability Selection, Repetition Allowed')
            
            normalMessage=sprintf(['Out of your total %d stimuli,',...
                ' how many stimuli do you want to randomly select?',...
                ' Please remember that you must evenly split your stimuli across %d recording sessions.',...
                ' Number can be greater than total stimuli available due to repetition being allowed.' ],studyInfo.stimNum, studyInfo.recNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmp(studyInfo.type,'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d stims.'...
                ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
                stimNum, stimNum);
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
            elseif ~isequal(length(selectW),stimNum)
                warningMessage = 'Your vector did not have enough elements. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nvia probability selection with repetition is generated.'], selectStimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 6;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, selectW, []);
            
            normalMessage = 'Your stimulus array via probability selection with repetition was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
        elseif strcmp(constructs,'Probability Selection via Groups, Repetition Allowed')
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
            
            dString=[];
            for i=1:gNum
                stimInGroup(i)= size(group{i},2);
                dString = ['%d ' dString];
            end
            
            normalMessage = sprintf(['You are grouping your stims %s.',...
                '\nThere are %d groups and [' dString '] stimuli in them respectively. '], groupBy,...
                size(group,2), stimInGroup);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            normalMessage=sprintf(['How many stimuli do you want to randomly select total from your groups?',...
                ' Please remember that you must evenly split your stimuli across %d recording sessions.',...
                ' Number can be greater than total stimuli available due to repetition being allowed.'],studyInfo.recNum);
            yesString=0;
            pause(0.1);
            selectStimNum=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if selectStimNum==0
                warningMessage = sprintf('You entered "0" which is an unacceptable response.\nPlease try again.');
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif isempty(selectStimNum)==1
                warningMessage = 'You exit before responding. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            elseif mod(selectStimNum,studyInfo.recNum)~=0
                warningMessage = 'Your selected stim number was not divisible by recording session number. Please try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            else
                stimPerRec=selectStimNum/studyInfo.recNum;
                studyInfo.stimPerRec = stimPerRec;
            end
            
            normalMessage=sprintf(['Please enter a vector of %d probability weights for your %d groups.'...
                ' Probability weights must be in decimal. The sum of the vector must add up to 1.'],...
                gNum, gNum);
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
            elseif ~isequal(length(selectW),gNum)
                warningMessage = 'Your vector did not have enough elements. Try again.';
                pause(0.1);
                warningInterface(studyInfo,warningMessage);
                drawnow
                return;
            end
            
            normalMessage = sprintf(['Please wait while your stimulus array of %d stims',...
                '\nby probability selection via groups with repetition is generated.'], selectStimNum);
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            randType = 7;
            stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, selectW, group);
            
            normalMessage = 'Your stimulus array by probability selection via groups with repetition was generated.';
            pause(0.1);
            messageInterface(studyInfo,normalMessage);
            drawnow
            
            
            
        elseif strcmp(constructs,'Customized Selections of Stims, Repetition Allowed')
            
            if strcmp(studyInfo.type, 'Neurophysiological Study')
                stimNum = studyInfo.stimNum-1;
            else
                stimNum = studyInfo.stimNum;
            end
            
            if studyInfo.presNum==1
                normalMessage = sprintf(['As you''ve selected to customize your selection of stims with repetition',...
                    ' please be prepared to input stims for all %d of your subjects.',...
                    ' All subjects should have the the same length for',...
                    ' their stim array and that length should be divisible by %d recording session(s).'],...
                    studyInfo.subNum, studyInfo.recNum);
                pause(0.1);
                messageInterface(studyInfo,normalMessage);
                drawnow
                
                for i=1:studyInfo.subNum
                    normalMessage=sprintf(['For subject %d, please input their stim array.',...
                        ' Please keep the stim array the same length for all subjects.',...
                        ' Repetition of stims is allowed here.'], i);
                    yesString=4;
                    
                    try
                        pause(0.1);
                        selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                        drawnow
                        
                        if length(unique(selectedStims(i,:)))==stimNum
                            warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                '\nfor the first stim array parameter question.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            close;
                        end
                        
                    catch
                        warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                            '\nTry again.']);
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    end
                end
                
                tempArray = double(selectedStims);
                
                if mod(size(tempArray,2),studyInfo.recNum)~=0
                    warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                    pause(0.1);
                    warningInterface(studyInfo,warningMessage);
                    drawnow
                    return;
                else
                    stimPerRec=size(tempArray,2)/studyInfo.recNum;
                    studyInfo.stimPerRec = stimPerRec;
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
            else
                normalMessage=sprintf(['Do you want to customize stim array for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmp(randPres,'yes')
                    for r=1:studyInfo.presNum
                        normalMessage = sprintf(['As you''ve selected to customize your selection of stims with repetition',...
                            ' please be prepared to input stims for all %d of your subjects in their presention #%d.',...
                            ' All subjects should have the the same length for',...
                            ' their stim array for all presentations and that length should be divisible by %d recording session(s).'],...
                            studyInfo.subNum, studyInfo.presNum, studyInfo.recNum);
                        pause(0.1);
                        messageInterface(studyInfo,normalMessage);
                        drawnow
                        
                        for i=1:studyInfo.subNum
                            normalMessage=sprintf(['For subject %d, please input their stim array.',...
                                ' Please keep the stim array the same length for all subjects.',...
                                ' Repetition of stims is allowed here.'], i);
                            yesString=4;
                            
                            try
                                pause(0.1);
                                selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                                drawnow
                                
                                if length(unique(selectedStims(i,:)))==stimNum
                                    warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                        '\nfor the first stim array parameter question.']);
                                    pause(0.1);
                                    warningInterface(studyInfo,warningMessage);
                                    drawnow
                                    return;
                                end
                                
                            catch
                                warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                    '\nTry again.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                        end
                        
                        tempArray = double(selectedStims);
                        
                        if mod(size(tempArray,2),studyInfo.recNum)~=0
                            warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        else
                            stimPerRec=size(tempArray,2)/studyInfo.recNum;
                            studyInfo.stimPerRec = stimPerRec;
                        end
                        indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r}= indPres;
                    end
                else
                    normalMessage = sprintf(['As you''ve selected to customize your selection of stims with no repetition',...
                        ' please be prepared to input stims for all %d of your subjects.',...
                        ' All subjects should have the the same length for',...
                        ' their stim array and that length should be divisible by %d recording session(s).'],...
                        studyInfo.subNum, studyInfo.recNum);
                    pause(0.1);
                    messageInterface(studyInfo,normalMessage);
                    drawnow
                    
                    for i=1:studyInfo.subNum
                        normalMessage=sprintf(['For subject %d, please input their stim array.',...
                            ' Please keep the stim array the same length for all subjects.',...
                            ' Repetition of stims is allowed here.'], i);
                        yesString=4;
                        
                        try
                            pause(0.1);
                            selectedStims(i,:)=userRespInterface(studyInfo,normalMessage,yesString);
                            drawnow
                            
                            if length(unique(selectedStims(i,:)))==stimNum
                                warningMessage = sprintf(['If you are using all stims please go back and select "Yes"',...
                                    '\nfor the first stim array parameter question.']);
                                pause(0.1);
                                warningInterface(studyInfo,warningMessage);
                                drawnow
                                return;
                            end
                            
                        catch
                            warningMessage = sprintf(['You exit before responding or stim array dimensions did not match.',...
                                '\nTry again.']);
                            pause(0.1);
                            warningInterface(studyInfo,warningMessage);
                            drawnow
                            return;
                        end
                    end
                    
                    tempArray = double(selectedStims);
                    
                    if mod(size(tempArray,2),studyInfo.recNum)~=0
                        warningMessage = 'Your stim array was not divisible by recording session number. Please try again.';
                        pause(0.1);
                        warningInterface(studyInfo,warningMessage);
                        drawnow
                        return;
                    else
                        stimPerRec=size(tempArray,2)/studyInfo.recNum;
                        studyInfo.stimPerRec = stimPerRec;
                    end
                    
                    indPres = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    
                    for r=1:studyInfo.presNum
                        stimArray{r}= indPres;
                    end
                end
                
            end
        end
end

handles.studyInfo = studyInfo;
handles.stimArray = stimArray;
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
