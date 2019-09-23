% 函数说明
% 紧接 Main.m 函数，对 DS-STMD 的输出结果进行三维的 Max 操作，只需运行一次即可
% 
% 2016-11-18


%% 读取数据
file = [Parameter_File.folder_Global,'/','Max_Operation_TQD_ON_Outputs.mat'];

if ~exist(file,'file')
    if ~exist('TQD_Correlation_Component_ON_All','var')
        
        if ~exist(strcat(Parameter_File.folder_Global,'\','TQD_Correlation_Component_ON_All.mat'),'file')
            
            if ~exist('RecordedData','var')
                File_Max = [Parameter_File.folder_Global,'\','Recorded-Data.mat'];
                load(File_Max)
            end
            
            NumFrame_Clustering = length(RecordedData);
            TQD_Correlation_Component_ON_All = cell(1,NumFrame_Clustering);
            
            for j = 1:NumFrame_Clustering
                
                TQD_Correlation_Component_ON_All{j} = RecordedData{j}.TQD_Correlation_Component_ON;
                
            end
            
            File = strcat(Parameter_File.folder_Global,'\','TQD_Correlation_Component_ON_All.mat');
            save(File,'TQD_Correlation_Component_ON_All','-v7.3')
            
            %clearvars -except DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_All
            clearvars RecordedData
        else
            File = strcat(Parameter_File.folder_Global,'\','TQD_Correlation_Component_ON_All.mat');
            load(File)
        end
    end
    
    
    
    %%
    
    % 读取相关数据
    % 记录的帧数
    NumFrame_Clustering = length(TQD_Correlation_Component_ON_All);
    % 图像大小及 DS-STMD 的方向
    [M_Clustering,N_Clustering,H_Clustering] = size(TQD_Correlation_Component_ON_All{1});
    MexOperation = 1;
    MaxRegionSize = 5;
    Max_Threshold = 1;
    % 用于存储 Max Operation 后的输出
    Max_Operation_TQD_ON_Outputs = cell(1,NumFrame_Clustering);
    
    tic;
    timedLog('Start Max Operation on TQD ON Outputs ...')
    for j = 1:NumFrame_Clustering

        % Max Operation (Along Theta Axis)
        MaxOperation_Input = TQD_Correlation_Component_ON_All{j};
        
        if MexOperation == 1
            timedLog('Building mex function: MaxOperation_3D_mex ...');
            % 编译 MaxOperation_3D.m
            codegen MaxOperation_3D -args {MaxOperation_Input,MaxRegionSize,Max_Threshold,M_Clustering,N_Clustering,H_Clustering} -o MaxOperation_3D_mex
            timedLog('Building mex function is completed.');
            MexOperation = 0;
            [ModelOutputs] = MaxOperation_3D_mex(MaxOperation_Input,MaxRegionSize,Max_Threshold,M_Clustering,N_Clustering,H_Clustering);
        else
            [ModelOutputs] = MaxOperation_3D_mex(MaxOperation_Input,MaxRegionSize,Max_Threshold,M_Clustering,N_Clustering,H_Clustering);
        end
        
        
        Max_Operation_TQD_ON_Outputs{j} = ModelOutputs;
        
        disp(j)
    end
    
    clearvars TQD_Correlation_Component_ON_All
    
    file = [Parameter_File.folder_Global,'/','Max_Operation_TQD_ON_Outputs.mat'];
    save(file,'Max_Operation_TQD_ON_Outputs','NumFrame_Clustering','M_Clustering','N_Clustering','H_Clustering','-v7.3')
    
    
    timeTrain = toc/60; % min
    if timeTrain<60
        timedLog(['Max Operation on TQD ON Outputs finished, time taken: ',num2str(timeTrain),' min'])
    else
        timedLog(['Max Operation on TQD ON Outputs finished, time taken: ',num2str(timeTrain/60), ' hrs'])
    end
    
     
else
    load(file)
end