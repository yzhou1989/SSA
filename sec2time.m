function [time]=sec2time(time)
% SEC2TIME 将秒值转换为时间

hour=sprintf('%02d',fix(time/3600));
minute=sprintf('%02d',fix(mod(time,3600)/60));
second=sprintf('%02d',mod(time,60));
time=[hour,':',minute,':',second];

end