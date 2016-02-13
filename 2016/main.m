clc;clear all;close all;
area=[1 5 1 5];
deg=0.0174533;
point=[2 2];
% moving diagonal right
for h=1:20
hex=createHexagon(point);
edge=1:2;
hold on
 plot(hex(:,1),hex(:,2),'r','LineWidth',2)
 plot(hex(edge,1),hex(edge,2),'LineWidth',2) 
 hexEdge=[hex(edge,1) hex(edge,2)];
 upperLeft=hexEdge(2,:);
 a=0.5;
 b=3*a^2/4;
 if(h<=5)
%  upper left
 node=[upperLeft(1)+b-a/2 upperLeft(2)+2*a];
 elseif(h<=10)
 %upper right
 node=[upperLeft(1)-3*a-b upperLeft(2)+2*a];
 elseif(h<=15)
%bottom left
node=[upperLeft(1)-4*a+a/2 upperLeft(2)-4*a+a/2-b];
 else

 %bottom right
 node=[upperLeft(1)-b+a/2 upperLeft(2)-4*a];

 end
 
%  pause(0.5)
 point=node;
end


axis square;
grid on
xlabel('xAxis')
ylabel('yAxis')