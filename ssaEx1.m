% 实验1

% ssaEx1
% 需修改部分代码以适应求值

%% 初始化
% clear;
% clc;
% tic;

%% 加载数据
% load station % 台站信息

%% 设置格网参数
minla=23; % 最小纬度
unitla=.1; % 纬向步长
maxla=37; % 最大纬度
minlg=98; % 最小经度
unitlg=.1; % 经向步长
maxlg=112; % 最大经度

%% 设置时间参数
startime=0; % 一天中秒值
unitime=5;
endtime=startime+100;

%% 设置速度结构
vel=3; % 设置面波传播速度，该处为3Km/s

%% 设置权重窗
% weigwin=ones(1,60);

%% 搜索求解
% stationData=ssaPrep(startime,endtime,weigwin); % 生成台站数据
stationData=sig;
stationData=[stationData,zeros(9,1000)];
numStatD=size(stationData,1); % 读取台站数
[gridlg,gridla]=meshgrid(minlg:unitlg:maxlg,minla:unitla:maxla); % 生成格网
[m,n]=size(gridlg);

wb=waitbar(0,'请等待...','Name','正在计算亮度函数图');
multiGrid=[];
for time=startime:unitime:endtime
    gridli=zeros(m,n);
    for i=1:1:m
        for j=1:1:n;
            tsum=0;
            for k=1:1:numStatD
%                 ind=scfind(station,stationData{k,1}); % 搜索台站代码相对的台站代码数据的位置
                tsf=delti(dist(station{k,2},station{k,3},gridla(i,j),gridlg(i,j)),vel);
                tsf=round(tsf);
                unit=stationData(k,time-startime+tsf+1); % 使用NS向数据
                tsum=tsum+unit;
            end
            gridli(i,j)=1/numStatD*tsum;
        end
    end
    multiGrid=cat(3,multiGrid,gridli);
    waitbar((time-startime)/(endtime-startime));
    figure;imagesc(gridlg(1,:),gridla(:,1)',gridli);axis xy;colorbar;...
        caxis([0,1]);title(num2str(time)); % 显示stattime亮度图
end
close(wb);
% toc;