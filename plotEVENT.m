function plotEVENT(i)
%clear;

c=0.9;
cdi_thresh=0.1;
load('data/dataStructV4d+.mat');

if(i==0)
    %i=[1 2];
    %i=find(strcmpi({S.EID},'us10004aqg')); % M 4.2 - 6km ENE of Edmond, Oklahoma, 2016-01-01.
    i=find(strcmpi({S.EID},'us2000dwui')); % M 4.6 - 26km WSW of Perry, Oklahoma, 2018-04-09.
    %i=find(strcmpi({S.EID},'usb000skq4')); % M 4.2 - 4km S of Cushing, Oklahoma, 2014-10-10.
end;


i
S(i).EID



eqMMI=interp2(S(i).gLon,S(i).gLat,S(i).gMMI,  S(i).eLon,S(i).eLat, 'linear',NaN);
eqPGA=interp2(S(i).gLon,S(i).gLat,S(i).gPGA,  S(i).eLon,S(i).eLat, 'linear',NaN);
eqPGV=interp2(S(i).gLon,S(i).gLat,S(i).gPGV,  S(i).eLon,S(i).eLat, 'linear',NaN);

% Fit the data.
[Bin_mmi,Pe_mmi,Pl_mmi,~,~,Pmmi,fpr_mmi,tpr_mmi,auc_mmi,~,dyfi_mmi,cdi_mmi,~]=data_prep(S(i),cdi_thresh,'MMI','yes','no');
[Bin_pga,Pe_pga,Pl_pga,~,~,Ppga,fpr_pga,tpr_pga,auc_pga,~,dyfi_pga,cdi_pga,~]=data_prep(S(i),cdi_thresh,'PGA','yes','no');
[Bin_pgv,Pe_pgv,Pl_pgv,~,~,Ppgv,fpr_pgv,tpr_pgv,auc_pgv,~,dyfi_pgv,cdi_pgv,~]=data_prep(S(i),cdi_thresh,'PGV','yes','no');

%Pmmi
%Ppga
%Ppgv
    
figure(1); clf;

subplot(311);
contourf(S(i).gLon, S(i).gLat, S(i).gMMI); hold on;
plot(S(i).pLon(S(i).pDYFI),S(i).pLat(S(i).pDYFI),   'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3);
%plot(S(i).pLon(~S(i).pDYFI),S(i).pLat(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(~S(i).zDYFI),S(i).zLat(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(S(i).zDYFI),S(i).zLat(S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','g','MarkerSize',3);
plot(S(i).eLon,S(i).eLat, 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','w','MarkerSize',10);
colormap(GM_colormap()); %caxis([0 13]);
h = colorbar(); h.Label.String = 'MMI';
xlabel('Longitude'); ylabel('Latitiude');
title(S(i).EID);

subplot(312);
contourf(S(i).gLon, S(i).gLat, S(i).gPGA); hold on;
plot(S(i).pLon(S(i).pDYFI),S(i).pLat(S(i).pDYFI),   'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3);
%plot(S(i).pLon(~S(i).pDYFI),S(i).pLat(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(~S(i).zDYFI),S(i).zLat(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(S(i).zDYFI),S(i).zLat(S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','g','MarkerSize',3);
plot(S(i).eLon,S(i).eLat, 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','w','MarkerSize',10);
colormap(GM_colormap()); %caxis([0 236]);
h = colorbar(); h.Label.String = 'PGA (m/s^2)';
xlabel('Longitude'); ylabel('Latitiude');
title(S(i).EID);

subplot(313);
contourf(S(i).gLon, S(i).gLat, S(i).gPGV); hold on;
plot(S(i).pLon(S(i).pDYFI),S(i).pLat(S(i).pDYFI),   'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3);
%plot(S(i).pLon(~S(i).pDYFI),S(i).pLat(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(~S(i).zDYFI),S(i).zLat(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3);
plot(S(i).zLon(S(i).zDYFI),S(i).zLat(S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','g','MarkerSize',3);
plot(S(i).eLon,S(i).eLat, 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','w','MarkerSize',10);
colormap(GM_colormap()); %caxis([0 225]);
h = colorbar(); h.Label.String = 'PGV (m/s)';
xlabel('Longitude'); ylabel('Latitiude');
title(S(i).EID);



figure(2); clf;

subplot(331);
semilogy( 0, eqMMI, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
semilogy( S(i).pRe( S(i).pDYFI), S(i).pMMI( S(i).pDYFI),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%semilogy( S(i).pRe(~S(i).pDYFI), S(i).pMMI(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( S(i).zRe(~S(i).zDYFI), S(i).zMMI(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
%semilogy( S(i).zRe( S(i).zDYFI), S(i).zMMI( S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( max(S(i).pRe(S(i).pDYFI))/c, c*min(S(i).pMMI(S(i).pDYFI)), 'd','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5  );
xlabel('Epicentral Distance (km)'); ylabel('MMI');

subplot(332);
plot( eqMMI,100, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
plot( Bin_mmi, Pe_mmi*100,'-dk');
plot( Bin_mmi, Pl_mmi*100,'-b');
plot( S(i).pMMI(S(i).pDYFI),100*ones(size(S(i).pMMI(S(i).pDYFI)))+6*rand(size(S(i).pMMI(S(i).pDYFI)))-3,  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%plot( S(i).pMMI(~S(i).pDYFI),zeros(size(S(i).pMMI(~S(i).pDYFI))),'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
plot( S(i).zMMI(~S(i).zDYFI),zeros(size(S(i).zMMI(~S(i).zDYFI)))+6*rand(size(S(i).zMMI(~S(i).zDYFI)))-3,'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
%plot( S(i).zMMI( S(i).zDYFI),100*ones(size(S(i).zMMI( S(i).zDYFI))),'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',3  );
plot( c*min(S(i).zMMI(S(i).zDYFI)),0, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5);
ylim([-5 105]); xlim([c*min(Bin_mmi) max(Bin_mmi)/c]);
xlabel('MMI'); ylabel('Chance of Nuisance (%)');

subplot(333);
plot( fpr_mmi*100,tpr_mmi*100, 'MarkerFaceColor','k'); hold on;
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70,5,['AUC: ',num2str(auc_mmi)]);

subplot(334);
semilogy( 0, eqPGA, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
semilogy( S(i).pRe( S(i).pDYFI), S(i).pPGA( S(i).pDYFI),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%semilogy( S(i).pRe(~S(i).pDYFI), S(i).pPGA(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( S(i).zRe(~S(i).zDYFI), S(i).zPGA(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
%semilogy( S(i).zRe( S(i).zDYFI), S(i).zPGA( S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( max(S(i).zRe(S(i).zDYFI))/c, c*min(S(i).zPGA(S(i).zDYFI)), 'd','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5  );
xlabel('Epicentral Distance (km)'); ylabel('PGA (m/s^2)');

subplot(335);
semilogx( eqPGA,100, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
semilogx( Bin_pga, Pe_pga*100,'-dk');
semilogx( Bin_pga, Pl_pga*100,'-b');
semilogx( S(i).pPGA(S(i).pDYFI),100*ones(size(S(i).pPGA(S(i).pDYFI)))+6*rand(size(S(i).pPGA(S(i).pDYFI)))-3,  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%semilogx( S(i).pPGA(~S(i).pDYFI),zeros(size(S(i).pPGA(~S(i).pDYFI))),'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
semilogx( S(i).zPGA(~S(i).zDYFI),zeros(size(S(i).zPGA(~S(i).zDYFI)))+6*rand(size(S(i).zPGA(~S(i).zDYFI)))-3,'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
%semilogx( S(i).zPGA( S(i).zDYFI),100*ones(size(S(i).zPGA( S(i).zDYFI))),'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',3  );
semilogx( c*min(S(i).zPGA(S(i).zDYFI)),0, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5);
ylim([-5 105]); xlim([c*min(Bin_pga) max(Bin_pga)/c]);
xlabel('PGA (m/s^2)'); ylabel('Chance of Nuisance (%)');

subplot(336);
plot( fpr_pga*100,tpr_pga*100, 'MarkerFaceColor','k'); hold on;
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70,5,['AUC: ',num2str(auc_pga)]);

subplot(337);
semilogy( 0, eqPGV, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
semilogy( S(i).pRe( S(i).pDYFI), S(i).pPGV( S(i).pDYFI),  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%semilogy( S(i).pRe(~S(i).pDYFI), S(i).pPGV(~S(i).pDYFI), 'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( S(i).zRe(~S(i).zDYFI), S(i).zPGV(~S(i).zDYFI), 'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',3  );
%semilogy( S(i).zRe( S(i).zDYFI), S(i).zPGV( S(i).zDYFI), 'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',3  );
semilogy( max(S(i).zRe(S(i).zDYFI))/c, c*min(S(i).zPGV(S(i).zDYFI)), 'd','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5  );
xlabel('Epicentral Distance (km)'); ylabel('PGV (m/s)');

subplot(338);
semilogx( eqPGV,100, 'd', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',5); hold on;
semilogx( Bin_pgv, Pe_pgv*100,'-dk');
semilogx( Bin_pgv, Pl_pgv*100,'-b');
semilogx( S(i).pPGV(S(i).pDYFI),100*ones(size(S(i).pPGV(S(i).pDYFI)))+6*rand(size(S(i).pPGV(S(i).pDYFI)))-3,  'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','g','MarkerSize',3  );
%semilogx( S(i).pPGV(~S(i).pDYFI),zeros(size(S(i).pPGV(~S(i).pDYFI))),'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',3  );
semilogx( S(i).zPGV(~S(i).zDYFI),zeros(size(S(i).zPGV(~S(i).zDYFI)))+6*rand(size(S(i).zPGV(~S(i).zDYFI)))-3,'x','MarkerEdgeColor', 'r', 'MarkerFaceColor','r','MarkerSize',5  );
%semilogx( S(i).zPGV( S(i).zDYFI),100*ones(size(S(i).zPGV( S(i).zDYFI))),'x','MarkerEdgeColor', 'g', 'MarkerFaceColor','r','MarkerSize',5  );
semilogy( c*min(S(i).zPGV(S(i).zDYFI)),0, 'd','MarkerEdgeColor', 'k', 'MarkerFaceColor','r','MarkerSize',5  );
ylim([-5 105]); xlim([c*min(Bin_pgv) max(Bin_pgv)/c]);
xlabel('PGV (m/s)'); ylabel('Chance of Nuisance (%)');

subplot(339);
plot( fpr_pgv*100,tpr_pgv*100, 'MarkerFaceColor','k'); hold on;
plot( [0 100],[0 100], '--k');
xlabel('False Positive Rate (%)'); ylabel('True Positive Rate (%)');
xlim([-5 105]); ylim([-5 105]);
text(70,5,['AUC: ',num2str(auc_pgv)]);

return
