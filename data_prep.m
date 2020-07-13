function [gm_bin,Fe,Fl,B,covB,P,FPr,TPr,AUC,gm,dyfi,cdi,w]=data_prep(S,cdi_thresh,gm_flag,ind_flag,bs_flag)
  % Simple wrapper function to prep data and fit.
  %
  % Written by Ryan Schultz.
  
  % Get DYFI information and weights.
  dyfi=vertcat(S.zDYFI);
  w=vertcat(S.zW);
  cdi=vertcat(S.zCDI);
  pop=vertcat(S.zPop);
  flag=ones(size(w));
  %cdi=zeros(size(cdi));
  
  % Make a list of EQ ids, same as other information and weights.
  id=[];
  for i=1:length(S)
      id=[id;i*ones(size(S(i).zW))];
  end
  
  % Get the appropriate ground motion.
  if(strcmpi(gm_flag,'MMI'))
      gm=vertcat(S.zMMI);
      GMend=[1 7];
  elseif(strcmpi(gm_flag,'PGA'))
      gm=log10(vertcat(S.zPGA));
      GMend=[-4 2];
  elseif(strcmpi(gm_flag,'PGV'))
      gm=log10(vertcat(S.zPGV));
      GMend=[-5 0];
  end
  
  % Use individualized responses, if flagged to.
  if(strcmpi(ind_flag,'yes'))
      
      % Keep only zip results with no felt reports.
      gm=gm(~dyfi);
      w=w(~dyfi);
      cdi=cdi(~dyfi);
      pop=pop(~dyfi);
      flag=flag(~dyfi);
      dyfi=dyfi(~dyfi);
      id=id(~dyfi);
      
      % Tack on the individualized felt reports.
      dyfi=[dyfi;vertcat(S.pDYFI)];
      w=[w;vertcat(S.pW)];
      cdi=[cdi;vertcat(S.pCDI)];
      %cdi=[cdi;vertcat(S.pReact)];
      flag=[flag;zeros(size(vertcat(S.pDYFI)))];
      pop=[pop;ones(size(vertcat(S.pDYFI)))];
      if(strcmpi(gm_flag,'MMI'))
          gm=[gm;vertcat(S.pMMI)];
      elseif(strcmpi(gm_flag,'PGA'))
          gm=[gm;log10(vertcat(S.pPGA))];
      elseif(strcmpi(gm_flag,'PGV'))
          gm=[gm;log10(vertcat(S.pPGV))];
      end
      
      for i=1:length(S)
          id=[id;i*ones(size(S(i).pW))];
      end
      
  end
  
  % Scrub out poorly interpolated ground motion values.
  I=isinf(gm);
  gm(I)=[];   w(I)=[];   cdi(I)=[];   dyfi(I)=[];   flag(I)=[];   pop(I)=[]; id(I)=[];
  
  % Scrub out data below the lower end of the GM thresholds.
  I=gm<GMend(1);
  gm(I)=[];   w(I)=[];   cdi(I)=[];   dyfi(I)=[];   flag(I)=[];   pop(I)=[]; id(I)=[];
  
  % Get bin edges.
  N=length(gm);
  [~,gm_bin,~]=histcounts( gm, round(3*sqrt(N)) );
  
  % Cut-off at CDI threshold value.
  dyfiC=(cdi>=cdi_thresh)&dyfi;
  
  % Perturb the input data, if flagged to.
  if(strcmpi(bs_flag,'yes'))
      
      % Randomly decimate the felt reports.
      I=find((dyfi==1)|(flag==0));
      I=I(unique(randperm(length(I),round(0.1*length(I)))));
      gm(I)=[];   w(I)=[];   cdi(I)=[];   dyfi(I)=[];   flag(I)=[];   dyfiC(I)=[];   pop(I)=[]; id(I)=[];
      
      % Perturb the ground motion, because of distance.
      gm=gm+normrnd(0.0,0.20,size(gm));
      
      % Perturb the ground motion, because of event variance.
      [~,~,I]=unique(id);
      gmP=normrnd(0.0,0.20,size(unique(id)));
      gm=gm+gmP(I);
      
      % Randomly flip the non-reporting zip codes.
      I=((flag==1)&(dyfi==0));
      temp=(1-0.0020).^pop;
      temp(temp>=0.20)=0.20;
      temp=temp>=rand(size(temp));
      I=I&temp;
      dyfi(I)=not(dyfi(I));
      dyfiC(I)=not(dyfiC(I));
      
  end
  
  % Empirically estimate the nuisance response curve.
  Fe=empirical_Fraction(gm,gm_bin,dyfiC,w);

  % Logistically fit the nuisance response curve.
  [Fl,P,B,covB,FPr,TPr,AUC]=logistic_fit(gm,gm_bin,dyfiC,w,GMend);
  
  % Convert back to linear units, if nessecary.
  if(strcmpi(gm_flag,'MMI'))
      return;
  end
  gm_bin=10.^gm_bin;
  gm=10.^gm;
  
return

