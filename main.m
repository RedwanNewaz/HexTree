close all ;clc;clear all;
set(0,'RecursionLimit',800)
area=[30 30];
hold on 
% robot =[2,2]; %good result found
% robot =[2,20]; % another good result
robot =[2,2];
goal=[25,20];
    
% find hamilton path
z_meas=measurement(1:area(1),goal,robot);
% surfc( )
[U,V] = gradient(z_meas,0.2,0.2);
quiver(U,V)
contour(z_meas,3,'LineWidth',2)
[global_max,max_index]=max(max(z_meas))
max_index=find(z_meas>=global_max,1);
[max_y,max_x]=ind2sub(size(z_meas),max_index)
plot(max_x,max_y,'^','LineWidth',2)
% colormap(gray)
%% RHexInfoTree
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
        
    %simulation
    plot(center(:,1),center(:,2),'o','LineWidth',2)
    plot(path(:,1),path(:,2),'k','LineWidth',2)
    plot(nei(:,1),nei(:,2),'r','LineWidth',2)
    pause(0.5)
    
end

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

%% Draw optimal path 

returnPath=[center]; %goal position
for i=length(parentIndex):-1:1
    returnPath=[returnPath; InfoTree(parentIndex(i)).parent.location];
end
returnPath=[returnPath;initial]; %initial location
plot(returnPath(:,1),returnPath(:,2),'m','LineWidth',5)
fprintf('  \n optimal path generated\n');
disp(returnPath)




