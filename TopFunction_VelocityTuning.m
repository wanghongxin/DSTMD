% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 Velocity Tuning 曲线

%clear all; close all; clc;
close all; 

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等

Parameter_File.Test_VelocityTuning = 1;     % 不生成 Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Parameter_File.Test_HeightTuning = 0;       % 不生成 Height Tuning Curve
Parameter_File.Test_ContrastTuning = 0;

% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
VelocityTuning_Frame = 30;

% 确定物体速度的变化范围
Target_Velocity_Range = [50 100 150 200 250 300 350 400 450 500 550 600 650 700 800 900 1000];


% 生成用于存储 ESTMD, TQD, TQD_LI 及 DS-STMD 响应的矩阵
ESTMD_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));

TQD_ON_OFF_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));

TQD_ON_OFF_LI_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));

DS_STMD_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));

tic;
timedLog('Start Record Velocity Tuning Curve ...')

% length(Target_Velocity_Range)
for k = 1:length(Target_Velocity_Range)
    
    disp('======================================')
    disp(strcat('Target Velocity =  ',num2str(Target_Velocity_Range(k))))
    
    % Parameters for Input Image Sequence
    Parameter_File.folderName = 'Velocity-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    Parameter_File.BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    Parameter_File.TargetNum = 'SingleTarget';
    Parameter_File.TargetWidth = 5;
    Parameter_File.TargetHeight = 5;
    Parameter_File.TargetVelocity = Target_Velocity_Range(k);         % 确定物体运动速度
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
    
    ESTMD_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    
    TQD_ON_OFF_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    
    TQD_ON_OFF_LI_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    
    DS_STMD_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    ESTMD_Responses_VelocityTuning(:,k) = ESTMD_Responses_VelocityTuning_EachStep;
    
    TQD_ON_OFF_Responses_VelocityTuning(:,k) = TQD_ON_OFF_Responses_VelocityTuning_EachStep;
    
    TQD_ON_OFF_LI_Responses_VelocityTuning(:,k) = TQD_ON_OFF_LI_Responses_VelocityTuning_EachStep;
    
    DS_STMD_Responses_VelocityTuning(:,k) = DS_STMD_Responses_VelocityTuning_EachStep;
    


end
% 存储记录的数据
if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    
    Save_Folder = 'Data-Journal-Paper-1\Tuning-Properties-2';
    if ~exist(Save_Folder,'dir')
        mkdir(Save_Folder) 
    end

    file = [Save_Folder,'/','Velocity-Tuning-Data.mat'];
    save(file,'Target_Velocity_Range','ESTMD_Responses_VelocityTuning','TQD_ON_OFF_Responses_VelocityTuning','TQD_ON_OFF_LI_Responses_VelocityTuning','DS_STMD_Responses_VelocityTuning','-v7.3')
    
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    file = [Parameter_Selectivity_SubFile,'/','Velocity-Tuning-Data.mat'];
    save(file,'Target_Velocity_Range','ESTMD_Responses_VelocityTuning','TQD_ON_OFF_Responses_VelocityTuning','TQD_ON_OFF_LI_Responses_VelocityTuning','DS_STMD_Responses_VelocityTuning','-v7.3')
end
%% 数据处理
% Method 1
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_ESTMD_VelocityTuning = max(ESTMD_Responses_VelocityTuning,[],1);

MaxValue_TQD_ON_OFF_VelocityTuning = max(TQD_ON_OFF_Responses_VelocityTuning,[],1);

MaxValue_TQD_ON_OFF_LI_VelocityTuning = max(TQD_ON_OFF_LI_Responses_VelocityTuning,[],1);

MaxValue_DS_STMD_VelocityTuning = max(DS_STMD_Responses_VelocityTuning,[],1);

% Data Normalization
Normalized_MaxValue_ESTMD_VelocityTuning = Data_Normalization([0 MaxValue_ESTMD_VelocityTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_VelocityTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_LI_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_LI_VelocityTuning],[0,1]);

Normalized_MaxValue_DS_STMD_VelocityTuning = Data_Normalization([0 MaxValue_DS_STMD_VelocityTuning],[0,1]);

figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_ESTMD_VelocityTuning,'r','DisPlayName','ESTMD')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'b','DisPlayName','TQD')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_LI_VelocityTuning,'g','DisPlayName','TQD LI')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')
% 保存图片
if (Test_Parameter_Sensitivity_Velocity == 0)&&(Test_Parameter_Sensitivity_Width== 0)&&(Test_Parameter_Sensitivity_Height== 0)
    saveas(gcf,strcat(Save_Folder,'/','Velocity-Tuning-MaxValue.fig'))
elseif (Test_Parameter_Sensitivity_Velocity == 1)||(Test_Parameter_Sensitivity_Width== 1)||(Test_Parameter_Sensitivity_Height== 1)
    saveas(gcf,strcat(Parameter_Selectivity_SubFile,'/','Velocity-Tuning-MaxValue.fig'))
end


%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 