function [ time ] = delti( dist, velo )
%DELTI Caculate the delayed time from focus to station
%   dist The distance from Focus to Station
%   velo The velocity of the media

% Zhou Yong 2012-10-14 modified

time=dist/velo;

end