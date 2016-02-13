close all ;clc;clear all;
set(0,'RecursionLimit',800)
area=[10 10];
hold on 
robot =[10 1];
goal=[1,10];
    
% find hamilton path
taken=[];
path=[];

%% RHexTREE
center=robot;
step=0;
while(distance(robot,goal)>5 && step<100)
    step=step+1;
% find the neighbor of robot Tree
nei= createHexagon(center);

[ path,taken,robot ] = sampleTree( robot,area,nei,path,taken );
% compute cost
BaseCost=distance(repmat(goal,length(nei),1) , nei);

for k=1:size(BaseCost,1)-1
gradient=BaseCost(k+1)-BaseCost(k);
end
[maxI,index]=min(BaseCost);
edge=[nei(index,:); nei(index+1,:)];

% FIND ROBOT IN THE HEXGRID
plot(path(:,1),path(:,2),'r','LineWidth',2)
plot(edge(:,1),edge(:,2),'b','LineWidth',2)

switch index
    case 1
        center=edge(2,:)+[0 1];
    case 2
        center=edge(2,:)+[0.75 0.5];
    case 3
        center=edge(2,:)+[0.75 -0.5];
    case 4
        center=edge(2,:)-[0 1];
    case 5
         center=edge(2,:)-[0.75 0.5];
    case 6
         center=edge(2,:)-[0.75 0.5];
end
pause(0.25)
end






grid on
axis equal