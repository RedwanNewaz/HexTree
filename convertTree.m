function [ numk,W,w,mu,v ] = convertTree( InfoTree )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
numk = length(InfoTree);       % number of item types
% compute total weight
W = 0;         % total bag weight limit
dir=0;
newDirLen=0;
w=[];% item weight by type>> cost
mu= [];    % mean of item return by type
v = [];    % variance of item return by type
for k=1:numk
   W=W+InfoTree(k).parent.cost;
   newDir=InfoTree(k).parent.info(2);
   if(newDir~=dir)
      newDirLen=0;
       for j=1:numk
            if(InfoTree(j).parent.info(2)==newDir);
                newDirLen=newDirLen+1;
            end
       end
      dir=newDir;
   end
   mu=[mu newDirLen];
   
   if(k>1)
      w=[w InfoTree(k).parent.cost-InfoTree(k-1).parent.cost]; 
      v=[v InfoTree(k).parent.info(1)-InfoTree(k-1).parent.info(1)]; 
   else
       w=[w 3];
       v=[v 1];
   end
   
end


end

