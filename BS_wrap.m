function [gm_bin,fl,b,covB,p,fpr,tpr,auc,Fl,B,P,FPr,TPr,AUC]=BS_wrap(S,cdi_thresh,gm_flag,ind_flag,Nbs)
  % Simple wrapper function to bootstrap the prep data and fit.
  %
  % Written by Ryan Schultz.
  
  % Run it first, without perturbations.
  [gm_bin,~,~,~,~,~,FPr,~,~,gm,dyfi,cdi,~]=data_prep(S,cdi_thresh,gm_flag,ind_flag,'no');
  
  % Initialize the vectors.
  B=zeros([Nbs 2]);
  AUC=zeros([Nbs 1]);
  P=zeros([Nbs 5]);
  Fl=zeros([Nbs length(gm_bin)]);
  TPr=zeros([Nbs length(FPr)]);
  FPr=TPr;
  
  % Loop over all boot strap realizations.
  for i=1:Nbs
      
      % Compute the perturbed data fit.
      %I=unique(randperm(length(S),round(0.9*length(S))));
      [~,~,fl,b,~,p,fpr,tpr,auc,~,~,~,~]=data_prep(S,cdi_thresh,gm_flag,ind_flag,'yes');
      
      % Stuff results into vectors.
      B(i,:)=b;
      AUC(i)=auc;
      P(i,:)=p;
      Fl(i,:)=fl;
      %TPr(i,:)=tpr;
      %FPr(i,:)=fpr;
  end
  
  % Compute the covariance matrix.
  covB=cov(B);
  
  % Compute the average fit parameters.
  b=median(B);
  
  % Convert to log scale for PGV & PGA ground motions.
  if(~strcmpi(gm_flag,'MMI'))
      gm_bin=log10(gm_bin);
      gm=log10(gm);
  end
  
  % Compute the boot strapped fit function.
  fl=glmval(b',gm_bin,'logit');
  fit=glmval(b',gm,'logit');
  dyfiC=(cdi>=cdi_thresh)&dyfi;
  [fpr,tpr,~,auc]=perfcurve( dyfiC,fit,1);
  
  % Find the percentiles.
  p=[0.05 0.32 0.50 0.68 0.95];
  p=interp1(fl,gm_bin,p,'spline');
  
  % Convert back to linear scale for PGV & PGA ground motions.
  if(~strcmpi(gm_flag,'MMI'))
      gm_bin=10.^gm_bin;
      gm=10.^gm;
  end
  
end