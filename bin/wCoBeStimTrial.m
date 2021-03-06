function studyInfo=wCoBeStimTrial(studyInfo)
%   function studyInfo=wCoBeStimTrial(studyInfo)
%
%   This funtion generates the stimTrial script for Continuous Behavioral 
%   Rating Study experiments. 
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

studyInfo=wdrawmyscaleS(studyInfo);
  
line{1}=sprintf(['function positions = stimTrial(wPtr, wRect,',...
    ' bgColor, fontColor, wavdata, pahandle, i, %s, trigIndex, trigger)'],studyInfo.insStructName);
line{2}=sprintf('%% %s', line{1});
line{3}='% This function displays the continous behavior stim screen and plays';
line{4}='% the stimulus.'; 
dLines=4;
line{dLines+1}='%';
line{dLines+2}='% This script was generated by AudExpCreator.';
line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
line{dLines+5}='% Contact: audexpcreator@gmail.com';
dOS=5;

line{dOS+6}='PsychPortAudio(''FillBuffer'', pahandle, wavdata{i});';
line{dOS+7}='KbName(''UnifyKeyNames'');';

line{dOS+9}='[xC, yC] = RectCenter(wRect);';
line{dOS+10}='sL = 400;';
line{dOS+11}='x = xC - sL;';
line{dOS+12}='y = yC;';

line{dOS+14}='SetMouse(x, y, wPtr);';
line{dOS+15}='position(1)=trigger{i};';
line{dOS+16}='counter=2;';

line{dOS+17}='PsychPortAudio(''Start'', pahandle, 1, 0, 0);';
line{dOS+18}='playing = 1;';
line{dOS+19}='while playing';
line{dOS+20}='tic';
line{dOS+21}='while toc<.04';
line{dOS+22}='Screen(''FillRect'',wPtr,bgColor);';
line{dOS+23}=sprintf('%s;',studyInfo.fLine.drawmsS);
line{dOS+24}='Screen(''Flip'', wPtr);';
line{dOS+25}='HideCursor;';
line{dOS+26}='[x, ~, ~] = GetMouse;';
line{dOS+27}='[~, ~, keyCode] = KbCheck;';
line{dOS+28}=sprintf('if keyCode(KbName(''%s''))',studyInfo.fQuitKey);
line{dOS+29}='sca;';
line{dOS+30}='clear all;';
line{dOS+31}='end';
line{dOS+32}='end';
line{dOS+33}='position(counter)=x;';
line{dOS+34}='counter=counter+1;';
line{dOS+35}='status = PsychPortAudio(''GetStatus'', pahandle);';
line{dOS+36}='playing = status.Active;';
line{dOS+37}='end';
line{dOS+39}='positions = position'';';
line{dOS+40}='Screen (''Close'');';

tabLine=[dOS+20:dOS+21 dOS+32:dOS+36];
dTabLine=[dOS+22:dOS+28 dOS+31];
tTabLine=dOS+29:dOS+30;

studyInfo.fLine.sTrial = line{1}(10:end);

fName = 'stimTrial';
fID = fopen([studyInfo.path filesep fName '.m'],'w');
for i=1:length(line)
    if any(ismember(i,tabLine))
        fprintf(fID,'\t%s\n',line{i});
    elseif any(ismember(i,dTabLine))
        fprintf(fID,'\t\t%s\n',line{i});
    elseif any(ismember(i,tTabLine))
        fprintf(fID,'\t\t\t%s\n',line{i});
    else
        fprintf(fID,'%s\n',line{i});
    end
end
fclose(fID);


