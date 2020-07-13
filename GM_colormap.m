function [Cz] = GM_colormap()
  % GM_colormap()
  %
  % Simple function to generate a USGS style color map to display 
  % earthquakes ground motion maps.
  %
  % Written by Ryan Schultz.
  %
  % Reference:
  %
  % Wald, D. J., Worden, B. C., Quitoriano, V., & Pankow, K. L. (2005). 
  % ShakeMap manual: technical manual, user's guide, and software guide (No. 12-A1).
  % https://doi.org/10.3133/tm12A1.
  % 
  
  n=50;
  
  % ShakeMap colour palette.
  Cz=[255 255 255; ...
     255 255 255; ...
     191 204 255; ...
     160 230 255; ...
     128 255 255; ...
     122 255 147; ...
     255 255   0; ...
     255 200   0; ...
     255 145   0; ...
     255   0   0; ...
     200   0   0; ...
     128   0   0];
  
  % Define the ShakeMap colours to ground motion ranges mapping.
  %if(strcmpi(GM_type, 'PGA'))
  %    %Zr=[0 0.17 1.4 3.9 9.2 18 34 65 124]';
  %    Zr=[0 0.17; 0.17 0.43; 0.43 1.4; 1.4 3.9; 3.9 9.2; 9.2 18; 18 34; 34 65; 65 124; 124 236; 236 inf];
  %elseif(strcmpi(GM_type, 'PGV'))
  %    %Zr=[0 0.10 1.1 3.4 8.1 16 31 60 116]';
  %    Zr=[0 0.10; 0.10 0.25; 0.25 1.1; 1.1 3.4; 3.4 8.1; 8.1 16; 16 31; 31 60; 60 116; 116 225; 225 inf];
  %elseif(strcmpi(GM_type, 'MMI'))
  %    %Zr=[0 1 2 3 4 5 6 7 8 9 10 13]';
  %    Zr=[0 1; 1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9; 9 10; 10 13];
  %end
     
  %colors = zeros(size(z));         
  %for i = 1:size(crange,1)
  %    colors(z > crange(i,1) & z<=crange(i,2)) = crange(i,2);           
  %end
  
  Cz=Cz/255;
  
  I=1:length(Cz);
  Cz=interp1(I,Cz,min(I):1/n:max(I));

return;