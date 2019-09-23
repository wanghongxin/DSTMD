function         [ RecordedData ] = DataRecording_DS_STMD(Photoreceptors_Outptut,LMCs_High_Pass_Output,...
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
                                                                         StartRecordFrame,i,RecordedData)

%% 函数说明
% StartFrame    开始记录数据的帧数
% i             此时正在处理的帧数
% BluredImage   模糊之后的图像
% HighPassFilter_Output   高通滤波器输出
% TQD_Correlation_Component_ON       TQD (Two Quadrant Detector) 的 ON Hand Correlation
% TQD_Correlation_Component_OFF      TQD (Two Quadrant Detector) 的 OFF Handl Correlation
% DS_STMD_CorrelationOutput          DS-STMD model Corelation Output (Triple Correlator Output)
% DS_STMD_LateralInhibitionOutput    DS-STMD model Outputs after Lateral Inhibition 

%% Main Function

Index = i - StartRecordFrame +1;
% % %========= 下列代码用于确定最佳高通滤波器及 LMCs Inhibition 参数===============%
% % 模糊之后的图像
% RecordedData{Index}.BluredImage = BluredImage;
% 
% % 高通滤波器输出 (High-pass filter)
% RecordedData{Index}.HighPassFilter_Output = HighPassFilter_Output;
% % 
% % LMCs Lateral Inhibition Mechanism 之后的输出
% RecordedData{Index}.LMCs_Inhibition_Output = LMCs_Inhibition_Output;
% % 
% % LMCs Lateral Inhibition Mechanism 之后的输出 (不包含时域部分 Temopral Part)
% RecordedData{Index}.LMCs_Inhibition_Output_NT = LMCs_Inhibition_Output_NT;

%%======================= 记录模型输出 ====================================%

% % T1 Neuron Outputs
% RecordedData{Index}.T1_Neuron_Outputs = T1_Neuron_Outputs;
% 
% % STMD Neuron Outputs (DS-STMD Theta Inhibition Mechanism Outputs)
% RecordedData{Index}.DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis = DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis;

% % LPTC Neuron Outputs (TQD Correlation Outputs)
% RecordedData{Index}.LPTC_Outputs = TQD_Correlation_Component_ON + TQD_Correlation_Component_OFF;

% % DS-STMD model Outputs after Lateral Inhibition 
% RecordedData{Index}.DS_STMD_LateralInhibitionOutput = DS_STMD_LateralInhibitionOutput;



% % TQD (Two Quadrant Detector) 的 ON channel Correlation
% RecordedData{Index}.TQD_Correlation_Component_ON = TQD_Correlation_Component_ON;
% 
% % TQD (Two Quadrant Detector) 的 OFF channel Correlation
% RecordedData{Index}.TQD_Correlation_Component_OFF = TQD_Correlation_Component_OFF;


% % ESTMD Model Outputs
% RecordedData{Index}.ESTMD_Output = ESTMD_Output;

% STMD Neuron Outputs (DS-STMD Theta Inhibition Mechanism Outputs)
RecordedData{Index}.DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis = DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis;


% % TQD Model Outputs
% RecordedData{Index}.TQD_Correlation_Component_ON = TQD_Correlation_Component_ON;
% RecordedData{Index}.TQD_Correlation_Component_OFF = TQD_Correlation_Component_OFF;





% % DS-STMD model Corelation Output (Triple Correlator Output)
% RecordedData{Index}.DS_STMD_CorrelationOutput = DS_STMD_CorrelationOutput;

% %======================= 下列代码可用于确定模型最优时延常数======================%


% % ON and OFF Channels
% RecordedData{Index}.ON_Channel = ON_Channel;
% RecordedData{Index}.OFF_Channel = OFF_Channel;
% 
% 
% % ON and OFF Channels (Laterally Inhibited)
% RecordedData{Index}.ON_Channel_LI = ON_Channel_LI;
% RecordedData{Index}.OFF_Channel_LI = OFF_Channel_LI;
% 
% % ESTMD
% RecordedData{Index}.ESTMD_Delayed_OFF_Channel = ESTMD_Delayed_OFF_Channel;
% 
% % TQD ON Hand
% RecordedData{Index}.TQD_Delayed_ON_Channel = TQD_Delayed_ON_Channel;
% % TQD OFF　Hand
% RecordedData{Index}.TQD_Delayed_OFF_Channel = TQD_Delayed_OFF_Channel;
% 
% % TQD ON Hand (LI)
% RecordedData{Index}.TQD_Delayed_ON_Channel_LI = TQD_Delayed_ON_Channel_LI;
% % TQD OFF　Hand (LI)
% RecordedData{Index}.TQD_Delayed_OFF_Channel_LI = TQD_Delayed_OFF_Channel_LI;
% 
% 
% % DS-STMD Channel Delay
% RecordedData{Index}.DS_STMD_Delayed_ON_Channel = DS_STMD_Delayed_ON_Channel;
% RecordedData{Index}.DS_STMD_Delayed_OFF_Channel_1 = DS_STMD_Delayed_OFF_Channel_1;
% RecordedData{Index}.DS_STMD_Delayed_OFF_Channel_2 = DS_STMD_Delayed_OFF_Channel_2;


end

