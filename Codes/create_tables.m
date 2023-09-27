%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Overborrowing and Systemic Externalities in the Business Cycle Under Imperfect Information
%
% In this code: We create all the tables included in the paper                   
% 
% Authors:  Juan Herreño, jherrenolopera@ucsd.edu
%               Carlos Rondón Moreno, crondon@bcentral.cl
%
% Date: 16 December  2022
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping

clearvars
clear global
close all

% Load databases

load('Param.mat')
load('FICE.mat')
load('FIP.mat')
load('IIPCC.mat')
load('IICECC.mat')

%fice_rec = load('../Recalibration/FICE.mat');
%fip_rec = load('../Recalibration/FIP.mat');
%fice_rec = fice_rec.FICE;
%fip_rec = fip_rec.FIP;

% Deep parameters

r = Param.r;
eta = Param.eta;
rho = Param.rho;
beta = Param.beta;
kappa = Param.kappa;
omega = Param.omega;
burn = Param.burn;
g = Param.g;



 %% Tables

% Table 1: Calibration

FID = fopen('Tables/Table1.tex', 'w');
fprintf(FID, '\\begin{table}[h!] \n');
fprintf(FID, '\\centering \n');
fprintf(FID, '\\begin{threeparttable} \n');
fprintf(FID, '\\caption{Baseline Calibration} \n');
fprintf(FID, '\\begin{tabular}{cccc}\\hline \\hline \n');
fprintf(FID, '\\multicolumn{1}{c}{Parameter} & \\multicolumn{1}{c}{Description} & \\multicolumn{1}{c}{Value} &  \\multicolumn{1}{c}{Source/Target} \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\multicolumn{ 1}{c}{{r}}               & \\multicolumn{ 1}{c}{{Annual interest rate}}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\%% & \\multicolumn{ 1}{c}{{Standard}}  \\\\ \n', r*100); 
fprintf(FID, '\\multicolumn{ 1}{c}{{$\\sigma$}}  & \\multicolumn{ 1}{c}{{Inverse of intertemporal elast. of substitution}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & \\multicolumn{ 1}{c}{{Standard}}  \\\\ \n', rho);
fprintf(FID, '\\multicolumn{ 1}{c}{{$\\epsilon$}} & \\multicolumn{ 1}{c}{{Intratemporal elast. of subst}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}   & \\multicolumn{ 1}{c}{{\\cite{Bianchi2011}}} \\\\ \n',  eta);
fprintf(FID, '\\multicolumn{ 1}{c}{{$\\omega$}} & \\multicolumn{ 1}{c}{{Weight on tradables in CES aggregator}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\%%  & \\multicolumn{ 1}{c}{{Share of tradable output: 32 \\%% }} \\\\ \n', omega);
fprintf(FID, '\\multicolumn{ 1}{c}{{$\\beta$}}    & \\multicolumn{ 1}{c}{{Intertemporal discount factor}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\%%  & \\multicolumn{ 1}{c}{{Average NFA-to-GDP Ratio: -29 \\%%}} \\\\ \n', beta);
fprintf(FID, '\\multicolumn{ 1}{c}{{$\\kappa$}}  & \\multicolumn{ 1}{c}{{Collateral constraint factor}} & %8.4f  & \\multicolumn{ 1}{c}{{Frequency of financial crises: 5.5 \\%%}} \\\\ \n', kappa);
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\label{table:calibration} \n');
fprintf(FID, '\\end{threeparttable} \n');
fprintf(FID, '\\end{table}');
fclose(FID);

 % Table 2: Debt-to-GDP Ratios

 FID = fopen('Tables/Table2.tex', 'w');
fprintf(FID, '\\begin{table}[h!] \n');
fprintf(FID, '\\centering \n');
fprintf(FID, '\\begin{threeparttable} \n');
fprintf(FID, '\\caption{Debt-to-Output Ratios} \n');
fprintf(FID, '\\begin{tabular}{lccc}\\hline \\hline \n');
fprintf(FID, '& \\multicolumn{1}{c}{Perfect Information} & \\multicolumn{1}{c}{Imperfect Information} &  \\multicolumn{1}{c}{Information Effect} \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\multicolumn{ 1}{c}{{Competitive Equilibrium}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FICE.mDtoY*100, IICECC.mDtoY*100, 100*(IICECC.mDtoY - FICE.mDtoY));
fprintf(FID, '\\multicolumn{ 1}{c}{{Constrained Planner}}      & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FIP.mDtoY*100, IIPCC.mDtoY*100, 100*(IIPCC.mDtoY - FIP.mDtoY)); 
fprintf(FID, '\\multicolumn{ 1}{c}{{Externality Effect}}          & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}   & -  \\\\ \n'       , 100*(FICE.mDtoY - FIP.mDtoY) , 100*(IICECC.mDtoY - IIPCC.mDtoY));
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\label{table:debt_to_gdp_table} \n');
fprintf(FID, '\\begin{tablenotes} \n');
fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
fprintf(FID, '\\item Note: This table presents the average debt to output ratios for the four allocations we have considered. The third column is the difference between the first and second columns. In the same spirit, the third row presents the difference between the first and second rows. \n');
fprintf(FID, '\\end{tablenotes} \n');
fprintf(FID, '\\end{threeparttable} \n');
fprintf(FID, '\\end{table}');
fclose(FID);

% Table 3: Frequency of financial crises

FID = fopen('Tables/Table3.tex', 'w');
fprintf(FID, '\\begin{table}[h!] \n');
fprintf(FID, '\\centering \n');
fprintf(FID, '\\begin{threeparttable} \n');
fprintf(FID, '\\caption{Likelihood of Financial Crises} \n');
fprintf(FID, '\\begin{tabular}{lccc}\\hline \\hline \n');
fprintf(FID, '& \\multicolumn{1}{c}{Perfect Information} & \\multicolumn{1}{c}{Imperfect Information} &  \\multicolumn{1}{c}{Information Effect} \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\multicolumn{ 1}{c}{{Competitive Equilibrium}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FICE.Freq*100, IICECC.Freq*100, 100*(IICECC.Freq - FICE.Freq));
fprintf(FID, '\\multicolumn{ 1}{c}{{Constrained Planner}}      & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FIP.Freq*100, IIPCC.Freq*100, 100*(IIPCC.Freq - FIP.Freq)); 
fprintf(FID, '\\multicolumn{ 1}{c}{{Externality Effect}}          & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}   & -  \\\\ \n'       , 100*(FICE.Freq - FIP.Freq), 100*(IICECC.Freq - IIPCC.Freq));
fprintf(FID, ' &            &            &           \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\label{table:fin_crises_table} \n');
fprintf(FID, '\\begin{tablenotes} \n');
fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
fprintf(FID, '\\item Note: This table presents the frequency of financial crises per 100 years.  \n');
fprintf(FID, '\\end{tablenotes} \n');
fprintf(FID, '\\end{threeparttable} \n');
fprintf(FID, '\\end{table}');
fclose(FID);


%% Tables Recalibration:

% For this exercise, we recalibrate the decentralized
% equilibrium under perfect information to match debt-to-gdp and crisis
% frequency
% 
% % Table 4: Overborrowing: Recalibrated Economy
% 
% FID = fopen('../Codes/Tables/Table4.tex', 'w');
% fprintf(FID, '\\begin{table}[h!] \n');
% fprintf(FID, '\\centering \n');
% fprintf(FID, '\\begin{threeparttable} \n');
% fprintf(FID, '\\caption{Debt-to-Output Ratios} \n');
% fprintf(FID, '\\begin{tabular}{lcc|c}\\hline \\hline \n');
% fprintf(FID, '& \\multicolumn{1}{c}{Perfect Information} & \\multicolumn{1}{c}{Imperfect Information} &  \\multicolumn{1}{c}{Recalibrated} \\\\ \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, ' &            &            &           \\\\ \n');
% fprintf(FID, '\\multicolumn{ 1}{c}{{Competitive Equilibrium}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FICE.mDtoY*100, IICECC.mDtoY*100, 100*fice_rec.mDtoY);
% fprintf(FID, '\\multicolumn{ 1}{c}{{Constrained Planner}}      & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FIP.mDtoY*100, IIPCC.mDtoY*100, 100*fip_rec.mDtoY); 
% fprintf(FID, '\\multicolumn{ 1}{c}{{Overborrowing Level}}     & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', 100*(FICE.mDtoY - FIP.mDtoY), 100*(IICECC.mDtoY - IIPCC.mDtoY), 100*(fice_rec.mDtoY - fip_rec.mDtoY));
% fprintf(FID, ' &            &            &           \\\\ \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, '\\end{tabular}\n');
% fprintf(FID, '\\label{table:debt_to_gdp_recalibrated_table} \n');
% fprintf(FID, '\\begin{tablenotes} \n');
% fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
% fprintf(FID, '\\item Note: This table compares the debt-to-output ratios for the four baseline economies we have analyzed and an economy under perfect information recalibrated to match the same targets as our benchmark under imperfect information. The last row shows the overborrowing level, defined as the difference between the planner and the competitive economy borrowing level. \n');
% fprintf(FID, '\\end{tablenotes} \n');
% fprintf(FID, '\\end{threeparttable} \n');
% fprintf(FID, '\\end{table}');
% fclose(FID);
% 
% % Table 5: Frequency of Crises
% 
% FID = fopen('../Codes/Tables/Table5.tex', 'w');
% fprintf(FID, '\\begin{table}[h!] \n');
% fprintf(FID, '\\centering \n');
% fprintf(FID, '\\begin{threeparttable} \n');
% fprintf(FID, '\\caption{Likelihood of Financial Crises} \n');
% fprintf(FID, '\\begin{tabular}{lcc|c}\\hline \\hline \n');
% fprintf(FID, '& \\multicolumn{1}{c}{Perfect Information} & \\multicolumn{1}{c}{Imperfect Information} &  \\multicolumn{1}{c}{Recalibrated} \\\\ \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, ' &            &            &           \\\\ \n');
% fprintf(FID, '\\multicolumn{ 1}{c}{{Competitive Equilibrium}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FICE.Freq*100, IICECC.Freq*100, 100*(fice_rec.Freq));
% fprintf(FID, '\\multicolumn{ 1}{c}{{Constrained Planner}}      & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FIP.Freq*100, IIPCC.Freq*100, 100*(fip_rec.Freq)); 
% fprintf(FID, '\\multicolumn{ 1}{c}{{Externality Effect}}          & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', 100*(FICE.Freq - FIP.Freq), 100*(IICECC.Freq - IIPCC.Freq), 100*(fice_rec.Freq - fip_rec.Freq));
% fprintf(FID, ' &            &            &           \\\\ \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, '\\hline \n');
% fprintf(FID, '\\end{tabular}\n');
% fprintf(FID, '\\label{table:fin_crises_comparison_table} \n');
% fprintf(FID, '\\begin{tablenotes} \n');
% fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
% fprintf(FID, '\\item Note: This table presents the frequency of financial crises per 100 years.  \n');
% fprintf(FID, '\\end{tablenotes} \n');
% fprintf(FID, '\\end{threeparttable} \n');
% fprintf(FID, '\\end{table}');
% fclose(FID);


%% Welfare cost and optimal policy comparison

% Table 6: Welfare Costs and Optimal Tax Policy 

 
p = prctile(FIP.TAOSim, [0.1, 99.9]);
FI_TAOSim = FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2));
temp = find((FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)));

p = prctile(IIPCC.TAOSim, [0.1, 99.9]);
II_TAOSim = IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2));
temp1 = find(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2));

FID = fopen('Tables/Table6.tex', 'w');
fprintf(FID, '\\begin{table}[h!] \n');
fprintf(FID, '\\centering \n');
fprintf(FID, '\\begin{threeparttable} \n');
fprintf(FID, '\\caption{Likelihood of Financial Crises} \n');
fprintf(FID, '\\begin{tabular}{lcc}\\hline \\hline \n');
fprintf(FID, '& \\multicolumn{1}{c}{Welfare Cost} & \\multicolumn{1}{c}{Optimal Tax} \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, ' &            &  \\\\ \n');
fprintf(FID, '\\multicolumn{ 1}{c}{{Perfect Information}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', FICE.mWelfcost_fi, mean(FI_TAOSim)*100);
fprintf(FID, '\\multicolumn{ 1}{c}{{Imperfect Information}} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f}  \\\\ \n', IICECC.mWelfcost_ii, mean(II_TAOSim)*100); 
fprintf(FID, ' &            &  \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\label{table:welf_costs_table} \n');
fprintf(FID, '\\begin{tablenotes} \n');
fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
fprintf(FID, '\\item Note: YET TO WRITE  \n');
fprintf(FID, '\\end{tablenotes} \n');
fprintf(FID, '\\end{threeparttable} \n');
fprintf(FID, '\\end{table}');
fclose(FID);

%% Long-Run Moments

% Table 7: Long-Run Moments

Simyt = IICECC.Sim(burn:end, 1);
Simyn = IICECC.Sim(burn:end, 2);
Simg = IICECC.Sim(burn:end, 3);
PSim = IICECC.PSim;

IICECC.Ytot = ((exp(Simyt(3:end)'+Simg(3:end)'+g) + PSim.*exp(Simyn(3:end)'+Simg(3:end)'+g)))./exp(Simyt(2:end- 1)');
p = prctile(IICECC.CAtoY, [0.1, 99.9]);
IICECC.CAtoY = IICECC.CAtoY(IICECC.CAtoY >= p(1) & IICECC.CAtoY <= p(2));

Simyt = IIPCC.Sim(burn:end, 1);
Simyn = IIPCC.Sim(burn:end, 2);
Simg = IIPCC.Sim(burn:end, 3);
PSim = IIPCC.PSim;

IIPCC.Ytot = ((exp(Simyt(3:end)'+Simg(3:end)'+g) + PSim.*exp(Simyn(3:end)'+Simg(3:end)'+g)))./exp(Simyt(2:end- 1)');
Ytot_iip = IIPCC.Ytot(temp1);
p = prctile(IIPCC.CAtoY, [0.1, 99.9]);
IIPCC.CAtoY = IIPCC.CAtoY(IIPCC.CAtoY >= p(1) & IIPCC.CAtoY <= p(2));

Simyt = FICE.Sim(burn:end, 1);
Simyn = FICE.Sim(burn:end, 2);
Simg = FICE.Sim(burn:end, 3);
PSim = FICE.PSim;

FICE.Ytot = ((exp(Simyt(2:end)'+Simg(2:end)'+g) + PSim.*exp(Simyn(2:end)'+Simg(2:end)'+g)))./exp(Simyt(1:end- 1)');
p = prctile(FICE.CAtoY, [0.1, 99.9]);
FICE.CAtoY = FICE.CAtoY(FICE.CAtoY >= p(1) & FICE.CAtoY <= p(2));

p = prctile(FICE.CtoY, [0.1, 99.9]);
FICE_CSim = FICE.CtoY(FICE.CtoY >= p(1) & FICE.CtoY <= p(2));
p = prctile(FIP.CtoY, [0.1, 99.9]);
FIP_CSim = FIP.CtoY(FIP.CtoY >= p(1) & FIP.CtoY <= p(2));
p = prctile(IIPCC.CtoY, [0.1, 99.9]);
IIP_CSim = IIPCC.CtoY(IIPCC.CtoY >= p(1) & IIPCC.CtoY <= p(2));
p = prctile(IICECC.CtoY, [0.1, 99.9]);
IICE_CSim = IICECC.CtoY(IICECC.CtoY >= p(1) & IICECC.CtoY <= p(2));

Simyt = FIP.Sim(burn:end, 1);
Simyn = FIP.Sim(burn:end, 2);
Simg = FIP.Sim(burn:end, 3);
PSim = FIP.PSim;

FIP.Ytot = ((exp(Simyt(2:end)'+Simg(2:end)'+g) + PSim.*exp(Simyn(2:end)'+Simg(2:end)'+g)))./exp(Simyt(1:end- 1)');
Ytot_fip = FIP.Ytot(temp);
p = prctile(FIP.CAtoY, [0.1, 99.9]);
FIP.CAtoY = FIP.CAtoY(FIP.CAtoY >= p(1) & FIP.CAtoY <= p(2));


p = prctile(FIP.CA, [0.1, 99.9]);
FIP_CA = FIP.CA(FIP.CA >= p(1) & FIP.CA <= p(2));
temp = find((FIP.CA>=p(1) & FIP.CA<=p(2)));
Ytot_fipca = FIP.Ytot(temp);

p = prctile(FICE.CA, [0.1, 99.9]);
FICE_CA = FICE.CA(FICE.CA >= p(1) & FICE.CA <= p(2));
temp = find((FICE.CA>=p(1) & FICE.CA<=p(2)));
Ytot_FICEca = FICE.Ytot(temp);

p = prctile(IIPCC.CA, [0.1, 99.9]);
IIPCC_CA = IIPCC.CA(IIPCC.CA >= p(1) & IIPCC.CA <= p(2));
temp = find((IIPCC.CA>=p(1) & IIPCC.CA<=p(2)));
Ytot_IIPCCca = IIPCC.Ytot(temp);

p = prctile(IICECC.CA, [0.1, 99.9]);
IICECC_CA = IICECC.CA(IICECC.CA >= p(1) & IICECC.CA <= p(2));
temp = find((IICECC.CA>=p(1) & IICECC.CA<=p(2)));
Ytot_IICECCca = IICECC.Ytot(temp);

FIPrec = load("../Recalibration/FIP.mat");
FICErec = load("../Recalibration/FICE.mat");


p = prctile(FIPrec.FIP.TAOSim, [0.1, 99.9]);
FIrec_TAOSim = FIPrec.FIP.TAOSim(FIPrec.FIP.TAOSim>=p(1) & FIPrec.FIP.TAOSim<=p(2));
temp = find((FIPrec.FIP.TAOSim>=p(1) & FIPrec.FIP.TAOSim<=p(2)));

Simyt = FIPrec.FIP.Sim(burn:end, 1);
Simyn = FIPrec.FIP.Sim(burn:end, 2);
Simg = FIPrec.FIP.Sim(burn:end, 3);
PSim = FIPrec.FIP.PSim;

FIPrec.FIP.Ytot = ((exp(Simyt(2:end)'+Simg(2:end)'+g) + PSim.*exp(Simyn(2:end)'+Simg(2:end)'+g)))./exp(Simyt(1:end- 1)');
Ytot_fiprec = FIPrec.FIP.Ytot(temp);

p = prctile(FICErec.FICE.CtoY, [0.1, 99.9]);
FICErec_CSim = FICErec.FICE.CtoY(FICErec.FICE.CtoY >= p(1) & FICErec.FICE.CtoY <= p(2));

p = prctile(FIPrec.FIP.CtoY, [0.1, 99.9]);
FIPrec_CSim = FIPrec.FIP.CtoY(FIPrec.FIP.CtoY >= p(1) & FIPrec.FIP.CtoY <= p(2));

Simyt = FICErec.FICE.Sim(burn:end, 1);
Simyn = FICErec.FICE.Sim(burn:end, 2);
Simg = FICErec.FICE.Sim(burn:end, 3);
PSim = FICErec.FICE.PSim;

FICErec.FICE.Ytot = ((exp(Simyt(2:end)'+Simg(2:end)'+g) + PSim.*exp(Simyn(2:end)'+Simg(2:end)'+g)))./exp(Simyt(1:end- 1)');

p = prctile(FICErec.FICE.CA, [0.1, 99.9]);
FICErec_CA = FICErec.FICE.CA(FICErec.FICE.CA >= p(1) & FICErec.FICE.CA <= p(2));
temp = find((FICErec.FICE.CA>=p(1) & FICErec.FICE.CA<=p(2)));
Ytot_FICEca = FICErec.FICE.Ytot(temp);

p = prctile(FIPrec.FIP.CA, [0.1, 99.9]);
FIPrec_CA = FIPrec.FIP.CA(FIPrec.FIP.CA >= p(1) & FIPrec.FIP.CA <= p(2));
temp = find((FIPrec.FIP.CA>=p(1) & FIPrec.FIP.CA<=p(2)));
Ytot_FIPca = FIPrec.FIP.Ytot(temp);


p = prctile(FIPrec.FIP.CAtoY, [0.1, 99.9]);
FIPrec.FIP.CAtoY = FIPrec.FIP.CAtoY(FIPrec.FIP.CAtoY >= p(1) & FIPrec.FIP.CAtoY <= p(2));
p = prctile(FICErec.FICE.CAtoY, [0.1, 99.9]);
FICErec.FICE.CAtoY = FICErec.FICE.CAtoY(FICErec.FICE.CAtoY >= p(1) & FICErec.FICE.CAtoY <= p(2));




FID = fopen('Tables/Table7.tex', 'w');
fprintf(FID, '\\begin{table}[h!] \n');
fprintf(FID, '\\centering \n');
fprintf(FID, '\\begin{threeparttable} \n');
fprintf(FID, '\\caption{Likelihood of Financial Crises} \n');
fprintf(FID, '\\begin{tabular}{lll} \\hline \\hline \n');
fprintf(FID, '\\multicolumn{3}{c}{Baseline Model} \\\\ \n');
fprintf(FID, '\\hline \n');
fprintf(FID, '& Perfect Information  & Imperfect Information \\\\ \n');
fprintf(FID, '$E\\left[B/Y\\right] (\\%%)$  &  & \\\\ \n'); %#ok<*CTPCT> 
fprintf(FID, '\\multicolumn{1}{r}{Social Planner}        & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', FIP.mDtoY*100, IIPCC.mDtoY*100);
fprintf(FID, '\\multicolumn{1}{r}{Decentralized Economy} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', FICE.mDtoY*100, IICECC.mDtoY*100);
fprintf(FID, 'Frecuency of Crises (\\%%)  &  & \\\\ \n');
fprintf(FID, '\\multicolumn{1}{r}{Social Planner}        & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', FIP.Freq*100, IIPCC.Freq*100);
fprintf(FID, '\\multicolumn{1}{r}{Decentralized Economy} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', FICE.Freq*100, IICECC.Freq*100);
fprintf(FID, '\\hline \n');
fprintf(FID, '$\\sigma(C)$ &  & \\\\ \n');
fprintf(FID, '\\multicolumn{1}{r}{Social Planner}        & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', std(FIP.CtoY), std(IIPCC.CtoY));
fprintf(FID, '\\multicolumn{1}{r}{Decentralized Economy} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', std(FICE.CSim), std(IICECC.CSim));
fprintf(FID, '$\\rho(CA,\\, y)$ &  & \\\\ \n');
fprintf(FID, '\\multicolumn{1}{r}{Social Planner}        & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', corr(FIP.CA', FIP.Ytot'), corr(FICE.CA', FICE.Ytot'));
fprintf(FID, '\\multicolumn{1}{r}{Decentralized Economy} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', corr(IIPCC.CA', IIPCC.Ytot'), corr(IICECC.CA', IICECC.Ytot'));
fprintf(FID, '$\\sigma(CA/Y) (\\%%)$ &  & \\\\ \n');
fprintf(FID, '\\multicolumn{1}{r}{Social Planner}        & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', std(FIP.CAtoY)*100, std(IIPCC.CAtoY)*100);
fprintf(FID, '\\multicolumn{1}{r}{Decentralized Economy} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', std(FICE.CAtoY)*100, std(IICECC.CAtoY)*100);
fprintf(FID, '\\hline \n');
fprintf(FID, 'Welfare Costs                               & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', FICE.mWelfcost_fi, IICECC.mWelfcost_ii);
fprintf(FID, '$E\\left[\\tau\\right]$                  & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', mean(FI_TAOSim)*100, mean(II_TAOSim)*100);
fprintf(FID, '$\\rho(\\tau,\\, y)$                      & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} & {\\fontsize{10pt}{10pt}\\selectfont  %8.2f} \\\\ \n', corr(FI_TAOSim', Ytot_fip'), corr(II_TAOSim', Ytot_iip'));
fprintf(FID, '\\hline \n');
fprintf(FID, '\\end{tabular}  \n');
fprintf(FID, '\\label{table:summary_table} \n');
fprintf(FID, '\\begin{tablenotes} \n');
fprintf(FID, '\\footnotesize \\baselineskip=14pt \n');
fprintf(FID, '\\item Note: ADD NOTES\n');
fprintf(FID, '\\end{tablenotes} \n');
fprintf(FID, '\\end{threeparttable} \n');
fprintf(FID, '\\end{table}');
fclose(FID);

%% Welfare comparisons across regimes:


% Open a .tex file for writing
fid = fopen('Tables/Table8.tex', 'w');

% Define the table data as variables (replace with actual data)
val1 = NaN;  % Replace '-' with the actual value
val2 = NaN;  % Replace ' ' with the actual value

% Write the table header
fprintf(fid, '\\begin{table}[]\n');
fprintf(fid, '\\centering\n');
fprintf(fid, '\\caption{Welfare Cost (Gain) From Moving Across Regimes}\n');
fprintf(fid, '\\label{tab:welf_implic}\n');
fprintf(fid, '\\begin{tabular}{@{}lcccc@{}}\n');
fprintf(fid, '\\toprule\n');

% Write the column headers
fprintf(fid, '& \\multicolumn{2}{c}{\\begin{tabular}[c]{@{}c@{}}Perfect\\\\ Information\\end{tabular}} & \\multicolumn{2}{c}{\\begin{tabular}[c]{@{}c@{}}Imperfect\\\\ Information\\end{tabular}} \\\\ \\cmidrule(l){2-5}\n');
fprintf(fid, '& \\begin{tabular}[c]{@{}c@{}}Constrained \\\\ Planner\\end{tabular} & \\begin{tabular}[c]{@{}c@{}}Decentralized\\\\ Economy\\end{tabular} & \\begin{tabular}[c]{@{}c@{}}Constrained\\\\ Planner\\end{tabular} & \\begin{tabular}[c]{@{}c@{}}Decentralized\\\\ Economy\\end{tabular} \\\\\n');
fprintf(fid, '\\midrule\n');

% Write each line of the table using fprintf with the variables
fprintf(fid, '\\multicolumn{1}{c}{\\begin{tabular}[c]{@{}c@{}}Informed\\\\ Constrained Planner\\end{tabular}} & - & %8.2f & %8.2f & %8.2f \\\\\n', FICE.mWelfcost_fi, IIPCC.mWelfcost_pp, IICECC.mWelfcost_crossiicevsfip);
fprintf(fid, '\\begin{tabular}[c]{@{}c@{}}Informed\\\\ Decentralized Economy\\end{tabular} &  &  & %8.2f & %8.2f \\\\\n', -FICE.mWelfcost_crossiipsfice, IICECC.mWelfcost_ce);
fprintf(fid, '\\multicolumn{1}{c}{\\begin{tabular}[c]{@{}c@{}} Uninformed\\\\ Constrained Planner\\end{tabular}} &  &  &  & %8.2f \\\\\n', IICECC.mWelfcost_ii);

% Write the table footer
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');
fprintf(fid, '\\end{table}\n');

% Close the .tex file
fclose(fid);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Sensitivity Analysis
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping
clc
clearvars -except FICE FIP IICECC IIPCC Param
clear global
close all

% Baseline 

omega = Param.omega;
eta = Param.eta;

% IICECC
rer_base_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_base_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_base_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_base_iice = IICECC.mWelfcost_ii;
freq_base_iice = IICECC.Freq*100;
dtoy_base_iice = IICECC.mDtoY*100;

% IIPCC
rer_base_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_base_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_base_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_base_iip = IIPCC.Freq*100;
dtoy_base_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_base_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_base_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_base_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_base_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_base_fice = FICE.mWelfcost_fi;
freq_base_fice = FICE.Freq*100;
dtoy_base_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [.1, 99.9]);  
tau_base_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_base_fip = FIP.Freq*100;
dtoy_base_fip = FIP.mDtoY*100;
rer_base_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_base_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_base_fip = max((FIP.Cycles.IRCAtoYMean))*100;
clear p FICE FIP IICECC IIPCC 

%%  %%%%%%%%%%%%%
% Recalibration


cd '/Users/crondon/Library/CloudStorage/OneDrive-Personal/GitHub/Overborrowing_Imperfect_Info/Recalibration/'

load('FIP.mat', 'FIP')
load('FICE.mat', 'FICE')

% FICE
rer_reca_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_reca_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_reca_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_reca_fice = FICE.mWelfcost_fi;
freq_reca_fice = FICE.Freq*100;
dtoy_reca_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [.1, 99.9]);  
tau_reca_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_reca_fip = FIP.Freq*100;
dtoy_reca_fip = FIP.mDtoY*100;
rer_reca_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_reca_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_reca_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear p FICE FIP 


%%  %%%%%%%%%%%%%
% Beta = .90

cd '/Users/crondon/Library/CloudStorage/OneDrive-Personal/GitHub/Overborrowing_Imperfect_Info/Sensitivity Analysis/'

% Load databases

load('B90/IICECC.mat', 'IICECC')
load('B90/IIPCC.mat', 'IIPCC')
load('B90/FIP.mat', 'FIP')
load('B90/FICE.mat', 'FICE')

% IICECC
rer_b90_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_b90_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_b90_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_b90_iice = IICECC.mWelfcost_ii;
freq_b90_iice = IICECC.Freq*100;
dtoy_b90_iice = IICECC.mDtoY*100;

% IIPCC
rer_b90_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_b90_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_b90_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_b90_iip = IIPCC.Freq*100;
dtoy_b90_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_b90_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_b90_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_b90_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_b90_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_b90_fice = FICE.mWelfcost_fi;
freq_b90_fice = FICE.Freq*100;
dtoy_b90_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [0.1, 99.9]);  
tau_b90_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_b90_fip = FIP.Freq*100;
dtoy_b90_fip = FIP.mDtoY*100;
rer_b90_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_b90_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_b90_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear IICECC IIPCC FICE FIP


%%  %%%%%%%%%%%%%
% Rho_g low

load('rho_low/IICECC.mat', 'IICECC')
load('rho_low/IIPCC.mat', 'IIPCC')
load('rho_low/FIP.mat', 'FIP')
load('rho_low/FICE.mat', 'FICE')

% IICECC
rer_rlow_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rlow_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_rlow_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_rlow_iice = IICECC.mWelfcost_ii;
freq_rlow_iice = IICECC.Freq*100;
dtoy_rlow_iice = IICECC.mDtoY*100;

% IIPCC
rer_rlow_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rlow_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_rlow_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_rlow_iip = IIPCC.Freq*100;
dtoy_rlow_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_rlow_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_rlow_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rlow_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_rlow_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_rlow_fice = FICE.mWelfcost_fi;
freq_rlow_fice = FICE.Freq*100;
dtoy_rlow_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [0.1, 99.9]);  
tau_rlow_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_rlow_fip = FIP.Freq*100;
dtoy_rlow_fip = FIP.mDtoY*100;
rer_rlow_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rlow_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_rlow_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear IICECC IIPCC FICE FIP

%%  %%%%%%%%%%%%%
% Rho_g high

load('rho_high/IICECC.mat', 'IICECC')
load('rho_high/IIPCC.mat', 'IIPCC')
load('rho_high/FIP.mat', 'FIP')
load('rho_high/FICE.mat', 'FICE')

% IICECC
rer_rhigh_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rhigh_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_rhigh_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_rhigh_iice = IICECC.mWelfcost_ii;
freq_rhigh_iice = IICECC.Freq*100;
dtoy_rhigh_iice = IICECC.mDtoY*100;

% IIPCC
rer_rhigh_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rhigh_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_rhigh_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_rhigh_iip = IIPCC.Freq*100;
dtoy_rhigh_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_rhigh_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_rhigh_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rhigh_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_rhigh_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_rhigh_fice = FICE.mWelfcost_fi;
freq_rhigh_fice = FICE.Freq*100;
dtoy_rhigh_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [0.1, 99.9]);  
tau_rhigh_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_rhigh_fip = FIP.Freq*100;
dtoy_rhigh_fip = FIP.mDtoY*100;
rer_rhigh_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_rhigh_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_rhigh_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear IICECC IIPCC FICE FIP

%%  %%%%%%%%%%%%%
% Sigma_g low

load('sigma_low/IICECC.mat', 'IICECC')
load('sigma_low/IIPCC.mat', 'IIPCC')
load('sigma_low/FIP.mat', 'FIP')
load('sigma_low/FICE.mat', 'FICE')

% IICECC
rer_slow_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_slow_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_slow_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_slow_iice = IICECC.mWelfcost_ii;
freq_slow_iice = IICECC.Freq*100;
dtoy_slow_iice = IICECC.mDtoY*100;

% IIPCC
rer_slow_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_slow_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_slow_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_slow_iip = IIPCC.Freq*100;
dtoy_slow_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_slow_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_slow_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_slow_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_slow_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_slow_fice = FICE.mWelfcost_fi;
freq_slow_fice = FICE.Freq*100;
dtoy_slow_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [0.1, 99.9]);  
tau_slow_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_slow_fip = FIP.Freq*100;
dtoy_slow_fip = FIP.mDtoY*100;
rer_slow_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_slow_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_slow_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear IICECC IIPCC FICE FIP

%%  %%%%%%%%%%%%%
% Sigma_g low

load('sigma_high/IICECC.mat', 'IICECC')
load('sigma_high/IIPCC.mat', 'IIPCC')
load('sigma_high/FIP.mat', 'FIP')
load('sigma_high/FICE.mat', 'FICE')

% IICECC
rer_shigh_iice = 100*max(((omega^eta + (1 - omega)^eta*(IICECC.Cycles.IRPMean+IICECC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IICECC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_shigh_iice = min((IICECC.Cycles.IRCMean/mean(IICECC.CSim)-1)*100);
ca_shigh_iice = max((IICECC.Cycles.IRCAtoYMean + IICECC.mCAtoY))*100;
welf_shigh_iice = IICECC.mWelfcost_ii;
freq_shigh_iice = IICECC.Freq*100;
dtoy_shigh_iice = IICECC.mDtoY*100;

% IIPCC
rer_shigh_iip = 100*max(((omega^eta + (1 - omega)^eta*(IIPCC.Cycles.IRPMean+IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(IIPCC.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_shigh_iip = min((IIPCC.Cycles.IRCMean/mean(IIPCC.CSim)-1)*100);
ca_shigh_iip = max((IIPCC.Cycles.IRCAtoYMean + IIPCC.mCAtoY))*100;
freq_shigh_iip = IIPCC.Freq*100;
dtoy_shigh_iip = IIPCC.mDtoY*100;
p = prctile(IIPCC.TAOSim, [0.1, 99.9]);  
tau_shigh_iip = mean(IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2)))*100;
clear p 

% FICE
rer_shigh_fice = 100*max(((omega^eta + (1 - omega)^eta*(FICE.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FICE.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_shigh_fice = min((FICE.Cycles.IRCMean/mean(FICE.CSim)-1)*100);
ca_shigh_fice = max((FICE.Cycles.IRCAtoYMean))*100;
welf_shigh_fice = FICE.mWelfcost_fi;
freq_shigh_fice = FICE.Freq*100;
dtoy_shigh_fice = FICE.mDtoY*100;

% FIP
p = prctile(FIP.TAOSim, [0.1, 99.9]);  
tau_shigh_fip = mean(FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2)))*100;
freq_shigh_fip = FIP.Freq*100;
dtoy_shigh_fip = FIP.mDtoY*100;
rer_shigh_fip = 100*max(((omega^eta + (1 - omega)^eta*(FIP.Cycles.IRPMean).^(1 - eta)).^(-1/(1-eta)))./((omega^eta + (1 - omega)^eta*(FIP.mP).^(1 - eta)).^(-1/(1-eta)))-1);
c_shigh_fip = min((FIP.Cycles.IRCMean/mean(FIP.CSim)-1)*100);
ca_shigh_fip = max((FIP.Cycles.IRCAtoYMean))*100;

clear IICECC IIPCC FICE FIP


%% Table 

cd '/Users/crondon/Library/CloudStorage/OneDrive-Personal/GitHub/Overborrowing_Imperfect_Info/Codes/'



filename = 'Tables/Table9.tex';
% Open the file for writing
fileID = fopen(filename, 'w');
% Print the table rows using fprintf
fprintf(fileID, '\\begin{landscape}\n');
fprintf(fileID, '\\begin{table}[]\n');
fprintf(fileID, '\\centering\n');
fprintf(fileID, '\\begin{adjustbox}{max width=1.5\\textwidth} \n');
fprintf(fileID, '\\begin{threeparttable} \n');
fprintf(fileID, '\\caption{Sensitivity Analysis}\n');
fprintf(fileID, '\\label{tab:senstable}\n');
fprintf(fileID, '\\begin{tabular}{@{}lccccccccccccccccccccccccccccc@{}}\n');
fprintf(fileID, '\\toprule \n');
fprintf(fileID, '\\toprule \n');
fprintf(fileID, ' &  &  &  &  &  &  &  &  &  &  &  &  &  &  &  &  &  & \\multicolumn{12}{c}{\\textit{Severity of Financial Crises}} \\\\ \\cmidrule(l){19-30} \n');
fprintf(fileID, ' &  &  &  &  &  &  &  & \\multicolumn{4}{c}{\\textit{\\begin{tabular}[c]{@{}c@{}}Debt-to-Output\\\\ Ratio\\end{tabular}}} &  & \\multicolumn{4}{c}{\\textit{Probability of Crises}} &  & \\multicolumn{4}{c}{\\textit{Consumption}} & \\multicolumn{4}{c}{\\textit{RER}} & \\multicolumn{4}{c}{\\textit{Current Account}} \\\\ \\cmidrule(lr){9-12} \\cmidrule(lr){14-17} \\cmidrule(l){19-30} \n');
fprintf(fileID, ' &  & \\multicolumn{2}{c}{\\textit{\\begin{tabular}[c]{@{}c@{}}Welfare\\\\ Costs\\end{tabular}}} &  & \\multicolumn{2}{c}{\\textit{\\begin{tabular}[c]{@{}c@{}}Tax\\\\ on Debt\\end{tabular}}} &  & \\multicolumn{2}{c}{\\textit{Perf. Info}} & \\multicolumn{2}{c}{\\textit{Imp. Info}} &  & \\multicolumn{2}{c}{\\textit{Perf. Info}} & \\multicolumn{2}{c}{\\textit{Imp. Info}} &  & \\multicolumn{2}{c}{\\textit{Perf. Info}} & \\multicolumn{2}{c}{\\textit{Imp. Info}} & \\multicolumn{2}{c}{\\textit{Perf. Info}} & \\multicolumn{2}{c}{\\textit{Imp. Info}} & \\multicolumn{2}{c}{\\textit{Perf. Info}} & \\multicolumn{2}{c}{\\textit{Imp. Info}} \\\\ \\cmidrule(lr){3-4} \\cmidrule(lr){6-7} \\cmidrule(lr){9-12} \\cmidrule(lr){14-17} \\cmidrule(l){19-30} \n');
fprintf(fileID, ' &  & \\textit{Perf. Info} & \\textit{Imp. Info} &  & \\textit{Perf. Info} & \\textit{Imp. Info} &  & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} &  & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} &  & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} & \\textit{D.E} & \\textit{S.P} \\\\ \\midrule\n');
% Fill the column values with placeholder %8.2f starting from "Baseline"
fprintf(fileID, '\\textit{Baseline $(\\beta = 0.83,\\ \\kappa = 0.335)$}  &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f \\\\\n', welf_base_fice, welf_base_iice, tau_base_fip, tau_base_iip, dtoy_base_fice, dtoy_base_fip, dtoy_base_iice, dtoy_base_iip, freq_base_fice, freq_base_fip, freq_base_iice, freq_base_iip, c_base_fice, c_base_fip, c_base_iice, c_base_iip, rer_base_fice, rer_base_fip, rer_base_iice, rer_base_iip, ca_base_fice, ca_base_fip, ca_base_iice, ca_base_iip);
fprintf(fileID, '\\textit{$\\beta = 0.90, \\ \\kappa = 0.335$}           &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f \\\\ \\midrule \n', welf_b90_fice, welf_b90_iice, tau_b90_fip, tau_b90_iip, dtoy_b90_fice, dtoy_b90_fip, dtoy_b90_iice, dtoy_b90_iip, freq_b90_fice, freq_b90_fip, freq_b90_iice, freq_b90_iip, c_b90_fice, c_b90_fip, c_b90_iice, c_b90_iip, rer_b90_fice, rer_b90_fip, rer_b90_iice, rer_b90_iip, ca_b90_fice, ca_b90_fip, ca_b90_iice, ca_b90_iip);
fprintf(fileID, '\\textit{Recalibrated F.I Economy $(\\beta = 0.53, \\ \\kappa = 0.3525)$} &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f \\\\ \\midrule \n', welf_reca_fice, welf_base_iice, tau_reca_fip, tau_base_iip, dtoy_reca_fice, dtoy_reca_fip, dtoy_base_iice, dtoy_base_iip, freq_reca_fice, freq_reca_fip, freq_base_iice, freq_base_iip, c_reca_fice, c_reca_fip, c_base_iice, c_base_iip, rer_reca_fice, rer_reca_fip, rer_base_iice, rer_base_iip, ca_reca_fice, ca_reca_fip, ca_base_iice, ca_base_iip);
fprintf(fileID, '\\textit{Autocorrelation $\\rho_g$ (15 \\%% less)}   &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f\\\\\n', welf_rlow_fice, welf_rlow_iice, tau_rlow_fip, tau_rlow_iip, dtoy_rlow_fice, dtoy_rlow_fip, dtoy_rlow_iice, dtoy_rlow_iip, freq_rlow_fice, freq_rlow_fip, freq_rlow_iice, freq_rlow_iip, c_rlow_fice, c_rlow_fip, c_rlow_iice, c_rlow_iip, rer_rlow_fice, rer_rlow_fip, rer_rlow_iice, rer_rlow_iip, ca_rlow_fice, ca_rlow_fip, ca_rlow_iice, ca_rlow_iip);
fprintf(fileID, '\\textit{Autocorrelation $\\rho_g$ (15 \\%% more)} &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f\\\\\n', welf_rhigh_fice, welf_rhigh_iice, tau_rhigh_fip, tau_rhigh_iip, dtoy_rhigh_fice, dtoy_rhigh_fip, dtoy_rhigh_iice, dtoy_rhigh_iip, freq_rhigh_fice, freq_rhigh_fip, freq_rhigh_iice, freq_rhigh_iip, c_rhigh_fice, c_rhigh_fip, c_rhigh_iice, c_rhigh_iip, rer_rhigh_fice, rer_rhigh_fip, rer_rhigh_iice, rer_rhigh_iip, ca_rhigh_fice, ca_rhigh_fip, ca_rhigh_iice, ca_rhigh_iip);
fprintf(fileID, '\\textit{Volatility $\\sigma_g$ (15 \\%% less)}         &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f\\\\\n', welf_slow_fice, welf_slow_iice, tau_slow_fip, tau_slow_iip, dtoy_slow_fice, dtoy_slow_fip, dtoy_slow_iice, dtoy_slow_iip, freq_slow_fice, freq_slow_fip, freq_slow_iice, freq_slow_iip, c_slow_fice, c_slow_fip, c_slow_iice, c_slow_iip, rer_slow_fice, rer_slow_fip, rer_slow_iice, rer_slow_iip, ca_slow_fice, ca_slow_fip, ca_slow_iice, ca_slow_iip);
fprintf(fileID, '\\textit{Volatility $\\sigma_g$ (15 \\%% more)}       &  & %8.2f & %8.2f &  & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & & %8.2f & %8.2f & %8.2f & %8.2f &  & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f\\\\\n', welf_shigh_fice, welf_shigh_iice, tau_shigh_fip, tau_shigh_iip, dtoy_shigh_fice, dtoy_shigh_fip, dtoy_shigh_iice, dtoy_shigh_iip, freq_shigh_fice, freq_shigh_fip, freq_shigh_iice, freq_shigh_iip, c_shigh_fice, c_shigh_fip, c_shigh_iice, c_shigh_iip, rer_shigh_fice, rer_shigh_fip, rer_shigh_iice, rer_shigh_iip, ca_shigh_fice, ca_shigh_fip, ca_shigh_iice, ca_shigh_iip);

% Close the environments and the file
fprintf(fileID, '\\bottomrule\n');
fprintf(fileID, '\\bottomrule\n');
fprintf(fileID, '\\end{tabular}%%\n');
fprintf(fileID, '\\begin{tablenotes} \n');
fprintf(fileID, '\\footnotesize \\baselineskip=14pt \n');
fprintf(fileID, '\\item Note: ADD NOTES\n');
fprintf(fileID, '\\end{tablenotes} \n');
fprintf(fileID, '\\end{threeparttable} \n');
fprintf(fileID, '\\end{adjustbox}\n');
fprintf(fileID, '\\end{table}\n');
fprintf(fileID, '\\end{landscape}\n');

fclose(fileID);


%%

