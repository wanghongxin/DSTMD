% 2016-11-18


% 函数说明
% 该函数用于计算检测正确率及错误率


timedLog('Start Calcualte DS-STMD Model -- Detection Rate and False Alarm Rate...')
%% Main Function

%clear all; close all; clc;

if ~exist('Clustering_Results','var')
    % 导入聚类
    File = [Parameter_File.folder_Global,'/',strcat('Clustering_Results-DS-STMD-Detection-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
    load(File)
end


% Ground Truth
if ~exist('Ground_Truth','var')
    if ~exist(strcat(Parameter_File.folder_Global,'\','Ground-Truth.mat'),'file')
        Claculate_Ground_Truth_Target_Positions
    else
        File = [Parameter_File.folder_Global,'/','Ground-Truth.mat'];
        load(File)
    end  
end

% 若物体坐标与检测点的距离小于 Distance_Threshold, 则视为物体被检测到
Distance_Threshold = 8;
% 背景的运动方向
Background_Motion_Direction = 2;
% 
Detected_Target_Num_DS_STMD = 0;
False_Positive_Num_DS_STMD= 0;


for kk = 1:NumFrame_Clustering
    
    Detected_Target_Num_DS_STMD_Each_Frame = 0;
    
    for jj = 1:Target_Num
        
        % 获取物体 jj 在第 kk 帧的真实坐标
        Target_Position_X = Ground_Truth(kk,1,jj);
        Target_Position_Y = Ground_Truth(kk,2,jj);
        
        % Current Frame Detected Points
        All_Points_Position = Clustering_Results{kk}.Clustering_Points_Matrix;
        All_Detected_Object_Num = Clustering_Results{kk}.Clustering_Detected_Object_Num;
        
        if All_Detected_Object_Num>0
            Detected_Points_Position = All_Points_Position(1:All_Detected_Object_Num,:);
        else
            Detected_Points_Position = [-100,-100,-1];
        end
        
        % 计算所有检测与物体的距离
        [Smallest_Dist,Smallest_Index] = pdist2(Detected_Points_Position(:,1:2),[Target_Position_X,Target_Position_Y],'euclidean','Smallest',1);
        
        if Smallest_Dist<Distance_Threshold
            
            Detected_Target_Num_DS_STMD = Detected_Target_Num_DS_STMD +1;
            Detected_Target_Num_DS_STMD_Each_Frame = Detected_Target_Num_DS_STMD_Each_Frame + 1;
        end
    end
    
    False_Positive_Num_DS_STMD = False_Positive_Num_DS_STMD + (All_Detected_Object_Num-Detected_Target_Num_DS_STMD_Each_Frame);
    
end


Detection_Rate_DS_STMD =  Detected_Target_Num_DS_STMD/(Target_Num*NumFrame_Clustering);
False_Alarm_Rate_DS_STMD = False_Positive_Num_DS_STMD/NumFrame_Clustering;


timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

