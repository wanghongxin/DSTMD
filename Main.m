% 2016-10-01
% Main.m
% 函数说明
% 该函数用于实现模型的主要功能，包括 Wide-field Motion Perception and Small Target Motion
% Perception

%% 以下为主函数

    
%figure

for i = Parameter_File.StartFrame:Parameter_File.EndFrame
    
    %======================  Retina Layer =============================%
    file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,i)];
    
    I = imread(file);
    OriginalImage = I;
    % Green Channel
    I = double(rgb2gray(I));
    %I = double(I(:,:,2));   
   
    % Photoreceptors (Gauss Filter,Spatial Filter)
    Photoreceptors_Outptut = conv2(I,Parameter_Fun.GaussFilter,'same');
    %GaussBluredImage = Photoreceptors_Outptut;
    
    %========================  Lamina Layer ===========================%
    
    % Motion Pathway
    % Large Monopolar Cells
    % High-pass Filter (Gamma function 1 - Gamma function 2)
    [LMCs_High_Pass_Output,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun2_Output] = LMCs_HighPassFilter_GammaDiff(Photoreceptors_Outptut,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun1_Tau,Parameter_Fun.GammaFun1_Order,...
                                                        Parameter_Fun.GammaFun2_Output,Parameter_Fun.GammaFun2_Tau,Parameter_Fun.GammaFun2_Order);
                                                                                            
                                                    
     % LMC(Large Monopolar Cells) Lateral Inhibition Mechanism
     % 是否对高通滤波后的信号进行侧抑制
     if Parameter_Fun.IsLMCs_LateralInhibition == 1   
         [LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX] = LMCs_LateralInhibitionMechanism(LMCs_High_Pass_Output,...
                                             Parameter_Fun.LMCs_SpatialInhibitionKernel,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W1_Alpha,...
                                             Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX,Parameter_Fun.LMCs_W2_Alpha,Parameter_Fun.IsTemporalInhibition_LMC); 
     else
         LMCs_Inhibition_Output = LMCs_High_Pass_Output;
         LMCs_Inhibition_Output_NT = LMCs_High_Pass_Output;
     end
     
     
     
    %========================== Medulla Layer ============================%
    
    % ON and OFF Channel Separation
     ON_Channel = (abs(LMCs_Inhibition_Output)+LMCs_Inhibition_Output)*0.5;
     OFF_Channel = (abs(LMCs_Inhibition_Output)-LMCs_Inhibition_Output)*0.5;
     
     
     
     % Second Lateral Inhibition Mechanism ---- ESTMD
     
     ON_Channel_LI = conv2(ON_Channel,Parameter_Fun.Second_Lateral_Inhibition_Kernel,'same');
     OFF_Channel_LI = conv2(OFF_Channel,Parameter_Fun.Second_Lateral_Inhibition_Kernel,'same');
     
     % Half-wave Rectification
     
     ON_Channel_LI = (abs(ON_Channel_LI)+ON_Channel_LI)*0.5;
     OFF_Channel_LI = (abs(OFF_Channel_LI)+OFF_Channel_LI)*0.5;
     
     
     %====================== Lobula Layer ===============================%
     
     % ESTMD
     % 注意 ESTMD 的输入是 ON_Channel_LI 和 OFF_Channel_LI
     [ESTMD_Output,Parameter_Fun.ESTMD_GammaFun_Output_OFF] = Elementary_Small_Target_Motion_Detector(ON_Channel_LI,OFF_Channel_LI,...
                                                              Parameter_Fun.ESTMD_GammaFun_Output_OFF,Parameter_Fun.ESTMD_GammaFun_Tau,Parameter_Fun.ESTMD_GammaFun_Order);
     
     % 延迟后的 OFF 通道
     ESTMD_Delayed_OFF_Channel = Parameter_Fun.ESTMD_GammaFun_Output_OFF(:,:,Parameter_Fun.ESTMD_GammaFun_Order+1);                                                      
                                                          
     %--------------------------------------------------------------------
     % LPTC -TQD
     [TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,Parameter_Fun.TQD_GammaFun_Output_ON,Parameter_Fun.TQD_GammaFun_Output_OFF] = ...
                          SingleHand_TwoQuadrantDetector(ON_Channel,OFF_Channel,Parameter_Fun.TQD_GammaFun_Output_ON,Parameter_Fun.TQD_GammaFun_Output_OFF,...
                          Parameter_Fun.TQD_GammaFun_Tau,Parameter_Fun.TQD_GammaFun_Order,Parameter_Fun.TQD_Dist,Parameter_Fun.TQD_Directions,Parameter_Fun.M,Parameter_Fun.N);
                      
     LPTC_Outputs = TQD_Correlation_Component_ON + TQD_Correlation_Component_OFF;
     
     % 延迟后的 ON and OFF 通道
     TQD_Delayed_ON_Channel = Parameter_Fun.TQD_GammaFun_Output_ON(:,:,Parameter_Fun.TQD_GammaFun_Order+1);
     TQD_Delayed_OFF_Channel = Parameter_Fun.TQD_GammaFun_Output_OFF(:,:,Parameter_Fun.TQD_GammaFun_Order+1);  
     
     
     %--------------------------------------------------------------------
     % LPTC - Laterally Inhibited TQD
     % 注意此时的输入是 ON_Channel_LI 和 OFF_Channel_LI
     [TQD_Correlation_Component_ON_LI,TQD_Correlation_Component_OFF_LI,Parameter_Fun.TQD_GammaFun_Output_ON_LI,Parameter_Fun.TQD_GammaFun_Output_OFF_LI] = ...
                          SingleHand_TwoQuadrantDetector(ON_Channel_LI,OFF_Channel_LI,Parameter_Fun.TQD_GammaFun_Output_ON_LI,Parameter_Fun.TQD_GammaFun_Output_OFF_LI,...
                          Parameter_Fun.TQD_GammaFun_Tau_LI,Parameter_Fun.TQD_GammaFun_Order_LI,Parameter_Fun.TQD_Dist_LI,Parameter_Fun.TQD_Directions_LI,Parameter_Fun.M,Parameter_Fun.N);
                      
     LPTC_Outputs_LI = TQD_Correlation_Component_ON_LI + TQD_Correlation_Component_OFF_LI;
     
     % 延迟后的 ON and OFF 通道
     TQD_Delayed_ON_Channel_LI = Parameter_Fun.TQD_GammaFun_Output_ON_LI(:,:,Parameter_Fun.TQD_GammaFun_Order_LI+1);
     TQD_Delayed_OFF_Channel_LI = Parameter_Fun.TQD_GammaFun_Output_OFF_LI(:,:,Parameter_Fun.TQD_GammaFun_Order_LI+1);  
     
     
 
     %--------------------------------------------------------------------
     % DS-STMD
     % DS-STMD Correlation
     
     [DS_STMD_LateralInhibitionOutput,DS_STMD_CorrelationOutput,Parameter_Fun.DS_STMD_GammaFun_Output_ON,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2] = ...
         DS_STMD_MotionDetector(ON_Channel,OFF_Channel,...
         Parameter_Fun.DS_STMD_GammaFun_Order_ON,Parameter_Fun.DS_STMD_GammaFun_Tau_ON,Parameter_Fun.DS_STMD_GammaFun_Output_ON,...
         Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1,...
         Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2,Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_2,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2,...
         Parameter_Fun.DS_STMD_Dist,Parameter_Fun.DS_STMD_Directions,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_InhibitionKernel);
     
     % 延迟后的 ON and OFF 通道
     DS_STMD_Delayed_ON_Channel = Parameter_Fun.DS_STMD_GammaFun_Output_ON(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_ON+1);
     DS_STMD_Delayed_OFF_Channel_1 = Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1+1);
     DS_STMD_Delayed_OFF_Channel_2 = Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2+1);

     
    % Inhibition Mechanism Along Theta Axis
    [DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis] = DS_STMD_Lateral_Inhibition_Mechanism_Along_Theta_Axis(DS_STMD_LateralInhibitionOutput,...
                                                                                    Parameter_Fun.DS_STMD_InhibitionKernel_Theta_Axis,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_Directions);
     
                                                                            
    %======================== 结果展示 ==============================%
    
%      if i == EndFrame 
%          figure
%          surf(HighPassFilter_Output')
%          title('High Pass Filter Output')
%          figure
%          surf(LMCs_Inhibition_Output')
%          title('LMCs Inhibition Output')
%          figure
%          surf(ON_Channel')
%          title('ON Channel')
%          figure
%          surf(OFF_Channel')
%          title('OFF Channel')
%          figure
%          surf(MaxOperation_ON_Output')
%          title('ON Channel Max Operation')
%          figure
%          surf(MaxOperation_OFF_Output')
%          title('OFF Channel Max Operation')
%          
%          for j = 1:DS_STMD_Directions
%              figure
%              surf(DS_STMD_CorrelationOutput(:,:,j)')
%              title(strcat('DS-STMD Model Output (Before Inhibition)-- ',num2str(j)))
%          end
%          
%          for j = 1:DS_STMD_Directions
%              figure
%              surf(DS_STMD_LateralInhibitionOutput(:,:,j)')
%              title(strcat('DS-STMD Model Output -- ',num2str(j)))
%          end
% 
%      end
%     
%     
%     


    % 是否绘制神经网络中每一层的输出（在空间域上展示,展示最后一帧的对应输出）
    if Parameter_Fun.Is_Show_Neural_Outputs_Along_A_Line
        if i == Parameter_File.EndFrame
            % 沿着直线展示模型在不同阶段的输出
            Show_Neural_Outputs_Along_A_Line
        end
    end
    
    
    %=======================数据记录，存储==========================%
    
    % 显示正在处理的帧数
    disp(i);

    % Velocity Tuning 
    % 记录 TQD 及 DS-STMD 的输出
    if Parameter_File.Test_VelocityTuning == 1    
        if i> (Parameter_File.EndFrame - VelocityTuning_Frame)
            % 确定存储的位置
            Index_VelocityTuning = i-(Parameter_File.EndFrame-VelocityTuning_Frame);
            
            % 以下 ESTMD_Responses_VelocityTuning_EachStep， TQD_ON_OFF_Responses_VelocityTuning_EachStep ... 在函数 TopFunction_VelocityTuning.m 中给出
            % ESTMD
            ESTMD_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(ESTMD_Output(125,:));  
            
            % TQD Response
            TQD_ON_OFF_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(LPTC_Outputs(125,:,1));
            
            % TQD (LI) Response
            TQD_ON_OFF_LI_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(LPTC_Outputs_LI(125,:,1));
            
            % DS-STMD
            DS_STMD_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
            
        end
    end
    
    % Width Tuning
    % 记录 TQD 及 DS-STMD 的输出
    if Parameter_File.Test_WidthTuning == 1
        if i> (Parameter_File.EndFrame - WidthTuning_Frame)
            % 确定存储的位置
            Index_WidthTuning = i-(Parameter_File.EndFrame-WidthTuning_Frame);
            
            % ESTMD
            ESTMD_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(ESTMD_Output(125,:));
            
            % TQD Response    
            TQD_ON_OFF_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(LPTC_Outputs(125,:,1));
            
            % TQD (LI) Response
            TQD_ON_OFF_LI_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(LPTC_Outputs_LI(125,:,1));
            
            % DS-STMD
            DS_STMD_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
            
        end
    end
    
    % Height Tuning
    % 记录 TQD 及 DS-STMD 的输出
    if Parameter_File.Test_HeightTuning == 1
        if i> (Parameter_File.EndFrame - HeightTuning_Frame)
            % 确定存储的位置
            Index_HeightTuning = i-(Parameter_File.EndFrame-HeightTuning_Frame);
            
            % ESTMD
            ESTMD_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(ESTMD_Output(125,:));
            
            % TQD Response
            TQD_ON_OFF_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(LPTC_Outputs(125,:,1));
            
            % TQD (LI) Response
            TQD_ON_OFF_LI_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(LPTC_Outputs_LI(125,:,1));
            
            % DS-STMD
            DS_STMD_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    
    % Contrast Tuning
    % 记录 TQD 及 DS-STMD 的输出
    if Parameter_File.Test_ContrastTuning == 1
        if i> (Parameter_File.EndFrame - ContrastTuning_Frame)
            % 确定存储的位置
            Index_ContrastTuning = i-(Parameter_File.EndFrame-ContrastTuning_Frame);
            
            % ESTMD
            ESTMD_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(ESTMD_Output(125,:));
            
            % TQD Response
            TQD_ON_OFF_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(LPTC_Outputs(125,:,1));
            
            % TQD (LI) Response
            TQD_ON_OFF_LI_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(LPTC_Outputs_LI(125,:,1));
            
            % DS-STMD
            DS_STMD_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    
    
    
    
        
    
    % 记录数据
    if Parameter_Fun.IsRecordData == 1  && (i >= Parameter_File.StartRecordFrame)
        % 生成存储数据的 cell
        if i == Parameter_File.StartRecordFrame
            RecordedData = cell(Parameter_File.EndFrame-Parameter_File.StartRecordFrame+1,1);
        end
        
        % 调用 DataRecording.m 记录数据
        [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_High_Pass_Output,...
                              LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,...
                              ON_Channel,OFF_Channel,...
                              ON_Channel_LI,OFF_Channel_LI,...
                              ESTMD_Output,ESTMD_Delayed_OFF_Channel,...
                              TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,...
                              TQD_Delayed_ON_Channel,TQD_Delayed_OFF_Channel,...
                              TQD_Correlation_Component_ON_LI,TQD_Correlation_Component_OFF_LI,...
                              TQD_Delayed_ON_Channel_LI,TQD_Delayed_OFF_Channel_LI,...
                              DS_STMD_CorrelationOutput,DS_STMD_LateralInhibitionOutput,...
                              DS_STMD_Delayed_ON_Channel,DS_STMD_Delayed_OFF_Channel_1,DS_STMD_Delayed_OFF_Channel_2,...
                              DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis,...
                              Parameter_File.StartRecordFrame,i,RecordedData);
                   
        if (i == Parameter_File.EndFrame) && (Parameter_Fun.Is_Show_Recorded_Data_in_Temporal_Field == 1)
            Show_Recorded_Data_in_Temporal_Field
        end
    end
    
    % 保存数据
    if Parameter_Fun.IsSaveData == 1
        % 当处理完最后一帧时保存数据
        if i == Parameter_File.EndFrame
            file = [Parameter_File.folder_Global,'/','Recorded-Data.mat'];
            StartFrame = Parameter_File.StartFrame;
            EndFrame = Parameter_File.EndFrame;
            StartRecordFrame = Parameter_File.StartRecordFrame;
            save(file,'RecordedData','StartFrame','EndFrame','StartRecordFrame','-v7.3')
        end
    end
    

       
    
%=========================== End ===================================%    
end    

