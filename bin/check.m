function varargout = check(varargin)
% CHECK MATLAB code for check.fig
%   function check
%
%   This check GUI is an addon tool tagged onto each study experiment as it
%   is created. This tool helps to check and maintain the operational
%   integrity of the study experiment. It helps users update and fix paths,
%   check for missing folders and objects, change between "Device Ready"
%   and "Not Ready", etc. To use, simply type check into the Matlab Command
%   Window while in the study experiment directory.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

% Edit the above text to modify the response to help check

% Last Modified by GUIDE v2.5 30-Jun-2017 13:04:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @check_OpeningFcn, ...
    'gui_OutputFcn',  @check_OutputFcn, ...
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


% --- Executes just before check is made visible.
function check_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to check (see VARARGIN)

addpath(genpath(pwd));

try
    warningMessage = sprintf(['Please wait while "check" does its job!',...
        '\nIf it finds something it will pop up fix suggestions for you followed by the fix selection box.']);
    pause(0.1);
    updateMInterface([],warningMessage);
    drawnow
catch
    if ~(exist('sup','dir')==7)
        warningMessage = ['The ''sup'' folder is missing from your experiment.',...
            ' "check.m" cannot run without the sup folder. "check" cannot help with this.',...
            ' Go and remake this experiment again. To get a new check add-on tool.'];
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        error('prog:input',['\n\nERROR: Your sup folder is missing!',...
            '\n"check.m" will not help. Go remake your experiment. \nGoodbye!']);
    else
        warningMessage = ['"check.m" is missing its essential functions from the ''sup'' folder.',...
            ' "check.m" cannot run without these functions . "check" cannot help with this.',...
            ' Go and remake this experiment again. To get a new check add-on tool.'];
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        error('prog:input',['\n\nERROR: Your "check.m" is corrupt!',...
            '\n"check.m" will not help. Go remake your experiment. \nGoodbye!']);
    end
end

% Choose default command line output for check
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    load('studyInfo.mat')
    handles.studyInfo = studyInfo;
catch
    warningMessage = sprintf(['The "studyInfo" is missing from your experiment.',...
        '\n"check" will now exit and error.']);
    pause(0.1);
    updateWInterface([],warningMessage);
    drawnow
    error('prog:input',['\n\nERROR: Your "studyInfo.mat" is missing!',...
        '\n"check.m" cannot run without "studyInfo". Goodbye!']);
end

if ~(exist('stimulus','dir')==7)
    warningMessage = ['The ''stimulus'' folder is missing from your experiment.',...
        ' Your experiment will fail to run. "check" cannot help with this.',...
        ' Go and remake this experiment again.'];
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    error('prog:input',['\n\nERROR: Your stimulus folder is missing!',...
        '\n"check.m" will not help. Go remake your experiment. \nGoodbye!']);
else
    if numel(dir('stimulus'))<=2
        warningMessage = ['The ''stimulus'' folder is empty! Your stimuli are missing!',...
            ' Your experiment will fail to run. "check" cannot help with this.',...
            ' Go and remake this experiment again.'];
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        error('prog:input',['\n\nERROR: Your stimulus folder is empty!',...
            '\n"check.m" will not help. Go remake your experiment. \nGoodbye!']);
    end
end

handles.message=sprintf('Let''s fix %s...', studyInfo.name);
set(handles.text2,'String',handles.message, 'FontSize', 12, 'FontWeight', 'bold')

c=1;
stimStruct = [studyInfo.stimStructName '.mat'];
if ~(exist(stimStruct,'file')==2)
    warningMessage = sprintf(['It seems that your stimulus structure, %s, is missing.',...
        ' Please use "Restore stim struct" to get it back.',...
        ' If not, your experiment will not run.'], stimStruct);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Restore stim struct';
    c=c+1;
end

stimArray = [studyInfo.stimArrayName '.mat'];
if ~(exist(stimArray,'file')==2)
    warningMessage = sprintf(['It seems that your stimulus array, %s, is missing.',...
        ' Please use "Restore stim array" to get it back.',...
        ' If not, your experiment will not run.'], stimArray);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Restore stim array';
    c=c+1;
end

if strcmp(studyInfo.type,'Behavioral Rating Study')
    qStruct = [studyInfo.qStructName '.mat'];
    if ~(exist(qStruct,'file')==2)
        warningMessage = sprintf(['It seems that your question structure, %s, is missing.',...
            ' Please use "Restore question struct" to get it back.',...
            ' If not, your experiment will not run.'], qStruct);
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        
        fixOpts{c}='Restore question struct';
        c=c+1;
    end
elseif strcmp(studyInfo.type, 'Comparison Behav. Rating Study')
    qStruct = [studyInfo.qStructName '.mat'];
    if ~(exist(qStruct,'file')==2)
        warningMessage = sprintf(['It seems that your question structure, %s, is missing.',...
            ' Please use "Restore question struct" to get it back.',...
            ' If not, your experiment will not run.'], qStruct);
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        
        fixOpts{c}='Restore question struct';
        c=c+1;
    end
elseif strcmp(studyInfo.type,'Continuous Behav. Rating Study')
    insStruct = [studyInfo.insStructName '.mat'];
    if ~(exist(insStruct,'file')==2)
        warningMessage = sprintf(['It seems that your instruction structure, %s, is missing.',...
            ' Please use "Restore instruction struct" to get it back.',...
            ' If not, your experiment will not run.'], insStruct);
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        
        fixOpts{c}='Restore instruction struct';
        c=c+1;
    end
    
    if ~strcmp(studyInfo.coBeInfo.questOpts,'No end question(s)')
        qStruct = [studyInfo.qStructName '.mat'];
        if ~(exist(qStruct,'file')==2)
            warningMessage = sprintf(['It seems that your question structure, %s, is missing.',...
                ' Please use "Restore question struct" to get it back.',...
                ' If not, your experiment will not run.'], qStruct);
            pause(0.1);
            updateWInterface(studyInfo,warningMessage);
            drawnow
            
            fixOpts{c}='Restore question struct';
            c=c+1;
        end
    end
elseif strcmp(studyInfo.type,'EEG Study')
    if ~strcmp(studyInfo.eSInfo.questOpts,'No question(s)')
        qStruct = [studyInfo.qStructName '.mat'];
        if ~(exist(qStruct,'file')==2)
            warningMessage = sprintf(['It seems that your question structure, %s, is missing.',...
                ' Please use "Restore question struct" to get it back.',...
                ' If not, your experiment will not run.'], qStruct);
            pause(0.1);
            updateWInterface(studyInfo,warningMessage);
            drawnow
            
            fixOpts{c}='Restore question struct';
            c=c+1;
        end
    end
elseif strcmp(studyInfo.type,'Neurophysiological Study')
    if ~strcmp(studyInfo.nSInfo.questOpts,'No question(s)')
        qStruct = [studyInfo.qStructName '.mat'];
        if ~(exist(qStruct,'file')==2)
            warningMessage = sprintf(['It seems that your question structure, %s, is missing.',...
                ' Please use "Restore question struct" to get it back.',...
                ' If not, your experiment will not run.'], qStruct);
            pause(0.1);
            updateWInterface(studyInfo,warningMessage);
            drawnow
            
            fixOpts{c}='Restore question struct';
            c=c+1;
        end
    end
end

if studyInfo.yesData==1
    if ~(exist('data','dir')==7)
        warningMessage = sprintf(['It seems that your data folder is missing.',...
            ' Please use "Restore data folder" to remake it.',...
            ' If not, your experiment will not run.'], qStruct);
        pause(0.1);
        updateWInterface(studyInfo,warningMessage);
        drawnow
        
        fixOpts{c}='Restore data folder';
        c=c+1;
    end
end

if ~(exist('log','dir')==7)
    warningMessage = sprintf(['It seems that your log folder is missing.',...
        ' Please use "Restore log folder" to remake it.',...
        ' If not, your experiment will not run.'], qStruct);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Restore log folder';
    c=c+1;
end

currPath=pwd;
if ~strcmp(studyInfo.path,currPath)
    warningMessage = sprintf(['Currently, the physical location of your experiment is in: %s.',...
        ' However, your experiment is still registered to be in: %s.',...
        ' Please use "Update path" to correctly update all the path information.',...
        ' If not, your experiment will not run.'], currPath, studyInfo.path);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Update path';
    c=c+1;
end

if strcmp(studyInfo.niReady,'Not NI Device Ready')
    warningMessage = sprintf(['Currently, your experiment is set to "Not NI Device Ready.',...
        ' If you would like to change this to "Yes NI Device Ready",',...
        ' please select the "Update to "Yes NI Device Ready"".',...
        ' If not, your experiment will still run, just without sending out triggers.']);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Update to "Yes NI Device Ready"';
    c=c+1;
elseif strcmp(studyInfo.niReady,'Yes NI Device Ready')
    warningMessage = sprintf(['Currently, your experiment is set to "Yes NI Device Ready.',...
        ' If you would like to change this to "Not NI Device Ready",',...
        ' please select the "Update to "Not NI Device Ready"".',...
        ' If not, your experiment might fail to run if your NI Device is not plugged in.']);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Update to "Not NI Device Ready"';
    c=c+1;
elseif strcmp(studyInfo.niReady,'Not Ethernet Ready')
    warningMessage = sprintf(['Currently, your experiment is set to "Not Ethernet Ready.',...
        ' If you would like to change this to "Yes Ethernet Ready",',...
        ' please select the "Update to "Yes Ethernet Ready"".',...
        ' If not, your experiment will still run, just without sending out triggers.']);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Update to "Yes Ethernet Ready"';
    c=c+1;
elseif strcmp(studyInfo.niReady,'Yes Ethernet Ready')
    warningMessage = sprintf(['Currently, your experiment is set to "Yes Ethernet Ready.',...
        ' If you would like to change this to "Not Ethernet Ready",',...
        ' please select the "Update to "Not Ethernet Ready"".',...
        ' If not, your experiment might fail to run if you are not TCP/IP connected via ethernet cable.']);
    pause(0.1);
    updateWInterface(studyInfo,warningMessage);
    drawnow
    
    fixOpts{c}='Update to "Not Ethernet Ready"';
    c=c+1;
end

if c>1
    fixOpts{c}='Do nothing';
end

try
    set(handles.popupmenu1,'String',fixOpts);
    guidata(hObject, handles);
    uiwait(handles.figure1);
catch
    warningMessage = 'Everything checked out! Your experiment is good to go! Goodbye!';
    updateMInterface(studyInfo,warningMessage);
    close;
end
% UIWAIT makes check wait for user response (see UIRESUME)



% --- Outputs from this function are returned to the command line.
function varargout = check_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=[];
varargout{1} = handles.output;
close;


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
handles.fixOpts = selectedType;

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

try
    fixOpts = handles.fixOpts;
catch
    content=get(handles.popupmenu1,'String');
    selected=get(handles.popupmenu1,'Value');
    fixOpts=content{selected};
end

if strcmp(fixOpts, 'Restore stim struct')
    currPath=pwd;
    
    eval([studyInfo.stimStructName '= studyInfo.stimStruct;']);
    save([currPath filesep studyInfo.stimStructName '.mat'],...
        studyInfo.stimStructName);
    
    warningMessage = sprintf('Your stimulus structure, "%s.mat", is now restored!',...
        studyInfo.stimStructName);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts, 'Restore stim array')
    currPath=pwd;
    
    eval([studyInfo.stimArrayName '= studyInfo.stimArray;']);
    save([currPath filesep studyInfo.stimArrayName '.mat'],...
        studyInfo.stimArrayName);
    
    warningMessage = sprintf('Your stimulus array, "%s.mat", is now restored!',...
        studyInfo.stimArrayName);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Restore question struct')
    currPath=pwd;
    
    eval([studyInfo.qStructName '= studyInfo.qStruct;']);
    save([currPath filesep studyInfo.qStructName '.mat'],...
        studyInfo.qStructName);
    
    warningMessage = sprintf('Your question structure, "%s.mat", is now restored!',...
        studyInfo.qStructName);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Restore instruction struct')
    currPath=pwd;
    
    eval([studyInfo.insStructName '= studyInfo.insStruct;']);
    save([currPath filesep studyInfo.insStructName '.mat'],...
        studyInfo.insStructName);
    
    warningMessage = sprintf('Your question structure, "%s.mat", is now restored!',...
        studyInfo.insStructName);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Restore data folder')
    currPath=pwd;
    
    mkdir(currPath,'data');
    
    warningMessage = 'A new "data" folder was made!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Restore log folder')
    currPath=pwd;
    
    mkdir(currPath,'log');
    
    warningMessage = 'A new "log" folder was made!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Update path')
    currPath=pwd;
    
    studyInfo.path = currPath;
    studyInfo.stimPath=[currPath filesep 'stimulus'];
    studyInfo.logPath=[currPath filesep 'log'];
    
    if studyInfo.yesData==1
        studyInfo.dataPath=[currPath filesep 'data'];
    end
    
    warningMessage = sprintf(['The paths of %s were updated. Please wait',...
        ' while the paths in the stimulus structure are also updated.'], studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    stimStruct = studyInfo.stimStruct;
    
    for i=1:size(stimStruct,2)
        stimName = sprintf('%02d.wav', i);
        stimStruct(i).file=[studyInfo.stimPath filesep stimName];
    end
    
    studyInfo.stimStruct = stimStruct;
    
    eval([studyInfo.stimStructName '= studyInfo.stimStruct;']);
    save([currPath filesep studyInfo.stimStructName '.mat'],...
        studyInfo.stimStructName);
    
    warningMessage = sprintf('The paths in your stimulus structure, "%s.mat", were now updated!',...
        studyInfo.stimStructName);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    updateWUserGuide(studyInfo);
    
    warningMessage = sprintf('%s''s README-FIRST: User''s Guide was also updated to reflect the new paths.', studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Path has been fully updated. Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Update to "Yes NI Device Ready"')
    
    mainTrial = sprintf('%sExp.m', studyInfo.name);
    if isfield(studyInfo, 'qStruct')
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'questionTrial.m', 'stimTrial.m', mainTrial};
        reWriteFLine = {'rTrial', 'bTrial', 'eTrial', 'qTrial', 'sTrial'};
    else
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'stimTrial.m', mainTrial};
        reWriteFLine = {'rTrial', 'bTrial', 'eTrial', 'sTrial'};
    end
    
    for i=1:length(reWriteFiles)
        
        fID = fopen(reWriteFiles{i},'r');
        numLines=0;
        tline = fgetl(fID);
        while ischar(tline)
            tline = fgetl(fID);
            numLines = numLines+1;
        end
        fclose(fID);
        
        fID = fopen(reWriteFiles{i},'r');
        line = cell(1,numLines);
        for k=1:numLines
            line{k}=fgetl(fID);
        end
        fclose(fID);
        
        if strcmp(reWriteFiles{i},mainTrial)
            
            repLine1 = strfind(line,');%');
            
            for p=1:length(repLine1)
                if ~isempty(repLine1{p})
                    line{p}=strrep(line{p},');%, s)',', s);');
                end
            end
            
            repLine1 = strfind(line,'%');
            
            start=2;
            for t=start:length(repLine1)
                if isempty(repLine1{t})
                    start=t;
                    break;
                end
            end
            
            for p=start:length(repLine1)
                if ~isempty(repLine1{p})
                    line{p}=strrep(line{p},'% ','');
                end
            end
            
        else
            line{1}=strrep(line{1},')%', '');
            line{2}=sprintf('%% %s', line{1});
            studyInfo.fLine.(reWriteFLine{i}) = line{1}(10:end);
            
            repLine = strfind(line,'%');
            
            start=2;
            for t=start:length(repLine)
                if isempty(repLine{t})
                    start=t;
                    break;
                end
            end
            
            for p=start:length(repLine)
                if ~isempty(repLine{p})
                    line{p}=strrep(line{p},'% ','');
                end
            end
            
            if strcmp(reWriteFiles{i},'stimTrial.m')
                repLine = strfind(line,'PsychPortAudio(''Start'', pahandle, 1, 0, 0);');
                repInd = find(not(cellfun('isempty', repLine)));
                line{repInd}=sprintf('%% %s', line{repInd});
            end
        end
        fID = fopen(reWriteFiles{i},'w');
        fprintf(fID,'%s\n',line{:});
        fclose(fID);
        
        clear line rep*
    end
    
    studyInfo.niReady='Yes NI Device Ready';
    
    warningMessage = sprintf('%s files have now been updated to "Yes NI Device Ready"!',...
        studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    updateWUserGuide(studyInfo);
    
    warningMessage = sprintf('%s''s README-FIRST: User''s Guide was also updated to reflect "Yes NI Device Ready"!', studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Update to "Yes NI Device Ready" is completed. Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Update to "Not NI Device Ready"')

    mainTrial = sprintf('%sExp.m', studyInfo.name);
    if isfield(studyInfo, 'qStruct')
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'questionTrial.m', 'stimTrial.m', mainTrial};
        reWriteFLine = {'rTrial', 'bTrial', 'eTrial', 'qTrial', 'sTrial'};
    else
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'stimTrial.m', mainTrial};
        reWriteFLine = {'rTrial', 'bTrial', 'eTrial', 'sTrial'};
    end
    
    
    for i=1:length(reWriteFiles)
        
        fID = fopen(reWriteFiles{i},'r');
        numLines=0;
        tline = fgetl(fID);
        while ischar(tline)
            tline = fgetl(fID);
            numLines = numLines+1;
        end
        fclose(fID);
        
        fID = fopen(reWriteFiles{i},'r');
        line = cell(1,numLines);
        for k=1:numLines
            line{k}=fgetl(fID);
        end
        fclose(fID);
        
        if strcmp(reWriteFiles{i},mainTrial)
            
            repLine1 = strfind(line,'s = startNIDevice');
            repInd1 = find(not(cellfun('isempty', repLine1)));
            line{repInd1}=sprintf('%% %s', line{repInd1});
            
            repLine2 = strfind(line,'readyTrial');
            repInd2 = find(not(cellfun('isempty', repLine2)));
            line{repInd2}=sprintf('%s);%%, s)',line{repInd2}(1:end-5));
            
            repLine3 = strfind(line,'breakTrial');
            repInd3 = find(not(cellfun('isempty', repLine3)));
            for p=1:length(repInd3)
                line{repInd3(p)}=sprintf('%s);%%, s)',line{repInd3(p)}(1:end-5));
            end
            
            repLine4 = strfind(line,'endTrial');
            repInd4 = find(not(cellfun('isempty', repLine4)));
            line{repInd4}=sprintf('%s);%%, s)',line{repInd4}(1:end-5));
            
                        
            repLine5 = strfind(line,'stimTrial');
            repInd5 = find(not(cellfun('isempty', repLine5)));
            line{repInd5}=sprintf('%s);%%, s)',line{repInd5}(1:end-5));
            
            if i==6
                repLine6 = strfind(line,'questionTrial');
                repInd6 = find(not(cellfun('isempty', repLine6)));
                line{repInd6}=sprintf('%s);%%, s)',line{repInd6}(1:end-5));
            end
            
        elseif strcmp(reWriteFiles{i},'stimTrial.m')
            repLine1 = strfind(line,'t=timer;');
            repInd1 = find(not(cellfun('isempty', repLine1)));
            line{repInd1}=sprintf('%% %s', line{repInd1});
            line{repInd1+1}=sprintf('%% %s', line{repInd1+1});
            line{repInd1+2}=sprintf('%% %s', line{repInd1+2});
            line{repInd1+3}=sprintf('%% %s', line{repInd1+3});
            
            repLine2 = strfind(line,'start(t)');
            repInd2 = find(not(cellfun('isempty', repLine2)));
            line{repInd2}=sprintf('%% %s', line{repInd2});
            
            repLine3 = strfind(line,'PsychPortAudio(''Start'', pahandle, 1, 0, 0);');
            repInd3 = find(not(cellfun('isempty', repLine3)));
            line{repInd3}=strrep(line{repInd3},'% ','');
            
            line{1}=sprintf('%s)%%, s)', line{1}(1:end-4));
            line{2}=sprintf('%% %s', line{1});
            studyInfo.fLine.(reWriteFLine{i}) = line{1}(10:end);
            
        else
            line{1}=sprintf('%s)%%, s)', line{1}(1:end-4));
            line{2}=sprintf('%% %s', line{1});
            studyInfo.fLine.(reWriteFLine{i}) = line{1}(10:end);
            
        end
        
        repLine = strfind(line,'s.outputSingleScan');
        repInd = find(not(cellfun('isempty', repLine)));
        for k=1:length(repInd)
            line{repInd(k)}=sprintf('%% %s', line{repInd(k)});
        end
        
        repLine1 = strfind(line,'s.stop');
        repInd1 = find(not(cellfun('isempty', repLine1)));
        for k=1:length(repInd1)
            line{repInd1(k)}=sprintf('%% %s', line{repInd1(k)});
        end
        
        repLine2 = strfind(line,'clearDin(s)');
        repInd2 = find(not(cellfun('isempty', repLine2)));
        for k=1:length(repInd2)
            line{repInd2(k)}=sprintf('%% %s', line{repInd2(k)});
        end
        
        repLine3 = strfind(line,'release(s)');
        repInd3 = find(not(cellfun('isempty', repLine3)));
        for k=1:length(repInd3)
            line{repInd3(k)}=sprintf('%% %s', line{repInd3(k)});
        end
 
        fID = fopen(reWriteFiles{i},'w');
        fprintf(fID,'%s\n',line{:});
        fclose(fID);
        
        clear line rep*
    end
    
    studyInfo.niReady='Not NI Device Ready';
    
    warningMessage = sprintf('%s files have now been updated to "Not NI Device Ready"!',...
        studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    updateWUserGuide(studyInfo);
    
    warningMessage = sprintf('%s''s README-FIRST: User''s Guide was also updated to reflect "Not NI Device Ready"!', studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Update to "Not NI Device Ready" is completed. Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Update to "Yes Ethernet Ready"')
    
    mainTrial = sprintf('%sExp.m', studyInfo.name);
    if isfield(studyInfo, 'qStruct')
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'questionTrial.m', 'stimTrial.m', mainTrial};
    else
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'stimTrial.m', mainTrial};
    end
    
    for i=1:length(reWriteFiles)
        fID = fopen(reWriteFiles{i},'r');
        numLines=0;
        tline = fgetl(fID);
        while ischar(tline)
            tline = fgetl(fID);
            numLines = numLines+1;
        end
        fclose(fID);
        
        fID = fopen(reWriteFiles{i},'r');
        line = cell(1,numLines);
        for k=1:numLines
            line{k}=fgetl(fID);
        end
        fclose(fID);
        
        repLine = strfind(line,'%');
        
        start=2;
        for t=start:length(repLine)
            if isempty(repLine{t})
                start=t;
                break;
            end
        end
        
        for p=start:length(repLine)
            if ~isempty(repLine{p})
                line{p}=strrep(line{p},'% ','');
            end
        end
        
        if strcmp(reWriteFiles{i},'stimTrial.m')
            repLine = strfind(line,'PsychPortAudio(''Start'', pahandle, 1, 0, 0);');
            repInd = find(not(cellfun('isempty', repLine)));
            line{repInd}=sprintf('%% %s', line{repInd});
        end
        
        fID = fopen(reWriteFiles{i},'w');
        fprintf(fID,'%s\n',line{:});
        fclose(fID);
        
        clear line rep*
    end
    
    studyInfo.niReady='Yes Ethernet Ready';
    
    warningMessage = sprintf('%s files have now been updated to "Yes Ethernet Ready"!',...
        studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    updateWUserGuide(studyInfo);
    
    warningMessage = sprintf('%s''s README-FIRST: User''s Guide was also updated to reflect "Yes Ethernet Ready"!', studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Update to "Yes Ethernet Ready" is completed. Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
elseif strcmp(fixOpts,'Update to "Not Ethernet Ready"')
    
    mainTrial = sprintf('%sExp.m', studyInfo.name);
    if isfield(studyInfo, 'qStruct')
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'questionTrial.m', 'stimTrial.m', mainTrial};
    else
        reWriteFiles = {'readyTrial.m', 'breakTrial.m', 'endTrial.m', 'stimTrial.m', mainTrial};
    end
    
    for i=1:length(reWriteFiles)
        fID = fopen(reWriteFiles{i},'r');
        numLines=0;
        tline = fgetl(fID);
        while ischar(tline)
            tline = fgetl(fID);
            numLines = numLines+1;
        end
        fclose(fID);
        
        fID = fopen(reWriteFiles{i},'r');
        line = cell(1,numLines);
        for k=1:numLines
            line{k}=fgetl(fID);
        end
        fclose(fID);
        
        if strcmp(reWriteFiles{i},'stimTrial.m')
            repLine1 = strfind(line,'t=timer;');
            repInd1 = find(not(cellfun('isempty', repLine1)));
            line{repInd1}=sprintf('%% %s', line{repInd1});
            line{repInd1+1}=sprintf('%% %s', line{repInd1+1});
            line{repInd1+2}=sprintf('%% %s', line{repInd1+2});
            line{repInd1+3}=sprintf('%% %s', line{repInd1+3});
            
            repLine2 = strfind(line,'start(t)');
            repInd2 = find(not(cellfun('isempty', repLine2)));
            line{repInd2}=sprintf('%% %s', line{repInd2});
            
            repLine3 = strfind(line,'PsychPortAudio(''Start'', pahandle, 1, 0, 0);');
            repInd3 = find(not(cellfun('isempty', repLine3)));
            line{repInd3}=strrep(line{repInd3},'% ','');
            
        elseif strcmp(reWriteFiles{i},mainTrial)
            repLine1 = strfind(line,'load(''NetSInfo.mat'');');
            repInd1 = find(not(cellfun('isempty', repLine1)));
            line{repInd1-1}=sprintf('%% %s', line{repInd1-1});
            line{repInd1}=sprintf('%% %s', line{repInd1});
            line{repInd1+1}=sprintf('%% %s', line{repInd1+1});
            line{repInd1+2}=sprintf('%% %s', line{repInd1+2});
            line{repInd1+3}=sprintf('%% %s', line{repInd1+3});
            line{repInd1+4}=sprintf('%% %s', line{repInd1+4});
            line{repInd1+5}=sprintf('%% %s', line{repInd1+5});
            line{repInd1+6}=sprintf('%% %s', line{repInd1+6});
            line{repInd1+7}=sprintf('%% %s', line{repInd1+7});
            line{repInd1+8}=sprintf('%% %s', line{repInd1+8});
            line{repInd1+9}=sprintf('%% %s', line{repInd1+9});
            line{repInd1+10}=sprintf('%% %s', line{repInd1+10});
            
            repLine = strfind(line,'[status, erMS]');
            
            for p=1:length(repLine)
                if ~isempty(repLine{p})
                    line{p}=sprintf('%% %s', line{p});
                    line{p+1}=sprintf('%% %s', line{p+1});
                    line{p+2}=sprintf('%% %s', line{p+2});
                    line{p+3}=sprintf('%% %s', line{p+3});
                    line{p+4}=sprintf('%% %s', line{p+4});
                    line{p+5}=sprintf('%% %s', line{p+5});
                    line{p+6}=sprintf('%% %s', line{p+6});
                end
            end
            
        else
            repLine = strfind(line,'[status, erMS]');
            
            for p=1:length(repLine)
                if ~isempty(repLine{p})
                    line{p}=sprintf('%% %s', line{p});
                    line{p+1}=sprintf('%% %s', line{p+1});
                    line{p+2}=sprintf('%% %s', line{p+2});
                    line{p+3}=sprintf('%% %s', line{p+3});
                    line{p+4}=sprintf('%% %s', line{p+4});
                end
            end
        end
        
        fID = fopen(reWriteFiles{i},'w');
        fprintf(fID,'%s\n',line{:});
        fclose(fID);
        
        clear line rep*
    end
    
    studyInfo.niReady='Not Ethernet Ready';
    
    warningMessage = sprintf('%s files have now been updated to "Not Ethernet Ready"!',...
        studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    updateWUserGuide(studyInfo);
    
    warningMessage = sprintf('%s''s README-FIRST: User''s Guide was also updated to reflect "Not Ethernet Ready"!', studyInfo.name);
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
    warningMessage = 'Update to "Not Ethernet Ready" is completed. Goodbye!';
    pause(0.1);
    updateMInterface(studyInfo,warningMessage);
    drawnow
    
end

save studyInfo.mat studyInfo

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


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
rmpath(genpath(pwd));
delete(hObject);
