%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Overborrowing and Systemic Externalities in the Business Cycle Under Imperfect Information
%
% In this code: We plot all the figures included in the paper                   
% 
% Authors: Juan Herreño. jdh2181@columbia.edu
%              Carlos Rondón Moreno, crondonm@nd.edu. 
%
% Date: 16 December  2022
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping

clearvars
clear global
close all

% Load databases

%load('IICEIRF.mat')
%load('IIPIRF.mat')
%load('FICEIRF.mat')
%load('FIPIRF.mat')

load('FICE.mat')
load('FIP.mat')
load('IIPCC.mat')
load('IICECC.mat')

% Figure parameters

Format.FontSize = 16;
Format.colors = {'k','r','k','r'};
Format.colors = {[0/255 0/255 102/255], [65/255 105/255 225/255],[123/255 104/255 238/255],[186/255 85/255 211/255]};
Format.widths = {3,3,3,3};
Format.styles = {'-',':','-.','-.'};
Format.figsize  = [460 200 700 525];
Format.figsize2 = [460 200 600 250];
Format.figsize3 = [460 200 700 250];
Format.figsize4 = [460 200 600 450];
Format.figsize6 = [460 200 875 875];
Format.FontSizeAxes = 12;
Format.fontweight = 'bold';
Format.XTick = [1975 1980 1985 1990 1995 2000 2005 2010 2015] ;
Format.Xlim =[1975 2015] ;
Format.Shade = 0.8 ;
Format.ScatterSize = [50,50] ;
Format.ScatterMarker = {'o','s'} ;

% Load Parameters

load('Param.mat')
fprintf("Parameters loaded... \n")

% Assign parameters
r = Param.r;
g =  Param.g;  % Mean growth rate of permanent component
burn = Param.burn;
nstd = Param.nstd;
init_debt = Param.init_debt;
horizn = Param.horizn;
ss = 21; % Position at which the IRF returns to origin
window = Param.window;

%% Figure 3: Debt-to-Collateral Ratio
% Differences between perfect and imperfect information for two types of
% shocks

cases = 3;
f4 = figure('Position',Format.figsize2,'Color',[1 1 1]);
subplot(1,2,1)
horizon=19;
a = IICEIRF.b(IICEIRF.SimB(start:end,cases))'./IICEIRF.BCSim(start:end,cases);
b = IICEIRF.b(IICEIRF.SimB(end,cases))'./IICEIRF.BCSim(end,cases);
c = (a/b-1)*100;
d = FICEIRF.SimBhat(start:end,cases)./FICEIRF.BCSim(start:end,cases);
e = FICEIRF.SimBhat(end,cases)'./FICEIRF.BCSim(end,cases);
f = (d/e-1)*100;
p7 = plot(1:horizon,c,1:horizon,f);
for linei = 1:2
       set(p7(linei),'LineStyle',Format.styles{linei})
       set(p7(linei),'color',Format.colors{linei})
       set(p7(linei),'linewidth',Format.widths{linei})
end
ylabel('% Deviation from Ergodic Mean')
title('Shock to g_t','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
legend('Imperfect Info', 'Perfect Info', 'Location', 'NorthEast');
subplot(1,2,2)
cases=1;
a = IICEIRF.b(IICEIRF.SimB(start:end,cases))'./IICEIRF.BCSim(start:end,cases);
b = IICEIRF.b(IICEIRF.SimB(end,cases))'./IICEIRF.BCSim(end,cases);
c = (a/b-1)*100;
d = FICEIRF.SimBhat(start:end,cases)./FICEIRF.BCSim(start:end,cases);
e = FICEIRF.SimBhat(end,cases)'./FICEIRF.BCSim(end,cases);
f = (d/e-1)*100;
p7 = plot(1:horizon,c,1:horizon,f);
for linei = 1:2
       set(p7(linei),'LineStyle',Format.styles{linei})
       set(p7(linei),'color',Format.colors{linei})
       set(p7(linei),'linewidth',Format.widths{linei})
end
ylabel('% Deviation from Ergodic Mean')
title('Shock to Z_t^T','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
legend('Imperfect Info', 'Perfect Info', 'Location', 'NorthEast');
saveas(f4,'Figures/Figure4_IIvsFI_DebtColl','png');

close all
%% Figure 5a: Ergodic Distribution of Assets Under Imperfect Information
% Debt Level

steps = 20;
H = histogram(IIPCC.b(IIPCC.SimB),'Normalization','probability','DisplayStyle','stairs') ;
datay1 = H.BinEdges(H.Values~=0) ;
datax1 = H.Values(H.Values~=0);
datax1 = movmean(datax1, steps);

H = histogram(IICECC.b(IICECC.SimB),'Normalization','probability','DisplayStyle','stairs') ;
datay2 = H.BinEdges(H.Values~=0) ;
datax2 = H.Values(H.Values~=0) ;
datax2 = movmean(datax2, steps);


Format.styles = {'-.','-','-.','-.'};

f5a = figure('Color',[1 1 1], 'Position',Format.figsize);
p1 = plot(datay1,datax1,datay2,datax2) ;
for linei = 1:2
    set(p1(linei),'LineStyle',Format.styles{linei})
    set(p1(linei),'color',Format.colors{linei})
    set(p1(linei),'linewidth',Format.widths{linei})
end
%title('Ergodic Distribution of Asset Holdings: Incomplete Information','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ylabel('Probability','FontSize',Format.FontSize, 'Interpreter','Latex')
xlabel('Bond Holdings ','FontSize',Format.FontSize, 'Interpreter','Latex')
legend('Social Planner','Decentralized Eqm','Location','NorthEast')
xlim([-1.1, -0.6 ]) ;
set(gca,'FontSize',Format.FontSizeAxes)
set(f5a,'PaperPositionMode', 'auto')
saveas(f5a,'Figures/Figure5a_ErgDist_Debt','png');

close all

%% Figure 5b: Ergodic Distribution of Assets Under Imperfect Information
% Debt-to-GDP Ratio

H = histogram(IIPCC.DtoY,'Normalization','probability','DisplayStyle','stairs') ;
datax1= H.BinEdges(H.Values~=0);
datay1= H.Values(H.Values~=0);
datay1= movmean(datay1, steps);

H = histogram(IICECC.DtoY,'Normalization','probability','DisplayStyle','stairs') ;
datax2= H.BinEdges(H.Values~=0) ;
datay2= H.Values(H.Values~=0) ;
datay2= movmean(datay2, steps);


Format.styles = {'-.','-','-.','-.'};
f5b = figure('Color',[1 1 1], 'Position',Format.figsize);
p1 = plot(datax1,datay1,datax2,datay2) ;
for linei = 1:2
    set(p1(linei),'LineStyle',Format.styles{linei})
    set(p1(linei),'color',Format.colors{linei})
    set(p1(linei),'linewidth',Format.widths{linei})
end
%title('Ergodic Distribution of Asset Holdings: Incomplete Information','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ylabel('Probability','FontSize',Format.FontSize, 'Interpreter','Latex')
xlabel('Bond Holdings (Share of GDP)','FontSize',Format.FontSize, 'Interpreter','Latex')
legend('Social Planner','Decentralized Eqm','Location','NorthEast')
set(gca,'FontSize',Format.FontSizeAxes)
set(f5b,'PaperPositionMode', 'auto')
saveas(f5b,'Figures/Figure5b_ErgDist_DtoY','png');




%% Figure 7: Welfare Distribution
% Welfare Costs of the Pecunary Externality Under Different Information Sets

        close all 
        
        [datay1, datax1] = ksdensity(FICE.Welfcost_fi);
        [datay2, datax2] = ksdensity(IICECC.Welfcost_ii);
        
        steps = 5;
        datay1= movmean(datay1, steps);
        datay2= movmean(datay2, steps);

        f7 = figure('Color',[1 1 1]);
        p1 = plot(datax1,datay1,datax2,datay2) ;
        for linei = 1:2
            set(p1(linei),'LineStyle',Format.styles{linei})
            set(p1(linei),'color',Format.colors{linei})
            set(p1(linei),'linewidth',Format.widths{linei})
        end
        %xlim([0 .4 ]) ;
        %ylim([0 1 ]) ;
        %title('Ergodic Distribution of Welfare Costs','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
        ylabel('Probability','FontSize',Format.FontSize, 'Interpreter','Latex')
        xlabel('Welfare Cost (\%)','FontSize',Format.FontSize, 'Interpreter','Latex')
        legend('Full Information','Imperfect Information','Location','NorthEast','FontSize',14)
        set(gca,'FontSize',Format.FontSizeAxes)
        saveas(f7,'Figures/Figure7_Dist_Welfare','png');


%% Figure 8: Optimal Macroprudential Policy: Optimal Tax Functions
% Optimal Tax policy functions
% We need to plot the functions for a particular realization of the states.
% To do this, first we pick which realization we are going to draw:

close all

% Standard Deviations

ZBBT = -nstd*std(IIPCC.S(:,1));
ZBBN = -nstd*std(IIPCC.S(:,2));
GBBT = -nstd*std(IIPCC.S(:,3));
GTBBT = -nstd*std(IIPCC.S(:,4));
GNBBT = -nstd*std(IIPCC.S(:,5));

% IIP Policy Function:
% Pick the realization that is closest to a 1 standard deviation on all the shocks

%Temp1 = [findClosest2(ZBBT,IIPCC.yt) findClosest2(ZBBN,IIPCC.yn) findClosest2(GBBT,IIPCC.gt+g) findClosest2(GTBBT,IIPCC.gT+g) findClosest2(GTBBT,IIPCC.gN+g)] ;
%Temp4 = [findClosest2(ZBBT,IIPCC.yt) findClosest2(ZBBN,IIPCC.yn) findClosest2(GBBT,IIPCC.gt+g)];

%Temp1 = [2 2 3 2 2]; 
%Temp4 = [2 2 3];
% Paper: Temp1 = [8 8 8 8 8]; Temp4 = [8 8 8];
Temp1 = [9 8 8 8 8]; 
Temp4 = [9 8 8];

% Approximate the grid to our simulation:

Temp2 = [findClosest2(FIP.S(:,1),FIP.yt) findClosest2(FIP.S(:,2),FIP.yn) findClosest2(FIP.S(:,3),FIP.gt+g)] ;
Temp3 = [findClosest2(IIPCC.S(:,1),IIPCC.yt) findClosest2(IIPCC.S(:,2),IIPCC.yn) findClosest2(IIPCC.S(:,3),IIPCC.gt+g) findClosest2(IIPCC.S(:,4),IIPCC.gT+g) findClosest2(IIPCC.S(:,5),IIPCC.gN+g)] ;

% Compute average total income:
IIPmY = mean(IIPCC.b(IIPCC.SimB(2:end)).*exp(IIPCC.Sim(burn+2:end-1,1)')./IIPCC.DtoY(2:end));
FIPmY = mean(FIP.SimBhat(2:end).*exp(FIP.Sim(burn+1:end-1,1)')./FIP.DtoY(2:end));

% Pick the events where our simulation observes the desired states:

index = find((Temp3(:,1)==Temp1(:,1)).*(Temp3(:,2)==Temp1(:,2)).*(Temp3(:,3)==Temp1(:,3).*(Temp3(:,4)==Temp1(:,4)).*(Temp3(:,5)==Temp1(:,5))));
index2 = find((Temp2(:,1)==Temp4(:,1)).*(Temp2(:,2)==Temp4(:,2)).*(Temp2(:,3)==Temp4(:,3)));

% Extract the optimal tax corresponding to the realization
IIPCC.StdPol = IIPCC.TAO(index,:) ;
FIP.StdPol   = FIP.TAO(index2,:) ;

% Here we create the shaded areas for our figure:
% First we need to locate the values for which the tax is zero:

Zzero = find(IIPCC.StdPol==0);
AA = IIPCC.StdPol;
AA(Zzero) = NaN;
BB  = IIPCC.StdPol;
BB(Zzero(end) + 1:end) = NaN;

% We repeat the same process for the full information model:
Zzero = find(FIP.StdPol==0);
CC = FIP.StdPol;
CC(Zzero) = NaN;
DD  = FIP.StdPol;
DD(Zzero(end) + 1:end) = NaN;

f8 = figure('Position',Format.figsize2,'Color',[1 1 1]);
subplot(1,2,1)
p1 = plot(IIPCC.b/IIPmY, AA*100,IIPCC.b/IIPmY, BB);
for linei = 1:2
    set(p1(linei),'LineStyle',Format.styles{linei})
    set(p1(linei),'color',Format.colors{linei})
    set(p1(linei),'linewidth',Format.widths{linei})
end
title('Imperfect Information','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ylabel('Optimal Tax (\%)','FontSize',Format.FontSize, 'Interpreter','Latex')
xlabel('Bond Holdings (Share of GDP)','FontSize',Format.FontSize, 'Interpreter','Latex')
xlim([-0.4 -0.1 ]) ;
ylim([0 70 ]) ;
set(gca,'FontSize',Format.FontSizeAxes)
set(f8,'PaperPositionMode', 'auto')
annotation(f8,'rectangle',...
    [0.218 0.1362 0.12 0.789],...
    'LineStyle','none',...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'FaceAlpha',0.4);
subplot(1,2,2)
p1 = plot(FIP.b/FIPmY,CC*100, FIP.b/FIPmY, DD);
for linei = 1:2
    set(p1(linei),'LineStyle',Format.styles{linei})
    set(p1(linei),'color',Format.colors{linei})
    set(p1(linei),'linewidth',Format.widths{linei})
end
title('Full Information','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ylabel('Optimal Tax (\%)','FontSize',Format.FontSize, 'Interpreter','Latex')
xlabel('Bond Holdings (Share of GDP)','FontSize',Format.FontSize, 'Interpreter','Latex')
xlim([-0.3 -0.1 ]) ;
ylim([0 8 ]) ;
v=axis;
%line(IIPCC.meanb*ones(1,2),[v(3) v(4)],'Linewidth',2,'Color',[17/255 17/255 17/255],'LineStyle',':')
% line(IICECC.meanb*ones(1,2),[v(3) v(4)],'Linewidth',2,'Color',[0/255 0/255 0/255],'LineStyle','-.')
% legend('Social Planner (SP)','Decentralized Eqm (DE)','SP Ergodic Mean of Debt','DE Ergodic Mean of Debt','Location','northeast')
%legend('Social Planner','Decentralized Eqm','Location','southeast')
set(gca,'FontSize',Format.FontSizeAxes)
set(f8,'PaperPositionMode', 'auto')
annotation(f8,'rectangle',...
     [0.695 0.1357 0.1 0.789],...
     'LineStyle','none',...
     'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
     'FaceAlpha',0.4);
saveas(f8,'Figures/Figure8_TaxFun_IIPvsFIP','png');


%% Figure 9: Optimal Macroprudential Policy: Optimal Tax Functions
% Ergodic Distribution of Debt

% Drop outliers
% meanIIP=mean(IIPCC.TAOSim(IIPCC.TAOSim<10));
% meanFIP=mean(FIP.TAOSim(FIP.TAOSim<10));
% H = histogram(FI_TAOSim,'Normalization','probability','DisplayStyle','stairs') ;
% datax1= H.BinEdges(H.Values~=0) ;
% datay1= H.Values(H.Values~=0) ;
%  
% H = histogram(II_TAOSim,'Normalization','probability','DisplayStyle','stairs') ;
% datax2= H.BinEdges(H.Values~=0) ;
% datay2= H.Values(H.Values~=0) ;

p = prctile(IIPCC.TAOSim, [0.75, 99.25]);  
II_TAOSim = IIPCC.TAOSim(IIPCC.TAOSim>=p(1) & IIPCC.TAOSim<=p(2));
p = prctile(FIP.TAOSim, [0.75, 99.25]);
FI_TAOSim = FIP.TAOSim(FIP.TAOSim>=p(1) & FIP.TAOSim<=p(2));

[datay1, datax1] = ksdensity(FI_TAOSim);
[datay2, datax2] = ksdensity(II_TAOSim);    
%datax2 = movmean(datax2, 3);

Format.styles = {'-.', '-', '-.','-.'};

f9 = figure('Color',[1 1 1], 'Position',Format.figsize);
p1 = plot(datax1, datay1, datax2, datay2) ;
for linei = 1:2
    set(p1(linei),'LineStyle',Format.styles{linei})
    set(p1(linei),'color',Format.colors{linei})
    set(p1(linei),'linewidth',Format.widths{linei})
end
%title('Ergodic Distribution of Asset Holdings: Incomplete Information','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ylabel('Frequency','FontSize',Format.FontSize, 'Interpreter','Latex')
xlabel('Optimal Tax Rate ','FontSize',Format.FontSize, 'Interpreter','Latex')
legend('Perfect Information','Imperfect Information','Location','NorthEast')
xlim([-0.1 0.4 ]) ;
%ylim([-0 .07 ]) ;
set(gca,'FontSize',Format.FontSizeAxes)
set(f9,'PaperPositionMode', 'auto')
saveas(f9,'Figures/Figure9_ErgDist_TaxesIIvsFI','png');

%% Figure 10: Event Analysis - Financial Crises

% Main Drivers: Imperfect Information

fxx= figure('Position',Format.figsize3,'Color',[1 1 1]);
tt = tiledlayout(1,3);
ax = nexttile;
p1 = plot(-window:window, IICECC.Cycles.IRZMean*100, -window:window, IICECC.Cycles.IRZSimMean*100);
   for linei = 1:2
       set(p1(linei),'LineStyle',Format.styles{linei})
       set(p1(linei),'color',Format.colors{linei})
       set(p1(linei),'linewidth',Format.widths{linei})
   end
ylim([-11 5]) ;
ylabel('Percent Change (%)')
title('Z_t^T','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ax = nexttile;
p2 = plot(-window:window, IICECC.Cycles.IRZNMean*100, -window:window, IICECC.Cycles.IRZNSimMean*100);
   for linei = 1:2
       set(p2(linei),'LineStyle',Format.styles{linei})
       set(p2(linei),'color',Format.colors{linei})
       set(p2(linei),'linewidth',Format.widths{linei})
   end
ylim([-11 5]) ;
ylabel('Percent Change (%)')
title('Z_t^N', 'FontSize', Format.FontSize, 'FontWeight', Format.fontweight)
ax = nexttile;
p3 = plot(-window:window, (IICECC.Cycles.IRGMean - g)*100, -window:window, (IICECC.Cycles.IRGSimMean - g)*100);
for linei = 1:2
       set(p3(linei),'LineStyle',Format.styles{linei})
       set(p3(linei),'color',Format.colors{linei})
       set(p3(linei),'linewidth',Format.widths{linei})
end
ylim([-11 5]) ;
title('\Gamma_t', 'FontSize', Format.FontSize, 'FontWeight', Format.fontweight)
ylabel('Percent Change (%)')
lg  = legend(ax,'Posterior', 'True', 'Orientation','Horizontal','NumColumns',2);
lg.Layout.Tile = 'South';

saveas(fxx,'Figures/Figurexx_bb_shocks','png');

close all

%% Event Analysis: Financial Crises under Imperfect Information

% Main Drivers: Imperfect Information

fxx= figure('Position',Format.figsize4,'Color',[1 1 1]);
tt = tiledlayout(2,2);
ax = nexttile;
p1 = plot(-window:window, IICECC.Cycles.IRCMean, -window:window, FICE.Cycles.IRCMean);
   for linei = 1:2
       set(p1(linei),'LineStyle',Format.styles{linei})
       set(p1(linei),'color',Format.colors{linei})
       set(p1(linei),'linewidth',Format.widths{linei})
   end
ylabel('Level')
title('C_t','FontSize',Format.FontSize,'FontWeight',Format.fontweight)
ax = nexttile;
p2 = plot(-window:window, IICECC.Cycles.IRZNMean*100, -window:window, IICECC.Cycles.IRZNSimMean*100);
   for linei = 1:2
       set(p2(linei),'LineStyle',Format.styles{linei})
       set(p2(linei),'color',Format.colors{linei})
       set(p2(linei),'linewidth',Format.widths{linei})
   end
ylim([-11 5]) ;
ylabel('Percent Change (%)')
title('Z_t^N', 'FontSize', Format.FontSize, 'FontWeight', Format.fontweight)
ax = nexttile;
p3 = plot(-window:window, (IICECC.Cycles.IRGMean - g)*100, -window:window, (IICECC.Cycles.IRGSimMean - g)*100);
for linei = 1:2
       set(p3(linei),'LineStyle',Format.styles{linei})
       set(p3(linei),'color',Format.colors{linei})
       set(p3(linei),'linewidth',Format.widths{linei})
end
ylim([-11 5]) ;
title('\Gamma_t', 'FontSize', Format.FontSize, 'FontWeight', Format.fontweight)
ylabel('Percent Change (%)')
lg  = legend(ax,'Posterior', 'True', 'Orientation','Horizontal','NumColumns',2);
lg.Layout.Tile = 'South';



saveas(fxx,'Figures/Figurexx_bb_shocks','png');

close all

