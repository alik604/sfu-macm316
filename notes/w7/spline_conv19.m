%
%  spline_conv19.m -- djm -- 05 feb 2019
%

Nmax = 100;
choice = 1;	%  1 = uniform, 2 = random

%  original function
ff  = @(x) exp(x).*sin(7*pi*(x-0.05));
ffp = @(x) ff(x) + 7*pi*exp(x).*cos(7*pi*(x-0.05));
%ff = @(x) 1./(1+25*x.^2);

%  original function for plotting
xx = transpose(-1:0.005:1);
yy = ff(xx);

%  make random sample points
xp = [-1 ; 1 ; 2*rand(Nmax-2,1)-1];

switch choice
case{1}
	Nlist = [8 16 32 64 128 256 512 1024 2048 4096];
case{2}
	Nlist = [10:10:60];
end
	
Errlist = [];
	
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
	
	nKnot_err = max(abs(yy1-yy))
	
	%  clamped at zero
	pp2 = spline(xs,[ffp(-1) ; ys ; ffp(1)]);
	yy2 = ppval(pp2,xx);

	subplot(2,1,1)
	plot(xx,yy2,'m:');

	subplot(2,1,2)
	plot(xx,yy2-yy,'m.');
	
	clamp_err = max(abs(yy2-yy))
	
	Errlist = [Errlist ; log10(nn), nKnot_err, clamp_err];
end

for nn = fliplr(Nlist)
	figure(nn)
end

figure(8888);  clf
plot(Errlist(:,1),log10(Errlist(:,2)),'bo');  hold on
plot(Errlist(:,1),log10(Errlist(:,3)),'mx');
plot([1.5 3.5],[-2 -10],'k')

grid on

title('fourth-order convergence','fontsize',14)
xlabel('log_{10} N','fontsize',12)
ylabel('log_{10} max err (n-a-k = b;  clamp = m)','fontsize',12)