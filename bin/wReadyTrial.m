function studyInfo=wReadyTrial(studyInfo,readyStruct)
%   function studyInfo=wReadyTrial(studyInfo,readyStruct)
%
%   This funtion generates the readyTrial script for study experiments
%   created with the AudExpCreator.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

if strcmp(studyInfo.niReady,'Yes NI Device Ready')
    line{1}='function readyTrial(wPtr, bgColor, fontColor, s)';
elseif strcmp(studyInfo.niReady,'Not NI Device Ready')
    line{1}='function readyTrial(wPtr, bgColor, fontColor)%, s)';
else
    line{1}='function readyTrial(wPtr, bgColor, fontColor)';
end

line{2}=sprintf('%% %s', line{1});
line{3}='% This function displays the start screen and the start screen text on the';
line{4}=sprintf('%% screen. To exit this start screen press the %s key.',readyStruct.exitB);
dLines=4;
line{dLines+1}='%';
line{dLines+2}='% This script was generated by AudExpCreator.';
line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
line{dLines+5}='% Contact: audexpcreator@gmail.com';
dOS=5;

line{dOS+6}='KbName(''UnifyKeyNames'');';
line{dOS+7}=sprintf('enterKey = KbName(''%s'');',readyStruct.exitB);
line{dOS+8}=sprintf('escapeKey = KbName(''%s'');',studyInfo.fQuitKey);

line{dOS+10}='Screen(''FillRect'',wPtr,bgColor);';
line{dOS+11}='Screen(''TextSize'', wPtr, 50);';
line{dOS+12}=sprintf('mytext = ''%s'';',readyStruct.text);
line{dOS+13}='[~, ~, ~] = DrawFormattedText(wPtr, mytext, ''center'', ''center'', fontColor);';
line{dOS+14}='Screen(wPtr, ''Flip'');';
line{dOS+15}='HideCursor;';

line{dOS+17}='notReady=true;';
line{dOS+18}='while notReady';
line{dOS+19}='[~, keyCode, ~] = KbWait([], 2);';
line{dOS+20}='if keyCode(enterKey)';
tabLine=dOS+19:dOS+20;
dTabLine=[];
tTabLine=[];
subL = dOS+20;

if strcmp(studyInfo.niReady,'Yes NI Device Ready')
    line{subL+1}='s.outputSingleScan(de2bi(11,12));';
    line{subL+2}='clearDin(s);';
    dTabLine=subL+1:subL+3;
    subL=subL+2;
elseif strcmp(studyInfo.niReady,'Not NI Device Ready')
    line{subL+1}='% s.outputSingleScan(de2bi(11,12));';
    line{subL+2}='% clearDin(s);';
    dTabLine=subL+1:subL+3;
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

line{subL+1}='notReady=false;';
line{subL+2}='elseif keyCode(escapeKey)';
line{subL+3}='clear all;';
tabLine=[tabLine subL+2];
dTabLine=[dTabLine subL+1 subL+3];
subL=subL+3;

if strcmp(studyInfo.niReady,'Yes NI Device Ready')
    line{subL+1}='clearDin(s);';
    line{subL+2}='s.stop();';
    line{subL+3}='release(s);';
    dTabLine=[dTabLine subL+1:subL+3];
    subL=subL+3;
elseif strcmp(studyInfo.niReady,'Not NI Device Ready')
    line{subL+1}='% clearDin(s);';
    line{subL+2}='% s.stop();';
    line{subL+3}='% release(s);';
    dTabLine=[dTabLine subL+1:subL+3];
    subL=subL+3;
end

line{subL+1}='sca';
line{subL+2}='end';
line{subL+3}='end';

dTabLine=[dTabLine subL+1];
tabLine=[tabLine subL+2];

studyInfo.fLine.rTrial = line{1}(10:end);

fName = 'readyTrial';
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

