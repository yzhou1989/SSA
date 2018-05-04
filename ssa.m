% SSA 震源搜索算法

% clrscr @ STARDUST STUDIO 2012.2

%% 初始化
clear;
clc;
tic;

%% 加载数据
% load station % 台站信息
stationInp; % 加载台站信息

%% 设置格网参数

minLa=20; % 最小纬度
unitLa=0.5; % 纬向步长
maxLa=50; % 最大纬度
minLg=100; % 最小经度
unitLg=0.5; % 经向步长
maxLg=130; % 最大经度

%% 设置时间参数

startTime=33600  ; % 一天中秒值
uniTime=60;
endTime=startTime+1200*2;
% endTime=3600*6;
dataEndTime=0; % 默认为0，非0则使用修改值，否则，计算最坏延时


%% 设置速度结构
velT=2.8; % 设置面波传播速度，该处为3Km/s
velG=2.9;

%% 设置时间窗
% weigWin=ones(1,10); %  平均分布
weigWin=normpdf(1:20,10,7); % 正态分布
% weigWin=1;
% % 绘制时间窗
% figure;plot(weigWin);title('时间窗');

%% 搜索求解
% 计算最坏延时
badTsf=ceil(delti(dist(minLa,minLg,maxLa,maxLg),min(velT,velG)));
if dataEndTime==0
    dataEndTime=endTime+badTsf;
end
stationData=ssaPrep(startTime,dataEndTime,weigWin); % 生成台站数据
% close all;

% 未读取到数据则跳出程序
if iscell(stationData)==0
    break;
end

% % 绘制各台站相对数据
sizeStatData=size(stationData,1);
% for nw=3:4
%     figure;
%     for i=1:sizeStatData
%         subplot(sizeStatData,1,i);
%         plot(stationData{i,nw}{1,2});
%         title([num2str(stationData{i,1}),'|',num2str(stationData{i,nw}{1,1})]);
%     end
% end

% numStatD=size(stationData,1); % 读取台站数
% [gridLg,gridLa]=meshgrid(minLg:unitLg:maxLg,minLa:unitLa:maxLa); % 生成格网
% [m,n]=size(gridLg);
% 
% wb=waitbar(0,'请等待...','Name','正在计算亮度函数图');
% multiGrid=[];
% timeAndMax=[];
% for time=startTime:uniTime:endTime
%     gridOneLay=zeros(m,n);
%     for i=1:1:m
%         for j=1:1:n;
%             tsum=0;
%             for k=1:1:numStatD
%                 ind=scfind(station,stationData{k,1}); % 搜索台站代码相对的台站代码数据的位置
%                 if ind==-1
%                     msgbox('未找到相应台站！','错误');
%                     break;
%                 end
%                 if strcmp(station{ind,6},'tilt')
%                     vel=velT;
%                 elseif strcmp(station{ind,6},'gravity')
%                     vel=velG;
%                 end
%                 tsf=delti(dist(station{ind,4},station{ind,3},gridLa(i,j),gridLg(i,j)),vel);
%                 tsf=round(tsf);
%                 % 数据超限，值为0
%                 if time+tsf >= dataEndTime || tsf==0
%                     unit=0;
%                 else
%                     unit=stationData{k,3}{1,2}(time-startTime+tsf); % 提取stationData中相应数据
%                 end
%                 tsum=tsum+unit;
%             end
%             gridOneLay(i,j)=1/numStatD*tsum;
%         end
%     end
%     waitbar((time-startTime)/(endTime-startTime));
%     % 亮度值全为0，继续下一级循环
%     if gridOneLay==zeros(m,n)
%         continue;
%     end
%     % 绘制亮度图2-1****************************************
%     figure;imagesc(gridLg(1,:),gridLa(:,1)',gridOneLay);axis xy;colorbar;...
%         caxis([0,1]);
%     hold on;
%     % 绘制台站位置
%     for i=1:sizeStatData
%         indStat=scfind(station,stationData{i,1});
%         plot(station{indStat,3},station{indStat,4},'ws');
%     end
%     % 绘制亮度图2-1****************************************
%     
%     % 突出显示最大值所在位置
%     maxGridOneLay=max(max(gridOneLay));
%     [indMaxLg,indMaxLa]=find(gridOneLay==maxGridOneLay);
%     maxLg=gridLg(indMaxLg,indMaxLa);
%     maxLa=gridLa(indMaxLg,indMaxLa);
%     if length(maxLg)>1
%         maxLg=maxLg(1);
%         maxLa=maxLa(1);
%         indMaxLg=indMaxLg(1);
%         indMaxLa=indMaxLa(1);
%     end
%     
%     % 绘制亮度图2-2****************************************
%     plot(maxLg,maxLa,'wo');
%     
%     % 显示时间和最大值
%     title([sec2time(time),'(',num2str(time),')',' ','|',' ',num2str(maxGridOneLay),...
%         '(',num2str(maxLg),',',num2str(maxLa),')']);
%     hold off;
%     % 绘制亮度图2-2****************************************
%     
%     % 记录当前时间和最大函数值
%     timeAndMax=[timeAndMax;[time,maxGridOneLay,maxLg,maxLa,indMaxLg,indMaxLa]];
%     % 记录历史亮度函数值
%     multiGrid=cat(3,multiGrid,gridOneLay);
% end
% close(wb);
% 
% % 绘制最大函数值变化图
% figure;plot(timeAndMax(:,1),timeAndMax(:,2),'--b*');xlabel('time/s');ylabel('lightness');title('最大亮度函数值变化图');
% hold on;
% maxLight=max(timeAndMax(:,2));
% [c,r]=find(timeAndMax==maxLight);
% xlim=get(gca,'XLim');plot(xlim,0.85*ones(1,2),'-m');
% title([sec2time(timeAndMax(c,1)),'(',num2str(timeAndMax(c,1)),')','|',...
%     num2str(timeAndMax(c,2)),'(',num2str(timeAndMax(c,3)),...
%     ',',num2str(timeAndMax(c,4)),')']);
% hold off;
% 
% % 绘制震颤源位置亮度函数值变化图
% figure;
% allMaxLg=timeAndMax(c,5);
% allMaxLa=timeAndMax(c,6);
% lightness(1:size(multiGrid,3))=multiGrid(allMaxLg,allMaxLa,:);
% plot(timeAndMax(:,1),lightness);hold on;
% set(gca,'Ylim',[0,1])
% xlim=get(gca,'Xlim');plot(xlim,0.85*ones(1,2),'--m');
% xlabel('time/s');ylabel('lightness');title('震颤源亮度值变化图')
% hold off;
% 
% % 绘制震颤源定位结果图
% % 绘制亮度图
% soureLay(1:m,1:n)=multiGrid(:,:,c);
% figure;imagesc(gridLg(1,:),gridLa(:,1)',soureLay);axis xy;colorbar;...
%     caxis([0,1]);
% hold on;
% % 绘制台站位置
% for i=1:sizeStatData
%     indStat=scfind(station,stationData{i,1});
%     plot(station{indStat,3},station{indStat,4},'ws');
% end
% % 突出显示最大值所在位置
% plot(timeAndMax(c,3),timeAndMax(c,4),'wo');
% % 显示时间和最大值
% title([sec2time(timeAndMax(c,1)),'(',num2str(timeAndMax(c,1)),')',' ','|',' ',num2str(timeAndMax(c,2)),...
%     '(',num2str(timeAndMax(c,3)),',',num2str(timeAndMax(c,4)),')']);
% hold off;

toc;