function randArray = generateRandArray(studyInfo,randType,presNum,subNum,stimNum,recNum,stimPerRec)
%
%   function randArray = generateRandArray(studyInfo,randType,presNum,subNum,stimNum,recNum,stimPerRec)
%
%   This function generates a randomized array based on selected
%   preferences chosen by users.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

rng('shuffle');

if strcmp(studyInfo.type,'Neurophysiological Study')
    startStim=2;
    stim=startStim:stimNum;
    stimNum=length(stim);
else
    startStim=1;
    stim=startStim:stimNum;
end
    
switch randType
    case 1
        if presNum == 1
            for i=1:(subNum)
                for k=rand*100
                    z = randperm(stimNum);
                    stim = stim(z);
                end
                tempArray(i,:) = stim;
            end
            randArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
        else
            normalMessage=sprintf(['Do you want to randomize differenly for each stim presentation?',...
                ' Please type ''yes'' or ''no''']);
            yesString=1;
            pause(0.1);
            randPres=userRespInterface(studyInfo,normalMessage,yesString);
            drawnow
            
            if strcmpi(randPres,'yes')
                for r=1:presNum
                    for i=1:(subNum)
                        for k=rand*100
                            z = randperm(stimNum);
                            stim = stim(z);
                        end
                        tempArray(i,:) = stim;
                    end
                    indPresArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
                    randArray{r} = indPresArray;
                end
            else
                for i=1:(subNum)
                    for k=rand*100
                        z = randperm(stimNum);
                        stim = stim(z);
                    end
                    tempArray(i,:) = stim;
                end
                indPresArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
                for r=1:presNum
                    randArray{r} = indPresArray;
                end
            end
        end
    case 2
        if presNum == 1
            for i=1:(subNum)
                tempArray(i,:) = stim;
            end
            randArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
        else
            for r=1:presNum
                for i=1:(subNum)
                    tempArray(i,:) = stim;
                end
                indPresArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
                randArray{r} = indPresArray;
            end
        end
    case 3
        if presNum == 1
            for i=1:(subNum)
                z=fliplr(stim);
                tempArray(i,:) = z;
            end
            randArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
        else
            for r=1:presNum
                for i=1:(subNum)
                    z=fliplr(stim);
                    tempArray(i,:) = z;
                end
                indPresArray = reshape(tempArray,[subNum,stimPerRec,recNum]);
                randArray{r} = indPresArray;
            end
        end
end



