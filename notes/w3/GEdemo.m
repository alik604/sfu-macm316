%
%  GEdemo.m -- djm -- 16 jan 2012
%

%  matrix size 
N = 4;

%  random matrix and b-vector (no semi-colon sends to display)
aa = floor(4*randn(N,N))
bb = floor(2*randn(N,1))

%  matlab backslash solution
xx = aa\bb;

pp = input('partial pivoting? (y/n): ','s');

%  call GE demos from (http://web.cecs.pdx.edu/~gerry/nmm/mfiles/)
if (pp=='n')
	x = GEshow(aa,bb)
else
	x = GEPivShow(aa,bb,0)
end