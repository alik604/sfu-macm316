%
%  lsq.m --- djm --- 10 feb 2019
%

%  column vector for xk
xk = (1:5)'
x0 = ones(size(xk));

%  column vector for yk
yk = 2*xk+floor(rand(size(xk))*5)

%  non-square matrix
A = [xk , x0]

%  backslash
c = A \ yk

%  make plot
figure(800);  clf
plot(xk,yk,'o');  hold on 
plot(xk,c(1)*xk+c(2),'b');  grid
xlabel('x_k axis');  ylabel('y_k axis')

%  check polyfit output
c_polyfit = polyfit(xk,yk,1)