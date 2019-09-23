% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 Velocity Tuning 曲线

%clear all; close all; clc;
close all;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Parameter_File.Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Parameter_File.Test_HeightTuning = 1;       % 不生成 Height Tuning Curve
Parameter_File.Test_ContrastTuning = 0;

% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
HeightTuning_Frame = 30;

% 确定物体速度的变化范围
Target_Height_Range = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];


% 生成用于存储 TQD 及 DS-STMD 响应的矩阵
ESTMD_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));

TQD_ON_OFF_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));

TQD_ON_OFF_LI_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));

DS_STMD_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));

tic;
timedLog('Start Record Height Tuning Curve ...')

% length(Target_Height_Range)

for k = 1:length(Target_Height_Range)
    
    disp('======================================')
    disp(strcat('Target Height =  ',num2str(Target_Height_Range(k))))
    
    % Parameters for Input Image Sequence
    Parameter_File.folderName = 'Height-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    Parameter_File.BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    Parameter_File.TargetNum = 'SingleTarget';
    Parameter_File.TargetWidth = 5;
    Parameter_File.TargetHeight = Target_Height_Range(k);
    Parameter_File.TargetVelocity = 250;         % 确定物体运动速度
    Parameter_File.TargetLuminance = 0;
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
    
    ESTMD_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);

    TQD_ON_OFF_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    
    TQD_ON_OFF_LI_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    
    DS_STMD_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    ESTMD_Responses_HeightTuning(:,k) = ESTMD_Responses_HeightTuning_EachStep;

    TQD_ON_OFF_Responses_HeightTuning(:,k) = TQD_ON_OFF_Responses_HeightTuning_EachStep;
    
    TQD_ON_OFF_LI_Responses_HeightTuning(:,k) = TQD_ON_OFF_LI_Responses_HeightTuning_EachStep;
    
    DS_STMD_Responses_HeightTuning(:,k) = DS_STMD_Responses_HeightTuning_EachStep;

end

% 存储记录的数据

if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    
    Save_Folder = 'Data-Journal-Paper-1\Tuning-Properties-2';
    if ~exist(Save_Folder,'dir')
        mkdir(Save_Folder)
    end
    
    file = [Save_Folder,'/','Height-Tuning-Data.mat'];
    save(file,'Target_Height_Range','ESTMD_Responses_HeightTuning','TQD_ON_OFF_Responses_HeightTuning','TQD_ON_OFF_LI_Responses_HeightTuning','DS_STMD_Responses_HeightTuning','-v7.3')
    
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    
    file = [Parameter_Selectivity_SubFile,'/','Height-Tuning-Data.mat'];
    save(file,'Target_Height_Range','ESTMD_Responses_HeightTuning','TQD_ON_OFF_Responses_HeightTuning','TQD_ON_OFF_LI_Responses_HeightTuning','DS_STMD_Responses_HeightTuning','-v7.3')
end

%% 数据处理
% Method 1
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_ESTMD_HeightTuning = max(ESTMD_Responses_HeightTuning,[],1);

MaxValue_TQD_ON_OFF_HeightTuning = max(TQD_ON_OFF_Responses_HeightTuning,[],1);

MaxValue_TQD_ON_OFF_LI_HeightTuning = max(TQD_ON_OFF_LI_Responses_HeightTuning,[],1);

MaxValue_DS_STMD_HeightTuning = max(DS_STMD_Responses_HeightTuning,[],1);

% Data Normalization
Normalized_MaxValue_ESTMD_HeightTuning = Data_Normalization([0 MaxValue_ESTMD_HeightTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_HeightTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_LI_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_LI_HeightTuning],[0,1]);

Normalized_MaxValue_DS_STMD_HeightTuning = Data_Normalization([0 MaxValue_DS_STMD_HeightTuning],[0,1]);

figure
plot([0 Target_Height_Range],Normalized_MaxValue_ESTMD_HeightTuning,'r','DisPlayName','ESTMD')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'b','DisPlayName','TQD')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_LI_HeightTuning,'g','DisPlayName','TQD LI')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
xlabel('Height')
ylabel('Neural Responses')

% 保存图片

if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    saveas(gcf,strcat(Save_Folder,'/','Height-Tuning-MaxValue.fig'))
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    saveas(gcf,strcat(Parameter_Selectivity_SubFile,'/','Height-Tuning-MaxValue.fig'))
end



%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 