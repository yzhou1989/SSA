function []=plotTime(timeInp)
% PLOTTIME plot time axis on current picture.
% example:
% plotTime(12000) or plotTime('3:30:45')

if ischar(timeInp)
    timeArr=sscanf(timeInp,'%d:%d:%d');
    time=timeArr(1)*3600+timeArr(2)*60+timeArr(3);
else
    time=timeInp;
end
yLim=get(gca,'Ylim');
hold on;plot(time*ones(1,2),yLim,'--r');hold off;

end