close all ;clc;clear all;
set(0,'RecursionLimit',800)
addpath('lib')
addpath('RRT')
addpath('errorbar_groups')
area=[30 30];

% robot =[2,2]; %good result found
% robot =[2,20]; % another good result
robot =[4,10];
goal=[25,20];
    

%% RHexInfoTree
[ sampled_path, neigbours, returnPath ] = hexTree( robot,goal,area );
%% RRT 
map = zeros(area(1),area(2));
k = 1000;
delta_q = 1; % sampling length
q_start = robot;
q_goal = goal;

p = 0.3;
delta = 5;
[vertices, edges, path] = rrt(map, robot, goal, k, delta_q, p);
path_smooth = smooth(map, path, vertices, delta);

%% result
fprintf('simulation result\n')
    %simulation for HexTree
subplot (2,2,1)
hold on 
    [ max_y,max_x ] = groundTruth( area,goal,robot );
    plot(returnPath(:,1),returnPath(:,2),'m','LineWidth',3)
    scatter(neigbours(:,1),neigbours(:,2),'white*','linewidth',2)
    plot(sampled_path(:,1),sampled_path(:,2),'cyan','LineWidth',2)
hold off


    %simulation for RRT
subplot (2,2,2)
    hold on;
    [ max_y,max_x ] = groundTruth( area,goal,robot );
    [edgesRowCount, ~] = size(edges);
    
    for ii = 1 : edgesRowCount
        plot(vertices(ii, 1), vertices(ii, 2), 'white*', 'linewidth', 2);
        plot([vertices(edges(ii, 1), 1), vertices(edges(ii, 2), 1)], ...
        [vertices(edges(ii, 1), 2), vertices(edges(ii, 2), 2)], ...
         'cyan', 'LineWidth', 2);
    end
    
    plot(q_start(1), q_start(2), 'g*', 'linewidth', 1);
    plot(q_goal(1), q_goal(2), 'r*', 'linewidth', 1);
    
    [~, pathCount] = size(path_smooth);
    
    for ii = 1 : pathCount - 1
        %plot(vertices(ii, 1), vertices(ii, 2), 'cyan*', 'linewidth', 1);
        plot([vertices(path_smooth(ii), 1), vertices(path_smooth(ii + 1), 1)], ...
        [vertices(path_smooth(ii), 2), vertices(path_smooth(ii + 1), 2)], ...
         'm','LineWidth',3);
    end
 
hold off


%% performance evaluation

%for rrt

rrt_path=   path_length(edges)
    % for hex tree
hex_tree_path=    path_length(sampled_path)


figure

sim_analyzer( area,goal,robot,neigbours,sampled_path,vertices,edges)

    
    