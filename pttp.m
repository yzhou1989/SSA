% plot travel time picture
% pttp

% Zhou Yong
% 2012-11-22

% function pttp
%  生成桌面
% plot data
% load Data3;
figure;hold on;xlabel('time/s');ylabel('distance/Km');
amplifier=100;
epicenter={103.21,31.26,216.8};
for i=1:size(stationData,1)
    ind=scfind(station,stationData{i,1});
    ybias=dist(station{ind,4},station{ind,3},epicenter{1,2},epicenter{1,1});
    plot(amplifier*stationData{i,3}{1,2}+ybias,'b');
    [maxVal,maxX]=max(stationData{i,3}{1,2});
    plot(maxX,ybias,'r*');
    text(maxX+30,ybias,num2str(maxX));
    xlim=get(gca,'XLim');
    text(xlim(1,2),ybias,station{ind,1});
    text(xlim(1,1),ybias-30,[num2str(ybias),'(',...
        num2str(ybias/(maxX-epicenter{1,3})),')']);
end
plotTime(epicenter{1,3});
ylim=get(gca,'Ylim');
text(epicenter{1,3},ylim(2),num2str(epicenter{1,3}));
% plot(amplifier*zaz(3600*20:3600*20+1000)+313,'r');
% plot(amplifier*ta(3600*20:3600*20+1000)+1477,'g');
% plot(amplifier*zez(3600*20:3600*20+1000)+1297,'b');
% plot(amplifier*qz(3600*20:3600*20+1000)+699,'y');
% plot(amplifier*xa(3600*20:3600*20+1000)+1359,'m');
% legend('漳州','泰安','郑州','琼中','西安');

% plot line
% [x,y]=ginput(2);plot(x,y,'--m');
% uicontrol('Style','pushbutton','String','Line',...
%     'Position',[10,40,30,30],...
%     'Callback',@plotLine);
% uicontrol('Style','pushbutton','String','Clear',...
%     'Position',[10,10,30,30],...
%     'Callback',@clearLine);
% end

% function plotLine(hobj,handles)
% % 绘制虚线
% pt1=ginput(1);
% pt2=ginput(1);
% % pt1=get(gca,'CurrentPoint');
% plot([pt1(1),pt1(2)],[pt2(1),pt2(2)],'--m');
% guidata(hobj,handles)
% end
% 
% function clearLine(hobj,handles)
% % 清除虚线
% delete(findobj(gca,'LineStyle','--'))
% end