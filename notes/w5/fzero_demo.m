%
%  fzero_demo.m  -- djm -- 28 jan 2019
%

f = @(x) tan(x) - 1./x;

%  set the tolerance
opts = optimset('TolX',1e-12);
call1 = fzero(f,1,opts)

%  see some performance output
opts = optimset('TolX',1e-12,'Display','iter');
call2 = fzero(f,1,opts)

%  give it two initial values!!
call3 = fzero(f,[0.1 1],opts)