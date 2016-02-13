function [ vertices ] = createHexagon( sp,shift )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (nargin==1)
    theta = 0:60:360;
    x =sp(2)+  2*cosd(theta);
    y = sp(1)+ 2*sind(theta);
    vertices=[y' x'];  
else
    theta = 0:60:360;
    x =shift(2)+sp(2)+ cosd(theta);
    y =shift(1)+ sp(1)+sind(theta);
    vertices=[y' x'];  
end


end

