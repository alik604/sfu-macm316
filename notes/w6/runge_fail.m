%
%  runge_fail.m -- djm -- 29 jan 2019
%	- needs barylag.m

Nmax = 70;
choice = 1;	%  1 = uniform, 2 = random

%  original function
%ff = @(x) exp(x).*sin(7*pi*(x-0.05));
ff = @(x) 1./(1+25*x.^2);

%  original function for plotting
xx = transpose(-1:0.0005:1);
y = ff(xx);

%  make random sample points
xp = [-1 ; 1 ; 2*rand(Nmax-2,1)-1];

Nlist = [4:2:12]
for nn = Nlist
	%  sample points
	switch choice
	case{1}
		xr = transpose([-1:1/(nn-1):1]);
	case{2}
		xr = sort(xp(1:nn));
	end
	
	%  sample function values
	yr = ff(xr);

	%  vandermonde solve
	Mv = vander(xr);
	cond_num = cond(Mv)
	aj = Mv \ yr;
	yv = polyval(aj,xx);

	%  vandermonde interpolated values
	xi = xr(1):0.01:xr(end);
	yi = polyval(aj,xi);

	%  plot original function & sample points
	figure(nn);  clf
	subplot(2,1,1)
	plot(xx,y,'r');  hold on

	plot(xr,yr,'ko')
	plot(xr(1),yr(1),'k*')
	plot(xr(end),yr(end),'k*')
	
	title('lagrange polynomial (green)')
	xlabel('x-axis')
	ylabel('y-axis (original f in red, monomial in dots)')

%
%  lagrange basis part
%

	yy = barylag([xr,yr],xx);
	
	plot(xx,yy,'g')
	grid

	%  plot vandermonde interpolation
	%plot(xx,yv,'k:')
	axis([-1 1 min(y)-0.2 max(y)+0.2])
	
	subplot(2,1,2)
	plot(xx,yy-y,'b');  hold on
	plot(xr,0,'ko')
	grid
	
	title('error from original')
	xlabel('x-axis')
	ylabel('y-axis')
end

for nn = fliplr(Nlist)
	figure(nn)
end
