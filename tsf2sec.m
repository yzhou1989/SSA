% tsf2sec
% 转换TSF格式到SEC格式

clear;
% 选择文件
[filename, pathname, filterindex] = uigetfile(...
    {'*.TSF','gPhone重力数据(*.TSF)';...
    '*.*','所有文件(*.*)'},...
    'Pick  file', 'MultiSelect', 'on');
% 判断是否选择了文件
if filterindex >= 1
    if iscell(filename) % 如果选择多个文件
        allData=zeros(2,86400*2); % 转换多天数据需修改
        [b,a]=butter(6,[0.36,0.7]);
        for i = 1:1:size(filename,2)
            ff=fullfile(pathname,filename{i});
            stationCode=ff(find(ff=='(',1,'first')+1:find(ff==')',1,'first')-1);
            date=ff(find(ff=='_',1,'first')+1:find(ff=='.',1,'first')-1);
            if i>1
                if ~(strcmp(stationCode,temStatCode)&&strcmp(date,temDate))
                    msgbox('两个文件日期或台站不符！请查询...','错误');
                    break;
                end
            else
                temStatCode=stationCode;
                temDate=date;
            end
            gravData=importdata(ff,' ',11);
            data=gravData.data(:,7);
            if isempty(strfind(ff,'(2121)'))==0
                data=filter(b,a,data);
                allData(1,:)=data;
            else
                allData(2,:)=data;
            end
        end
        % 写入文件
        head=['0000000',' ',date,' ',stationCode,' ','000XXXXX0000',' ',...
            '02',' ','2',' ','2221',' ','2222'];
        resAllData=reshape(allData,1,size(allData,2)*2);
        newFileName=[stationCode,'222X',date(3:end),'G.SEC'];
        fid=fopen(fullfile(pathname,newFileName),'w');
        fprintf(fid,'%s ',head);
        fprintf(fid,'%.2f ',resAllData);
        fclose(fid);
    else % 仅选择一个文件
        msgbox('选择文件数目不够。','错误');
    end
end