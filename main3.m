close all ;clc;clear all;
set(0,'RecursionLimit',800)
addpath('lib')
addpath('RRT')
addpath('errorbar_groups')

% for hextree
robot =[4,10];
goal=[25,20];
area=[30 30];
%for rrt
map = zeros(area(1),area(2));
k = 1000;
delta_q = 1; % sampling length
q_start = robot;
q_goal = goal;
p = 0.3;
delta = 5;
    
for loop=1:10
    %% RHexInfoTree
    [ sampled_path, neigbours, returnPath ] = hexTree( robot,goal,area,0 );
    %% RRT 
    [vertices, edges, path] = rrt(map, robot, goal, k, delta_q, p);
    path_smooth = smooth(map, path, vertices, delta);
    %% performance evaluation
    rrt_path(loop,:)=   path_length(edges);
    hex_tree_path(loop,:)=    path_length(sampled_path);
    %% statistical data
    fprintf('loop iteration %d \n',loop)
end

%% data plot
figure
sim_analyzer( area,goal,robot,neigbours,sampled_path,vertices,edges);
%statistical data plot
subplot(2,2,4)
title('statistical performance analysis')
measY=[rrt_path hex_tree_path];
mean_y=mean(measY);
err_y=sqrt(var(measY));
errorbar_groups(mean_y,err_y);    

    