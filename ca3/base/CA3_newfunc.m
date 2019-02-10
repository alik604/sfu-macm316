%
%  CA3_newfunc.m --- CA3 --- djm, 25 jan 2019
%

%  define domain in x and y
xx = -2.5:0.025:2.5;  yy = -2.5:0.025:2.5;

%  define a 'mesh' to plot on
[xg,yg] = meshgrid(xx,yy);

%  define random constants: a1 a2
%###### You should pick a1 and a2; do not leave them random #####
a1 = (rand(1)-0.5)/2;
a2 = (rand(1)-0.5)/2;

%  function handle for f(x,y)
%##### This is the function handle you should copy into your code #####
ff = @(x,y) sin(pi*x).*sin(pi*y) + a1*cos(pi*(pi*x-y)/2) + a2*cos(pi*(x+pi*y)/2);

%  contour plot of f(x,y) with zero contours in white
figure(200);  clf;  hold on;  axis equal
contourf(xg,yg,ff(xg,yg),8)
contour(xg,yg,ff(xg,yg),[0 0],'w--')
xlabel('x')
ylabel('y')
title(['Cellular function using a_1 = ',num2str(a1),', a_2 = ',num2str(a2)])
colorbar