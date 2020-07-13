function [F]=empirical_Fraction(gm,gm_bin,dyfi,w)
  % Simple function to emprirically estimate fractions of populations who 
  % felt an earthquake (or not).
  %
  % Written by Ryan Schultz.
  
  % Normalize the weights.
  w=w/sum(w);
  %N=length(gm);
  %Ny=sum(w( dyfi));
  %Nn=sum(w(~dyfi));
  
  % Get bin edges.
  [~,~,I]=histcounts( gm, gm_bin ); 
  
  % Produce a weighted count.
  W=zeros(size(gm_bin)); Wy=W; Wn=W; Wc=W;
  for i=1:(length(gm_bin)-1)
      W(i+1)=sum(w((I==i)));
      Wy(i+1)=sum(w((I==i)&( dyfi)));
      Wn(i+1)=sum(w((I==i)&(~dyfi)));
      Wc(i+1)=Wy(i+1)-Wn(i+1);
  end
  Wcy=Wc;
  Wcn=-Wc;
  Wcy(Wcy<0)=0;
  Wcn(Wcn<0)=0;
  
  % Compute fraction function as a CDF.
  Fcy=cumsum(Wcy)/sum(Wcy);
  Fcn=1-fliplr(cumsum(fliplr(Wcn))/sum(Wcn));
  
  % Compute the fraction of people who felt the event, in the conventional sense.
  Ff=(Wy./(Wy+Wn));
  n=round(0.05*length(gm_bin));
  Ff=smooth(Ff,n,'rlowess')';
  
  % Create the composite function.
  %F=(0.2*Ff) + (0.6*Fcn) + (0.2*Fcy);
  %F=0.1*Ff+0.9*F;
  F=Ff;
  
return