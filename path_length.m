function [ dist ] = path_length( vertices )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    [vertexRowCount, ~] = size(vertices);    
    dist=0;
    for ii = 1 : vertexRowCount-1
        a=[vertices(ii, 1) vertices(ii, 2)];
        b=[vertices(ii+1, 1) vertices(ii+1, 2)];
        dist=dist+sqrt(sum((a-b).^2,2));
    end

end

