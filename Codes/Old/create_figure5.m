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

load('Param.mat')
fprintf("Parameters loaded... \n")
load('IICESim.mat')

fprintf("Database loaded... \n")

g =  Param.g;  % Mean growth rate of permanent component

Tsim = Param.Tsim;   % Simulation points
burn = Param.burn; % Burn-in period for simulation
nstd = Param.nstd;
window = Param.window;
FICEmP = mP;

% Settings for figures

Format.FontSize = 18;
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

%% Simulation

fprintf("Starting crises analysis ... \n")

Simyt = Sim(burn+2:end,1)' ; Simyn = Sim(burn+2:end,2)' ; Simg = Sim(burn+2:end,3)' ; 

AAA = b(SimB) > BCSim + (b(2) - b(1))/2 ; 
CCC =CA;
CCCT = nstd*std(CCC);
Crisis = (CCC > CCCT).*(1 - AAA) ;
Crisis2 = sum(Crisis)/(length(CCC)) ;
%Crisis = [0 Crisis]; 
CrInd = find(Crisis == 1) ;
CrInd = CrInd(CrInd > window + 1) ; 
CrInd = CrInd(CrInd < Tsim - burn - window) ;  

clear BBII 

for i=-window:window
    BBII.CE.IRB(i + window + 1,:) = b(SimB(CrInd + i));
    BBII.CE.IRCA(i + window + 1,:) = CA(CrInd + i);
    BBII.CE.IRBC(i + window + 1,:) = BCSim(CrInd + i);
    BBII.CE.IRC(i + window + 1,:) = CSim(CrInd + i);
    BBII.CE.IRCT(i + window + 1,:) = CTSim(CrInd + i);
    BBII.CE.IRCN(i + window + 1,:) = CNSim(CrInd + i - 1);
    BBII.CE.IRP(i + window + 1,:) = PSim(CrInd + i);
    BBII.CE.IRDtoY(i + window + 1,:) = DtoY(CrInd + i); 
    BBII.CE.IRCtoY(i + window + 1,:) = CtoY(CrInd + i + 1);
    BBII.CE.IRCTtoY(i + window + 1,:) = CTtoY(CrInd + i);
    BBII.CE.IRCNtoY(i + window + 1,:) = CNtoY(CrInd + i);
    BBII.CE.IRCAtoY(i + window + 1,:) = CAtoY(CrInd + i);
    BBII.CE.IRYtot(i + window + 1,:) = Ytot(CrInd + i);
end 
 
BBII.CE.IRBMean = mean(BBII.CE.IRB, 2);
BBII.CE.IRCAMean = mean(BBII.CE.IRCA,2);
BBII.CE.IRBCMean = mean(BBII.CE.IRBC,2);
BBII.CE.IRCMean = mean(BBII.CE.IRC,2);
BBII.CE.IRCTMean = mean(BBII.CE.IRCT,2);
BBII.CE.IRCNMean = mean(BBII.CE.IRCN,2);
BBII.CE.IRPMean = mean(BBII.CE.IRP, 2);
BBII.CE.IRDtoYMean = mean(BBII.CE.IRDtoY,2);
BBII.CE.IRCtoYMean = mean(BBII.CE.IRCtoY,2);
BBII.CE.IRCTtoYMean = mean(BBII.CE.IRCTtoY,2);
BBII.CE.IRCNtoYMean = mean(BBII.CE.IRCNtoY,2);
BBII.CE.IRCAtoYMean = mean(BBII.CE.IRCAtoY,2);
BBII.CE.IRYtotMean = mean(BBII.CE.IRYtot,2);

clearvars -except BBII g Tsim burn nstd window Format 

%% Full Information

load("FICEsim.mat")

fprintf("Starting crises analysis Full Information \n")

AAA = b(SimB) > BCSim + (b(2) - b(1))/2 ; 
CCC =CA;
CCCT = nstd*std(CCC);
Crisis = (CCC > CCCT).*(1 - AAA) ;
Crisis2 = sum(Crisis)/(length(CCC)) ;
%Crisis = [0 Crisis]; 
CrInd = find(Crisis == 1) ;
CrInd = CrInd(CrInd > window + 1) ; 
CrInd = CrInd(CrInd < Tsim - burn - window) ;  


clear BBFI 

for i=-window:window
    BBFI.CE.IRB(i + window + 1,:) = SimBhat(CrInd + i);
    BBFI.CE.IRCA(i + window + 1,:) = CA(CrInd + i) ;
    BBFI.CE.IRBC(i + window + 1,:) = BCSim(CrInd + i) ;
    BBFI.CE.IRC(i + window + 1,:) = CSim(CrInd + i) ;
    BBFI.CE.IRCT(i + window + 1,:) = CTSim(CrInd + i) ;
    BBFI.CE.IRP(i + window + 1,:) = PSim(CrInd + i) ;
    BBFI.CE.IRDtoY(i + window + 1,:) = DtoY(CrInd + i + 1); 
    BBFI.CE.IRLambda(i + window + 1,:) = LambdaSim(CrInd + i);
    BBFI.CE.IRgrYTSim(i + window + 1,:) = grYTSim(CrInd + i);
    BBFI.CE.IRgrYNSim(i + window + 1,:) = grYNSim(CrInd + i);
    BBFI.CE.IRCtoY(i + window + 1,:) = CtoY(CrInd + i + 1);
    BBFI.CE.IRCAtoY(i + window + 1,:) = CAtoY(CrInd + i);
    BBFI.CE.IRCTtoY(i + window + 1,:) = CTtoY(CrInd + i);
    BBFI.CE.IRCNtoY(i + window + 1,:) = CNtoY(CrInd + i);
    BBFI.CE.IRYtot(i + window + 1,:) = Ytot(CrInd + i);
end 
 
BBFI.CE.IRBMean = mean(BBFI.CE.IRB, 2);
BBFI.CE.IRCAMean = mean(BBFI.CE.IRCA,2);
BBFI.CE.IRBCMean = mean(BBFI.CE.IRBC,2);
BBFI.CE.IRCMean = mean(BBFI.CE.IRC,2);
BBFI.CE.IRCTMean = mean(BBFI.CE.IRCT,2);
BBFI.CE.IRPMean = mean(BBFI.CE.IRP, 2);
BBFI.CE.IRDtoYMean = mean(BBFI.CE.IRDtoY,2);
BBFI.CE.IRCtoYMean = mean(BBFI.CE.IRCtoY,2);
BBFI.CE.IRCTtoYMean = mean(BBFI.CE.IRCTtoY,2);
BBFI.CE.IRCNtoYMean = mean(BBFI.CE.IRCNtoY,2);
BBFI.CE.IRCAtoYMean = mean(BBFI.CE.IRCAtoY,2);
BBFI.CE.IRYtotMean = mean(BBFI.CE.IRYtot,2);



%% Figure XX

close all

f1 = figure('Position',Format.figsize4,'Color',[1 1 1]);
subplot(2,2,1)
p1 = plot(-window:window, BBFI.CE.IRCTMean-mCT,-window:window, BBII.CE.IRCTMean); 
    for linei = 1:2
        set(p1(linei),'LineStyle',Format.styles{linei})
        set(p1(linei),'color',Format.colors{linei})
        set(p1(linei),'linewidth',Format.widths{linei})
    end
title('$C_t^T$','FontSize',Format.FontSize,'FontWeight',Format.fontweight,'Interpreter','latex')
ylabel('Level', 'FontSize',14,'FontWeight',  Format.fontweight,'Interpreter','latex')
xlabel('Years', 'FontSize',12, 'FontWeight', Format.fontweight,'Interpreter','latex')
xticks([-5,-4,-3,-2,-1,0,1,2,3,4, 5 ]) ;

subplot(2,2,2)
p2 = plot(-window:window, BBFI.CE.IRPMean - mP,-window:window, BBII.CE.IRPMean); 
    for linei = 1:2
        set(p2(linei),'LineStyle',Format.styles{linei})
        set(p2(linei),'color',Format.colors{linei})
        set(p2(linei),'linewidth',Format.widths{linei})
    end
title('$P_t$','FontSize',Format.FontSize,'FontWeight',Format.fontweight,'Interpreter','latex')
xticks([-5,-4,-3,-2,-1,0,1,2,3,4, 5 ]) ;
ylabel('Level', 'FontSize',14,'FontWeight',  Format.fontweight,'Interpreter','latex')
xlabel('Years', 'FontSize',12, 'FontWeight', Format.fontweight,'Interpreter','latex')

subplot(2,2,3)
p3 = plot(-window:window, BBFI.CE.IRBMean,-window:window, BBII.CE.IRBMean); 
    for linei = 1:2
        set(p3(linei),'LineStyle',Format.styles{linei})
        set(p3(linei),'color',Format.colors{linei})
        set(p3(linei),'linewidth',Format.widths{linei})
    end
title('$B_{t+1}$','FontSize',Format.FontSize,'FontWeight',Format.fontweight,'Interpreter','latex')
xticks([-5,-4,-3,-2,-1,0,1,2,3,4, 5 ]) ;
ylabel('Level', 'FontSize',14,'FontWeight',  Format.fontweight,'Interpreter','latex')
xlabel('Years', 'FontSize',12, 'FontWeight', Format.fontweight,'Interpreter','latex')

subplot(2,2,4)
p3 = plot(-window:window, BBFI.CE.IRBCMean ,-window:window, BBII.CE.IRBCMean); 
    for linei = 1:2
        set(p3(linei),'LineStyle',Format.styles{linei})
        set(p3(linei),'color',Format.colors{linei})
        set(p3(linei),'linewidth',Format.widths{linei})
    end
title('Borrowing Limit','FontSize',Format.FontSize,'FontWeight',Format.fontweight,'Interpreter','latex')
xticks([-5,-4,-3,-2,-1,0,1,2,3,4, 5 ]) ;
ylabel('Level', 'FontSize',14,'FontWeight',  Format.fontweight,'Interpreter','latex')
xlabel('Years', 'FontSize',12, 'FontWeight', Format.fontweight,'Interpreter','latex')
legend('Perfect Information','Imperfect Information', 'Location', 'SouthEast', 'Orientation','horizontal', 'FontSize', 14,'Interpreter','latex');
% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 50;
fig.Position(4) = fig.Position(4) + 100;
% add legend
Lgnd = legend('show');
Lgnd.Position(1) = 0.2405  ;
Lgnd.Position(2) = 0.0101;

saveas(f1, 'Figures/FigureXX', 'png');

