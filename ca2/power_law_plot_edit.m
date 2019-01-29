%
% power_law_plot.m (hl -- Jan. 2019)
%
% Purpose      : To highlight how the slope of a log-log plot can be
%                used to determine the leading order behaviour of a
%                power law relationship
%
% Instructions : Run the code as is, and check the output in the
%                command line. How does lo_exp compare to the best 
%                fit slope? experiment by changing lo_exp.
%

% Define x-values, chosen so that leading order beahviour 
% dominates. 
x = [10,100,1000]; 

% Leading order exponent
% Experiment by changing this value
lo_exp = [3,2,2]

% Our power law we wish to analyze 
avg_dense_time = [4*10^(-6), 1.68*10^(-4), 2.2462*10^(-2)]; 
avg_tri_time = [1*10^(-6), 6*10^(-6), 4.84*10^(-3)];
avg_perm_time = [1*10^(-6), 3.4*10^(-5), 4.550*10^(-3)];
y = [avg_dense_time; avg_tri_time; avg_perm_time];

% Compute log values
logx = log10(x); 
logy = log10(y);

ylabels = ["avg dense time"; "avg tri time"; "avg perm time"];
logylabels = ["log_{10}(avg dense time)", "log_{10}(avg tri time)", ...
                "log_{10}(avg perm time)"];

for k = 1:3
    % Best fit line to log data 
    p = polyfit(logx,logy(k,:),1);
    
    % Output
    % How does the slope of the best fit compare to lo_exp?
    display(['Leading order power law is : ',num2str(lo_exp(k))])
    display(['Slope of best fit line is  : ',num2str(p(1))])
    
    % Plotting 
    figure(k) 
    clf; hold on; 

    % Plot of raw data
    % Is it clear exactly what power law is being plotted? 
    subplot(1,2,1)
    plot(x,y(k,:),'b')
    grid on 
    xlabel('x')
    ylabel(ylabels(k))
    title(['Power law with l.o. exponent of ', ...
       num2str(lo_exp(k))])
   
    % Plot of log data 
    % It should be clear that this relationship is linear
    subplot(1,2,2)
    plot(logx,logy(k,:),'ro') 
    grid on 
    xlabel('log_{10}(x)')
    ylabel(logylabels(k))
    title(['Log-log plot, with slope ', num2str(p(1))])
end
