%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Overborrowing and Systemic Externalities in the Business Cycle Under Imperfect Information
%
% In this code: Main File. 
%               1. Executes the codes needed to replicate the complete set of results.
%               
% Authors:  Juan Herreño, jherrenolopera@ucsd.edu
%               Carlos Rondón Moreno, crondon@bcentral.cl
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Housekeeping

clearvars
clear global
close all

%% Create Parameters and Transition Matrix...

run create_parameters.m
run create_transition_matrix.m

%% Solve the model ...

run estm_dcntrlzd_eqm_imp_info.m
run estm_planner_imp_info.m
run estm_dcntrlzd_eqm_pfct_info.m
run estm_planner_prfct_info.m

%% Simulate welfare costs...

run simul_welf_costs.m

%% Create figures and tables ...

run create_figures.m
run create_tables.m
