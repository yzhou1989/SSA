function [dist] = dist(b1, l1, b2, l2, refellip)
% 已知两点经纬度计算两点间距离
% 参考文献： 李庆海 误差不大于10米的长距离大地线长度的计算公式
% b latitude
% l longtitude
% b1,l1,b2,l2 Degree
% S Km

if (nargin == 4)
    refellip=[6378.137,1/298.257223563]; % 未选择参数时默认使用WGS-84椭球参数
end

% format long;

if(b1==b2 && l1==l2)
    dist=0;
else
    
    a=refellip(1);
    f=refellip(2);
    b=a*(1-f);
    
    u1=atan(b*tan(deg2rad(b1))/a);
    u2=atan(b*tan(deg2rad(b2))/a);
    
    de=acos(sin(u1)*sin(u2)+cos(u1)*cos(u2)*cos(deg2rad(l1-l2)));
    
    u=(sin(u1)+sin(u2))^2;
    v=(sin(u1)-sin(u2))^2;
    s=(de-sin(de))/(1+cos(de));
    t=(de+sin(de))/(1-cos(de));
    
    dist=a*de-0.25*a*f*(s*u+t*v);
    
end

end