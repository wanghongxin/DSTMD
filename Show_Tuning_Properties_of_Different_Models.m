% 函数说明
% 该函数用于展示在不同模型 的 Tuning Properties
% 相关数据已由 TopFunction_AllTuning.m 生成



%% Main

clear all; close all; clc;

%=================================================================%
File_Folder = 'Data-Journal-Paper-1\Tuning-Properties';


% Velocity Tuning
File = [File_Folder,'\','Velocity-Tuning-Data.mat'];
load(File)


% 数据处理
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
plot([0 Target_Velocity_Range],Normalized_MaxValue_ESTMD_VelocityTuning,'b','DisPlayName','ESTMD','linewidth',1.5)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD','linewidth',1.5)
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')

figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'r','DisPlayName','TQD','linewidth',1.5)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_LI_VelocityTuning,'g','DisPlayName','TQD (LI)','linewidth',1.5)
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')

%% Width Tuning
File = [File_Folder,'\','Width-Tuning-Data.mat'];
load(File)


% 对每个 Width 记录 WidthTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_ESTMD_WidthTuning = max(ESTMD_Responses_WidthTuning,[],1);

MaxValue_TQD_ON_OFF_WidthTuning = max(TQD_ON_OFF_Responses_WidthTuning,[],1);

MaxValue_TQD_ON_OFF_LI_WidthTuning = max(TQD_ON_OFF_LI_Responses_WidthTuning,[],1);

MaxValue_DS_STMD_WidthTuning = max(DS_STMD_Responses_WidthTuning,[],1);

% Data Normalization
Normalized_MaxValue_ESTMD_WidthTuning = Data_Normalization([0 MaxValue_ESTMD_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_LI_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_LI_WidthTuning],[0,1]);
Normalized_MaxValue_DS_STMD_WidthTuning = Data_Normalization([0 MaxValue_DS_STMD_WidthTuning],[0,1]);

figure
plot([0 Target_Width_Range], Normalized_MaxValue_ESTMD_WidthTuning,'b','DisPlayName','ESTMD','linewidth',1.5)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD','linewidth',1.5)
legend('show')
xlabel('Width')
ylabel('Neural Responses')

figure
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'r','DisPlayName','TQD','linewidth',1.5)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_LI_WidthTuning,'g','DisPlayName','TQD (LI)','linewidth',1.5)
legend('show')
xlabel('Width')
ylabel('Neural Responses')


%% Height Tuning
File = [File_Folder,'\','Height-Tuning-Data.mat'];
load(File)

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
plot([0 Target_Height_Range],Normalized_MaxValue_ESTMD_HeightTuning,'b','DisPlayName','ESTMD','linewidth',1.5)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD','linewidth',1.5)
legend('show')
xlabel('Height')
ylabel('Neural Responses')

figure
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'r','DisPlayName','TQD','linewidth',1.5)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_LI_HeightTuning,'g','DisPlayName','TQD (LI)','linewidth',1.5)
legend('show')
xlabel('Height')
ylabel('Neural Responses')

%% LDTB Tuning
File = [File_Folder,'\','Contrast-Tuning-Data.mat'];
load(File)

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
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_ESTMD_ContrastTuning,'b','DisPlayName','ESTMD','linewidth',1.5)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'m','DisPlayName','DS-STMD','linewidth',1.5)
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')

figure
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','TQD','linewidth',1.5)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_LI_ContrastTuning,'g','DisPlayName','TQD (LI)','linewidth',1.5)
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')


