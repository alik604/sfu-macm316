%
%  BiSsqrt.m --- BiS first example --- djm, 22 jan 2019
%	- includes bracketting to find sign-change interval
%

clear

tol = 1e-10;

%  assume 1 < a < 100
a = 12;  %  or try 4, 1.5^4, 0.1

disp(['what is the square root of ' num2str(a) '?'])

%  define f(x) with vectorized arithmetic
ff = @(x,a) x.^2-a;

%%%BEGIN:   this part does sqrt-specific bracketting

%  bracketting list
xlist = [1:1:10];
flist = ff(xlist,a);
sign_check = sign(flist)

%  check for any exact zeros!!
indX = find(sign_check==0);
if (isempty(indX)~=1)
	x_sqrt = xlist(indX);
	disp(['square root = ' num2str(x_sqrt) ' & err = ' num2str(flist(indX))])
	return
end

%  find sign-change interval
indX = find(diff(sign_check),1);
if (isempty(indX)==1)
	disp('no sign change')
	return
end

%%%END:   this part does sqrt-specific bracketting

%  0)  set sign-change interval
xL = xlist(indX  );  fL = ff(xL,a);
xR = xlist(indX+1);  fR = ff(xR,a);
Nevals = 2;

%  1)  compute first midpoint
figure(101);  clf;  hold on;  grid on
check = (xR-xL)/2;
plot(Nevals,log10(abs(check)),'rx')

fprintf('\t %d \t %16.15f \t %+6.5e \t %+16.15f \t %+6.5e \t %+6.5e \n', ...
		[Nevals, xL, fL, xR, fR, check])

xB  = xL + check;

%  root-finding loop
while (abs(check)>tol)
	%  2)  function evaluation
	fB = ff(xB,a);
	Nevals = Nevals + 1;
	
	%  3)  decision
	if (fB==0)
		xL = xB;  fL = fB;
		xR = xB;  fR = fB;
	else
		if (fL*fB>0)
			xL = xB;  fL = fB;
		else
			xR = xB;  fR = fB;
		end		
	end
	
	fprintf('\t %d \t %16.15f \t %+6.5e \t %+16.15f \t %+6.5e \t %+6.5e \n', ...
		[Nevals, xL, fL, xR, fR, check])

	%  4)  prepare next iteration
	check = (xR-xL)/2;
	plot(Nevals,log10(abs(check)),'kx')
	
	xB  = xL + check;
end

%  output & plot
disp('square root & error are:')
fprintf('\t %+16.15f \t %+16.15e \n',[xB, check])

title('BiSection method','fontsize',16)
ylabel('log_{10} check','fontsize',14)
xlabel('iteration','fontsize',14)