% Script to make Figure 5 in Schultz et al., 2020.
clear;

% Load in the dataset.
load('data/dataStructV4d+.mat');

% Scrub out the grid data, to save memory.
S=rmfield(S,'gMMI');
S=rmfield(S,'gPGA');
S=rmfield(S,'gPGV');
S=rmfield(S,'gLat');
S=rmfield(S,'gLon');

% Define some variables
c=0.9;
N=100;

% GR-FMD stats.
M=[S.M];
Mc=3.5;  % For SS5-17 Xcatalogue.
dM=0.1;
[b, b_err, a, R2_b,~,Mgr,Ngr,ngr]=Bval(M, Mc,dM);
po=[-b,a];
Mgr_fit=[Mc, max(M)];
Ngr_fit=10.^polyval(po,Mgr_fit);
fprintf('b-value fit: %0.2f +/- %0.2f  (R² %0.3f)\n',b,b_err, R2_b);



[C,~,I]=histcounts(M,Mgr);

% Find nuisance dependence on M.
D=struct('Pmmi',[],'Ppga',[],'Ppgv',[]);
for i=1:length(Mgr)-1
    
    if(C(i)==0)
        continue;
    end
    
    It=find(i==I);
    [Bin_mmi0,pl_mmi0,b_mmi0,db_mmi0,p_mmi0,fp_mmi0,tp_mmi0,auc_mmi0,Pl_mmi0,B_mmi0,P_mmi0,FP_mmi0,TP_mmi0,AUC_mmi0]=BS_wrap(S(It),2.0,'MMI','yes',N);
    [Bin_pga0,pl_pga0,b_pga0,db_pga0,p_pga0,fp_pga0,tp_pga0,auc_pga0,Pl_pga0,B_pga0,P_pga0,FP_pga0,TP_pga0,AUC_pga0]=BS_wrap(S(It),2.0,'PGA','yes',N);
    [Bin_pgv0,pl_pgv0,b_pgv0,db_pgv0,p_pgv0,fp_pgv0,tp_pgv0,auc_pgv0,Pl_pgv0,B_pgv0,P_pgv0,FP_pgv0,TP_pgv0,AUC_pgv0]=BS_wrap(S(It),2.0,'PGV','yes',N);
    D(i).Pmmi=P_mmi0(:,3);
    D(i).Ppga=P_pga0(:,3);
    D(i).Ppgv=P_pgv0(:,3);
end



% Plot.
GREY=[0.85,0.85,0.85];
figure(1); clf;

% Plot the GR-FMD.
subplot(221);
semilogy(Mgr, Ngr, 'o', 'Color', 'k'); hold on;
bar(Mgr,ngr, 'FaceColor', GREY);
semilogy(Mgr_fit, Ngr_fit, '-', 'Color', 'black');
xlabel('Magnitude'); ylabel('Count');
xlim([min(Mgr)-dM/2 max(Mgr)+dM/2]); ylim([0.7 1.3*max(Ngr)]);

subplot(222);
boxplot([D.Pmmi],Mgr(1:end-1));
xlabel('Magnitude'); ylabel('MMI');
ylim([1.5 4.0]);

subplot(223);
boxplot([D.Ppga],Mgr(1:end-1));
xlabel('Magnitude'); ylabel('PGA (log_{10}[m/s^2])');
ylim([-2.5 0.0]);

subplot(224);
boxplot([D.Ppgv],Mgr(1:end-1));
xlabel('Magnitude'); ylabel('PGV (log_{10}[m/s])');
ylim([-4.5 -2.0]);










