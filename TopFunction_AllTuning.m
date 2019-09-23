
% 函数说明
% 该函数主要用于计算 Velocity, Width and Height Tuning
clear all; close all; clc;

%% Main Function
disp('=======================================================')
disp('Same Paramters')
Test_Parameter_Sensitivity_Velocity = 0;
Test_Parameter_Sensitivity_Width = 0;
Test_Parameter_Sensitivity_Height = 0;

% Velocity Tuning
% 调用 TopFunction_VelocityTuning.m
TopFunction_VelocityTuning

% Width Tuning
% 调用 TopFunction_WidthTuning.m
TopFunction_WidthTuning


% Height Tuning
% 调用 TopFunction_HeightTuning.m
TopFunction_HeightTuning

% LDTB Tuning
% 调用 TopFunction_ContrastTuning.m
TopFunction_ContrastTuning


%% 针对不同参数研究 DS-STMD 模型的 Tuning Properties
disp('=======================================================')
disp('Test_Parameter_Sensitivity_Velocity')

Test_Parameter_Sensitivity_Velocity = 1;
Test_Parameter_Sensitivity_Width = 0;
Test_Parameter_Sensitivity_Height = 0;
% Velocity Tuning

ESTMD_Parameter_Order = [5 5 5 5 5 5];
ESTMD_Parameter_Tau = [25 25 25 25 25 25];

TQD_Parameter_Order = [1 2 3 4 5 6];
TQD_Parameter_Tau = [5 10 15 20 25 30];

TQD_LI_Parameter_Order = TQD_Parameter_Order;
TQD_LI_Parameter_Tau = TQD_Parameter_Tau;

DS_STMD_ON_Parameter_Order = TQD_Parameter_Order;
DS_STMD_ON_Parameter_Tau = TQD_Parameter_Tau;

DS_STMD_OFF_1_Parameter_Order = ESTMD_Parameter_Order;
DS_STMD_OFF_1_Parameter_Tau = ESTMD_Parameter_Tau;

DS_STMD_OFF_2_Parameter_Order = DS_STMD_ON_Parameter_Order + DS_STMD_OFF_1_Parameter_Order;
DS_STMD_OFF_2_Parameter_Tau = DS_STMD_ON_Parameter_Tau + DS_STMD_OFF_1_Parameter_Tau;

Parameter_Selectivity_File = 'Data-Journal-Paper-1\Parameter-Selectivity-2\Parameter-Selectivity-Velocity';
if ~exist(Parameter_Selectivity_File,'dir')
    mkdir(Parameter_Selectivity_File)
end

% length(DS_STMD_ON_Parameter_Order)
for i_para = 1:length(DS_STMD_ON_Parameter_Order)
    
    Parameter_Selectivity_SubFile= strcat(Parameter_Selectivity_File,'\','Parameter-',num2str(i_para));
    if ~exist(Parameter_Selectivity_SubFile,'dir')
        mkdir(Parameter_Selectivity_SubFile)
    end

    TopFunction_VelocityTuning
    TopFunction_WidthTuning
    TopFunction_HeightTuning
    TopFunction_ContrastTuning
    
end

file = [Parameter_Selectivity_File,'/','Parameter-Selection.mat'];
save(file,'ESTMD_Parameter_Order','ESTMD_Parameter_Tau','TQD_Parameter_Order','TQD_Parameter_Tau','TQD_LI_Parameter_Order','TQD_LI_Parameter_Tau',...
                  'DS_STMD_ON_Parameter_Order','DS_STMD_ON_Parameter_Tau','DS_STMD_OFF_1_Parameter_Order','DS_STMD_OFF_1_Parameter_Tau','DS_STMD_OFF_2_Parameter_Order','DS_STMD_OFF_2_Parameter_Tau','-v7.3')



             
              
             
%=======================================================%
disp('====================================================')
disp('Test_Parameter_Sensitivity_Width')
Test_Parameter_Sensitivity_Velocity = 0;
Test_Parameter_Sensitivity_Width = 1;
Test_Parameter_Sensitivity_Height = 0;
% Width Tuning

ESTMD_Parameter_Order = [2 4 6 5 8 10 12];
ESTMD_Parameter_Tau = [8 16 24 25 32 40 48];

TQD_Parameter_Order = [3 3 3 3 3 3 3];
TQD_Parameter_Tau = [15 15 15 15 15 15 15];

TQD_LI_Parameter_Order = TQD_Parameter_Order;
TQD_LI_Parameter_Tau = TQD_Parameter_Tau;

DS_STMD_ON_Parameter_Order = TQD_Parameter_Order;
DS_STMD_ON_Parameter_Tau = TQD_Parameter_Tau;

DS_STMD_OFF_1_Parameter_Order = ESTMD_Parameter_Order;
DS_STMD_OFF_1_Parameter_Tau = ESTMD_Parameter_Tau;

DS_STMD_OFF_2_Parameter_Order = DS_STMD_ON_Parameter_Order + DS_STMD_OFF_1_Parameter_Order;
DS_STMD_OFF_2_Parameter_Tau = DS_STMD_ON_Parameter_Tau + DS_STMD_OFF_1_Parameter_Tau;

Parameter_Selectivity_File = 'Data-Journal-Paper-1\Parameter-Selectivity-2\Parameter-Selectivity-Width';
if ~exist(Parameter_Selectivity_File,'dir')
    mkdir(Parameter_Selectivity_File)
end

% length(DS_STMD_ON_Parameter_Order)
for i_para = 1:length(DS_STMD_ON_Parameter_Order)
    
    Parameter_Selectivity_SubFile= strcat(Parameter_Selectivity_File,'\','Parameter-',num2str(i_para));
    if ~exist(Parameter_Selectivity_SubFile,'dir')
        mkdir(Parameter_Selectivity_SubFile)
    end

    TopFunction_VelocityTuning
    TopFunction_WidthTuning
    TopFunction_HeightTuning
    TopFunction_ContrastTuning
    
end

file = [Parameter_Selectivity_File,'/','Parameter-Selection.mat'];
save(file,'ESTMD_Parameter_Order','ESTMD_Parameter_Tau','TQD_Parameter_Order','TQD_Parameter_Tau','TQD_LI_Parameter_Order','TQD_LI_Parameter_Tau',...
                  'DS_STMD_ON_Parameter_Order','DS_STMD_ON_Parameter_Tau','DS_STMD_OFF_1_Parameter_Order','DS_STMD_OFF_1_Parameter_Tau','DS_STMD_OFF_2_Parameter_Order','DS_STMD_OFF_2_Parameter_Tau','-v7.3')


%=======================================================%
disp('====================================================')
disp('Test_Parameter_Sensitivity_Height')
% Height Tuning
Test_Parameter_Sensitivity_Velocity = 0;
Test_Parameter_Sensitivity_Width = 0;
Test_Parameter_Sensitivity_Height = 1;

Inhibition_Kernel_Sigmal_1 = [1 1.5 2.3 2.8 3.7];
Inhibition_Kernel_Sigmal_2 = 2*Inhibition_Kernel_Sigmal_1;
Inhibition_Kernel_Size = [13 13 21 25 35];

Parameter_Selectivity_File = 'Data-Journal-Paper-1\Parameter-Selectivity-2\Parameter-Selectivity-Height';
if ~exist(Parameter_Selectivity_File,'dir')
    mkdir(Parameter_Selectivity_File)
end

% length(Inhibition_Kernel_Sigmal_1)
for i_para = 1:length(Inhibition_Kernel_Sigmal_1)
    
    Parameter_Selectivity_SubFile= strcat(Parameter_Selectivity_File,'\','Parameter-',num2str(i_para));
    if ~exist(Parameter_Selectivity_SubFile,'dir')
        mkdir(Parameter_Selectivity_SubFile)
    end

    TopFunction_VelocityTuning
    TopFunction_WidthTuning
    TopFunction_HeightTuning
    TopFunction_ContrastTuning
    
end

file = [Parameter_Selectivity_File,'/','Parameter-Selection.mat'];
save(file,'Inhibition_Kernel_Sigmal_1','Inhibition_Kernel_Sigmal_2','-v7.3')
















