function studyInfo=wClearDin(studyInfo)
%   function studyInfo=wClearDin(studyInfo)
%
%   This funtion generates the clearDin script for study experiments
%   created with the AudExpCreator.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

line{1}='function clearDin(s)';
line{2}=sprintf('%% %s', line{1});
line{3}='% This function clears away the DIN so the NI Device can send out';
line{4}='% out the same trigger through the "s" object.';
dLines=4;
line{dLines+1}='%';
line{dLines+2}='% This script was generated by AudExpCreator.';
line{dLines+3}='% (c) Duc T. Nguyen and Blair Kaneshiro, 2017';
line{dLines+4}='% Distributed under Creative Commons Zero (CC0) license';
line{dLines+5}='% Contact: audexpcreator@gmail.com';
dOS=5;

line{dOS+6}='s.outputSingleScan(de2bi(0,12));';

studyInfo.fLine.cDIN = line{1}(10:end);

fName = 'clearDin';
fID = fopen([studyInfo.path filesep fName '.m'],'w');
for i=1:length(line)
        fprintf(fID,'%s\n',line{i});
end
fclose(fID);