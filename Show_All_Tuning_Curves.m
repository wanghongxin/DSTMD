% 2016-11-13


% 函数说明
% 该函数用于展示相同参数下不同模型的 tuning curves
% Tuning 数据已经由 TopFunction_AllTuning.m 生成
% 该函数用于读取存储的 Tuning Curve 数据，并展示所有的 Tuning Curves

clear all; close all; clc;

File_Folder = 'Data-Journal-Paper-1\Tuning-Properties';

%% Velocity Tuning

Velocity_Tuning_file = [File_Folder,'/','Velocity-Tuning-Data.mat'];
load(Velocity_Tuning_file)

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
plot([0 Target_Velocity_Range],Normalized_MaxValue_ESTMD_VelocityTuning,'r','DisPlayName','ESTMD','linewidth',1.0)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'b','DisPlayName','TQD','linewidth',1.0)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_LI_VelocityTuning,'g','DisPlayName','TQD-LI','linewidth',1.0)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD','linewidth',1.0)
grid on
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')


%% Width Tuning
Width_Tuning_file = [File_Folder,'/','Width-Tuning-Data.mat'];
load(Width_Tuning_file)

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
plot([0 Target_Width_Range], Normalized_MaxValue_ESTMD_WidthTuning,'r','DisPlayName','ESTMD','linewidth',1.0)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'b','DisPlayName','TQD','linewidth',1.0)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_LI_WidthTuning,'g','DisPlayName','TQD LI','linewidth',1.0)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD','linewidth',1.0)
grid on
legend('show')
xlabel('Width')
ylabel('Neural Responses')


%% Height Tuning
Height_Tuning_file = [File_Folder,'/','Height-Tuning-Data.mat'];
load(Height_Tuning_file)


% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_ESTMD_HeightTuning = max(ESTMD_Responses_HeighthTuning,[],1);

MaxValue_TQD_ON_OFF_HeightTuning = max(TQD_ON_OFF_Responses_HeightTuning,[],1);

MaxValue_TQD_ON_OFF_LI_HeightTuning = max(TQD_ON_OFF_LI_Responses_HeightTuning,[],1);

MaxValue_DS_STMD_HeightTuning = max(DS_STMD_Responses_HeightTuning,[],1);

% Data Normalization
Normalized_MaxValue_ESTMD_HeightTuning = Data_Normalization([0 MaxValue_ESTMD_HeightTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_HeightTuning],[0,1]);

Normalized_MaxValue_TQD_ON_OFF_LI_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_LI_HeightTuning],[0,1]);

Normalized_MaxValue_DS_STMD_HeightTuning = Data_Normalization([0 MaxValue_DS_STMD_HeightTuning],[0,1]);

figure
plot([0 Target_Height_Range],Normalized_MaxValue_ESTMD_HeightTuning,'r','DisPlayName','ESTMD','linewidth',1.0)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'b','DisPlayName','TQD','linewidth',1.0)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_LI_HeightTuning,'g','DisPlayName','TQD LI','linewidth',1.0)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD','linewidth',1.0)
grid on
legend('show')
xlabel('Height')
ylabel('Neural Responses')



%% LDTB Tuning
LDTB_Tuning_file = [File_Folder,'/','Contrast-Tuning-Data.mat'];
load(LDTB_Tuning_file)


%% 数据处理
% Method 1
% 对每个 LDTV 记录 ContrastTuning_Frame 帧数据，对这些记录的数据取 Max
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
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_ESTMD_ContrastTuning,'r*-','DisPlayName','ESTMD','linewidth',1.0)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'b^-','DisPlayName','TQD','linewidth',1.0)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_LI_ContrastTuning,'go-','DisPlayName','TQD-LI','linewidth',1.0)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'m+-','DisPlayName','DS-STMD','linewidth',1.0)
grid on
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')


