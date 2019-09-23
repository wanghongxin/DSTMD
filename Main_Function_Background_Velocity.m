% 用于存储 Detection Rate 及 False Alarm Rate
    All_DS_STMD_Detection_Rate_Background_Velocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold_DS_STMD);
    All_DS_STMD_False_Alarm_Background_Velocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold_DS_STMD);
    All_ESTMD_Detection_Rate_Background_Velocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold_ESTMD);
    All_ESTMD_False_Alarm_Background_Velocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold_ESTMD);
    
    
    MarkerEdgeColors = jet(length(BackgroundVelocity_Range));
    
    figure
    for i_Background_Velocity = 1:length(BackgroundVelocity_Range)
        
        
        % 读取文件夹，调用 Main.m 函数处理视频
        Read_In_Folder_Name_Background_Velocity
        
        %================================================================%
        % 对 DS-STMD 的输出结果进行三维的 Max 操作，只需运行一次即可
        Max_Operation_On_DS_STMD_Outputs
        
        for j_Background_Velocity = 1:Num_Detection_Threshold_DS_STMD
            
            % 确定 DS-STMD 检测阈值
            DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(j_Background_Velocity);
            
            disp('=====================================================')
            disp(strcat('Background Velocity = ', num2str(BackgroundVelocity_Range(i_Background_Velocity))))
            disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
            
            
            % 调用函数 Clustering_Detected_Points.m 进行聚类运算
            Cluster_DS_STMD_Detected_Points
            
            % 记录 Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % 用于计算算法的正确率
            Calculate_Detection_Accuracy_and_False_Alarm_DS_STMD
            
            All_DS_STMD_Detection_Rate_Background_Velocity(i_Background_Velocity,j_Background_Velocity) = Detection_Rate_DS_STMD;
            All_DS_STMD_False_Alarm_Background_Velocity(i_Background_Velocity,j_Background_Velocity) = False_Alarm_Rate_DS_STMD;            
            
        end
        
        clearvars Max_Operation_DS_STMD_Outputs Max_Operation_DS_STMD_Outputs

        %=======================================================%
        % ESTMD
        
        Max_Operation_On_ESTMD_Outputs
        
        for j_Background_Velocity = 1:Num_Detection_Threshold_ESTMD
            
            % 确定 DS-STMD 检测阈值
            ESTMD_Detection_Threshold = ESTMD_Detection_Threshold_Range(j_Background_Velocity);
            
            disp('=====================================================')
            disp(strcat('Background Velocity = ', num2str(BackgroundVelocity_Range(i_Background_Velocity))))
            disp(strcat('Detection Threshold = ',num2str(ESTMD_Detection_Threshold)))
            
            
            % 调用函数 Clustering_Detected_Points.m 进行聚类运算
            Cluster_ESTMD_Detected_Points
            
            % 记录 Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % 用于计算算法的正确率
            Calculate_Detection_Accuracy_and_False_Alarm_ESTMD
            
            All_ESTMD_Detection_Rate_Background_Velocity(i_Background_Velocity,j_Background_Velocity) = Detection_Rate_ESTMD;
            All_ESTMD_False_Alarm_Background_Velocity(i_Background_Velocity,j_Background_Velocity) = False_Alarm_Rate_ESTMD;
            
        end
        
        clearvars Max_Operation_ESTMD_Outputs
               
        
        % 循环 i_LDTB 时，必须重新记录 Ground_Truth
        
        clearvars Ground_Truth
        
        % 绘图
        
        plot(All_DS_STMD_False_Alarm_Background_Velocity(i_Background_Velocity,:),All_DS_STMD_Detection_Rate_Background_Velocity(i_Background_Velocity,:),'color',MarkerEdgeColors(i_Background_Velocity,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DSTMD-BKV-',num2str(BackgroundVelocity_Range(i_Background_Velocity))),'linewidth',1)
        hold on
        plot(All_ESTMD_False_Alarm_Background_Velocity(i_Background_Velocity,:),All_ESTMD_Detection_Rate_Background_Velocity(i_Background_Velocity,:),'color',MarkerEdgeColors(i_Background_Velocity,:),'LineStyle','-','Marker','o','DisPlayName',strcat('ESTMD-BKV-',num2str(BackgroundVelocity_Range(i_Background_Velocity))),'linewidth',1)
        hold on
        
    end
