

% Medulla Layer Second Lateral Inhibition Kernel (MLSLIK)
% 该抑制核与 DS-STMD 的抑制核一致
% 参数设置
Parameter_Fun.MLSLIK_Sigma1 = Inhibition_Kernel_Sigmal_1(i_para);          % size 5*5 是的最优参数（1.5，3.0）
Parameter_Fun.MLSLIK_Sigma2 = Inhibition_Kernel_Sigmal_2(i_para);
Parameter_Fun.MLSLIK_e = 1.0;
Parameter_Fun.MLSLIK_rho = 0.0;
Parameter_Fun.MLSLIK_A = 1;
Parameter_Fun.MLSLIK_B = 3;
Parameter_Fun.MLSLIK_Size = Inhibition_Kernel_Size(i_para);          % Size 5*5  ---13
% 将参数放置到向量中
Parameter_Fun.MLSLIK = [Parameter_Fun.MLSLIK_Sigma1,Parameter_Fun.MLSLIK_Sigma2,Parameter_Fun.MLSLIK_e,...
                             Parameter_Fun.MLSLIK_rho,Parameter_Fun.MLSLIK_A,Parameter_Fun.MLSLIK_B,Parameter_Fun.MLSLIK_Size];

[Parameter_Fun.Second_Lateral_Inhibition_Kernel] = Generalize_Medulla_Layer_Second_Lateral_Inhibition_Kernel(Parameter_Fun.MLSLIK);



% DS-STMD Inhibition Kernel (DSSTMDIK)
% Inhibition Kernel 参数选取
Parameter_Fun.DSSTMDIK_Sigma1 = Inhibition_Kernel_Sigmal_1(i_para);          % size 5*5 是的最优参数（1.5，3.0）
Parameter_Fun.DSSTMDIK_Sigma2 = Inhibition_Kernel_Sigmal_2(i_para);
Parameter_Fun.DSSTMDIK_e = 1.0;
Parameter_Fun.DSSTMDIK_rho = 0.0;
Parameter_Fun.DSSTMDIK_A = 1;
Parameter_Fun.DSSTMDIK_B = 3;
Parameter_Fun.DSSTMDIK_Size = Inhibition_Kernel_Size(i_para);      % Size 5*5  ---13

Parameter_Fun.DSSTMDIK = [Parameter_Fun.DSSTMDIK_Sigma1,Parameter_Fun.DSSTMDIK_Sigma2,Parameter_Fun.DSSTMDIK_e,...
                               Parameter_Fun.DSSTMDIK_rho,Parameter_Fun.DSSTMDIK_A,Parameter_Fun.DSSTMDIK_B,Parameter_Fun.DSSTMDIK_Size];
% 生成侧抑制核
[Parameter_Fun.DS_STMD_InhibitionKernel] = Generalize_DS_STMD_Inhibition_Kernel(Parameter_Fun.DSSTMDIK);