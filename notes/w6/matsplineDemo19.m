%
%  mat_spline316Demo.m -- djm -- 05 feb 2019
%

Nmax = 100;
choice = 1;	%  1 = uniform, 2 = random

%  original function
ff = @(x) exp(x).*sin(7*pi*(x-0.05));
%ff = @(x) 1./(1+25*x.^2);

%  original function for plotting
xx = transpose(-1:0.005:1);
yy = ff(xx);

%  make random sample points
xp = [-1 ; 1 ; 2*rand(Nmax-2,1)-1];

switch choice
case{1}
	Nlist = [10:10:60];
case{2}
	Nlist = [10:10:60];
end
	
for nn = Nlist
	%  N+1 sample points
	switch choice
	case{1}
		xs = transpose([-1:2/nn:1]);
	case{2}
		xs = sort(xp(1:nn+1));
	end
	
	%  sample function values
	ys = ff(xs);
	
	% not-a-knot	
	pp1 = spline(xs,ys);
	yy1 = ppval(pp1,xx);

	%  plot original function & sample points
	figure(nn);  clf
	subplot(2,1,1)
	plot(xx,yy,'r');  hold on
	
	plot(xs,ys,'ko')
	plot(xs(1),ys(1),'k*')
	plot(xs(end),ys(end),'k*')

	plot(xx,yy1,'b');
	grid on
	
	title('not-a-knot (blue) & clamped (magenta)')
	xlabel('x-axis')
	ylabel('y-axis (original f in red)')
	
	subplot(2,1,2)
	plot(xx,yy1-yy,'b.');  hold on
	axis([-1 1 min(yy1-yy) max(yy1-yy)])
	grid on
	
	title('spline error = S(x)-f(x)','fontsize',14)
	xlabel('x-axis, showing all blue pts, some magenta off-plot!!!','fontsize',12)
	ylabel('error','fontsize',12)
	
	%  clamped at zero
	pp2 = spline(xs,[0 ; ys ; 0]);
	yy2 = ppval(pp2,xx);

	subplot(2,1,1)
	plot(xx,yy2,'m:');

	subplot(2,1,2)
	plot(xx,yy2-yy,'m.');
end

for nn = fliplr(Nlist)
	figure(nn)
end