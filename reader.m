% 选取数据曲线
% 针对垂直摆倾斜仪实验数据

% clrscr @ STARDUST STUDIO 2012.3.6

% 选择文件
[filename, pathname, filterindex] = uigetfile( {'*.SEC01','秒采样南北分量文件(*.SEC01)';...
    '*.SEC02','秒采样东西分量文件(*.SEC02)';'*.HF01','南北分量高频数据(*HF01)';...
    '*.HF02','东西分量高频数据(HF02)';'*.*','所有文件(*.*)'}, 'Pick  file', 'MultiSelect', 'on');
% 判断是否选择了文件
if filterindex ~= 0
    data = [];
    if iscell(filename)
        for i = 1:1:length(filename)
            fullfilename = fullfile(pathname,filename{i});
            repStr(fullfilename,'1e+06');
            repStr(fullfilename,'NULL');
            data = [data,load(fullfilename)];
        end
    else
        fullfilename = fullfile(pathname,filename);
        repStr(fullfilename,'1e+06');
        repStr(fullfilename,'NULL');
        data = load(fullfilename);
    end
    data=data';
    time=0:length(data)-1;
    figure;plot(time,data);xlabel('time');ylabel('ms');
    clear filename;
    clear filterindex;
    clear fullfilename;
    clear i;
    clear pathname;
end