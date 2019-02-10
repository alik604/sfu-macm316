%
%  CA4_bessel.m -- djm -- 03 feb 2019
%

%  matrix size (kP = # of zeros, mP-1 = max bessel index)
kP = 2;
mP = kP;

%  matrix for zeros
Amk = zeros(mP,kP);

% Count for function evals
Nevals=0;

% Convergence tolerance
tol=1e-6; 

%  define bessel function
bfunc = @(x,mm) besselj(mm,x);

%  fzero options - 2 versions
opt1 = optimset('TolX',tol,'Display','final');
opt2 = optimset('TolX',tol,'Display','iter');

%
% The following section shows how to find some roots using fzero 
% You can use this to create your all fzero code
%
mm = 0;

% Compute z_{0,1} using fzero - options version 1
ri = [2,3];    % Initial Bracket
[Amk(mm+1,1),err,exitflag,output] = fzero(@(x) bfunc(x,mm),ri,opt1);
output

% This tracks functions evals for fzero
Nevals = Nevals + output.funcCount; 

% Compute z_{0,2} using fzero - options version 2
ri = [5,6];    % Initial Bracket
[Amk(mm+1,2),err,exitflag,output] = fzero(@(x) bfunc(x,mm),[5,6],opt2);
Nevals = Nevals + output.funcCount; 

%
% The following section shows how to find some roots using Newton's method 
% You can use this section to create your all Newton's method code
%
mm = 1;

nm = @(x,m) x - besselj(m,x)/(0.5*(besselj(m-1,x)-besselj(m+1,x)));

%Initial guess for z_{1,1}
z11i = 3;
 
zn=z11i;
check=1; 
%Root finding loop
while abs(check) > tol
    Amk(mm+1,1) = nm(zn,mm);
    check = Amk(mm+1,1)-zn;
    
    % Here we track function evals for Newton
    Nevals = Nevals + 3; 
    
    zn = Amk(mm+1,1);
end


%Initial guess for z_{1,2}
z12i = 6;

Nevals=0; 
zn=z12i;
check=1; 
%Root finding loop
while abs(check) > tol
    Amk(mm+1,2) = nm(zn,mm);
    check = Amk(mm+1,2)-zn;
    
    % Here we track function evals for Newton
    Nevals = Nevals + 3; 
    
    zn = Amk(mm+1,2);
end

%
% Output 2x2 matrix and Nevals for checking
%
A22 = Amk(1:2,1:2)
Nevals

%  plot bessel function (useful for testing?)
figure(1000);  clf
xx = 0:0.05:8;
plot(xx,besselj(0,xx),'b');  hold on
plot(xx,besselj(1,xx),'m');
plot(A22,0*A22,'k*')
grid on
axis normal
title('J_0(x) in blue & J_1(x) in magenta --- non-zero roots in *')
xlabel('x-axis')
ylabel('J-axis')
