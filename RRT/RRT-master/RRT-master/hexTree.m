function [ sampled_path, neigbours, returnPath ] = hexTree( robot,goal,area )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

initial=robot;
center=robot;
step=0;
taken=[];
path=[];
terminate=10000;



%HEXTREE STRUCTURE
valueParent=struct('location',[],'cost',[],'info',[]);
valueNeighbor=struct('location',[],'cost',[],'info',[]);
InfoTree = struct('parent',valueParent,'neighbour',valueNeighbor);
pathSize=0;

sampled_path=struct('x',[],'y',[]);
neigbours=[[],[]];
while(terminate>1)
    step=step+1;
    % determine hexagonal sample locations
    nei= (createHexagon(center));
    % minimize exploration by finding hamilton path
    [ path,taken,robot ] = sampleTree( robot,area,nei,path,taken );   
    % compute cost
    BaseCost=distance(repmat(goal,length(nei),1) , nei);
    %update Tree
    [center,InfoTree]  = updateTree( InfoTree,center,initial,nei,BaseCost,step );    
    % termination 
    terminate=distance(center,goal);
    
    %data store
    sampled_path(step).x=path(:,1);
    sampled_path(step).y=path(:,2);
    neigbours=[neigbours;nei];

end



%% optimal return path 
parentIndex=optimalPath( InfoTree );
returnPath=[center]; %goal position
for i=length(parentIndex):-1:1
    returnPath=[returnPath; InfoTree(parentIndex(i)).parent.location];
end
returnPath=[returnPath;initial]; %initial location




end


function [ parentIndex ] = optimalPath( InfoTree )
%% shortest maximum info path
% find DP parameters from the Tree
[ numk,W,w,mu,v ] = convertTree( InfoTree );
% Solve DKP for different values of W.
fprintf('   W   p*  mu*   v*   w* -x-\n');
hw=0;
for path_length = 3:15:168
    [popt, x] = DSKPsolve(numk,path_length,w,mu,v,24,false);
    fprintf('%4d %4.2f %4d %4d %4d [%s]\n',...
        path_length,popt,sum(mu.*x),sum(v.*x),sum(w.*x),...
        sprintf('%d ',x));    
    parentIndex=find(x>0);
    %check convergence of the solution
    if(hw==length(parentIndex))
        break;
    else
        hw=length(parentIndex);
    end
    
end

end

