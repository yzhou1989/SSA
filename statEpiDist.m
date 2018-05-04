% 计算个台站到震源的水平距离

% Zhou Yong

load station
load epicenter
m=size(station,1);
SEDist={};
for i=1:m
    d=dist(epicenter{1,3},epicenter{1,2},station{i,4},station{i,3});
    OSDist={epicenter{1,1},station{i,1},d};
    SEDist=[SEDist;OSDist];
end