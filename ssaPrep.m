function [stationData]=ssaPrep(startime,endtime,weigwin)
% SSA数据预处理
% 选择单个或多个台站文件，生成相应时间内的标准station.mat数据
% 预处理内容包括：1分离测向，2去除趋势，3按时间窗卷积，4组合成cell
% 需调用sepaMtx.m文件、repNULL.m文件

% clrscr @ STARDUST STUDIO

% 选择文件
[filename, pathname, filterindex] = uigetfile( ...
    {'*.SEC','秒采样数据文件(*.SEC)';...
%     '*.TSF','gPhone重力数据(*.TSF)'...
    '*.*','所有文件(*.*)'},...
    'Pick  file', 'MultiSelect', 'on');
stationData=[];
% 判断是否选择了文件
if filterindex >= 1
    if iscell(filename) % 如果选择多个文件
        wb=waitbar(0,'请等待...','Name','正在读取数据...');
        for i = 1:1:size(filename,2)
            ff=fullfile(pathname,filename{i});
            stationData=[stationData;extractData(ff,startime,endtime,weigwin)];
            waitbar(i/size(filename,2));
        end
    else % 仅选择一个文件
        msgbox('选择文件数目不够。','错误');
    end
    close(wb);
else
    stationData=NaN;
end

end