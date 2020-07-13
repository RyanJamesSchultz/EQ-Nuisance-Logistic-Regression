function [F,Fp,B,covB,FPr,TPr,AUROC]=logistic_fit(gm,gm_bin,dyfi,w,GMend)
  % Simple wrapper function to perform logistic regression.
  %
  % Written by Ryan Schultz.
  
  % Normalize the weights, in case they haven't been already.
  w=w/sum(w);
  %N=length(gm);
  
  % Perform logistic regression.
  [B,~,stats]=glmfit([GMend(1); gm; GMend(2)],[0; dyfi; 1],'binomial','weights',[sum(w)/20; w; sum(w)/20]);
  covB=stats.covb;
  
  % Determine AUROC.
  fit=glmval(B,gm,'logit');
  [FPr,TPr,~,AUROC]=perfcurve(dyfi,fit,1);
  
  % Compute the best fit function.
  F=glmval(B,gm_bin,'logit');
  %F=1./(1+exp(-gm_bin*B(2)-B(1)));
  
  % Find the percentiles.
  p=[0.05 0.32 0.50 0.68 0.95];
  I=((F>=0.01)&(F<=0.99));
  Fp=interp1(F(I),gm_bin(I),p,'spline');
  
return