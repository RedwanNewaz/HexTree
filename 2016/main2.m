close all ;clc;clear all;
set(0,'RecursionLimit',800)
area=[10 11];
hold on 
robot =[1 1];
goal=[9,5];
    
 count=1;
for x=1:2:area(1)    
    for y=1:1.75:area(2)        
      node=createHexagon([y x]);
      plot(node(:,1),node(:,2),'*')
            Hexgrid(count).parent=[y x];
            Hexgrid(count).childred=node;
                text(y,x, num2str(count), 'VerticalAlignment','middle', ...
                             'HorizontalAlignment','center')
            count=count+1;
    end
end

% FIND ROBOT IN THE HEXGRID
for i=1:length(Hexgrid)
    dist(i,:)=distance(Hexgrid(i).parent,robot);
end
[minDist,index]=min(dist);
plot(Hexgrid(index).parent(1),Hexgrid(index).parent(2),'^','LineWidth',3)
%robot=[Hexgrid(index).parent(1),Hexgrid(index).parent(2)];
robotNode=index;
% find hamilton path
taken=[];
path=[];
parentTake=[];

parentTake=[parentTake;robotNode];
%% RHexTREE
for steps=1:25
% find the neighbor of robot Tree
nei= Hexgrid(robotNode).childred;


[ path,taken,robot ] = sampleTree( robot,area,nei,path,taken );
% compute cost
BaseCost=distance(repmat(goal,length(nei),1) , nei);

for k=1:size(BaseCost,1)-1
gradient=BaseCost(k+1)-BaseCost(k);
end
[maxI,index]=max(gradient);
edge=[nei(index,:); nei(index+1,:)];

% FIND ROBOT IN THE HEXGRID
for i=1:length(Hexgrid)
    distA(i,:)=distance(edge(1,:),Hexgrid(i).parent);
    
    if(find(i==parentTake))
        distB(i,:)=10000;
    else
     distB(i,:)=distance(edge(2,:),Hexgrid(i).parent);
    end
end

plot(path(:,1),path(:,2),'r','LineWidth',2)

[minDijkst,indexu]=min(distA+distB);
robotNode=indexu;
parentTake=[parentTake;robotNode];
pause(0.25)

plot(edge(:,1),edge(:,2),'b','LineWidth',2)
distance(robot,goal)
plot(Hexgrid(robotNode).parent(1),Hexgrid(robotNode).parent(2),'^','LineWidth',3)
if(distance(robot,goal)<5)
    break;
end

end






grid on
axis equal