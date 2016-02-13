
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
[global_max,max_index]=max(max(z_meas));
max_index=find(z_meas>=global_max,1);
[max_y,max_x]=ind2sub(size(z_meas),max_index);
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
RIG_tree=struct('location',[],'cost',[],'info',[]);

store=[];
while(step<50)

    step=step+1;
    % determine hexagonal sample locations
%     nei= (createHexagon(center));
    rep=0;
    step_size=[1,1];
    count=1;
            step_size=step_size+count;
    x_samp=randi(20,1000,2);
    robo_pos=repmat(center,length(x_samp),1);
    neil=abs(x_samp+robo_pos);
%     while(1)

stop=0;
while(stop<7)
    x=neil(count,1);
    y=neil(count,2);
    linearInd = sub2ind(size(z_meas), x, y);
    if(find(store==linearInd))
        count=count+1
    else
           store=[store; sub2ind(size(z_meas), x, y) ];
        count=count+1;
        stop=stop+1;
        nei(stop,:)=[x y];
    end
end

    % minimize exploration by finding hamilton path
    
    
    % compute cost
    BaseCost=distance(repmat(robot,length(nei),1) , nei);
    % Find nearest node
    [tree_Cost,minIndex]=min(BaseCost);

    %check until new index is found
    center=nei(minIndex,:);

%     end
    
    
    % compute info
    tree_Info=distance(goal , center);
    %update Tree
    RIG_tree(step).location=center;
    RIG_tree(step).cost=tree_Cost;
    RIG_tree(step).info=tree_Info;
    
    %make a decision
    max_info=[];
    for i=1:step
       max_info(i,:)= RIG_tree(step).info;
    end
    [maxi_Info,infoIndex]=min(max_info);
    center=RIG_tree(infoIndex).location;
    

    % termination 
    terminate=distance(center,goal);
        
    %simulation
    plot(center(:,1),center(:,2),'o','LineWidth',2)
%     plot(path(:,1),path(:,2),'k','LineWidth',2)
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




