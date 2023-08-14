# Overborrowing and Systemic Externalities in the Business Cycle Under Imperfect Information*

This repository contains all the codes needed to replicate the results included in the paper.

## 1. System Requirements 

The results were estimated on the University of Notre Dame's computer cluster. When using the exact grid sizes as in our baseline calibration, the codes require approximately 1 TB of RAM to execute.

The codes are for MATLAB.

## 2. Instructions

To replicate the full set of results, run the file main_file.m. This file will create the parameter and transition structures needed to solve the model. 

### 2.1 create_parameters.m

This file contains all the parameters used for the model solution. It includes the calibration parameters and the constants used for simulations.

### 2.2 create_transition_matrix.m

This file discretizes the VAR process used for the calibration. 
The result is two .mat files. The first one is the matrix used for the full information model. The second one is used for the model with imperfect information. 

For this file, we use two ancillary files:

    -   tpm.m: Stephanie Smith-Grohé and Martín Uribe's routine to discretize VAR(1) processes.
    -   KF_transition_matrix.m: Adjusts the imperfect information transition matrix to reflect that   the agent only observes aggregate income and not its components.

### 2.3 estm_dctrlzd_eqp_imp_info.m

In this code, we use Policy Function iteration to solve the decentralized equilibrium model with imperfect information. The code also simulates de model, including the IRF-like series shown in the paper.

### 2.4 estm_planner_eqp_imp_info.m

In this code, we use Value Function iteration to solve the decentralized equilibrium model with imperfect information. The code also simulates de model, including the IRF-like series shown in the paper.

### 2.5 estm_dctrlzd_eqp_pfct_info.m

In this code, we use Policy Function iteration to solve the decentralized equilibrium model with perfect information. The code also simulates de model, including the IRF-like series shown in the paper.


### 2.6 estm_planner_eqp_pfct_info.m

In this code, we use Value Function iteration to solve the decentralized equilibrium model with perfect information. The code also simulates de model, including the IRF-like series shown in the paper.


### 2.7 simul_welf_costs.m

Once both models are solved and the .mat files containing the solution are created. This code simulates the welfare costs for both the perfect and imperfect information models. 

### 2.8 create_figures.m

Once all the previous steps are completed. This file uses the .mat files containing the results to produce all the figures included both in the paper and the appendix.

### 2.9 create_tables.m

Once all the previous steps are completed. This file uses the .mat files containing the results to produce all the tables included both in the paper and the appendix.

### Ancillary functions:

    -   findClosest2.m
    -   compute_irf_imp_info.m
    -   compute_irf_pfct_info.m


 
 
