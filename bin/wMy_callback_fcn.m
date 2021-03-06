function studyInfo = wMy_callback_fcn(studyInfo)
%   function studyInfo = wMy_callback_fcn(studyInfo)
%
%   This funtion generates the my_callback_fcn script for study 
%   experiments created with the AudExpCreator.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

line{1}='function my_callback_fcn(obj, event, pahandle)';
line{2}=sprintf('%% %s', line{1});
subL=2;

if strcmp(studyInfo.signalType,'TTL')
    line{subL+1}='% This function is part of the timer object that operates on the s object to';
    line{subL+2}='% try to simultaneously start playing the stim while also sending out the';
    line{subL+3}='% trigger. This function works on playing the stim.  However there is a delay';
    line{subL+4}='% nevertheless. So please use embedded clicks for better timing.';
    dLines=subL+4;
    line{dLines+1}='%';
    line{dLines+2}='% This script was generated by AudExpCreator.';
    line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
    line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
    line{dLines+5}='% Contact: audexpcreator@gmail.com';
    
    subL=dLines+6;
elseif strcmp(studyInfo.signalType,'TCP/IP')
    line{subL+1}='% This function is part of the timer object that tries to simultaneously start';
    line{subL+2}='% playing the stim while also sending out the trigger. This function works on';
    line{subL+3}='% playing the stim.  However there might be a delay nevertheless. So please use';
    line{subL+4}='% embedded clicks for better timing.';
    dLines=subL+4;
    line{dLines+1}='%';
    line{dLines+2}='% This script was generated by AudExpCreator.';
    line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
    line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
    line{dLines+5}='% Contact: audexpcreator@gmail.com';
    
    subL=dLines+6;
end

line{subL+1}='PsychPortAudio(''Start'', pahandle, 1, 0, 0);';

studyInfo.fLine.mcfcn = line{1}(10:end);

fName = 'my_callback_fcn';
fID = fopen([studyInfo.path filesep fName '.m'],'w');
for i=1:length(line)
    fprintf(fID,'%s\n',line{i});
end
fclose(fID);