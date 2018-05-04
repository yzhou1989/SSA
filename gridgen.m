function [ gr ] = gridgen( minla, minlg, maxla, maxlg, ula, ulg )
%GRIDGEN Generate the Grid
%   minla The min value of Latitude
%   minlg The min value of Longitude
%   maxla The max value of Latitude
%   maxlg The max value of Longitude
%   ula   The Unit of Latitude
%   ulg   The Unit of Longitude
%   gr    The Grid

m=ceil((maxla-minla)/ula);
n=ceil((maxlg-minlg)/ulg);
gr=zeros(m,n);

end