% 模拟实验1台站和震源位置图

% stationMapEx1

m_proj('mercator','longtitudes',[98,112],'latitudes',[23,37]);
% m_coast('patch',[.7,.7,.7],'edgecolor','none');
m_grid('box','fancy');
station={'STA1',35,100;
    'STA2',35,105;
    'STA3',35,110;
    'STA4',30,100;
    'STA5',30,105;
    'STA6',30,110;
    'STA7',25,100;
    'STA8',25,105;
    'STA9',25,110};
epicenter={'EPI1',27,104;
    'EPI2',30.5,109};

for i=1:size(station,1)
    m_line(station{i,3},station{i,2},'Marker','s','MarkerFaceColor','b',...
        'MarkerEdgeColor','none');
    m_text(station{i,3}+.3,station{i,2},station{i,1});
end

for i=1:size(epicenter,1)
    m_line(epicenter{i,3},epicenter{i,2},'Marker','o','MarkerFaceColor','r',...
        'MarkerEdgeColor','none');
    m_text(epicenter{i,3}+.3,epicenter{i,2},epicenter{i,1});
end
