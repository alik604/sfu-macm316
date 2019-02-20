%
%  NMsqrt.m --- NM first example --- djm, 22 jan 2019
%

a = 3

nm = @(x,a) x - (x^2-a)/(2*x);

format long

%  start iteration
jj = 0;
y = 1.0;
err = y-sqrt(a);

fprintf('\t %d \t %16.15e \t %+16.15f \n',[jj, y, err])

while (abs(err)>1e-12)
	y = nm(y,a);
	err = y-sqrt(a);

	jj = jj+1;
	fprintf('\t %d \t %-16.15e \t %+16.15f \n',[jj, y, err])
end
