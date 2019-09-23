% 2016-10-19

% 函数说明
% 该函数用于设置整个程序的参数，包括 High Pass Filter， Lateral Inhibition Mechanism,
% Monophasic Neurons, TQD and DS-STMD

%% Parameter Setting
% Image Parameters
% Initialization
Parameter_Fun.file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,1)];
I = rgb2gray(imread(Parameter_Fun.file));
[Parameter_Fun.M,Parameter_Fun.N] = size(I);


%----------------- Parameters for Retina Layer ---------------------------%
% Gauss Blur
Parameter_Fun.GaussFilter = fspecial('gaussian',3,1);

%----------------- Parameters for Lamina Layer ---------------------------%

% High Pass Filter (Gamma function 1 - Gamma function 2)
% Comment: High-pass Filter 的参数选择为 :
% Gamma Function 1 : Order = 3    Tau = 5
% Gamma Function 2 : Order = 18   Tau = 30

% Parameters for Gamma Function 1
Parameter_Fun.GammaFun1_Order = 2;
Parameter_Fun.GammaFun1_Tau = 3;              % Mu = Order/Tau < 1
Parameter_Fun.GammaFun1_Output = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.GammaFun1_Order+1);
% Parameters for Gamma Function 2
Parameter_Fun.GammaFun2_Order = 6;
Parameter_Fun.GammaFun2_Tau = 9;              % Mu = Order/Tau < 1
Parameter_Fun.GammaFun2_Output = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.GammaFun2_Order+1);


% Large Monopolar Cells (LMCs) Lateral Inhibition Mechanism
Parameter_Fun.IsLMCs_LateralInhibition = 1;       %  是否对高通滤波后的信号进行侧抑制
Parameter_Fun.IsTemporalInhibition_LMC = 1;       %  是否在时域上对信号进行卷积（时域上的耦合）
% LMCs 侧抑制的空间域部分，这里采用 Difference of Gaussians
Parameter_Fun.LMCs_KernelSize = 13;
Parameter_Fun.LMCs_Sigma1 = 1.5;
Parameter_Fun.LMCs_Sigma2 = 3.0;
Parameter_Fun.LMCs_SpatialInhibitionKernel = DoGFilter(Parameter_Fun.LMCs_KernelSize,Parameter_Fun.LMCs_Sigma1,Parameter_Fun.LMCs_Sigma2);
% LMCs 侧抑制的时间域部分
Parameter_Fun.LMCs_W1_PastY = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W1_PastX = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W1_Alpha = 3;
Parameter_Fun.LMCs_W2_PastY = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W2_PastX = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W2_Alpha = 9;


%----------------- Parameters for Medulla Layer ---------------------------%
% Medulla Layer Second Lateral Inhibition Kernel (MLSLIK)
% 该抑制核与 DS-STMD 的抑制核一致
% 参数设置
Parameter_Fun.MLSLIK_Sigma1 = 1.5;          % size 5*5 是的最优参数（1.5，3.0）
Parameter_Fun.MLSLIK_Sigma2 = 3;
Parameter_Fun.MLSLIK_e = 1.0;
Parameter_Fun.MLSLIK_rho = 0.0;
Parameter_Fun.MLSLIK_A = 1;
Parameter_Fun.MLSLIK_B = 3;
Parameter_Fun.MLSLIK_Size = 13;
% 将参数放置到向量中
Parameter_Fun.MLSLIK = [Parameter_Fun.MLSLIK_Sigma1,Parameter_Fun.MLSLIK_Sigma2,Parameter_Fun.MLSLIK_e,...
                        Parameter_Fun.MLSLIK_rho,Parameter_Fun.MLSLIK_A,Parameter_Fun.MLSLIK_B,Parameter_Fun.MLSLIK_Size];

[Parameter_Fun.Second_Lateral_Inhibition_Kernel] = Generalize_Medulla_Layer_Second_Lateral_Inhibition_Kernel(Parameter_Fun.MLSLIK);

%----------------- Parameters for Lobula Layer ---------------------------%
% ESTMD
Parameter_Fun.ESTMD_GammaFun_Order = 5;
Parameter_Fun.ESTMD_GammaFun_Tau = 25;             % Mu = Order/Tau < 1
Parameter_Fun.ESTMD_GammaFun_Output_OFF = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.ESTMD_GammaFun_Order+1);


% TQD (Two Quadrant Detector) --- Channel Correlation (Time Delay)
Parameter_Fun.TQD_GammaFun_Order = 5;
Parameter_Fun.TQD_GammaFun_Tau = 15;             % Mu = Order/Tau < 1
Parameter_Fun.TQD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_GammaFun_Output_OFF = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_Dist = 3;   % Distance Between Two Pixels (Elementary Motion Detector)
Parameter_Fun.TQD_Directions = 4;      % 沿几个方向计算 EMD 的输出 （水平，竖直）


% Laterally Inhibited TQD --- Channel Correlation (Time Delay)
Parameter_Fun.TQD_GammaFun_Order_LI = 5;
Parameter_Fun.TQD_GammaFun_Tau_LI = 15;             % Mu = Order/Tau < 1
Parameter_Fun.TQD_GammaFun_Output_ON_LI = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order_LI+1);
Parameter_Fun.TQD_GammaFun_Output_OFF_LI = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order_LI+1);
Parameter_Fun.TQD_Dist_LI = 3;   % Distance Between Two Pixels (Elementary Motion Detector)
Parameter_Fun.TQD_Directions_LI = 4;      % 沿几个方向计算 EMD 的输出 （水平，竖直）


% DS-STMD (Directionally Selective Small Target Motion Detector)  
% Parameter for Correlation

% Channel Delay 
Parameter_Fun.DS_STMD_GammaFun_Order_ON = 3;      % ON Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_ON = 15;       % ON Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_ON+1);  % 用于存储 ON Channel 延迟的输出

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1 = 5;      % 第一次 OFF Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_1 = 25;       % 第一次 OFF Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1+1);  % 用于存储 OFF Channel 延迟的输出

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2 = 8;      % 第二次 OFF Channel 延迟的阶数
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_2 = 40;       % 第二次 OFF Channel 延迟的时间常数   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2+1);  % 用于存储 OFF Channel 延迟的输出

% Channel Correlation
Parameter_Fun.DS_STMD_Dist = 3;                      % DS-STMD Channel Correlation 时两个像素点之间的距离
Parameter_Fun.DS_STMD_Directions = 8;   

% DS-STMD Inhibition Kernel (DSSTMDIK)
% Inhibition Kernel 参数选取
Parameter_Fun.DSSTMDIK_Sigma1 = 1.5;          % size 5*5 是的最优参数（1.5，3.0）
Parameter_Fun.DSSTMDIK_Sigma2 = 3;
Parameter_Fun.DSSTMDIK_e = 1.0;
Parameter_Fun.DSSTMDIK_rho = 0.0;
Parameter_Fun.DSSTMDIK_A = 1;
Parameter_Fun.DSSTMDIK_B = 3;
Parameter_Fun.DSSTMDIK_Size = 13;

Parameter_Fun.DSSTMDIK = [Parameter_Fun.DSSTMDIK_Sigma1,Parameter_Fun.DSSTMDIK_Sigma2,Parameter_Fun.DSSTMDIK_e,...
                         Parameter_Fun.DSSTMDIK_rho,Parameter_Fun.DSSTMDIK_A,Parameter_Fun.DSSTMDIK_B,Parameter_Fun.DSSTMDIK_Size];

% 生成侧抑制核
[Parameter_Fun.DS_STMD_InhibitionKernel] = Generalize_DS_STMD_Inhibition_Kernel(Parameter_Fun.DSSTMDIK);

% Lateral Inhibition Kernel (Along Theta Axis)
[Parameter_Fun.DS_STMD_InhibitionKernel_Theta_Axis] = Generalization_InhibitionKernel_Along_Theta_Axis(Parameter_Fun.DS_STMD_Directions);


%------------------ Parameters for Result Presentation-------------------%
% 是否绘制神经网络中每一层的输出（在空间域上展示,展示最后一帧的对应输出）
Parameter_Fun.Is_Show_Neural_Outputs_Along_A_Line = 0;

% 是否保存数据
Parameter_Fun.IsRecordData = 1;
Parameter_Fun.Is_Show_Recorded_Data_in_Temporal_Field = 0;      % 是否展示一个像素点所记录数据随时间的变化
Parameter_Fun.IsSaveData = 1;


