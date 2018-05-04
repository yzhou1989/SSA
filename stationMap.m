% 台站和震源位置图

figure;
m_proj('mercator','longtitudes',[100,130],'latitudes',[25,45]);
m_coast('patch',[.7,.7,.7],'edgecolor','none');
m_grid('box','fancy');
stationInp;
epicenterInp;
load bou2_4l; % 读取国界线
for i=1:length(bou2_4l.ncst)
    m_line(bou2_4l.ncst{i}(:,1),bou2_4l.ncst{i}(:,2),'color','k');
end
%% 绘制台站
for i=1:size(station,1)
    %         if(i==1||i==2||i==3||i==10||i==14||i==15||i==16)
    %             continue;
    %         end
    %     if(i==1||i==4||i==6||i==8||i==12||i==13)
    if(strcmp(station{i,1},'黄梅')==1||strcmp(station{i,1},'宁陕')==1)
        color='b';shape='^';
    else
        color='b';shape='s';
    end
    m_line(station{i,3},station{i,4},'Marker',shape,'MarkerFaceColor',color,...
        'MarkerEdgeColor','none');
    ybias=0;
    if(i==12)
        ybias=.5;
    end
    if(i==13)
        ybias=-.5;
    end
    m_text(station{i,3}+.3,station{i,4}+ybias,station{i,1});
    %     end
end
% %% 绘制震源位置
% for i=1:size(epicenter,1)
%     position='right';
%     if(strcmp(epicenter{i,4},'蒙古')==1)
%         position='left';
%     end
%     m_line(epicenter{i,2},epicenter{i,1},'Marker','o','MarkerFaceColor','r',...
%         'MarkerEdgeColor','none');
% %     m_text(epicenter{i,2}-.2,epicenter{i,1},...
% %         epicenter{i,4},'HorizontalAlignment',position);
% end
% %% 绘制地震射线
% for i=1:size(epicenter,1)
%     for j=1:size(station,1)
%         m_line([epicenter{i,2};station{j,3}],[epicenter{i,1};station{j,4}],...
%             'color','r','linestyle','-');
%     end
% end
% clear;