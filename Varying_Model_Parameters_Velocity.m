
% 函数说明
% 用于对模型参数进行修改


%% Main
% ESTMD
Parameter_Fun.ESTMD_GammaFun_Order = ESTMD_Parameter_Order(i_para);
Parameter_Fun.ESTMD_GammaFun_Tau = ESTMD_Parameter_Tau(i_para);             % Mu = Order/Tau < 1
Parameter_Fun.ESTMD_GammaFun_Output_OFF = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.ESTMD_GammaFun_Order+1);


% TQD (Two Quadrant Detector) --- Channel Correlation (Time Delay)
Parameter_Fun.TQD_GammaFun_Order = TQD_Parameter_Order(i_para);
Parameter_Fun.TQD_GammaFun_Tau = TQD_Parameter_Tau(i_para);             % Mu = Order/Tau < 1
Parameter_Fun.TQD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_GammaFun_Output_OFF = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_Dist = 3;   % Distance Between Two Pixels (Elementary Motion Detector)
Parameter_Fun.TQD_Directions = 4;      % 沿几个方向计算 EMD 的输出 （水平，竖直）


% Laterally Inhibited TQD --- Channel Correlation (Time Delay)
Parameter_Fun.TQD_GammaFun_Order_LI = TQD_LI_Parameter_Order(i_para);
Parameter_Fun.TQD_GammaFun_Tau_LI = TQD_LI_Parameter_Tau(i_para);             % Mu = Order/Tau < 1
Parameter_Fun.TQD_GammaFun_Output_ON_LI = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order_LI+1);
Parameter_Fun.TQD_GammaFun_Output_OFF_LI = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order_LI+1);
Parameter_Fun.TQD_Dist_LI = 3;   % Distance Between Two Pixels (Elementary Motion Detector)
Parameter_Fun.TQD_Directions_LI = 4;      % 沿几个方向计算 EMD 的输出 （水平，竖直）


% DS-STMD (Directionally Selective Small Target Motion Detector)  
% Parameter for Correlation

% Channel Delay 
Parameter_Fun.DS_STMD_GammaFun_Order_ON = DS_STMD_ON_Parameter_Order(i_para);      % ON Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_ON = DS_STMD_ON_Parameter_Tau(i_para);       % ON Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_ON+1);  % 用于存储 ON Channel 延迟的输出

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1 = DS_STMD_OFF_1_Parameter_Order(i_para);      % 第一次 OFF Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_1 = DS_STMD_OFF_1_Parameter_Tau(i_para);       % 第一次 OFF Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1+1);  % 用于存储 OFF Channel 延迟的输出

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2 = DS_STMD_OFF_2_Parameter_Order(i_para);      % 第二次 OFF Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_2 = DS_STMD_OFF_2_Parameter_Tau(i_para);       % 第二次 OFF Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2+1);  % 用于存储 OFF Channel 延迟的输出

