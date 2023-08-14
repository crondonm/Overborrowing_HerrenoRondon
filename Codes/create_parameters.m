%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Overborrowing and Systemic Externalities in the Business Cycle Under Imperfect Information
%
% In this code: 
%               1. Load parameters 
%               
% Authors:  Juan Herreño, jherrenolopera@ucsd.edu
%               Carlos Rondón Moreno, crondon@bcentral.cl
% Date: 16 December  2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Housekeeping

clearvars
clear global
close all

%% Parameters to control Simulation

fprintf("Starting to create parameters ... \n")

Param.nodes = 19;                  % Nodes state-space exogenous variables
Param.grid_points = 501;       % Grid for debt
Param.burn = 1000000;             % Burning period       
Param.Tsim = 1000000+Param.burn;  % Horizon of simulation

%% Parameters to control IRFs

Param.horizn    = 21;
Param.init_debt = floor(Param.grid_points/2);  % IRFs start must start at Steady State for Debt


%% Parameters to control degree of information

%Param.rho_g = 0.3636;           % Autocorrelation
%Param.sigmag = 0.0624;              % Std. dev. growth rate of permanent component 
%Param.g = log(1.0251);           %  Mean growth rate of permanent component

%Param.rho_g = 0.534044264596305;
%Param.sigmag = 0.00347681210932543;       
%Param.g = log(1.01);        %  Mean growth rate of permanent component

Param.rho_g = 0.496779121757470;
Param.sigmag = 0.00327510105056510;
Param.g = log(1.0131);        %  Mean growth rate of permanent component

%% Parameters for AR(1) of endowment
% ----> Mix of estimated parameters and Bianchi (2011)
%       A: Autocorrelation between T, N and G endowment last column means that

%Param.A  =  [ 0.3244 -0.0683     0; ...
%                   0.2610  0.6051     0; ...
%                    0       0     Param.rho_g ]; % Autocorrelation Matrix

% Autocorrelation Matrix

%Param.A  = [0.758853801845635,  -0.231146183896947, 0;
%                  0.0148890997214473, 0.508597605332998, 0;
%                  0, 0, 0.534044264596305];


Param.A  = [0.734679129925539,  -0.255320869154147 ,0;
                  0.0336525070039930, 0.417047371095781, 0;
                  0, 0, Param.rho_g];

%Param.Sigma = [ 0.00310298148143216   -0.000184623011507698   0; ...
%                       -0.000184623011507698  0.00542375328735066    0; ... 
%                           0                    0                    Param.sigmag^2] ; % Variance-Covariance Matrix

% Variance-Covariance Matrix

%Param.Sigma = [0.00473199052668207,0.000323570395270583,0;
%                        0.000323570395270583,0.00153907879687669,0;
%                        0,0,0.00347681210932543];

Param.Sigma = [0.00461817366335938, 0.000379607811872954, 0;
                        0.000379607811872954, 0.00137117483970497, 0;
                        0, 0, Param.sigmag];
        

%% Deep Parameters
% ----> Following Bianchi (2011)

Param.r = 0.04; % Annual Interest Rate
Param.rho = 2;    % Risk Aversion Coef
Param.beta = 0.83;
Param.omega = 0.31; % Weight of Tradables 
Param.eta   = 0.83; % Intratemporal Elasticity of Substitution
Param.kappa = 0.335;
Param.ytn = Param.nodes;  % Transitory Component of tradable endowment
Param.ynn = Param.nodes; % Transitory Component of Non-tradable endowment
Param.gn = Param.nodes;   % Permanent Component
Param.gTn = Param.nodes; % Growth Rate Tradable Output
Param.gNn = Param.nodes; % Growth Rate Nontradable Output

Param.bmin = -1.4 ;
Param.bmax = -0.2 ;
Param.bn = Param.grid_points;
Param.b = linspace(Param.bmin,Param.bmax,Param.bn) ;

%% ----> Other Parameters

Param.nstd = 1; % Number of standard deviations to consider Financial Crises
Param.window = 5; % Number of years around crises

%% Save

fprintf("Done \n")

save('Param.mat', '-v7.3')
