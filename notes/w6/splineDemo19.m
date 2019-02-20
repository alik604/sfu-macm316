%
%  spline316Demo.m -- djm -- 05 feb 2019
%

Nmax = 100;
choice = 1;	%  1 = uniform, 2 = random

%  original function
ff = @(x) exp(x).*sin(7*pi*(x-0.05));
%ff = @(x) 1./(1+25*x.^2);

%  original function for plotting
xx = transpose(-1:0.01:1);
yy = ff(xx);

%  make random sample points
xp = [-1 ; 1 ; 2*rand(Nmax-2,1)-1];

switch choice
case{1}
	Nlist = [8:8:32];
case{2}
	Nlist = [10:10:80];
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

	%  natural spline (Np polys)
	h = diff(xs);

	%  (a,b,c,d) coeffs
	Sa = ys(1:nn);

	%  build tri-diagonal matrix (Np-1 unknowns)
	Mtx = zeros(nn+1,nn+1);
	Mtx(2:end-1,1:end-2) = Mtx(2:end-1,1:end-2) +   diag(h(1:end-1),0); 
	Mtx(2:end-1,2:end-1) = Mtx(2:end-1,2:end-1) + 2*diag(h(1:end-1),0); 
	Mtx(2:end-1,2:end-1) = Mtx(2:end-1,2:end-1) + 2*diag(h(2:end  ),0); 
	Mtx(2:end-1,3:end  ) = Mtx(2:end-1,3:end  ) +   diag(h(2:end  ),0);
	Mtx(1,1) = 1;  Mtx(end,end) = 1;

	%  build right-side vector
	Bvec = zeros(nn+1,1);
	Bvec(2:end-1) = Bvec(2:end-1) + 3*(ys(3:end  )-ys(2:end-1))./h(2:end  );
	Bvec(2:end-1) = Bvec(2:end-1) - 3*(ys(2:end-1)-ys(1:end-2))./h(1:end-1);

	Mtx = sparse(Mtx);

	%  linear solve
	Cvec = Mtx \ Bvec;  

	%  coeffs
	Sc = Cvec(1:end-1);
	Sd = (diff(Cvec)./h)/3;
	Sb = (diff(ys)./h) - (h/3).*(Cvec(2:end)+2*Cvec(1:end-1));

	Coef = [xs(1:end-1), xs(2:end), Sd , Sc , Sb , Sa];

	%  plot original function & sample points
	figure(nn);  clf
	subplot(2,1,1)
	plot(xx,yy,'r');  hold on

	plot(xs,ys,'ko')
	plot(xs(1),ys(1),'k*')
	plot(xs(end),ys(end),'k*')
	
	title('natural cubic spline (green)')
	xlabel('x-axis')
	ylabel('y-axis (original f in red)')
	
	subplot(2,1,2);  hold on
	
	%  plot each interval of spline
	for jj = 1:nn
		xx1 = xx(find(xx >xs(jj)));
		yy1 = yy(find(xx >xs(jj)));
		xx2 = [xs(jj) ; xx1(find(xx1<xs(jj+1))) ; xs(jj+1)];
		yy2 = [ys(jj) ; yy1(find(xx1<xs(jj+1))) ; ys(jj+1)];
	
		cubic = polyval(Coef(jj,3:end),xx2-xs(jj));
	
		subplot(2,1,1)
		plot(xx2,cubic,'g')
		grid on
		
		subplot(2,1,2)
		plot(xx2,yy2-cubic,'b.')
		grid on
	end
end

for nn = fliplr(Nlist)
	figure(nn)
end