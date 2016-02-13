function [ dist] = distance(A,B )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dist=sum((A-B).^2,2);


end

