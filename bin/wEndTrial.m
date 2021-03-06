function studyInfo=wEndTrial(studyInfo,endStruct)
%   function studyInfo=wBreakTrial(studyInfo,breakStruct)
%
%   This funtion generates the endTrial script for study experiments
%   created with the AudExpCreator.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

if strcmp(studyInfo.niReady,'Yes NI Device Ready')
    line{1}='function endTrial(wPtr, bgColor, fontColor, s)';
elseif strcmp(studyInfo.niReady,'Not NI Device Ready')
    line{1}='function endTrial(wPtr, bgColor, fontColor)%, s)';
else
    line{1}='function endTrial(wPtr, bgColor, fontColor)';
end

line{2}=sprintf('%% %s', line{1});
line{3}='% This function displays the end screen and the end screen text on the';
line{4}=sprintf('%% screen. To exit this end screen press the %s key. The force', endStruct.exitB);
line{5}='% quit key is not available in this screen to preserve the data output.';
dLines=5;
line{dLines+1}='%';
line{dLines+2}='% This script was generated by AudExpCreator.';
line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
line{dLines+5}='% Contact: audexpcreator@gmail.com';
dOS=5;

line{dOS+7}='KbName(''UnifyKeyNames'');';
line{dOS+8}=sprintf('enterKey = KbName(''%s'');',endStruct.exitB);

line{dOS+10}='Screen(''FillRect'',wPtr,bgColor);';
line{dOS+11}='Screen(''TextSize'', wPtr, 30);';
line{dOS+12}=sprintf('mytext = ''%s'';',endStruct.text);
line{dOS+13}='[~, ~, ~] = DrawFormattedText(wPtr, mytext, ''center'', ''center'', fontColor);';
line{dOS+14}='Screen(wPtr, ''Flip'');';
line{dOS+15}='HideCursor;';

line{dOS+17}='notDone=true;';
line{dOS+18}='while notDone';
line{dOS+19}='[~, keyCode, ~] = KbWait([], 2);';
line{dOS+20}='if keyCode(enterKey)';
tabLine=dOS+19:dOS+20;
dTabLine=[];
tTabLine=[];
subL=dOS+20;

if strcmp(studyInfo.niReady,'Yes NI Device Ready')
    line{subL+1}='s.outputSingleScan(de2bi(11,12));';
    line{subL+2}='clearDin(s);';
    dTabLine=[dTabLine subL+1:subL+2];
    subL=subL+2;
elseif strcmp(studyInfo.niReady,'Not NI Device Ready')
    line{subL+1}='% s.outputSingleScan(de2bi(11,12));';
    line{subL+2}='% clearDin(s);';
    dTabLine=[dTabLine subL+1:subL+2];
    subL=subL+2;
elseif strcmp(studyInfo.niReady,'Yes Ethernet Ready')
    line{subL+1}='[status, erMS] = NetStation(''Event'',''0011'');';
    line{subL+2}='if status~=0';
    line{subL+3}='display([erMS ''. Goodbye.''])';
    line{subL+4}='error(''Failure in sending event to NetStation.'');';
    line{subL+5}='end';
    dTabLine=[subL+1:subL+2 subL+5];
    tTabLine=subL+3:subL+4;
    subL=subL+5;
elseif strcmp(studyInfo.niReady,'Not Ethernet Ready')
    line{subL+1}='% [status, erMS] = NetStation(''Event'',''0011'');';
    line{subL+2}='% if status~=0';
    line{subL+3}='% display([erMS ''. Goodbye.''])';
    line{subL+4}='% error(''Failure in sending event to NetStation.'');';
    line{subL+5}='% end';
    dTabLine=[subL+1:subL+2 subL+5];
    tTabLine=subL+3:subL+4;
    subL=subL+5;
end

line{subL+1}='notDone=false;';
line{subL+2}='end';
line{subL+3}='end';

tabLine=[tabLine subL+2];
dTabLine=[dTabLine subL+1];


studyInfo.fLine.eTrial = line{1}(10:end);

fName = 'endTrial';
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