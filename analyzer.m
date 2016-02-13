
function []=analyzer( area,goal,robot,neigbours,sampled_path,neigbours,sampled_path)

if nargin<5
% clear all;close all;clc;
load('hexTree_ex_1')
load('rrt_ex1')

%simulation parameter
area=[30 30];
robot =[4,10];
goal=[25,20];
end


q_start=robot;
q_goal=goal;

%% result
    %simulation for HexTree
subplot (2,2,1)
hold on 
    [ max_y,max_x ] = groundTruth( area,goal,robot );
    plot_graph( 1,neigbours,sampled_path,1 )
hold off

    %simulation for RRT
subplot (2,2,2)
hold on;
    [ max_y,max_x ] = groundTruth( area,goal,robot );
    plot_graph( iteration,vertices,edges,0 );
hold off

%% performance evaluation


% for hex tree
subplot (2,2,3)
hex_tree_path=    path_length(sampled_path);
iteration=1;x=0;hex_converge=[];
while(x<hex_tree_path)
   x= plot_graph( iteration,neigbours,sampled_path,1,0 );
   hex_converge(iteration,:)=x;
   iteration=iteration+1;
end

%for rrt
rrt_path=   path_length(edges);
    iteration=1;x=0;rrt_converge=[];
while(x<rrt_path)
   x= plot_graph( iteration,vertices,edges,0,0 );
   rrt_converge(iteration,:)=x;
   iteration=iteration+1;
end

%plot performance graph
hold off
hold on
plot(1:length(hex_converge),hex_converge)
plot(1:length(rrt_converge),rrt_converge)
xlabel('time spent')
ylabel('distance traveled')
hold off
end