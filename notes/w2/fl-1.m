%
%  fl(x,p) -- floating-point truncation -- djm --- 10 jan 2019
%
%
function [out] = fl(x,p)

xs = sign(x);
y = abs(x);
if (y~=0)
	out = xs*round(10^(log10(y)-floor(log10(y)) + p-1)) * 10^(floor(log10(y))-(p-1));
else
	out = 0;
end

format long e