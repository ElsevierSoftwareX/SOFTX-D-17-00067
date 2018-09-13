function navi
% function navi
% This function accompanies "AudExpCreator", the GUI-based MATLAB tool for
% auditory experiment design and creation, and helps directs the user on
% where to go next. Run this function and it will tell you how to proceed
% in your process of creating your own experimental study.
%
% Type "navi" into the MATLAB Command Window and it will help direct you to
% where you need to go.
%
%      That's it! Enjoy!
%       - The Creators of AudExpCreator
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

if ~exist('bin','dir')==7
    error('prog:input',['\n\nERROR: SOMETHING IS WRONG! Your version of AudExpCreator',...
        ' does not \ncontain its main component folder ''bin''. Please go acquire a',...
        ' correct version of this toolbox.']);
end

addpath(genpath(pwd));

try
    load('studyInfo.mat')
catch
    fprintf('\n\nIt seems you have yet to initiate a study creation with AudExpCreator.\n\n');
    
    yesStart=input(['Would you like "navi" to help you initiate the process?',...
        '\nType "yes" or "no": '],'s');
    
    if strcmp(yesStart,'yes')
        
        hFig = figure('units','normalized','outerposition',[0 0 1 1]);
        set(hFig,'menubar','none')
        set(hFig,'NumberTitle','off');
        audImage = imread('AudExpCreator.jpg');
        imshow(audImage, 'Border', 'tight');
        drawnow
        
        tic
        while toc < 2
        end
        delete(hFig);
        
        pause(0.1);
        experimenterInterface;
        drawnow
        return;
    elseif strcmp(yesStart,'no')
        fprintf(['\n\nAll right. Feel free to type "run experimenterInterface" or simply',...
            '\n"experimenterInterface" in the MATLAB Command Window when you',...
            '\nare ready to initiate a study creation with AudExpCreator.',...
            '\nOr call on "navi" again.\n\n']);
        return;
    else
        warning('prog:input','\n\nYour response "%s" was not valid. Goodbye.\n\n', yesStart);
        return;
    end
end

try
    if strcmp(studyInfo.nextStep,'COMPLETED')
        fprintf(['\n\nThis study has already been completed. But users are welcome',...
            '\nto do advanced updates on the study, applying major changes.',...
            '\ngetBasicParameters, getStructuralParameters or %s ',...
            '\ncan help users apply these major changes to the study.\n\n'], studyInfo.lastComp(1:end-11));
        
        prompt=sprintf(['\nWould you like "navi" to help you with this?',...
            '\nType "yes" or "no": ']);
        yesNavi=input(prompt,'s');
        
        if strcmp(yesNavi,'yes')
            prompt=sprintf(['\ngetBasicParameters, getStructuralParameters or %s',...
                '\nWhich GUI would you like "navi" to help you with?',...
                '\n\nType "getBasic", "getStruct", or "write":  '], studyInfo.lastComp(1:end-11));
            whichGUI=input(prompt,'s');
            
            if strcmpi(whichGUI,'getBasic')
                hFig = figure('units','normalized','outerposition',[0 0 1 1]);
                set(hFig,'menubar','none')
                set(hFig,'NumberTitle','off');
                audImage = imread('AudExpCreator.jpg');
                imshow(audImage, 'Border', 'tight');
                drawnow
                
                tic
                while toc < 2
                end
                delete(hFig);
                
                pause(0.1);
                getBasicParameters(studyInfo);
                drawnow
                return;
            elseif strcmpi(whichGUI,'getStruct')
                
                hFig = figure('units','normalized','outerposition',[0 0 1 1]);
                set(hFig,'menubar','none')
                set(hFig,'NumberTitle','off');
                audImage = imread('AudExpCreator.jpg');
                imshow(audImage, 'Border', 'tight');
                drawnow
                
                tic
                while toc < 2
                end
                delete(hFig);
                
                pause(0.1);
                getStructuralParameters(studyInfo);
                drawnow
                return;
            elseif strcmpi(whichGUI,'write')
                
                hFig = figure('units','normalized','outerposition',[0 0 1 1]);
                set(hFig,'menubar','none')
                set(hFig,'NumberTitle','off');
                audImage = imread('AudExpCreator.jpg');
                imshow(audImage, 'Border', 'tight');
                drawnow
                
                tic
                while toc < 2
                end
                delete(hFig);
                
                eval([studyInfo.lastComp ';'])
                drawnow
                return;
            else
                warning('prog:input','\n\nYour response "%s" was not valid. Goodbye.\n\n', whichGUI);
                return;
            end
            
        elseif strcmp(yesNavi,'no')
            fprintf(['\n\nAll right. Feel free to type "getBasicParameters", "getStructuralParameters",',...
                '\nor "%s" in the MATLAB Command Window if you change your mind.',...
                '\nOr call on "navi" again. \n\n'], studyInfo.lastComp(1:end-11));
            return;
        else
            warning('prog:input','\n\nYour response "%s" was not valid. Goodbye.\n\n', yesNavi);
            return;
        end
        
    else
        fprintf(['\n\nThe last step you completed was: %s.\n',...
            '\nThe step you are on now is: %s.\n'], studyInfo.lastComp, studyInfo.nextStep(1:end-11));
        
        prompt=sprintf(['\nWould you like "navi" to help you start %s?',...
            '\nType "yes" or "no": '], studyInfo.nextStep(1:end-11));
        yesStart=input(prompt,'s');
        
        if strcmp(yesStart,'yes')
            
            hFig = figure('units','normalized','outerposition',[0 0 1 1]);
            set(hFig,'menubar','none')
            set(hFig,'NumberTitle','off');
            audImage = imread('AudExpCreator.jpg');
            imshow(audImage, 'Border', 'tight');
            drawnow
            
            tic
            while toc < 2
            end
            delete(hFig);
            
            eval([studyInfo.nextStep ';'])
            drawnow
            return;
        elseif strcmp(yesStart,'no')
            fprintf(['\n\nAll right. Feel free to type "%s" in the MATLAB Command Window when you',...
                '\nare ready to continue where you left off. Or call on "navi" again.\n\n'], studyInfo.nextStep(1:end-11));
            return;
        else
            warning('prog:input','\n\nYour response "%s" was not valid. Goodbye.\n\n', yesStart);
            return;
        end
    end
catch
    error('prog:input',['\n\nERROR: SOMETHING IS WRONG with your "studyInfo.mat"!',...
        '\nConsider deleting it.\n\nPlease reinitiate with experimenterInterface!']);
end

