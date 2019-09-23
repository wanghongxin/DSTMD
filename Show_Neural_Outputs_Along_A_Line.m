
% 函数说明
% 该函数用于沿着一条确定的直线展示 Input Image (I) 在该直线上不同神经元的输出
% 例如：
% 该条直线的起点为 （X_s,Y_s）,终点为 （X_e,Y_e）且 X_s = X_e 或者 Y_s = Y_e
% Data = I(X_s,Y_s:Y:e) 或者 Data = I(X_s:X_e,Y_s)

%% 几条命令的说明
% 对图形的位置及大小进行设置,单位为厘米，大小为 W cm× H cm，图形起点坐标为（Px,Py）cm 表示左下点离显示器左侧边界 Px cm，离下侧边界 Py cm
% set(gcf,'unit','centimeters','position',[Px Py W H])

% 控制所画的图形在figure中所占的比例，前两个值表示位置，后两个值表示大小
%set(gca,'Position',[0.1 0.5 0.8 0.25]);


%% Main Function
close all;
%===================== 沿着 X 轴展示 ==========================%
% 确定沿图像的平行于 X 轴的中线的起点及终点
X_Line = 125;

StartPoint = [X_Line,1];
EndPoint = [X_Line,500];


%% Retina Layer and Lamina Layer

%  输入图像及高斯模糊后的图像
[OriginalImage_Recorded_Data_XLine] = Extract_Data_Along_A_Line(OriginalImage,StartPoint,EndPoint,0);
[Photoreceptors_Recorded_Data_XLine] = Extract_Data_Along_A_Line(Photoreceptors_Outptut,StartPoint,EndPoint,0);


% 提取高通滤波器，LMCs 侧抑制（包含时域部分），LMCs 侧抑制（不包含时域部分，NT）的输出
[LMCs_High_Pass_Output_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_High_Pass_Output,StartPoint,EndPoint,0);
[LMCs_Inhibition_Output_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);

% 没有时间域部分的侧抑制 (NTs)
[LMCs_Inhibition_Output_NT_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);


figure
plot(StartPoint(2):EndPoint(2),OriginalImage_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,255])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('Input Image')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Input-Signal.fig')

figure
plot(StartPoint(2):EndPoint(2),Photoreceptors_Recorded_Data_XLine,'color','m','linewidth',1.0)
axis([0,500,0,255])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('Photoreceptor Outputs')
title('Input Image')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Photoreceptor-Output.fig')

figure
plot(StartPoint(2):EndPoint(2),LMCs_Inhibition_Output_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,-21,21])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('LMC Outputs')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\LMC-Output.fig')

%% Medulla Layer
% ON and OFF Channel
% 提取数据
[ON_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(ON_Channel,StartPoint,EndPoint,0);
[OFF_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(OFF_Channel,StartPoint,EndPoint,0);

figure
subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,25])
title('Tm3 Outputs (ON Channel)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),OFF_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,25])
title('Tm2 Outputs (OFF Channel)')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\ON-and-OFF-Channels.fig')

% Lateral Inhibited ON and OFF Channels
[ON_Channel_LI_Recorded_Data_XLine] = Extract_Data_Along_A_Line(ON_Channel_LI,StartPoint,EndPoint,0);
[OFF_Channel_LI_Recorded_Data_XLine] = Extract_Data_Along_A_Line(OFF_Channel_LI,StartPoint,EndPoint,0);

figure
subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),ON_Channel_LI_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,25])
title('ON Channel LI')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),OFF_Channel_LI_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,25])
title('OFF Channel LI')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\ON-and-OFF-Channels-LI.fig')


%% Lobula Layer

% ESTMD
ESTMD_Delayed_OFF_Channel_Xline = Extract_Data_Along_A_Line(ESTMD_Delayed_OFF_Channel,StartPoint,EndPoint,0);


figure
subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),ON_Channel_LI_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,10])
title('ON Channel LI (ESTMD)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),ESTMD_Delayed_OFF_Channel_Xline,'color','r','linewidth',1.0)
axis([0,500,0,10])
title('Delayed OFF Channel LI (ESTMD)')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Medulla-Signals-ESTMD.fig')



ESTMD_Output__Xline = Extract_Data_Along_A_Line(ESTMD_Output,StartPoint,EndPoint,0);

figure
subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ESTMD_Output__Xline,'color','b','linewidth',1.0)
axis([0,500,0,25])
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('ESTMD Outputs')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\ESTMD-Model-Outputs.fig')


% TQD

% TQD Delayed Channels
TQD_Delayed_ON_Channel_Xline = Extract_Data_Along_A_Line(TQD_Delayed_ON_Channel,StartPoint,EndPoint,0);
TQD_Delayed_OFF_Channel_Xline = Extract_Data_Along_A_Line(TQD_Delayed_OFF_Channel,StartPoint,EndPoint,0);

% figure
% plot(StartPoint(2):EndPoint(2),TQD_Delayed_ON_Channel_Xline,'color','b','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Mi1 Output (n = 5, \tau = 15)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),TQD_Delayed_OFF_Channel_Xline,'color','r','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 5, \tau = 15)')


% 将四个子图放到同一个图中
figure

subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,21])
title('Tm3 Outputs')

subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_ON_Channel_Xline,'color','g','linewidth',1.0)
axis([0,500,0,21])
title('Mi1 Output (n = 5, \tau = 15)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),OFF_Channel_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,21])
title('Tm2 Outputs')

subplot(4,1,4)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_OFF_Channel_Xline,'color','m','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 5, \tau = 15)')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Medulla-Signals-LPTC.fig')


% ON Hand
TQD_Correlation_Component_ON_Xline = cell(Parameter_Fun.TQD_Directions,1);
for j = 1:Parameter_Fun.TQD_Directions
    TQD_Correlation_Component_ON_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_ON(:,:,j),StartPoint,EndPoint,0);
end

% figure
% MarkerEdgeColors = jet(TQD_Directions);
% for j = 1:TQD_Directions
%     plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_ON_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('TQD ON Hand - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% set(gca,'Position',[0.1 0.5 0.8 0.25]);
% title('TQD Correlation Outputs ON Component')
% 
% 
% OFF Hand
TQD_Correlation_Component_OFF_Xline = cell(Parameter_Fun.TQD_Directions,1);
for j = 1:Parameter_Fun.TQD_Directions
    TQD_Correlation_Component_OFF_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_OFF(:,:,j),StartPoint,EndPoint,0);
end
% 
% figure
% MarkerEdgeColors = jet(TQD_Directions);
% for j = 1:TQD_Directions
%     plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_OFF_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('TQD OFF Hand - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% set(gca,'Position',[0.1 0.5 0.8 0.25]);
% title('TQD Correlation Outputs OFF Component')


% ON + OFF

figure
MarkerEdgeColors = jet(Parameter_Fun.TQD_Directions);
for j = 1:Parameter_Fun.TQD_Directions
    plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_ON_Xline{j}+TQD_Correlation_Component_OFF_Xline{j},'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on 
end
axis([0,500,0,425])
legend('\psi = \pi','\psi = 0','\psi = \pi/2','\psi = 3\pi/2')
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('LPTC Outputs')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\LPTC-Outputs.fig')



% TQD (Laterally Inhibited)

% TQD_Delayed_ON_Channel_LI
TQD_Delayed_ON_Channel_LI_Xline = Extract_Data_Along_A_Line(TQD_Delayed_ON_Channel_LI,StartPoint,EndPoint,0);
TQD_Delayed_OFF_Channel_LI_Xline = Extract_Data_Along_A_Line(TQD_Delayed_OFF_Channel_LI,StartPoint,EndPoint,0);


% 将四个子图放到同一个图中
figure

subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ON_Channel_LI_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,10])
title('Tm3 Outputs LI')

subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_ON_Channel_LI_Xline,'color','g','linewidth',1.0)
axis([0,500,0,10])
title('Mi1 Output (n = 5, \tau = 15) LI')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),OFF_Channel_LI_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,10])
title('Tm2 Outputs LI')

subplot(4,1,4)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_OFF_Channel_LI_Xline ,'color','m','linewidth',1.0)
axis([0,500,0,10])
title('Tm1 Output (n = 5, \tau = 15) LI')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Medulla-Signals-LPTC-LI.fig')


% ON Hand
TQD_Correlation_Component_ON_LI_Xline = cell(Parameter_Fun.TQD_Directions,1);
for j = 1:Parameter_Fun.TQD_Directions
    TQD_Correlation_Component_ON_LI_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_ON_LI(:,:,j),StartPoint,EndPoint,0);
end

% OFF Hand
TQD_Correlation_Component_OFF_LI_Xline = cell(Parameter_Fun.TQD_Directions,1);
for j = 1:Parameter_Fun.TQD_Directions
    TQD_Correlation_Component_OFF_LI_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_OFF_LI(:,:,j),StartPoint,EndPoint,0);
end

% ON + OFF
figure
MarkerEdgeColors = jet(Parameter_Fun.TQD_Directions);
for j = 1:Parameter_Fun.TQD_Directions
    plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_ON_LI_Xline{j}+TQD_Correlation_Component_OFF_LI_Xline{j},'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on 
end
axis([0,500,0,50])
legend('\psi = \pi','\psi = 0','\psi = \pi/2','\psi = 3\pi/2')
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('LPTC Outputs (LI)')
saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\LPTC-Outputs-LI.fig')

%% Part Six
% 展示 DS-STMD Model 的输出

% Delayed Channel
DS_STMD_Delayed_ON_Channel_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_ON_Channel,StartPoint,EndPoint,0);
DS_STMD_Delayed_OFF_Channel_1_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_OFF_Channel_1,StartPoint,EndPoint,0);
DS_STMD_Delayed_OFF_Channel_2_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_OFF_Channel_2,StartPoint,EndPoint,0);


% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_ON_Channel_Xline,'color','b','DisPlayName','Delayed ON Channel','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Mi1 Output (n = 3, \tau = 15)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_1_Xline,'color','r','DisPlayName','Delayed OFF Channel - 1','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 5, \tau = 25)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_2_Xline,'color','m','DisPlayName','Delayed OFF Channel - 2','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 8, \tau = 40)')




% 将四个子图放到同一个图中

figure
subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,21])
title('Tm3 Outputs')

subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_ON_Channel_Xline,'color','g','DisPlayName','Delayed ON Channel','linewidth',1.0)
axis([0,500,0,21])
title('Mi1 Output (n = 3, \tau = 15)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_1_Xline,'color','b','DisPlayName','Delayed OFF Channel - 1','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 5, \tau = 25)')

subplot(4,1,4)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_2_Xline,'color','m','DisPlayName','Delayed OFF Channel - 2','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 8, \tau = 40)')

saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\Medulla-Signals-DS-STMD.fig')
% % 侧抑制前
% DS_STMD_CorrelationOutput_Xline = cell(DS_STMD_Directions,1);
% for j = 1:DS_STMD_Directions
%     DS_STMD_CorrelationOutput_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_CorrelationOutput(:,:,j),StartPoint,EndPoint,0);
% end
% 
% figure
% MarkerEdgeColors = jet(DS_STMD_Directions);
% for j = 1:DS_STMD_Directions
%     plot(StartPoint(2):EndPoint(2),DS_STMD_CorrelationOutput_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Correlation Output - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% legend('show')
% title('DS-STMD Correlation Outputs (Before Inhibition)')
% 
% % 侧抑制后
% DS_STMD_LateralInhibitionOutput_Xline = cell(DS_STMD_Directions,1);
% for j = 1:DS_STMD_Directions
%     DS_STMD_LateralInhibitionOutput_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_LateralInhibitionOutput(:,:,j),StartPoint,EndPoint,0);
% end
% 
% figure
% MarkerEdgeColors = jet(DS_STMD_Directions);
% for j = 1:DS_STMD_Directions
%     plot(StartPoint(2):EndPoint(2),DS_STMD_LateralInhibitionOutput_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Output - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% 
% grid on
% legend('show')
% title('DS-STMD Correlation Outputs (After Inhibition)')



% 展示经过 Theta Direction 抑制后的输出
% Outputs_After_Inhibition_Along_Theta_Axis

DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline = cell(Parameter_Fun.DS_STMD_Directions,1);
for j = 1:Parameter_Fun.DS_STMD_Directions
    DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(:,:,j),StartPoint,EndPoint,0);
end

figure
MarkerEdgeColors = jet(Parameter_Fun.DS_STMD_Directions);
for j = 1:Parameter_Fun.DS_STMD_Directions
    plot(StartPoint(2):EndPoint(2),DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline{j},'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on
end 
legend('\theta = \pi','\theta = 0','\theta = \pi/2','\theta = 3\pi/2','\theta = \pi/4','\theta = 3\pi/4','\theta = 5\pi/4','\theta = 7\pi/4')
axis([0,500,0,550])
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('STMD Neuron Outputs, E(x,y,t;\theta)')

saveas(gcf,'Data-Journal-Paper-1\Neural Outputs of Each Layer\DS-STMD-Outputs.fig')




% %% 
% %========================= 沿 Y 轴展示 ==================================%
% 
% 
% 
% %========================= OFF Signal ==================================%
% % 确定要展示的 X 轴坐标
% [OFF_Y,OFF_X] = find(HighPassFilter_Output == min(HighPassFilter_Output(:)));
% Presentation_X = min(OFF_X);
% StartPoint = [1,Presentation_X];
% EndPoint = [250,Presentation_X];
% 
% % 提取数据
% [HPF_Recorded_Data_YLine] = Extract_Data_Along_A_Line(HighPassFilter_Output,StartPoint,EndPoint,0);
% [LMCs_Recorded_Data_YLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);
% % 没有时间域部分的侧抑制
% [LMCs_Recorded_Data_YLine_NT] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);
% 
% % 绘图
% figure
% plot(StartPoint(1):EndPoint(1),HPF_Recorded_Data_YLine,'r','DisPlayName','High-pass Filter Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine,'b','DisPlayName','LMCs Inhibition Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine_NT,'g','DisPlayName','LMCs Inhibition Output (NT)')
% title(strcat('X = ',num2str(StartPoint(2)),'   Y = ',num2str(StartPoint(1)),' : ',num2str(EndPoint(1))))
% ylabel('OFF Signal')
% grid on
% legend('show')
% 
% % ========================= ON Signal ==================================%
% % 确定要展示的 X 轴坐标
% [ON_Y,ON_X] = find(HighPassFilter_Output == max(HighPassFilter_Output(:)));
% Presentation_X = min(ON_X);
% StartPoint = [1,Presentation_X];
% EndPoint = [250,Presentation_X];
% 
% % 抽取数据
% [HPF_Recorded_Data_YLine] = Extract_Data_Along_A_Line(HighPassFilter_Output,StartPoint,EndPoint,0);
% [LMCs_Recorded_Data_YLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);
% % 没有时间域部分的侧抑制
% [LMCs_Recorded_Data_YLine_NT] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);
% 
% % 绘图
% figure
% plot(StartPoint(1):EndPoint(1),HPF_Recorded_Data_YLine,'r','DisPlayName','High-pass Filter Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine,'b','DisPlayName','LMCs Inhibition Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine_NT,'g','DisPlayName','LMCs Inhibition Output (NT)')
% title(strcat('X = ',num2str(StartPoint(2)),'   Y = ',num2str(StartPoint(1)),' : ',num2str(EndPoint(1))))
% ylabel('ON Signal')
% grid on
% legend('show')
% 
% 
