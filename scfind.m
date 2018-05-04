function [ind]=scfind(station,sc)
% 查找台站代码在station中的位置
% 找到返回行号，未找到则返回-1。

ind=-1;
for i=1:size(station,1)
    if(station{i,2}==sc)
        ind=i;
        break;
    end
end

end