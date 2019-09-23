% 函数说明
% 该函数用于记录 Detection Rate and False Alarm Rate 曲线，在不同的 LDTB， Size and
% Velocity 下的物体运动


clear all; close all; clc;

%% Main
Is_DR_FA_LDTB = 0;
Is_DR_FA_Size = 0;
Is_DR_FA_Velocity = 1;
Is_DR_FA_BackgroundVelocity = 0;


% 给定 DS-STMD 的检测阈值
DS_STMD_Detection_Threshold_Range = [1000:-25:50,45:-5:10,9:-1:1,0.9:-0.05:0.05];
ESTMD_Detection_Threshold_Range = [1000:-25:50,45:-5:10,9:-1:1,0.9:-0.05:0.05];

Num_Detection_Threshold_DS_STMD = length(DS_STMD_Detection_Threshold_Range);
Num_Detection_Threshold_ESTMD = length(ESTMD_Detection_Threshold_Range);


%% LDTB (Luminance Difference Between Target and Background)
if Is_DR_FA_LDTB == 1
    
    LDTB_Range = [0 15 25 40 50 65 75];
    
    %========================%
    Main_Function_LDTB
    
    %========================%
    
    legend('show')
    axis([0,50,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % 存储数据
    file = ['Data-Journal-Paper-1\Data-for-DR-FA\',Parameter_File.BackgroundType,'\LDTB\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_LDTB','All_DS_STMD_False_Alarm_LDTB','ESTMD_Detection_Threshold_Range',...
               'All_ESTMD_Detection_Rate_LDTB','All_ESTMD_False_Alarm_LDTB','-v7.3')
    
end




%% Size
if Is_DR_FA_Size == 1
    
    Size_Range = [1000];
    
    %========================%
    Main_Function_Size
    
    %========================%
    
    legend('show')
    axis([0,50,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')

    % 存储数据
    file = ['Data-Journal-Paper-1\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Size\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_Size','All_DS_STMD_False_Alarm_Size','ESTMD_Detection_Threshold_Range',...
        'All_ESTMD_Detection_Rate_Size','All_ESTMD_False_Alarm_Size','-v7.3')
    
end

%% Velocity
if Is_DR_FA_Velocity == 1
    
    Velocity_Range = [250];
    
    %========================%
    Main_Function_Velocity
    
    %========================%
    
    legend('show')
    axis([0,25,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % 存储数据
    file = ['Data-Journal-Paper-1\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Velocity\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_Velocity','All_DS_STMD_False_Alarm_Velocity','ESTMD_Detection_Threshold_Range',...
        'All_ESTMD_Detection_Rate_Velocity','All_ESTMD_False_Alarm_Velocity','-v7.3')
    
end



%%  Varying Background Velocity
if Is_DR_FA_BackgroundVelocity  == 1
    
    BackgroundVelocity_Range = [100 150 250 300 350 450 500];
    
    %========================%
    Main_Function_Background_Velocity
    
    %========================%
    
    legend('show')
    axis([0,50,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % 存储数据
    file = ['Data-Journal-Paper-1\Data-for-DR-FA\Varying-Background-Velocity\',Parameter_File.BackgroundType,'\',Parameter_File.MotionMode,'\Background-Velocity\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_Background_Velocity','All_DS_STMD_False_Alarm_Background_Velocity','ESTMD_Detection_Threshold_Range',...
        'All_ESTMD_Detection_Rate_Background_Velocity','All_ESTMD_False_Alarm_Background_Velocity','-v7.3')
    
end






