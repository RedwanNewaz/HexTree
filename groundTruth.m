function [ max_y,max_x ] = groundTruth( area,goal,robot )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

z_meas=measurement(1:area(1),goal,robot);
[U,V] = gradient(z_meas,0.2,0.2);
% quiver(U,V)
h=surf(-z_meas);
 set(h,'edgecolor','none');
contour(z_meas,3,'LineWidth',2)
[global_max,max_index]=max(max(z_meas));
max_index=find(z_meas>=global_max,1);
[max_y,max_x]=ind2sub(size(z_meas),max_index);
plot(max_x,max_y,'^','LineWidth',2)
colormap(hot)
axis([1,30,1,30])
xlabel('x-axis distance')
ylabel('y-axis distance')
end

