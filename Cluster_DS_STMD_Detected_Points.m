% 2016-11-05

% 函数说明
% 该函数用于实现对于 DS-STMD 输出结果的聚类
% 对于 DS-STMD 模型经过方向抑制后的结果 Outputs_After_Inhibition_Along_Theta_Axis，
% 首先沿 Z 轴进行 Max 操作，寻求运动方向
% 然后对 Max 操作后的结果进行聚类


% 导入变量 Max_Operation_DS_STMD_Outputs
if ~exist('Max_Operation_DS_STMD_Outputs','var')
    file = [Parameter_File.folder_Global,'/','Max_Operation_DS_STMD_Outputs.mat'];
    load(file)
end


% 生成存储聚类结果的 cell
NumFrame_Clustering = length(Max_Operation_DS_STMD_Outputs);
Clustering_Results = cell(1,NumFrame_Clustering);

tic;
timedLog('Start Clustering...')
for j = 1:NumFrame_Clustering
    
    
    ModelOutputs = Max_Operation_DS_STMD_Outputs{j};
    Clustering_Points_Matrix = [];
    Clustering_Points_Num_Matrix_Each_Direction = zeros(1,H_Clustering);
    Index_Clustering = 0;
    
    for k = 1:H_Clustering
        
        % 寻找大于阈值的点
        [IndX,IndY] = find(ModelOutputs(:,:,k)>DS_STMD_Detection_Threshold);
        % 去掉一些边界点
        NIndY = IndY(IndY>5&IndY<(N_Clustering-5)&IndX>5&IndX<(M_Clustering-5));
        NIndX = IndX(IndY>5&IndY<(N_Clustering-5)&IndX>5&IndX<(M_Clustering-5));
        
        % 判断是否是空集，若不是空集，调用 DBSCAN.m 进行聚类
        if ~isempty(NIndY)
            % 若距离小于 5, 则判断为一类
            epsilon = 3;
            MinPts = 1;
            IDX = DBSCAN([NIndX,NIndY],epsilon,MinPts);
        else
            IDX = 0;
        end
        
        
        Cluster_Num = max(IDX);
        
        if Cluster_Num>0
            % 若大于 0，则计算每类的类中心
            Cluster_Center = zeros(Cluster_Num,2);
            for l=1:Cluster_Num
                % 计算类中心
                Clustering_X = NIndX(IDX==l);
                Clustering_Y = NIndY(IDX==l);
                Cluster_Center_X = round(mean(Clustering_X));
                Cluster_Center_Y = round(mean(Clustering_Y));
                Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
            end
            % 存储类中心
            Cluster_Center_Matrix = [Cluster_Center,k*ones(Cluster_Num,1)];
            Clustering_Points_Matrix = [Clustering_Points_Matrix;Cluster_Center_Matrix];
            Clustering_Points_Num_Matrix_Each_Direction(k) = Cluster_Num;
            Index_Clustering = Index_Clustering + Cluster_Num;
        else
            % 若小于 0 ,则判断为没有输出
            Clustering_Points_Num_Matrix_Each_Direction(k) = 0;
            Index_Clustering = Index_Clustering + Cluster_Num;
        end

    end
    
    
    
    
    Clustering_Results{j}.Clustering_Points_Matrix = Clustering_Points_Matrix; 
    Clustering_Results{j}.Clustering_Points_Num_Matrix_Each_Direction = Clustering_Points_Num_Matrix_Each_Direction;
    Clustering_Results{j}.Clustering_Detected_Object_Num = Index_Clustering;
end


file = [Parameter_File.folder_Global,'/',strcat('Clustering_Results-DS-STMD-Detection-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
save(file,'Clustering_Results','NumFrame_Clustering','DS_STMD_Detection_Threshold','-v7.3')


% clearvars Max_Operation_DS_STMD_Outputs

timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Clustering finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Clustering finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

         