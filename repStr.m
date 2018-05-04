function []=repStr(ff,repStr)
% 替换文件中的repStr字符

fid=fopen(ff);
tl=fgetl(fid);
fclose(fid);
sf=strfind(tl,repStr);
if(~isempty(sf))
    fid=fopen(ff,'w+');
    tl=strrep(tl,repStr,'NaN');
    fprintf(fid,tl);
    fclose(fid);
end

end