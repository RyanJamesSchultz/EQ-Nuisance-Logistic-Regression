% Script to make Figures 3 & 4 in Schultz et al., 2020.
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
N=500;
%i=[1:20,108,164,359,94];
i=1:length(S);

% Fit the data normally - CDI 0.
[~,Pe_mmi0,~,~,~,~,~,~,~,gm_mmi0,dyfi_mmi0,cdi_mmi0,~]=data_prep(S(i),0.1,'MMI','yes','no');
[~,Pe_pga0,~,~,~,~,~,~,~,gm_pga0,dyfi_pga0,cdi_pga0,~]=data_prep(S(i),0.1,'PGA','yes','no');
[~,Pe_pgv0,~,~,~,~,~,~,~,gm_pgv0,dyfi_pgv0,cdi_pgv0,~]=data_prep(S(i),0.1,'PGV','yes','no');

% Fit the data via boot strap - CDI 2.
[Bin_mmi2,pl_mmi2,b_mmi2,db_mmi2,p_mmi2,fp_mmi2,tp_mmi2,auc_mmi2,Pl_mmi2,B_mmi2,P_mmi2,FP_mmi2,TP_mmi2,AUC_mmi2]=BS_wrap(S(i),2.0,'MMI','yes',N);
[Bin_pga2,pl_pga2,b_pga2,db_pga2,p_pga2,fp_pga2,tp_pga2,auc_pga2,Pl_pga2,B_pga2,P_pga2,FP_pga2,TP_pga2,AUC_pga2]=BS_wrap(S(i),2.0,'PGA','yes',N);
[Bin_pgv2,pl_pgv2,b_pgv2,db_pgv2,p_pgv2,fp_pgv2,tp_pgv2,auc_pgv2,Pl_pgv2,B_pgv2,P_pgv2,FP_pgv2,TP_pgv2,AUC_pgv2]=BS_wrap(S(i),2.0,'PGV','yes',N);

% Fit the data via boot strap - CDI 3.
[Bin_mmi3,pl_mmi3,b_mmi3,db_mmi3,p_mmi3,fp_mmi3,tp_mmi3,auc_mmi3,Pl_mmi3,B_mmi3,P_mmi3,FP_mmi3,TP_mmi3,AUC_mmi3]=BS_wrap(S(i),3.0,'MMI','yes',N);
[Bin_pga3,pl_pga3,b_pga3,db_pga3,p_pga3,fp_pga3,tp_pga3,auc_pga3,Pl_pga3,B_pga3,P_pga3,FP_pga3,TP_pga3,AUC_pga3]=BS_wrap(S(i),3.0,'PGA','yes',N);
[Bin_pgv3,pl_pgv3,b_pgv3,db_pgv3,p_pgv3,fp_pgv3,tp_pgv3,auc_pgv3,Pl_pgv3,B_pgv3,P_pgv3,FP_pgv3,TP_pgv3,AUC_pgv3]=BS_wrap(S(i),3.0,'PGV','yes',N);

% Fit the data via boot strap - CDI 4.
[Bin_mmi4,pl_mmi4,b_mmi4,db_mmi4,p_mmi4,fp_mmi4,tp_mmi4,auc_mmi4,Pl_mmi4,B_mmi4,P_mmi4,FP_mmi4,TP_mmi4,AUC_mmi4]=BS_wrap(S(i),4.0,'MMI','yes',N);
[Bin_pga4,pl_pga4,b_pga4,db_pga4,p_pga4,fp_pga4,tp_pga4,auc_pga4,Pl_pga4,B_pga4,P_pga4,FP_pga4,TP_pga4,AUC_pga4]=BS_wrap(S(i),4.0,'PGA','yes',N);
[Bin_pgv4,pl_pgv4,b_pgv4,db_pgv4,p_pgv4,fp_pgv4,tp_pgv4,auc_pgv4,Pl_pgv4,B_pgv4,P_pgv4,FP_pgv4,TP_pgv4,AUC_pgv4]=BS_wrap(S(i),4.0,'PGV','yes',N);

% Fit the data via boot strap - CDI 5.
[Bin_mmi5,pl_mmi5,b_mmi5,db_mmi5,p_mmi5,fp_mmi5,tp_mmi5,auc_mmi5,Pl_mmi5,B_mmi5,P_mmi5,FP_mmi5,TP_mmi5,AUC_mmi5]=BS_wrap(S(i),5.0,'MMI','yes',N);
[Bin_pga5,pl_pga5,b_pga5,db_pga5,p_pga5,fp_pga5,tp_pga5,auc_pga5,Pl_pga5,B_pga5,P_pga5,FP_pga5,TP_pga5,AUC_pga5]=BS_wrap(S(i),5.0,'PGA','yes',N);
[Bin_pgv5,pl_pgv5,b_pgv5,db_pgv5,p_pgv5,fp_pgv5,tp_pgv5,auc_pgv5,Pl_pgv5,B_pgv5,P_pgv5,FP_pgv5,TP_pgv5,AUC_pgv5]=BS_wrap(S(i),5.0,'PGV','yes',N);

% Fit the data via boot strap - CDI 6.
[Bin_mmi6,pl_mmi6,b_mmi6,db_mmi6,p_mmi6,fp_mmi6,tp_mmi6,auc_mmi6,Pl_mmi6,B_mmi6,P_mmi6,FP_mmi6,TP_mmi6,AUC_mmi6]=BS_wrap(S(i),6.0,'MMI','yes',N);
[Bin_pga6,pl_pga6,b_pga6,db_pga6,p_pga6,fp_pga6,tp_pga6,auc_pga6,Pl_pga6,B_pga6,P_pga6,FP_pga6,TP_pga6,AUC_pga6]=BS_wrap(S(i),6.0,'PGA','yes',N);
[Bin_pgv6,pl_pgv6,b_pgv6,db_pgv6,p_pgv6,fp_pgv6,tp_pgv6,auc_pgv6,Pl_pgv6,B_pgv6,P_pgv6,FP_pgv6,TP_pgv6,AUC_pgv6]=BS_wrap(S(i),6.0,'PGV','yes',N);

p_mmi2
p_pga2
p_pgv2



% Print out values of interest.
fprintf('\n');
fprintf('                                             MMI,                                                              PGA (log_{10}[m/s^2]),                                                                   PGV (log_{10}[m/s])\n');
fprintf('CDI;                           B0,B1,v1,v2,v12,auc,p5,p32,p50,p68,p95;                                        B0,B1,v1,v2,v12,auc,p5,p32,p50,p68,p95;                                                  B0,B1,v1,v2,v12,auc,p5,p32,p50,p68,p95\n');
fprintf('  2;  %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_mmi2(1),b_mmi2(2), db_mmi2(1,1),db_mmi2(2,2),db_mmi2(1,2), auc_mmi2,  p_mmi2(1),p_mmi2(2),p_mmi2(3),p_mmi2(4),p_mmi2(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_pga2(1),b_pga2(2), db_pga2(1,1),db_pga2(2,2),db_pga2(1,2), auc_pga2,  p_pga2(1),p_pga2(2),p_pga2(3),p_pga2(4),p_pga2(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f\n', b_pgv2(1),b_pgv2(2), db_pgv2(1,1),db_pgv2(2,2),db_pgv2(1,2), auc_pgv2,  p_pgv2(1),p_pgv2(2),p_pgv2(3),p_pgv2(4),p_pgv2(5) );

fprintf('  3;  %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_mmi3(1),b_mmi3(2), db_mmi3(1,1),db_mmi3(2,2),db_mmi3(1,2), auc_mmi3,  p_mmi3(1),p_mmi3(2),p_mmi3(3),p_mmi3(4),p_mmi3(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_pga3(1),b_pga3(2), db_pga3(1,1),db_pga3(2,2),db_pga3(1,2), auc_pga3,  p_pga3(1),p_pga3(2),p_pga3(3),p_pga3(4),p_pga3(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f\n', b_pgv3(1),b_pgv3(2), db_pgv3(1,1),db_pgv3(2,2),db_pgv3(1,2), auc_pgv3,  p_pgv3(1),p_pgv3(2),p_pgv3(3),p_pgv3(4),p_pgv3(5) );

fprintf('  4;  %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_mmi4(1),b_mmi4(2), db_mmi4(1,1),db_mmi4(2,2),db_mmi4(1,2), auc_mmi4,  p_mmi4(1),p_mmi4(2),p_mmi4(3),p_mmi4(4),p_mmi4(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_pga4(1),b_pga4(2), db_pga4(1,1),db_pga4(2,2),db_pga4(1,2), auc_pga4,  p_pga4(1),p_pga4(2),p_pga4(3),p_pga4(4),p_pga4(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f\n', b_pgv4(1),b_pgv4(2), db_pgv4(1,1),db_pgv4(2,2),db_pgv4(1,2), auc_pgv4,  p_pgv4(1),p_pgv4(2),p_pgv4(3),p_pgv4(4),p_pgv4(5) );

fprintf('  5;  %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_mmi5(1),b_mmi5(2), db_mmi5(1,1),db_mmi5(2,2),db_mmi5(1,2), auc_mmi5,  p_mmi5(1),p_mmi5(2),p_mmi5(3),p_mmi5(4),p_mmi5(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_pga5(1),b_pga5(2), db_pga5(1,1),db_pga5(2,2),db_pga5(1,2), auc_pga5,  p_pga5(1),p_pga5(2),p_pga5(3),p_pga5(4),p_pga5(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f\n', b_pgv5(1),b_pgv5(2), db_pgv5(1,1),db_pgv5(2,2),db_pgv5(1,2), auc_pgv5,  p_pgv5(1),p_pgv5(2),p_pgv5(3),p_pgv5(4),p_pgv5(5) );

fprintf('  6;  %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_mmi6(1),b_mmi6(2), db_mmi6(1,1),db_mmi6(2,2),db_mmi6(1,2), auc_mmi6,  p_mmi6(1),p_mmi6(2),p_mmi6(3),p_mmi6(4),p_mmi6(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f ;', b_pga6(1),b_pga6(2), db_pga6(1,1),db_pga6(2,2),db_pga6(1,2), auc_pga6,  p_pga6(1),p_pga6(2),p_pga6(3),p_pga6(4),p_pga6(5) );
fprintf('      %0.4f,%0.4f,%0.2e,%0.2e,%0.2e,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f\n', b_pgv6(1),b_pgv6(2), db_pgv6(1,1),db_pgv6(2,2),db_pgv6(1,2), auc_pgv6,  p_pgv6(1),p_pgv6(2),p_pgv6(3),p_pgv6(4),p_pgv6(5) );

fprintf('\n');

% Plot logistic regression fit parameter distributions.
figure(1); clf;

% B0, MMI, CDI 2.
subplot(5,6,1);
histogram(B_mmi2(:,1),round(2*sqrt(length(B_mmi2)))); hold on;
line([b_mmi2(1) b_mmi2(1)], ylim(),'LineStyle','--');
xlabel('MMI: B_0 values'); ylabel('Count');

% B1, MMI, CDI 2.
subplot(5,6,2);
histogram(B_mmi2(:,2),round(2*sqrt(length(B_mmi2)))); hold on;
line([b_mmi2(2) b_mmi2(2)], ylim(),'LineStyle','--');
xlabel('MMI: B_1 values'); ylabel('Count');

% B0, PGA, CDI 2.
subplot(5,6,3);
histogram(B_pga2(:,1),round(2*sqrt(length(B_pga2)))); hold on;
line([b_pga2(1) b_pga2(1)], ylim(),'LineStyle','--');
xlabel('PGA: B_0 values'); ylabel('Count');

% B1, PGA, CDI 2.
subplot(5,6,4);
histogram(B_pga2(:,2),round(2*sqrt(length(B_pga2)))); hold on;
line([b_pga2(2) b_pga2(2)], ylim(),'LineStyle','--');
xlabel('PGA: B_1 values'); ylabel('Count');

% B0, PGV, CDI 2.
subplot(5,6,5);
histogram(B_pgv2(:,1),round(2*sqrt(length(B_pgv2)))); hold on;
line([b_pgv2(1) b_pgv2(1)], ylim(),'LineStyle','--');
xlabel('PGV: B_0 values'); ylabel('Count');

% B1, PGV, CDI 2.
subplot(5,6,6);
histogram(B_pgv2(:,2),round(2*sqrt(length(B_pgv2)))); hold on;
line([b_pgv2(2) b_pgv2(2)], ylim(),'LineStyle','--');
xlabel('PGV: B_1 values'); ylabel('Count');


% B0, MMI, CDI 3.
subplot(5,6,7);
histogram(B_mmi3(:,1),round(2*sqrt(length(B_mmi3)))); hold on;
line([b_mmi3(1) b_mmi3(1)], ylim(),'LineStyle','--');
xlabel('MMI: B_0 values'); ylabel('Count');

% B1, MMI, CDI 3.
subplot(5,6,8);
histogram(B_mmi3(:,2),round(2*sqrt(length(B_mmi3)))); hold on;
line([b_mmi3(2) b_mmi3(2)], ylim(),'LineStyle','--');
xlabel('MMI: B_1 values'); ylabel('Count');

% B0, PGA, CDI 3.
subplot(5,6,9);
histogram(B_pga3(:,1),round(2*sqrt(length(B_pga3)))); hold on;
line([b_pga3(1) b_pga3(1)], ylim(),'LineStyle','--');
xlabel('PGA: B_0 values'); ylabel('Count');

% B1, PGA, CDI 3.
subplot(5,6,10);
histogram(B_pga3(:,2),round(2*sqrt(length(B_pga3)))); hold on;
line([b_pga3(2) b_pga3(2)], ylim(),'LineStyle','--');
xlabel('PGA: B_1 values'); ylabel('Count');

% B0, PGV, CDI 3.
subplot(5,6,11);
histogram(B_pgv3(:,1),round(2*sqrt(length(B_pgv3)))); hold on;
line([b_pgv3(1) b_pgv3(1)], ylim(),'LineStyle','--');
xlabel('PGV: B_0 values'); ylabel('Count');

% B1, PGV, CDI 3.
subplot(5,6,12);
histogram(B_pgv3(:,2),round(2*sqrt(length(B_pgv3)))); hold on;
line([b_pgv3(2) b_pgv3(2)], ylim(),'LineStyle','--');
xlabel('PGV: B_1 values'); ylabel('Count');


% B0, MMI, CDI 4.
subplot(5,6,13);
histogram(B_mmi4(:,1),round(2*sqrt(length(B_mmi4)))); hold on;
line([b_mmi4(1) b_mmi4(1)], ylim(),'LineStyle','--');
xlabel('MMI: B_0 values'); ylabel('Count');

% B1, MMI, CDI 4.
subplot(5,6,14);
histogram(B_mmi4(:,2),round(2*sqrt(length(B_mmi4)))); hold on;
line([b_mmi4(2) b_mmi4(2)], ylim(),'LineStyle','--');
xlabel('MMI: B_1 values'); ylabel('Count');

% B0, PGA, CDI 4.
subplot(5,6,15);
histogram(B_pga4(:,1),round(2*sqrt(length(B_pga4)))); hold on;
line([b_pga4(1) b_pga4(1)], ylim(),'LineStyle','--');
xlabel('PGA: B_0 values'); ylabel('Count');

% B1, PGA, CDI 4.
subplot(5,6,16);
histogram(B_pga4(:,2),round(2*sqrt(length(B_pga4)))); hold on;
line([b_pga4(2) b_pga4(2)], ylim(),'LineStyle','--');
xlabel('PGA: B_1 values'); ylabel('Count');

% B0, PGV, CDI 4.
subplot(5,6,17);
histogram(B_pgv4(:,1),round(2*sqrt(length(B_pgv4)))); hold on;
line([b_pgv4(1) b_pgv4(1)], ylim(),'LineStyle','--');
xlabel('PGV: B_0 values'); ylabel('Count');

% B1, PGV, CDI 4.
subplot(5,6,18);
histogram(B_pgv4(:,2),round(2*sqrt(length(B_pgv4)))); hold on;
line([b_pgv4(2) b_pgv4(2)], ylim(),'LineStyle','--');
xlabel('PGV: B_1 values'); ylabel('Count');


% B0, MMI, CDI 5.
subplot(5,6,19);
histogram(B_mmi5(:,1),round(2*sqrt(length(B_mmi5)))); hold on;
line([b_mmi5(1) b_mmi5(1)], ylim(),'LineStyle','--');
xlabel('MMI: B_0 values'); ylabel('Count');

% B1, MMI, CDI 5.
subplot(5,6,20);
histogram(B_mmi5(:,2),round(2*sqrt(length(B_mmi5)))); hold on;
line([b_mmi5(2) b_mmi5(2)], ylim(),'LineStyle','--');
xlabel('MMI: B_1 values'); ylabel('Count');

% B0, PGA, CDI 5.
subplot(5,6,21);
histogram(B_pga5(:,1),round(2*sqrt(length(B_pga5)))); hold on;
line([b_pga5(1) b_pga5(1)], ylim(),'LineStyle','--');
xlabel('PGA: B_0 values'); ylabel('Count');

% B1, PGA, CDI 5.
subplot(5,6,22);
histogram(B_pga5(:,2),round(2*sqrt(length(B_pga5)))); hold on;
line([b_pga5(2) b_pga5(2)], ylim(),'LineStyle','--');
xlabel('PGA: B_1 values'); ylabel('Count');

% B0, PGV, CDI 5.
subplot(5,6,23);
histogram(B_pgv5(:,1),round(2*sqrt(length(B_pgv5)))); hold on;
line([b_pgv5(1) b_pgv5(1)], ylim(),'LineStyle','--');
xlabel('PGV: B_0 values'); ylabel('Count');

% B1, PGV, CDI 5.
subplot(5,6,24);
histogram(B_pgv5(:,2),round(2*sqrt(length(B_pgv5)))); hold on;
line([b_pgv5(2) b_pgv5(2)], ylim(),'LineStyle','--');
xlabel('PGV: B_1 values'); ylabel('Count');


% B0, MMI, CDI 6.
subplot(5,6,25);
histogram(B_mmi6(:,1),round(2*sqrt(length(B_mmi6)))); hold on;
line([b_mmi6(1) b_mmi6(1)], ylim(),'LineStyle','--');
xlabel('MMI: B_0 values'); ylabel('Count');

% B1, MMI, CDI 6.
subplot(5,6,26);
histogram(B_mmi6(:,2),round(2*sqrt(length(B_mmi6)))); hold on;
line([b_mmi6(2) b_mmi6(2)], ylim(),'LineStyle','--');
xlabel('MMI: B_1 values'); ylabel('Count');

% B0, PGA, CDI 6.
subplot(5,6,27);
histogram(B_pga6(:,1),round(2*sqrt(length(B_pga6)))); hold on;
line([b_pga6(1) b_pga6(1)], ylim(),'LineStyle','--');
xlabel('PGA: B_0 values'); ylabel('Count');

% B1, PGA, CDI 6.
subplot(5,6,28);
histogram(B_pga6(:,2),round(2*sqrt(length(B_pga6)))); hold on;
line([b_pga6(2) b_pga6(2)], ylim(),'LineStyle','--');
xlabel('PGA: B_1 values'); ylabel('Count');

% B0, PGV, CDI 6.
subplot(5,6,29);
histogram(B_pgv6(:,1),round(2*sqrt(length(B_pgv6)))); hold on;
line([b_pgv6(1) b_pgv6(1)], ylim(),'LineStyle','--');
xlabel('PGV: B_0 values'); ylabel('Count');

% B1, PGV, CDI 6.
subplot(5,6,30);
histogram(B_pgv6(:,2),round(2*sqrt(length(B_pgv6)))); hold on;
line([b_pgv6(2) b_pgv6(2)], ylim(),'LineStyle','--');
xlabel('PGV: B_1 values'); ylabel('Count');



% Plot the fitted distributions.
figure(2); clf;

subplot(321);
plot( Bin_mmi2, pl_mmi2*100,'-'); hold on;
plot( Bin_mmi3, pl_mmi3*100,'-');
plot( Bin_mmi4, pl_mmi4*100,'-');
plot( Bin_mmi5, pl_mmi5*100,'-');
plot( Bin_mmi6, pl_mmi6*100,'-');
r=6*rand(size(dyfi_mmi0))-3;
plot( gm_mmi0( cdi_mmi0>=2.0 ),100*dyfi_mmi0( cdi_mmi0>=2.0 )+r( cdi_mmi0>=2.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#0072BD','MarkerSize',3  );
plot( gm_mmi0( cdi_mmi0>=3.0 ),100*dyfi_mmi0( cdi_mmi0>=3.0 )+r( cdi_mmi0>=3.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#D95319','MarkerSize',3  );
plot( gm_mmi0( cdi_mmi0>=4.0 ),100*dyfi_mmi0( cdi_mmi0>=4.0 )+r( cdi_mmi0>=4.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#EDB120','MarkerSize',3  );
plot( gm_mmi0( cdi_mmi0>=5.0 ),100*dyfi_mmi0( cdi_mmi0>=5.0 )+r( cdi_mmi0>=5.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#7E2F8E','MarkerSize',3  );
plot( gm_mmi0( cdi_mmi0>=6.0 ),100*dyfi_mmi0( cdi_mmi0>=6.0 )+r( cdi_mmi0>=6.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#77AC30','MarkerSize',3  );
plot( gm_mmi0(~dyfi_mmi0),    dyfi_mmi0(~dyfi_mmi0)+r(~dyfi_mmi0),  'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
ylim([-5 105]); xlim([2 7]);
xlabel('MMI'); ylabel('Chance of Nuisance, u_N (%)');


subplot(322);
plot( fp_mmi2*100,tp_mmi2*100); hold on;
plot( fp_mmi3*100,tp_mmi3*100);
plot( fp_mmi4*100,tp_mmi4*100);
plot( fp_mmi5*100,tp_mmi5*100);
plot( fp_mmi6*100,tp_mmi6*100);
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70, 5,['CDI 2:  AUC=',num2str(auc_mmi2)]);
text(70,10,['CDI 3:  AUC=',num2str(auc_mmi3)]);
text(70,15,['CDI 4:  AUC=',num2str(auc_mmi4)]);
text(70,20,['CDI 5:  AUC=',num2str(auc_mmi5)]);
text(70,25,['CDI 6:  AUC=',num2str(auc_mmi6)]);


subplot(323);
semilogx( Bin_pga2, pl_pga2*100,'-'); hold on;
semilogx( Bin_pga3, pl_pga3*100,'-');
semilogx( Bin_pga4, pl_pga4*100,'-');
semilogx( Bin_pga5, pl_pga5*100,'-');
semilogx( Bin_pga6, pl_pga6*100,'-');
r=6*rand(size(dyfi_pga0))-3;
semilogx( gm_pga0( cdi_pga0>=2.0 ),100*dyfi_pga0( cdi_pga0>=2.0 )+r( cdi_pga0>=2.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#0072BD','MarkerSize',3  );
semilogx( gm_pga0( cdi_pga0>=3.0 ),100*dyfi_pga0( cdi_pga0>=3.0 )+r( cdi_pga0>=3.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#D95319','MarkerSize',3  );
semilogx( gm_pga0( cdi_pga0>=4.0 ),100*dyfi_pga0( cdi_pga0>=4.0 )+r( cdi_pga0>=4.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#EDB120','MarkerSize',3  );
semilogx( gm_pga0( cdi_pga0>=5.0 ),100*dyfi_pga0( cdi_pga0>=5.0 )+r( cdi_pga0>=5.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#7E2F8E','MarkerSize',3  );
semilogx( gm_pga0( cdi_pga0>=6.0 ),100*dyfi_pga0( cdi_pga0>=6.0 )+r( cdi_pga0>=6.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#77AC30','MarkerSize',3  );
semilogx( gm_pga0(~dyfi_pga0),    dyfi_pga0(~dyfi_pga0)+r(~dyfi_pga0),  'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
ylim([-5 105]); xlim([10^-3 10^0.8]);
xlabel('PGA (m/s^2)'); ylabel('Chance of Nuisance, u_N (%)');

subplot(324);
plot( fp_pga2*100,tp_pga2*100); hold on;
plot( fp_pga3*100,tp_pga3*100);
plot( fp_pga4*100,tp_pga4*100);
plot( fp_pga5*100,tp_pga5*100);
plot( fp_pga6*100,tp_pga6*100);
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70, 5,['CDI 2:  AUC=',num2str(auc_pga2)]);
text(70,10,['CDI 3:  AUC=',num2str(auc_pga3)]);
text(70,15,['CDI 4:  AUC=',num2str(auc_pga4)]);
text(70,20,['CDI 5:  AUC=',num2str(auc_pga5)]);
text(70,25,['CDI 6:  AUC=',num2str(auc_pga6)]);


subplot(325);
semilogx( Bin_pgv2, pl_pgv2*100,'-'); hold on;
semilogx( Bin_pgv3, pl_pgv3*100,'-');
semilogx( Bin_pgv4, pl_pgv4*100,'-');
semilogx( Bin_pgv5, pl_pgv5*100,'-');
semilogx( Bin_pgv6, pl_pgv6*100,'-');
r=6*rand(size(dyfi_pgv0))-3;
semilogx( gm_pgv0( cdi_pgv0>=2.0 ),100*dyfi_pgv0( cdi_pgv0>=2.0 )+r( cdi_pgv0>=2.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#0072BD','MarkerSize',3  );
semilogx( gm_pgv0( cdi_pgv0>=3.0 ),100*dyfi_pgv0( cdi_pgv0>=3.0 )+r( cdi_pgv0>=3.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#D95319','MarkerSize',3  );
semilogx( gm_pgv0( cdi_pgv0>=4.0 ),100*dyfi_pgv0( cdi_pgv0>=4.0 )+r( cdi_pgv0>=4.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#EDB120','MarkerSize',3  );
semilogx( gm_pgv0( cdi_pgv0>=5.0 ),100*dyfi_pgv0( cdi_pgv0>=5.0 )+r( cdi_pgv0>=5.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#7E2F8E','MarkerSize',3  );
semilogx( gm_pgv0( cdi_pgv0>=6.0 ),100*dyfi_pgv0( cdi_pgv0>=6.0 )+r( cdi_pgv0>=6.0 ),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','#77AC30','MarkerSize',3  );
semilogx( gm_pgv0(~dyfi_pgv0),    dyfi_pgv0(~dyfi_pgv0 )+r(~dyfi_pgv0 ),  'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
ylim([-5 105]); xlim([10^-4 10^-0.7]);
xlabel('PGV (m/s)'); ylabel('Chance of Nuisance, u_N (%)');

subplot(326);
plot( fp_pgv2*100,tp_pgv2*100); hold on;
plot( fp_pgv3*100,tp_pgv3*100);
plot( fp_pgv4*100,tp_pgv4*100);
plot( fp_pgv5*100,tp_pgv5*100);
plot( fp_pgv6*100,tp_pgv6*100);
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70, 5,['CDI 2:  AUC=',num2str(auc_pgv2)]);
text(70,10,['CDI 3:  AUC=',num2str(auc_pgv3)]);
text(70,15,['CDI 4:  AUC=',num2str(auc_pgv4)]);
text(70,20,['CDI 5:  AUC=',num2str(auc_pgv5)]);
text(70,25,['CDI 6:  AUC=',num2str(auc_pgv6)]);







