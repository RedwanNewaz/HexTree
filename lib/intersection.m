function [x,y]=intersection(lineA,lineB)
x1 = lineA.x1; x2=lineA.x2;
y1 = lineA.y1; y2=lineA.y2;
y3 = lineB.y1; y4=lineB.y2;
x3 = lineB.x1; x4=lineB.x2;

x12 = x1 - x2;
x34 = x3 - x4;
y12 = y1 - y2;
y34 = y3 - y4;

c = x12 * y34 - y12 * x34;
if (abs(c) < 0.01)
	x=0;y=0;
else
   a = x1 * y2 - y1 * x2;
   b = x3 * y4 - y3 * x4;
   x = (a * x34 - b * x12) / c;
   y = (a * y34 - b * y12) / c;
end

end