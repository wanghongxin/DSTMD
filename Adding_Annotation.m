% 对图形添加注释

% 图像长宽为 625*312.5

Length_Arrow = 40/312.5;

% （408,110）
X = 408;
Y = 110;

A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;

annotation('textarrow',[A_X,A_X],[A_Y-Length_Arrow,A_Y],'String','A')


% （386,117）
X = 386;
Y = 117;
A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;
annotation('textarrow',[A_X,A_X],[A_Y-Length_Arrow,A_Y],'String','B')



% （379,122）
X = 379;
Y = 122;
A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;
annotation('textarrow',[A_X,A_X],[A_Y+Length_Arrow,A_Y],'String','C')


% （368,130）
X = 368;
Y = 130;
A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;
annotation('textarrow',[A_X,A_X],[A_Y-Length_Arrow,A_Y],'String','D')


% （322,131）
X = 322;
Y = 131;
A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;
annotation('textarrow',[A_X,A_X],[A_Y+Length_Arrow,A_Y],'String','E')


% （315,126）
X = 315;
Y = 126;
A_X = (X+62.5)/625;
A_Y = (Y+31.25)/312.5;
annotation('textarrow',[A_X,A_X],[A_Y-Length_Arrow,A_Y],'String','F')
