% 函数说明
% 该函数用于输出记录物体运动轨迹上的点的时域上的响应




%% Main

%clear all; close all; clc;
%close all; clc
if ~exist('RecordedData','var')
    Parameter_File.folder_Global = 'Data-Journal-Paper-1\Direction-Selectivity\CB-0';
    File = [Parameter_File.folder_Global,'\','Recorded-Data.mat'];
    load(File)
end



% 确定要展示的坐标
X_Show = 250 - 131;
Y_Show = 322;

% Y    X
% 408 110    0.51
% 386 117    1.94
% 379 122    0.0821
% 368 130    1.88
% 342 140
% 339 139
% 322 131
% 315 126    1.7837
% 304 118
% 291 111
% 286 111
% 274 111
% 257 120




% 生成矩阵用于存储 Model Outptut
All_ESTMD_Model_Outputs = zeros(1,length(RecordedData));
All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis = zeros(8,length(RecordedData));
All_DS_STMD_CorrelationOutput = zeros(8,length(RecordedData));


for i = 1:length(RecordedData)
    
    StageValue = RecordedData{i}.ESTMD_Output;
    All_ESTMD_Model_Outputs(1,i) = StageValue(X_Show,Y_Show);
    
    
    StageValue = RecordedData{i}.DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis;
    for j = 1:8
        All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(j,i) = StageValue(X_Show,Y_Show,j);
    end
    
    
    StageValue = RecordedData{i}.DS_STMD_CorrelationOutput;
    for j = 1:8
        All_DS_STMD_CorrelationOutput(j,i) = StageValue(X_Show,Y_Show,j);
    end
    
end


% 绘制图像
PlotStartFrame = 1;
PlotEndFrame = 1500;


% figure
% plot(PlotStartFrame:PlotEndFrame,All_ESTMD_Model_Outputs(PlotStartFrame:PlotEndFrame),'b','linewidth',1.0)
% 
% set(gca,'Position',[0.1 0.1 0.8 0.45]);
% title('ESTMD Outputs')




figure
MarkerEdgeColors = jet(8);
for j = 1:8
    plot(PlotStartFrame:PlotEndFrame,All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(j,PlotStartFrame:PlotEndFrame),'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on
end 
legend('\theta = \pi','\theta = 0','\theta = \pi/2','\theta = 3\pi/2','\theta = \pi/4','\theta = 3\pi/4','\theta = 5\pi/4','\theta = 7\pi/4')
axis([0 550 0 3000])
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('DS-STMD Outputs')
xlabel('Frame')
ylabel('Neural Responses')


% figure
% MarkerEdgeColors = jet(8);
% for j = 1:8
%     plot(PlotStartFrame:PlotEndFrame,All_DS_STMD_CorrelationOutput(j,PlotStartFrame:PlotEndFrame),'color',MarkerEdgeColors(j,:),'linewidth',1.0)
%     hold on
% end 
% legend('\theta = \pi','\theta = 0','\theta = \pi/2','\theta = 3\pi/2','\theta = \pi/4','\theta = 3\pi/4','\theta = 5\pi/4','\theta = 7\pi/4')
% 
% set(gca,'Position',[0.1 0.1 0.8 0.45]);
% title('DS-STMD Neuron Correlation Outputs, E(x,y,t;\theta)')


%% 将获取的数据在极坐标上展示

Max_DS_STMD_Output = max(All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(:));
[Max_Row,Max_Col] = find(All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis == Max_DS_STMD_Output);

DS_STMD_Model_Outputs = max(All_DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(:,Max_Col),[],2);

% Normalization
DS_STMD_Model_Outputs = DS_STMD_Model_Outputs./Max_DS_STMD_Output;



Theta = [pi,0,pi/2,3*pi/2,pi/4,3*pi/4,5*pi/4,7*pi/4];


figure
Motion_Direction = [0,0];
for i = 1:length(DS_STMD_Model_Outputs)
    
    for r = 0:0.01:DS_STMD_Model_Outputs(i)
        polar(Theta(i),r,'r.')
        hold on
    end
    
    Motion_Direction = Motion_Direction + DS_STMD_Model_Outputs(i)*[cos(Theta(i)),sin(Theta(i))];
end

% 实际运动方向
Component_1 = -0.25;
Component_2 = 15*cos(4*pi*(500-Y_Show)/250)*4*pi/1000;

Actual_Direction_Angle = pi+atan(Component_2/Component_1);


figure
[Motion_Direction_Theta,Motion_Direction_R] = cart2pol(Motion_Direction(1),Motion_Direction(2));
for r = 0:0.01:1
        polar(Motion_Direction_Theta,r,'r.')
        hold on
        polar(Actual_Direction_Angle,r,'b.')
end




%xlabel('Motion Direction')


% 计算角度

Motion_Direction_Angle = (Motion_Direction_Theta)*180/pi


Component_1 = -0.25;
Component_2 = 15*cos(4*pi*(500-Y_Show)/250)*4*pi/1000;

atan(Component_2/Component_1)*180/pi
Actual_Direction_Angle = 180 - atan(Component_2/Component_1)*180/pi


Angle_Difference = Motion_Direction_Angle + Actual_Direction_Angle
