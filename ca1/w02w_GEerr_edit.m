%
%  w02w_GEerr_edit.m -- GE truncation error (dhp -- 21 jan 2019)
%

C = 16;         %  C = growth of matrix size per loop;
nmax = 64;      %  nmax = max value of n for n*C
Nex = 10*100;  %  Nex = # of experiments

%  data vector of mean residual error for NxN sized matrices
mean_res_err = zeros(nmax,2);

for n = 1:nmax
    %  N = size of matrix A
    N = n*C
    
    %  solution of all ones
    x0 = ones(N,1);
    
    %  data vector of errors
    res_err = zeros(Nex,1);

    for kk = 1:Nex
        %  make random matrix & b-vector
        A = eye(N,N) + randn(N,N)/sqrt(N);
        b = A*x0;

        %  GE via backslash
        x1 = A \ b;
        
        %  rms residual error 
        res_err(kk) = rms(A*x1-b); 
    end
    
    %  mean_res_error for matrices sized NxN
    mean_res_err(n,1) = N;
    mean_res_err(n,2) = mean(res_err);
end


%  plot for mean residual error of NxN sized matrices
figure(1);  clf
subplot(1,1,1)
scatter(log10(mean_res_err(:,1)),log10(mean_res_err(:,2)))

xlabel('log_{10}N','fontsize',12)
ylabel(['mean ?_{res}(N) from ' num2str(Nex) ' experiments per N'])
title('log_{10}N vs. mean ?_{res}(N)','fontsize',14)


