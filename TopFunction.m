% 函数说明
% 该函数为整个程序的头函数

clear all; close all; clc;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Parameter_File.Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Parameter_File.Test_HeightTuning = 0;       % 不生成 Height Tuning Curve
Parameter_File.Test_ContrastTuning = 0;
% Parameters for Input Image Sequence

Parameter_File.folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';  'Cluttered-Background-Curvilinear-Motion'

if strcmp(Parameter_File.folderName,'Width-Tuning')
    % 判断文件夹，根据不同文件夹调整路径名
    
    Parameter_File.BackgroundType = 'WhiteBackground';                      %  CB-1, CB-2 or WhiteBackground  
    Parameter_File.TargetNum = 'SingleTarget';
    Parameter_File.TargetWidth = 12;
    Parameter_File.TargetHeight = 5;
    Parameter_File.TargetVelocity = 250;
    Parameter_File.TargetLuminance = 0;
    Parameter_File.BackgroundVelocity = 0;
    Parameter_File.MotionMode = 'BackgroundStationary';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    Parameter_File.VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz
    
    % Path of Input Image Sequence
    Parameter_File.folder0 = ['D:\Matlab\TestSet-STMD\',Parameter_File.folderName,'\',Parameter_File.BackgroundType,'-',Parameter_File.TargetNum,'-TargetWidth-',num2str(Parameter_File.TargetWidth),'-TargetHeight-',num2str(Parameter_File.TargetHeight),...
        '-TargetVelocity-',num2str(Parameter_File.TargetVelocity),'-TargetLuminance-',num2str(Parameter_File.TargetLuminance),'-BackgroundVelocity-',num2str(Parameter_File.BackgroundVelocity),'-',Parameter_File.MotionMode,...
        '-SamplingFrequency-',num2str(Parameter_File.VideoSamplingFrequency)];
    
elseif strcmp(Parameter_File.folderName,'Cluttered-Background-Curvilinear-Motion')
    
    Parameter_File.BackgroundType = 'CB-0';                               % 1 表示混杂背景，2 表示较为干净的背景， 0 表示无背景
    Parameter_File.TargetNum = 'SingleTarget';
    Parameter_File.TargetWidth = 5;
    Parameter_File.TargetHeight = 5;
    Parameter_File.TargetVelocity = 250;
    Parameter_File.TargetLuminance = 0;
    Parameter_File.BackgroundVelocity = 250;
    Parameter_File.MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    Parameter_File.Y_Axis_Amplitude = 15;
    Parameter_File.Y_Axis_TemporalFrequency = 2;
    Parameter_File.VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz
    
    % Path of Input Image Sequence
    Parameter_File.folder0 = ['D:\Matlab\TestSet-STMD\',Parameter_File.folderName,'\',Parameter_File.BackgroundType,'-',Parameter_File.TargetNum,'-TargetWidth-',num2str(Parameter_File.TargetWidth),'-TargetHeight-',num2str(Parameter_File.TargetHeight),...
        '-TargetVelocity-',num2str(Parameter_File.TargetVelocity),'-TargetLuminance-',num2str(Parameter_File.TargetLuminance),'-BackgroundVelocity-',num2str(Parameter_File.BackgroundVelocity),'-',Parameter_File.MotionMode,'-Amp-',...
        num2str(Parameter_File.Y_Axis_Amplitude),'-TemFre-',num2str(Parameter_File.Y_Axis_TemporalFrequency),'-SamplingFrequency-',num2str(Parameter_File.VideoSamplingFrequency)];
    
end
 
Parameter_File.folder_Global = 'Data-Journal-Paper-1\Direction-Selectivity\CB-0';

if ~exist(Parameter_File.folder_Global,'dir')
    mkdir(Parameter_File.folder_Global)
end

% Title of Input Image Sequence
Parameter_File.Imagetitle = 'Synthetic-Stimuli';

% Start and end frame of input image sequence
Parameter_File.StartRecordFrame = 300;         % 开始记录数据的帧
Parameter_File.StartFrame = 1;
%Parameter_File.EndFrame = 1300;
Parameter_File.EndFrame = 1800;

% Cluttered Background   50 - 550  (更新300帧 即可)
% White Background 500-1000        (更新300帧 即可)

%% 调入函数 ParameterSetting.m 设置整个程序的参数

ParameterSetting

% 计算时间 （Start Point）
tic;
timedLog('Start Motion Perception...')
%% 调入 Main.m 文件处理 Input Image Sequence

Main

%===================================================================%
% 计算时间 （End Point）  
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 












