function [ESTMD_Output,GammaFun_Output_OFF] = Elementary_Small_Target_Motion_Detector(ON_Channel,OFF_Channel,...
                                                              GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order)
                                                          
% 函数说明
% 该函数用于计算 ESTMD 模型的输出

% 参数说明
% ON_Channel : 当前时刻 ON 通道的输入
% OFF_Channel ：当前时刻 OFF 通道的输入
% GammaFun_Output_OFF : Time Delay 由 Gamma Convolution 实现，该参数为 OFF Channel 的 Gamma 函数的迭代输出


%% Main
% OFF Channel Delay
[GammaFun_Output_OFF] = GammaFunction(OFF_Channel,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order);
DelayOFF_Channel = GammaFun_Output_OFF(:,:,GammaFun_Order+1);



% ESTMD Correlation Step

ESTMD_Output = ON_Channel.*DelayOFF_Channel;



end


