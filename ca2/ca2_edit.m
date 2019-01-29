%
%  ca2_demo.m -- timing exercise (macm316, hl -- 13 jan 2019)
%
% Purpose:      This script serves as a demo for students to build on in
%               completing computing assignment 2. This script builds three types
%               of NxN matricies: dense, upper triangular, and permuted upper
%               triangular. It then performs a matrix solve with each, Nex number
%               of times. The time it takes for Nex number of solves is used to
%               estimate the time of one solve .  
%
% Instructions: Start by running the script once, and see the
%               output for the esimtated times. Note: the choice of Nex here may
%               not give accurate results for all three matrix types. Next, copy
%               and paste this code into your own Matlab
%               file. Follow the assignment sheet for further instructions to
%               complete your report. 

%  experimental parameters
N   = 10;
dense_Nex = 300000;
tri_Nex = 2000000;
perm_Nex = 1200000;

%  three matrix types

%  dense matrix (no zeros)
Md = randn(N,N); 

%  upper triangular
Mt = triu(Md); 

%  randomly row-exchanged upper triangular (these are tricky array commands, 
%  but if you run a small sample, it is clear they do the right thing)
idx=randperm(N); 
Mp = Mt(idx,:); 

%Tri-diagonal and sparse tri-diagonal
%M3 = diag(diag(Md))+diag(diag(Md,-1),-1)+diag(diag(Md,1),1);
%M3s=sparse(M3)

%  exact solution of all ones
x = ones(N,1);

%  right-side vectors
bd = Md*x;
bt = Mt*x;
bp = bt(idx);

%  dense test
tic 
for jj = 1:dense_Nex
    xd = Md\bd;
end
dense_time=toc

%  upper tri test
tic
for jj = 1:tri_Nex
    xt = Mt\bt;
end
tri_time=toc

% permuted upper tri test  
tic
for jj = 1:perm_Nex
    xp = Mp\bp;
end
perm_tri_time=toc

%Computing avgerage solve times
avg_dense_time = dense_time/(dense_Nex);

avg_tri_time = tri_time/(tri_Nex);

avg_perm_time = perm_tri_time/(perm_Nex);

% You may find the following code helpful for displaying the results 
% of this demo.
type_times = {'Dense',avg_dense_time,'Upper Triangular', ...
              avg_tri_time,'permuted Upper Triangular', ...
              avg_perm_time};
fprintf(' \n')
fprintf('Estimated time for a %s matrix is %f seconds. \n',type_times{:})