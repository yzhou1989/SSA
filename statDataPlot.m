function []=statDataPlot(stationData)
% 绘制数据图形

load station;
% startime=41860;
% endtime=startime+1800;
n=size(stationData,1);
% figure;
for i=1:n
    %     k=1;
    %     axis tight;
    %     subplot(n,1,i);plot(stationData{i,2+k}{1,2}(startime:endtime));
    %     title([station{scfind(station,stationData{i,1}),1},' ',...
    %         num2str(stationData{i,2}),' ',num2str(stationData{i,2+k}{1,1})]);
    figure;
    for k=1:2
        subplot(2,1,k);plot(stationData{i,3}{1,1+k});
        title([station{scfind(station,stationData{i,1}),1},' ',...
            num2str(stationData{i,2}),' ',num2str(stationData{i,3}{1,1})]);
        %     hold on;
        %     ylim=get(gca,'Ylim');
        %     plot(startime*ones(1,2),ylim,'r--');
        %     plot(endtime*ones(1,2),ylim,'k--');
        %     hold off;
    end
end