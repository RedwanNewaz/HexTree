% triangle (add your points)
A = [1 2];
B = [5 7];
C = [2 9];
M = [A; B; C]; % matrix to hold points
plot(M(:,1),M(:,2),'*')
% line of symmetry (add your m and n)
m = .5;
n = -1;
x = [-100 100];
y = m.*x+n;
hold on
plot(x,y)
hold off
As = symetric_P_about_line(A,m,n);
Bs = symetric_P_about_line(B,m,n);
Cs = symetric_P_about_line(C,m,n);
Ms = [As; Bs; Cs]; % matrix to hold symmetric points 
hold on
plot(Ms(:,1),Ms(:,2),'r*')
hold off
axis([-10 20 -10 20])
axis square