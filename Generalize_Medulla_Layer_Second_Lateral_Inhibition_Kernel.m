function [Second_Lateral_Inhibition_Kernel] = Generalize_Medulla_Layer_Second_Lateral_Inhibition_Kernel(Parameter_Vector)

% 函数说明
% 该函数用于生成 Medulla Layer Second Lateral Inhibition Kernel, DoG 形式
% W(x,y) = A*[g_1(x,y)] - B[-g_1(x,y)]    % [x]   max(x,0)
% g_1 = G_1(x,y) - e*G_2(x,y) - rho

% 参数说明
% KernelSize  Inhibition Kernel 的大小，一般为奇数
% Sigma1      Gauss 函数 1 的 Sigma
% Sigma2      Gauss 函数 2 的 Sigma
% e           参数 e



%% Main
Sigma1 = Parameter_Vector(1);
Sigma2 = Parameter_Vector(2);
e = Parameter_Vector(3);
rho = Parameter_Vector(4);
A = Parameter_Vector(5);
B = Parameter_Vector(6);
KernelSize = Parameter_Vector(7);

% 将卷积核大小设置为奇数
Flag = mod(KernelSize,2);
if Flag == 0
    KernelSize = KernelSize +1;
end

% 确定卷积核的中心
CenX = round(KernelSize/2);
CenY = round(KernelSize/2);
% 生成网格
[X,Y] = meshgrid(1:KernelSize,1:KernelSize);
% 网格平移
ShiftX = X-CenX;
ShiftY = Y-CenY;

% 生成 Gauss 函数 1 和 2
Gauss1 = (1/(2*pi*Sigma1^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma1^2));
Gauss2 = (1/(2*pi*Sigma2^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma2^2));

% 生成 DoG, 两高斯函数相减
DoG_Filter = Gauss1 - e*Gauss2 - rho;

% max(x,0)
Positive_Component = (abs(DoG_Filter) + DoG_Filter)*0.5;
Negative_Component = (abs(DoG_Filter) - DoG_Filter)*0.5;
% Inhibition Kernel

Second_Lateral_Inhibition_Kernel = A*Positive_Component - B*Negative_Component;


end