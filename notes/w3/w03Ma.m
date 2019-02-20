%
%  w03Ma.m -- limit example (djm -- 13 jan 2019)
%

%  two functions equivalent by trig identity
f1 = @(x) (1-cos(x))./(x.^2);
f2 = @(x) ((sin(x/2)./(x/2)).^2) / 2;

ex_list = (-1:-1:-10);
xx = 10.^(ex_list);

format short e

f_1 = f1(xx)

err1 = f1(xx)-(1/2)
err2 = f2(xx)-(1/2)

disp('why is f_2 exact at x = 1e-8?')

%  
figure(1);  clf
subplot(2,1,1)
plot(ex_list,abs(err1),'ro')
hold on
plot(ex_list,abs(err2),'bx')
grid on

%  plot labels
xlabel('log_{10} x','fontsize',12)
ylabel(['f_1(x) in red o & f_2(x) in blue x'],'fontsize',12)
title('error = |f_j(x) - (1/2)|','fontsize',14)

%  plot for solution error
subplot(2,1,2)
plot(ex_list,log10(abs(err1)),'ro')
hold on
plot(ex_list,log10(abs(err2)),'bx')
grid on

ylabel(['f_1(x) in red o & f_2(x) in blue x'],'fontsize',12)
xlabel('log_{10} x','fontsize',12)
title('log10(error) = log_{10} |f_j(x) - (1/2)|','fontsize',14)