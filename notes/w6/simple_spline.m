%
%  simple_spline.m -- djm -- 07 feb 2019
%

%
%  exact curve, plotting points
%
xx = 0:pi/50:2*pi;

figure(1);  clf
plot(xx,sin(xx),'r');  hold on
grid on

title('simple spline')
xlabel('x-axis')

%
%  N sample points
%
N = 8;
xs = (0:N)*(2*pi/N);
ys = sin(xs);

plot(xs,ys,'ko')

%
%  interpolation points
%
xi = (0:1/4:N)*(2*pi/N);
yi = spline(xs,ys,xi);

plot(xi,yi,'k:')

%
%  spline coefficients
%

sp_info = spline(xs,ys)
whos

out1 = sp_info.breaks
out2 = sp_info.coefs
out3 = sp_info.pieces

%
%  spline from coefficients
%
yci = ppval(sp_info,xi);
plot(xi,yci,'bx')
