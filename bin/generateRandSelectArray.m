function stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, gNum, group)
%
%   function stimArray=generateRandSelectArray(studyInfo, randType, selectStimNum, gNum, group)
%
%   This function generates a stimulus array based on users selected
%   preferences based on stimulus constructions options
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

rng('shuffle');

switch randType
    
    case 1 %Random Select, No - Allstim, Yes - NoRep
        
        if strcmp(studyInfo.type,'Neurophysiological Study')
            startStim=2;
            stim=startStim:studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        else
            startStim=1;
            stim=startStim:studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        end
        
        if studyInfo.presNum == 1
            for i=1:studyInfo.subNum
                for k=1:rand*100
                    z=randperm(selectStimNum);
                end
                indArray=datasample(stim,selectStimNum,'Replace',false);
                tempArray(i,:)=indArray(z);
            end
            stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
        else
            normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                ' Please type ''yes'' or ''no''']);
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmpi(randPres,'yes')
                for r=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        for k=1:rand*100
                            z=randperm(selectStimNum);
                        end
                        indArray=datasample(stim,selectStimNum,'Replace',false);
                        tempArray(i,:)=indArray(z);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    stimArray{r} = indPresArray;
                end
            else
                for i=1:studyInfo.subNum
                    z=randperm(selectStimNum);
                    indArray=datasample(stim,selectStimNum,'Replace',false);
                    tempArray(i,:)=indArray(z);
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                for r=1:studyInfo.presNum
                    stimArray{r} = indPresArray;
                end
            end
        end
        
    case 2 %Random select via group, No - Allstim, Yes - NoRep
        
        stimPerRec=sum(selectStimNum)/studyInfo.recNum;
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                stim=[];
                for g=1:gNum
                    selected = datasample(group{g},selectStimNum(g),'Replace', false);
                    stim=[stim selected];
                end
                for k=rand*100
                    z = randperm(sum(selectStimNum));
                    stim = stim(z);
                end
                tempArray(i,:)=stim;
            end
            stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
        else
            normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                ' Please type ''yes'' or ''no''']);
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmpi(randPres,'yes')
                for r=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        stim=[];
                        for g=1:gNum
                            selected = datasample(group{g},selectStimNum(g),'Replace', false);
                            stim=[stim selected];
                        end
                        for k=rand*100
                            z = randperm(sum(selectStimNum));
                            stim = stim(z);
                        end
                        tempArray(i,:)=stim;
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    stimArray{r} = indPresArray;
                end
            else
                for i=1:studyInfo.subNum
                    stim=[];
                    for g=1:gNum
                        selected = datasample(group{g},selectStimNum(g),'Replace', false);
                        stim=[stim selected];
                    end
                    for k=rand*100
                        z = randperm(sum(selectStimNum));
                        stim = stim(z);
                    end
                    tempArray(i,:)=stim;
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
                for r=1:studyInfo.presNum
                    stimArray{r} = indPresArray;
                end
            end
        end
    case 3 %Probability Selection, No - Allstim, Yes - NoRep
        
        selectW=gNum;
        
        if strcmp(studyInfo.type,'Neurophysiological Study')
            startStim=2;
            stim=startStim:studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        else
            startStim=1;
            stim=startStim:studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        end
        
        if studyInfo.presNum == 1
            for i=1:studyInfo.subNum
                for k=1:rand*100
                    z=randperm(selectStimNum);
                end
                indArray=datasample(stim,selectStimNum,'Replace',false,'Weights',selectW);
                tempArray(i,:)=indArray(z);
            end
            stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
        else
            normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                ' Please type ''yes'' or ''no''']);
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmpi(randPres,'yes')
                for r=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        z=randperm(selectStimNum);
                        indArray=datasample(stim,selectStimNum,'Replace',false,'Weights',selectW);
                        tempArray(i,:)=indArray(z);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    stimArray{r} = indPresArray;
                end
            else
                for i=1:studyInfo.subNum
                    z=randperm(selectStimNum);
                    indArray=datasample(stim,selectStimNum,'Replace',false,'Weights',selectW);
                    tempArray(i,:)=indArray(z);
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                for r=1:studyInfo.presNum
                    stimArray{r} = indPresArray;
                end
            end
        end
    case 4 %Probability via Groups, No - AllStim, Yes - noRepeat
        selectW = gNum;
        groups = 1:length(selectW);
        stimPerRec=sum(selectStimNum)/studyInfo.recNum;
        
        if studyInfo.presNum==1
            for i=1:studyInfo.subNum
                getStim = true;
                while getStim
                    selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                    stim=[];
                    try
                        for k=1:length(selectW)
                            gIndex(k) = sum(selectedG(:)==k);
                            selected = datasample(group{k},gIndex(k),'Replace', false);
                            stim=[stim selected];
                        end
                        getStim=false;
                    catch
                    end
                end
                for r=rand*100
                    z = randperm(selectStimNum);
                    stim = stim(z);
                end
                tempArray(i,:)=stim;
            end
            stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
        else
            normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                ' Please type ''yes'' or ''no''']);
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmpi(randPres,'yes')
                for r=1:studyInfo.presNum
                    for i=1:studyInfo.subNum
                        getStim = true;
                        while getStim
                            selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                            stim=[];
                            try
                                for k=1:length(selectW)
                                    gIndex(k) = sum(selectedG(:)==k);
                                    selected = datasample(group{k},gIndex(k),'Replace', false);
                                    stim=[stim selected];
                                end
                                getStim=false;
                            catch
                            end
                        end
                        for p=rand*100
                            z = randperm(selectStimNum);
                            stim = stim(z);
                        end
                        tempArray(i,:)=stim;
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    stimArray{r} = indPresArray;
                end
            else
                for i=1:studyInfo.subNum
                    getStim = true;
                    while getStim
                        selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                        stim=[];
                        try
                            for k=1:length(selectW)
                                gIndex(k) = sum(selectedG(:)==k);
                                selected = datasample(group{k},gIndex(k),'Replace', false);
                                stim=[stim selected];
                            end
                            getStim=false;
                        catch
                        end
                    end
                    for p=rand*100
                        z = randperm(selectStimNum);
                        stim = stim(z);
                    end
                    tempArray(i,:)=stim;
                end
                indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                
                for r=1:studyInfo.presNum
                    stimArray{r} = indPresArray;
                end
            end
        end
    case 5 %Probability Repetition, Yes - Allstim, No - NoRep
        selectW=gNum;
        
        if strcmp(studyInfo.type,'Neurophysiological Study')
            startStim=2;
            stim=startStim:studyInfo.stimNum;
            stimNum=studyInfo.stimNum-1;
            stimPerRec=selectStimNum/studyInfo.recNum;
        else
            startStim=1;
            stim=startStim:studyInfo.stimNum;
            stimNum=studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        end
        
        
        normalMessage=sprintf(['Would you like to scramble the repetition for all subjects? (yes/no)',...
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
        elseif strcmpi(yesScram,'yes')
            if studyInfo.presNum == 1
                for i=1:studyInfo.subNum
                    notAll=true;
                    while notAll
                        for k=1:rand*100
                            z=randperm(selectStimNum);
                        end
                        indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                        
                        if length(unique(indArray))==stimNum
                            notAll=false;
                        end
                    end
                    tempArray(i,:)=indArray(z);
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            notAll=true;
                            while notAll
                                for k=1:rand*100
                                    z=randperm(selectStimNum);
                                end
                                indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                                
                                if length(unique(indArray))==stimNum
                                    notAll=false;
                                end
                            end
                            tempArray(i,:)=indArray(z);
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        notAll=true;
                        while notAll
                            for k=1:rand*100
                                z=randperm(selectStimNum);
                            end
                            indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                            
                            if length(unique(indArray))==stimNum
                                notAll=false;
                            end
                        end
                        tempArray(i,:)=indArray(z);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        else
            if studyInfo.presNum == 1
                for i=1:studyInfo.subNum
                    notAll=true;
                    while notAll
                        indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                        if length(unique(indArray))==stimNum
                            notAll=false;
                        end
                    end
                    tempArray(i,:)=sort(indArray);
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            notAll=true;
                            while notAll
                                indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                                if length(unique(indArray))==stimNum
                                    notAll=false;
                                end
                            end
                            tempArray(i,:)=sort(indArray);
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        notAll=true;
                        while notAll
                            indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                            if length(unique(indArray))==stimNum
                                notAll=false;
                            end
                        end
                        tempArray(i,:)=sort(indArray);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        end
        
    case 6 %Probability Repetition - No - Allstim, No - NoRep
        
        selectW=gNum;
        
        if strcmp(studyInfo.type,'Neurophysiological Study')
            startStim=2;
            stim=startStim:studyInfo.stimNum;
            stimNum=studyInfo.stimNum-1;
            stimPerRec=selectStimNum/studyInfo.recNum;
        else
            startStim=1;
            stim=startStim:studyInfo.stimNum;
            stimNum=studyInfo.stimNum;
            stimPerRec=selectStimNum/studyInfo.recNum;
        end
        
        
        normalMessage=sprintf(['Would you like to scramble the repetition for all subjects? (yes/no)',...
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
        elseif strcmpi(yesScram,'yes')
            if studyInfo.presNum == 1
                for i=1:studyInfo.subNum
                    allStim=true;
                    while allStim
                        for k=1:rand*100
                            z=randperm(selectStimNum);
                        end
                        indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                        
                        if length(unique(indArray))<stimNum
                            allStim=false;
                        end
                    end
                    tempArray(i,:)=indArray(z);
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            allStim=true;
                            while allStim
                                for k=1:rand*100
                                    z=randperm(selectStimNum);
                                end
                                indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                                
                                if length(unique(indArray))<stimNum
                                    allStim=false;
                                end
                            end
                            tempArray(i,:)=indArray(z);
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        allStim=true;
                        while allStim
                            for k=1:rand*100
                                z=randperm(selectStimNum);
                            end
                            indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                            
                            if length(unique(indArray))<stimNum
                                allStim=false;
                            end
                        end
                        tempArray(i,:)=indArray(z);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        else
            if studyInfo.presNum == 1
                for i=1:studyInfo.subNum
                    allStim=true;
                    while allStim
                        indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                        if length(unique(indArray))<stimNum
                            allStim=false;
                        end
                    end
                    tempArray(i,:)=sort(indArray);
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            allStim=true;
                            while allStim
                                indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                                if length(unique(indArray))<stimNum
                                    allStim=false;
                                end
                            end
                            tempArray(i,:)=sort(indArray);
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        allStim=true;
                        while allStim
                            indArray=datasample(stim,selectStimNum,'Replace',true,'Weights',selectW);
                            if length(unique(indArray))<stimNum
                                allStim=false;
                            end
                        end
                        tempArray(i,:)=sort(indArray);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        end
        
    case 7 %Probability Repetition via Groups, No - AllStim, No - noRep
        
        selectW = gNum;
        groups = 1:length(selectW);
        stimPerRec=sum(selectStimNum)/studyInfo.recNum;
        
        if strcmp(studyInfo.type,'Neurophysiological Study')
            stimNum=studyInfo.stimNum-1;
        else
            stimNum=studyInfo.stimNum;
        end
        
        normalMessage=sprintf(['Would you like to scramble the repetition for all subjects? (yes/no)',...
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
        elseif strcmpi(yesScram,'yes')
            if studyInfo.presNum==1
                for i=1:studyInfo.subNum
                    allStim = true;
                    while allStim
                        selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                        stim=[];
                        for k=1:length(selectW)
                            gIndex(k) = sum(selectedG(:)==k);
                            selected = datasample(group{k},gIndex(k),'Replace', true);
                            stim=[stim selected];
                        end
                        if length(unique(stim))<stimNum
                            allStim=false;
                        end
                    end
                    for r=rand*100
                        z = randperm(selectStimNum);
                        stim = stim(z);
                    end
                    tempArray(i,:)=stim;
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            allStim = true;
                            while allStim
                                selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                                stim=[];
                                for k=1:length(selectW)
                                    gIndex(k) = sum(selectedG(:)==k);
                                    selected = datasample(group{k},gIndex(k),'Replace', true);
                                    stim=[stim selected];
                                end
                                if length(unique(stim))<stimNum
                                    allStim=false;
                                end
                            end
                            for p=rand*100
                                z = randperm(selectStimNum);
                                stim = stim(z);
                            end
                            tempArray(i,:)=stim;
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        allStim = true;
                        while allStim
                            selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                            stim=[];
                            for k=1:length(selectW)
                                gIndex(k) = sum(selectedG(:)==k);
                                selected = datasample(group{k},gIndex(k),'Replace', true);
                                stim=[stim selected];
                            end
                            if length(unique(stim))<stimNum
                                allStim=false;
                            end
                        end
                        for p=rand*100
                            z = randperm(selectStimNum);
                            stim = stim(z);
                        end
                        tempArray(i,:)=stim;
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        else
            if studyInfo.presNum==1
                for i=1:studyInfo.subNum
                    allStim = true;
                    while allStim
                        selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                        stim=[];
                        for k=1:length(selectW)
                            gIndex(k) = sum(selectedG(:)==k);
                            selected = datasample(group{k},gIndex(k),'Replace', true);
                            stim=[stim selected];
                        end
                        if length(unique(stim))<stimNum
                            allStim=false;
                        end
                    end
                    tempArray(i,:)=sort(stim);
                end
                stimArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
            else
                normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                    ' Please type ''yes'' or ''no''']);
                yesString=1;
                pause(0.1);
                randPres=userRespInterface(studyInfo,normalMessage,yesString);
                drawnow
                
                if strcmpi(randPres,'yes')
                    for r=1:studyInfo.presNum
                        for i=1:studyInfo.subNum
                            allStim = true;
                            while allStim
                                selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                                stim=[];
                                for k=1:length(selectW)
                                    gIndex(k) = sum(selectedG(:)==k);
                                    selected = datasample(group{k},gIndex(k),'Replace', true);
                                    stim=[stim selected];
                                end
                                if length(unique(stim))<stimNum
                                    allStim=false;
                                end
                            end
                            tempArray(i,:)=sort(stim);
                        end
                        indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                        stimArray{r} = indPresArray;
                    end
                else
                    for i=1:studyInfo.subNum
                        allStim = true;
                        while allStim
                            selectedG = datasample(groups,selectStimNum,'Replace',true,'Weights',selectW);
                            stim=[];
                            for k=1:length(selectW)
                                gIndex(k) = sum(selectedG(:)==k);
                                selected = datasample(group{k},gIndex(k),'Replace', true);
                                stim=[stim selected];
                            end
                            if length(unique(stim))<stimNum
                                allStim=false;
                            end
                        end
                        tempArray(i,:)=sort(stim);
                    end
                    indPresArray = reshape(tempArray,[studyInfo.subNum,stimPerRec,studyInfo.recNum]);
                    for r=1:studyInfo.presNum
                        stimArray{r} = indPresArray;
                    end
                end
            end
        end
end
