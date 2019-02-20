%
% MACM 316 - Tutorial 6 - Cubic Splines (hl, Feb. 2019)
%
% Instructions: Follow along with the slides for instructions. 
%              If done correctly, you should be able to solve for
%              the missing coefficent vector c1
%



% Random seed. Feel free to experiment after tutorial!
rng(5);

% Missing coeffs of S_1(x) to be solved for
c1 = [0 0 0 0];

% Set up some random data
n=4;
xd = linspace(0,1,n); 
z  = (xd-.2)/.4;
fd = .5*exp(-z.^2).*(1+erf(4*z));
fd = fd.*(1+.5*rand(1,n));

% Have Matlab compute the cubic spline
pp=spline(xd,fd);

% Coeffs of S_0 and S_2
c0 = pp.coefs(1,:); 
c2 = pp.coefs(3,:);  

% Fine grids of our domain
x1 = linspace(0,xd(2),100);
x2 = linspace(xd(2),xd(3),100);
x3 = linspace(xd(3),xd(4),100);

% Given derivative data
S0p_x1 = 1/3*c0(1)+2/3*c0(2) + c0(3);
S2pp_x2 = 2*c2(2);

% Plotting. 
% If everything is done right, you will plot 
% all 3 portions of S(x)
figure(2); clf; hold on; 
lgd = {'Data','S_0(x)','S_2(x)'};
plot(xd,fd,'ko')
plot(x1,(x1-xd(1))'.^[3:-1:0]*c0','b')
if norm(c1) > 0
plot(x2,(x2-xd(2))'.^[3:-1:0]*c1','r')
lgd = {'Data','S_0(x)', 'S_1(x)','S_2(x)'};
end
plot(x3,(x3-xd(3))'.^[3:-1:0]*c2','m')

title('Cubic Spline Interpolation of Function Data', ...
      'fontsize',15)

text(xd(2),fd(2)-.1, ['$f_1$ = ', num2str(fd(2)), newline,'$S_0''(x_1)=$',num2str(S0p_x1)],'interpreter','latex','fontsize',15)
text(xd(3),fd(3)+.1, ['$f_2$ = ', num2str(fd(3)), newline,'$S_2''''(x_2) =$ ',num2str(S2pp_x2)],'interpreter','latex','fontsize',15)
legend(lgd,'fontsize',15)
grid on
xlabel('x','fontsize',15)
ylabel('y','fontsize',15)

