% 函数说明
% 该函数用于展示在不同参数下 DS-STMD 的 Tuning Properties
% 相关数据已由 TopFunction_AllTuning.m 生成



%% Main

clear all; close all; clc;

%=================================================================%
% Velocity Selectivity
File_Folder = 'Data-Journal-Paper-1\Parameter-Selectivity-Order\Parameter-Selectivity-Width';
File = [File_Folder,'\','Parameter-Selection.mat'];
load(File)

% length(DS_STMD_ON_Parameter_Order)
% length(Inhibition_Kernel_Sigmal_1)
Num_Para = 3;
MarkerEdgeColors = [0 0 1;0 1 0;1 0 0];

% Velocity Tuning
figure
Color_Index = 0;
for i_para = 1:Num_Para
    
    Folder0 = [File_Folder,'\',strcat('Parameter-',num2str(i_para)),'\','Velocity-Tuning-Data.mat'];
    load(Folder0)
    Color_Index = Color_Index +1;
    
    MaxValue_DS_STMD_VelocityTuning = max(DS_STMD_Responses_VelocityTuning,[],1);
    Normalized_MaxValue_DS_STMD_VelocityTuning = Data_Normalization([0 MaxValue_DS_STMD_VelocityTuning],[0,1]);
    
    plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'color',MarkerEdgeColors(Color_Index,:),'DisPlayName',strcat('P-',num2str(Color_Index)),'linewidth',1.5)
    hold on

    
end
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')



% Width Tuning
figure
Color_Index = 0;
for i_para = 1:Num_Para
    
    Folder0 = [File_Folder,'\',strcat('Parameter-',num2str(i_para)),'\','Width-Tuning-Data.mat'];
    load(Folder0)
    Color_Index = Color_Index +1;
    
    MaxValue_DS_STMD_WidthTuning = max(DS_STMD_Responses_WidthTuning,[],1);
    Normalized_MaxValue_DS_STMD_WidthTuning = Data_Normalization([0 MaxValue_DS_STMD_WidthTuning],[0,1]);
    
    plot([0 Target_Width_Range],Normalized_MaxValue_DS_STMD_WidthTuning,'color',MarkerEdgeColors(Color_Index,:),'DisPlayName',strcat('P-',num2str(Color_Index)),'linewidth',1.5)
    hold on

    
end
legend('show')
xlabel('Width')
ylabel('Neural Responses')



% Height Tuning
figure
Color_Index = 0;
for i_para = 1:Num_Para
    
    Folder0 = [File_Folder,'\',strcat('Parameter-',num2str(i_para)),'\','Height-Tuning-Data.mat'];
    load(Folder0)
    
    Color_Index = Color_Index +1;
    MaxValue_DS_STMD_HeightTuning = max(DS_STMD_Responses_HeightTuning,[],1);
    Normalized_MaxValue_DS_STMD_HeightTuning = Data_Normalization([0 MaxValue_DS_STMD_HeightTuning],[0,1]);
    
    plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'color',MarkerEdgeColors(Color_Index,:),'DisPlayName',strcat('P-',num2str(Color_Index)),'linewidth',1.5)
    hold on

    
end
legend('show')
xlabel('Height')
ylabel('Neural Responses')




% LDTB Tuning
figure
Color_Index = 0;
for i_para = 1:Num_Para
    
    Folder0 = [File_Folder,'\',strcat('Parameter-',num2str(i_para)),'\','Contrast-Tuning-Data.mat'];
    load(Folder0)
    Color_Index = Color_Index +1;
    
    MaxValue_DS_STMD_ContrastTuning = max(DS_STMD_Responses_ContrastTuning,[],1);
    Normalized_MaxValue_DS_STMD_ContrastTuning = Data_Normalization([MaxValue_DS_STMD_ContrastTuning,0],[0,1]);
    
    plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'color',MarkerEdgeColors(Color_Index,:),'DisPlayName',strcat('P-',num2str(Color_Index)),'linewidth',1.5)
    hold on

    
end
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')



