clear avErrors
[~, ~, raw] = xlsread('C:\Users\Chris\Documents\MATLAB\HELEN\HELEN SIM\errors.xls','Errors','A1:E10000');
errors = reshape([raw{:}],size(raw));
clearvars raw;
errors=rmmissing(errors);
errsx = errors(:,1);
errsy = errors(:,2);
errsz = errors(:,3);
errs = errors(:,4);
times = errors(:,5);
% step = 1;
% alpha = 0.1;
% 
% lastSmoothedValue = mean(errors(1:10));
% 
% 
% step = 2*step;
% for i = step:step:200
%     avErrors(i/step) = (alpha * mean(errors(i-(step-1):i))) + (1-alpha) * lastSmoothedValue;
%     lastSmoothedValue = avErrors(i/step);
% end
% 
% plot([step:step:200],avErrors);



[~,edges] = histcounts(log10(errs),30);
histogram(errs,10.^edges,'Normalization','probability')
set(gca, 'xscale','log')
xlabel("Positional Error (m)")
ylabel("Probability of Error")
title("Error Probability Density");


figure()
scatter(times,errs)
title("Scatter Plot of Timing Synchronization vs. Positional Error");
xlabel("Time Synchronization (s)")
ylabel("Positional Error (m)")
set(gca, 'xscale','log')
set(gca, 'yscale','log')
fprintf("Standard Deviation r: %f3.3\n",sqrt((sum(errs.^2))/(length(errs)-1)))
fprintf("Standard Deviation x: %f3.3\n",sqrt((sum(errsx.^2))/(length(errsx)-1)))
fprintf("Standard Deviation y: %f3.3\n",sqrt((sum(errsy.^2))/(length(errsy)-1)))
fprintf("Standard Deviation z: %f3.3\n",sqrt((sum(errsz.^2))/(length(errsz)-1)))