% Stress_Strain_Tri3

function [sigma, epsilon] = Stress_Strain_TRI3 (x1,y1,x2,y2,x3,y3,C,delta)
p2 = [x2,y2,0];
p1 = [x1,y1,0];
p3 = [x3,y3,0];

Ae = norm(cross(p2-p1,p3-p1))/2;

df1dx = (y2-y3)/(2*Ae);
df1dy = (x3-x2)/(2*Ae);
df2dx = (-y1+y3)/(2*Ae);
df2dy = (-x3+x1)/(2*Ae);
df3dx = (-y2+y1)/(2*Ae);
df3dy = (-x1+x2)/(2*Ae);

% Matriz B (3x6) para elasticidade plana
B = [df1dx 0 df2dx 0 df3dx 0;...
    0 df1dy 0 df2dy 0 df3dy;...
    df1dy df1dx df2dy df2dx df3dy df3dx];

epsilon = B*delta;
sigma = C*epsilon;
end