function [ stationData ] = extractData( ff,startime,endtime,weigwin )
%extracData 提取数据
% ff 文件
% MT 分离测项后矩阵，大小为N*2
% 需调用repNULL.m文件

% 判断文件类型
ind=find(ff=='.',1,'last');
ext=ff(ind+1:end);

if strcmp(ext,'SEC')
    
    
    repStr(ff,'NULL'); % 替换文件中的NULL字符
    repStr(ff,'999999');
    M = load(ff);
    % 如果M长度为奇数，添零
    if mod(length(M),2) == 1
        M = [M,0];
    end
    ffhead=M(1,1:8);
    M(1:8)=[];
    % 分离测项
    MT=reshape(M,2,length(M)/2);
    % 剔除趋势
    DT=zeros(size(MT(1:2,startime:endtime)));
    for i=1:2
        %         figure;
        data=MT(i,startime:endtime); %原始数据
        %         subplot(411);plot(startime:endtime,data);title('原始数据');
        %         1 小波分解
        data=data-mean(data);
%                 hfdata=data; % 直接相等
        [c,l]=wavedec(data,6,'db4');
        %         %         提取高频数据方法1，获取趋势，剔除趋势得到高频数据
        %         c(l(1)+1:end)=0;
        %         rbdata=waverec(c,l,'db4');
        %         hfdata=data-rbdata; % 去除趋势
        %         %         提取高频数据方法1******************************
        % 提取高频数据方法2，利用高频系数重建信号
        c(1:l(1))=0;
        hfdata=waverec(c,l,'db4');
%         subplot(412);plot(startime:endtime,hfdata);title('高频数据');
        % 提取高频数据方法2******************************
        % 2 滤波
%                 [b,a]=butter(4,[0.36,0.5]);
%                 hfdata=filter(b,a,data);
        %         subplot(412);plot(startime:endtime,hfdata);title('滤波后数据');
        %         % 滤波******************************************
        hfdata=abs(hfdata); % 绝对值
        %         hfdata=uniti(hfdata); % 单位化数据
        %         subplot(413);plot(startime:endtime,hfdata);title('归一化数据');
        hfdata=conv(hfdata,weigwin,'same')/sum(weigwin,2); % 按权重窗进行卷积
        hfdata=uniti(hfdata); % 单位化
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %1
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %2
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %3
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %4
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %5
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %6
        %         hfdata(isnan(hfdata))=0;
        %         subplot(414);plot(startime:endtime,hfdata);title('权重卷积数据');
        DT(i,:)=hfdata;
        %         xlabel([num2str(ffhead(1,3)),'|',num2str(ffhead(1,6+i))]);
    end
    stationData={ffhead(1,3),ffhead(1,2),{ffhead(1,7),DT(1,:)},...
        {ffhead(1,8),DT(2,:)}};
else
    msgbox('文件类型出错！请查询...','错误');
    % elseif strcmp(ext,'TSF')
    %     repStr(ff,'999999');
    %     gravData=importdata(ff,' ',11);
    %     data=gravData.data(startime:endtime,7);
    
end

end