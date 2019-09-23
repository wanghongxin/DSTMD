% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 LDTB Tuning 曲线
% LDTB (Luminance Difference Between Target and Background)
% LDTB = abs(Lumiance of Target - Luminance of Backgroud)/255
% 类似于 SCR, 但将分母由 Sigma_Backgorund 改为 255



%clear all; close all; clc;
close all;


%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等

Parameter_File.Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Parameter_File.Test_HeightTuning = 0;       % 不生成 Height Tuning Curve
Parameter_File.Test_ContrastTuning = 1;

% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
ContrastTuning_Frame = 30;

% 确定物体速度的变化范围
Target_Luminance_Range = [0 25 50 75 100 125 150 175 200 225 250];


% 生成用于存储 TQD 及 DS-STMD 响应的矩阵
ESTMD_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));

TQD_ON_OFF_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));

TQD_ON_OFF_LI_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));

DS_STMD_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));

tic;
timedLog('Start Record Contrast Tuning Curve ...')

% length(Target_Luminance_Range)
for k = 1:length(Target_Luminance_Range)
    
    disp('======================================')
    disp(strcat('Target Luminance =  ',num2str(Target_Luminance_Range(k))))
    
    % Parameters for Input Image Sequence
    Parameter_File.folderName = 'Contrast-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    Parameter_File.BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    Parameter_File.TargetNum = 'SingleTarget';
    Parameter_File.TargetWidth = 5;
    Parameter_File.TargetHeight = 5;
    Parameter_File.TargetVelocity = 250;                             % 确定物体运动速度
    Parameter_File.TargetLuminance = Target_Luminance_Range(k);
    Parameter_File.BackgroundVelocity = 0;
    Parameter_File.MotionMode = 'BackgroundStationary';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    Parameter_File.VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz

    % Path of Input Image Sequence
    Parameter_File.folder0 = ['D:\Matlab\TestSet-STMD\',Parameter_File.folderName,'\',Parameter_File.BackgroundType,'-',Parameter_File.TargetNum,'-TargetWidth-',num2str(Parameter_File.TargetWidth),'-TargetHeight-',num2str(Parameter_File.TargetHeight),...
                 '-TargetVelocity-',num2str(Parameter_File.TargetVelocity),'-TargetLuminance-',num2str(Parameter_File.TargetLuminance),'-BackgroundVelocity-',num2str(Parameter_File.BackgroundVelocity),'-',Parameter_File.MotionMode,...
                 '-SamplingFrequency-',num2str(Parameter_File.VideoSamplingFrequency)];

    % Title of Input Image Sequence
    Parameter_File.Imagetitle = 'Synthetic-Stimuli';

    % Start and end frame of input image sequence
    Parameter_File.StartFrame = 1;
    Parameter_File.EndFrame = 350;

    %% 调入函数 ParameterSetting.m 设置整个程序的参数

    ParameterSetting
    
    
    if Test_Parameter_Sensitivity_Velocity == 1
        % 测试模型对参数的敏感性 （下面改变模型参数）
        Varying_Model_Parameters_Velocity
    end
    
    if Test_Parameter_Sensitivity_Width == 1
        % 测试模型对参数的敏感性 （下面改变模型参数）
        Varying_Model_Parameters_Width
    end
    
    if Test_Parameter_Sensitivity_Height == 1
        % 测试模型对参数的敏感性 （下面改变模型参数）
        Varying_Model_Parameters_Height
    end
    
    
    
    %% 生成记录每次循环响应的矩阵
    
    ESTMD_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);

    TQD_ON_OFF_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);
    
    TQD_ON_OFF_LI_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);
    
    DS_STMD_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    ESTMD_Responses_ContrastTuning(:,k) = ESTMD_Responses_ContrastTuning_EachStep;

    TQD_ON_OFF_Responses_ContrastTuning(:,k) = TQD_ON_OFF_Responses_ContrastTuning_EachStep;
    
    TQD_ON_OFF_LI_Responses_ContrastTuning(:,k) = TQD_ON_OFF_LI_Responses_ContrastTuning_EachStep;
        
    DS_STMD_Responses_ContrastTuning(:,k) = DS_STMD_Responses_ContrastTuning_EachStep;
    


end
% 存储记录的数据

if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    
    Save_Folder = 'Data-Journal-Paper-1\Tuning-Properties-2';
    if ~exist(Save_Folder,'dir')
        mkdir(Save_Folder)
    end
    
    file = ['Data-Journal-Paper-1\Tuning-Properties','/','Contrast-Tuning-Data.mat'];
    save(file,'Target_Luminance_Range','ESTMD_Responses_ContrastTuning','TQD_ON_OFF_Responses_ContrastTuning','TQD_ON_OFF_LI_Responses_ContrastTuning','DS_STMD_Responses_ContrastTuning','-v7.3')
    
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    
    file = [Parameter_Selectivity_SubFile,'/','Contrast-Tuning-Data.mat'];
    save(file,'Target_Luminance_Range','ESTMD_Responses_ContrastTuning','TQD_ON_OFF_Responses_ContrastTuning','TQD_ON_OFF_LI_Responses_ContrastTuning','DS_STMD_Responses_ContrastTuning','-v7.3')
end
%% 数据处理
% Method LDTB 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_ESTMD_ContrastTuning = max(ESTMD_Responses_ContrastTuning,[],1);

MaxValue_TQD_ON_OFF_ContrastTuning = max(TQD_ON_OFF_Responses_ContrastTuning,[],1);

MaxValue_TQD_ON_OFF_LI_ContrastTuning = max(TQD_ON_OFF_LI_Responses_ContrastTuning,[],1);

MaxValue_DS_STMD_ContrastTuning = max(DS_STMD_Responses_ContrastTuning,[],1);

% Data Normalization
Normalized_MaxValue_ESTMD_ContrastTuning = Data_Normalization([MaxValue_ESTMD_ContrastTuning,0],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_ContrastTuning = Data_Normalization([MaxValue_TQD_ON_OFF_ContrastTuning,0],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_LI_ContrastTuning = Data_Normalization([MaxValue_TQD_ON_OFF_LI_ContrastTuning,0],[0,1]);

Normalized_MaxValue_DS_STMD_ContrastTuning = Data_Normalization([MaxValue_DS_STMD_ContrastTuning,0],[0,1]);



figure
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_ESTMD_ContrastTuning,'r','DisPlayName','ESTMD')
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'b','DisPlayName','TQD')
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_LI_ContrastTuning,'g','DisPlayName','TQD LI')
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')


if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    saveas(gcf,strcat(Save_Folder,'/','Contrast-Tuning-MaxValue.fig'))
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    saveas(gcf,strcat(Parameter_Selectivity_SubFile,'/','Contrast-Tuning-MaxValue.fig'))
end



%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 