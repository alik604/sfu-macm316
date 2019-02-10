%
%  SMsqrt.m --- Secant Method first example --- djm, 22 jan 2019
%

clear

tol = 1e-10;  itmax = 30;

%  assume 1 < a < 100
a = 12;  %  or try 4, 1.5^4, 0.1

disp(['what is the square root of ' num2str(a) '?'])

%  define f(x) with vectorized arithmetic
ff = @(x,a) x.^2-a;

%  0)  set two initial guesses
x0 = 1  ;  f0 = ff(x0,a);
x1 = 100;
Nevals = 1;

figure(100);  clf;  hold on;  grid on
check = x1-x0;
plot(Nevals,log10(abs(check)),'rx')

%  root-finding loop
while (abs(check)>tol)
	if Nevals > itmax
		disp('no convergence')
		return
	end

	%  1)  function evaluation at x1
	f1 = ff(x1,a);
	Nevals = Nevals + 1;
	
	fprintf('\t %d \t %16.15f \t %+6.5e \t %+16.15f \t %+6.5e \t %+6.5e \n', ...
		[Nevals, x0, f0, x1, f1, check])
	
	%  2)  secant update
	xS = x1 - (f1 * (x1-x0)/(f1-f0));
	
	%  3)  prepare next iteration
	x0 = x1;  f0 = f1;
	x1 = xS;
	
	check = x1-x0;
	plot(Nevals,log10(abs(check)),'kx')
end

%  output & plot
disp('square root, last |dx| & residual error:')
fprintf('\t %+16.15f \t %+16.15e \t %+16.15e \n',[x1, check, ff(x1,a)])

title('Secant Method error','fontsize',16)
ylabel('log_{10} error','fontsize',14)
xlabel('iteration','fontsize',14)