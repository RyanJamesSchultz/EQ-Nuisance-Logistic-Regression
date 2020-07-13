clear;

c=0.9;
cf=1;
load('data/dataStructV4d+.mat');

pop=vertcat(S.zPop);
con=vertcat(S.zC);
dyfiP=vertcat(S.pDYFI);
dyfiZ=vertcat(S.zDYFI);
cdi=[vertcat(S.pCDI)];

Ne=length(S);
Nz=length(pop);
Nf=sum(con);

Pr=con./pop;
Pr(isnan(Pr))=[];
Pr(isinf(Pr))=[];
Pr(Pr<=0)=[];

Pf=(1-cf*mean(Pr)).^pop;
Pf(Pf>=0.20)=0.20;

figure(1); clf;
subplot(511);
histogram(pop,round(sqrt(length(pop))));
set(gca, 'YScale', 'log');
xlabel('Zip Code Population'); ylabel('Count');

subplot(512);
histogram(con,round(sqrt(length(con))));
set(gca, 'YScale', 'log');
xlabel('Zip Code Number of Felt Reports'); ylabel('Count');

subplot(513);
histogram(Pr,round(sqrt(length(Pr))));
set(gca, 'YScale', 'log');
xlabel('Percent Reporting (%)'); ylabel('Count');

subplot(514);
histogram(Pf*100,round(sqrt(length(Pf))));
set(gca, 'YScale', 'log');
xlabel('Chance a Zip Code will need to Flip (%)'); ylabel('Count');

subplot(515);
histogram(cdi,0:10);
%set(gca, 'YScale', 'log');
xlabel('CDI'); ylabel('Count');

% Report some numbers.
fprintf('\n\n');
fprintf('Number of earthquakes:  %d\n',Ne);
fprintf('Number of zip codes: %d\n',Nz);
fprintf('Number of felt reports: %d\n',Nf);
fprintf('\n');
fprintf('Average of population in zips:   %f\n',mean(pop));
fprintf('Average number of reports per zip:   %f\n',mean(con(con~=0)));
fprintf('Percent of population reporting: %f\n',cf*mean(Pr)*100);
fprintf('\n');
fprintf('Percent chance an average zip has no reports: %f\n',((1-cf*mean(Pr))^mean(pop))*100);
fprintf('Median percent of zip codes needing to flip: %f\n',median(Pf)*100);
fprintf('\n');
fprintf('Percent of DYFI reports, stating not felt: %f\n',(sum(dyfiP==0)/length(dyfiP))*100);
fprintf('Percent of ZIP reports, stating not felt: %f\n',(sum(dyfiZ==0)/length(dyfiZ))*100);
fprintf('\n\n');