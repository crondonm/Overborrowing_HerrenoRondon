% Kalman Filter plus MLE to compute filtered series

clear all
clc

% Import Data

opts = spreadsheetImportOptions("NumVariables", 9);
% Specify sheet and rangedelta
opts.Sheet = "Data";
opts.DataRange = "A30:I145";
% Specify column names and types
opts.VariableNames = ["Year", "Agriculture", "Manufacturing", "Services", "Tradable", "SignalYT", "SignalYN", "Total", "Ratio"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];
filename = "Database.xlsx";

% Import the data
Data = readtable(filename, opts, "UseExcel", false);

%% Create variables

lnsignalYT = (Data.SignalYT) - mean(Data.SignalYT);
lnsignalYN = (Data.SignalYN) - mean(Data.SignalYN);
T = size(lnsignalYN,1);

% Fit a quadratic polynomial (order = 2) to the data
order = 2; 
t = 1:T;
%p = polyfit(t, lnsignalYT, order);
%quadratic_trend = polyval(p, t');    % Evaluate the fitted quadratic polynomial at the time points
%lnsignalYT = lnsignalYT - quadratic_trend; % Remove the quadratic trend from the time series
p = polyfit(t, lnsignalYN, order);
quadratic_trend = polyval(p, t');
lnsignalYN = lnsignalYN - quadratic_trend; % Remove the quadratic trend from the time series

lntotalY = (Data.Ratio);
num=10;
std_yt = num*std(lnsignalYT)^2;
std_yn = num*std(lnsignalYN)^2;
std_y = num*std(lntotalY)^2;
cov_yTN = num*cov(lnsignalYT', lnsignalYN');
grY = 100*1.01/100;

neg_LL = @(x) LL_klm(x, [lnsignalYT';lnsignalYN']);
opt_LL = @(x) LL_klm_opt(x, [lnsignalYT';lnsignalYN']);

lb   = [ -0.99; -0.99; -0.99;-0.99;  -0.99;  1e-6; -cov_yTN(1,2); 1e-6; 1e-6]';
ub  = [ 0.99;  0.99;  0.99;  0.99;  0.99;  std_yt; cov_yTN(1,2); std_yn;  std_y]';

x0 = lb;

%% Pattern Search + Simulated Annealing

rng(10,'twister') % for reproducibility

options = optimoptions('fmincon','Display','iter','MaxIterations', 6e4, 'MaxFunctionEvaluations', 10e10, 'HessianApproximation', 'bfgs', 'PlotFcn',{@optimplotfval,@optimplotx,@optimplotfirstorderopt});
[sol1, fval0,~,~,~,~,hess] = fmincon(neg_LL,x0,[],[],[],[],lb,ub,[],options);
options = optimoptions('simulannealbnd', 'InitialTemperature', 100, 'TemperatureFcn','temperaturefast', 'MaxFunctionEvaluations', 1e100, 'MaxIterations', 10e10);
[sol2, fval1] = simulannealbnd(neg_LL, sol1, lb, ub, options);
options = optimoptions('patternsearch','Display','iter','PlotFcn',{@psplotbestf, @psplotbestx}, 'MaxIterations', 6e4, 'MaxFunctionEvaluations', 10e10);
[sol3, fval2] = patternsearch(neg_LL, sol2, [],[],[],[],lb,ub, options);
options = optimoptions('fminunc','Display','iter','MaxIterations', 6e4, 'MaxFunctionEvaluations', 10e10, 'HessianApproximation', 'bfgs', 'PlotFcn',{@optimplotfval,@optimplotx,@optimplotfirstorderopt});
[xopt, fval3,~,~,~,hess2] = fminunc(neg_LL, sol3, options);

sqrt(diag(inv(hessiancsd(opt_LL,xopt))))


%


% % Print execution time on screen
%tic;
%execution_ time = toc;
% fprintf('Execution time: %f seconds\n', execution_time);
% 
% 
% delta = xopt;

% delta  = [0.734679129925539,-0.255320869154147,0.0336525070039930,0.417047371095781,0.496779121757470,0.00461817366335938,0.000379607811872954,0.00137117483970497,0.00327510105056510];
% Ahat = [delta(1,1)  delta(1,2) 0 0;
%             delta(1,3)  delta(1,4) 0 0;
%             0 0 delta(1, 5) 0;
%             1 0 0 0];
%  
% Chat = [delta(1,6)  delta(1,7) 0 0;
%             delta(1,7)  delta(1,8) 0 0;
%             0 0 delta(1,9) 0;
%             0 0 0 0];
% 
% muhat = log(1.01);
% 
% Dhat  = [1 0 1 -1;
%             0 1 1 -1];
%  
% Ehat = [0; 0; (1-delta(1,5))*log(1.01); 0];
% 
% H = [1 0 1 -1;
%         0 1 1 -1];
% 
% eig(Ahat)
% 
% %n_bootstrap = 2;
% [filtered_states, filtered_covariance, smooth_states, smooth_covariance] = kalman_filter_smoother(lnsignalYT, lnsignalYN, H, Ahat, Chat, Ehat, []);
% 
% %[bootstrap] = kalman_bootstrap(lnsignalYT, lnsignalYN, delta, n_bootstrap);
%  
% %% Other options
% 
% 
save('Calibration.mat', '-v7.3')
% 
% 
