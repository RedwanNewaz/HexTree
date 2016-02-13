function [ result ] = information( mat,index )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(index)
   result(i,:)=mat(index(i,2),index(i,1)); 
end


end

