function S=USGS_EQ_xml_wrapper(IDlist)
  % Wrapper function to take both USGS *.xml ShakeMap data and USGS 
  % DYFI data and then parse it into a Matlab structure.
  %
  % Written by Ryan Schultz.
  
  % Define directory.
  Hdir='/Users/rjs10/Desktop/nuisance/codes/data/';
  
  % Prep outut structure.
  S=struct('EID',{},'M',[],'eLat',[],'eLon',[],'eDep',[],'gLat',[],'gLon',[],'gPGA',[],'gPGV',[],'gMMI',[],'zLat',[],'zLon',[],'zZip',[],'zPop',[],'zCDI',[],'zC',[],'zRe',[],'zDYFI',[],'zPGA',[],'zPGV',[],'zMMI',[],'zW',[],'pLat',[],'pLon',[],'pCDI',[],'pRe',[],'pDYFI',[],'pPGA',[],'pPGV',[],'pMMI',[],'pW',[]);
  
  
  for i=1:length(IDlist)
      
      % Load in USGS ShakeMap datafile
      %xml_file=dir([Hdir,'ShakeMap/',IDlist{i},'/',IDlist{i},'*.xml']); % Original dataset from LibComcat.
      %xml_file=dir([Hdir,'ShakeMapV4/',IDlist{i},'*with_dyfi.grid.xml']); % V4 dataset, with DYFI.
      %xml_file=dir([Hdir,'ShakeMapV4/',IDlist{i},'*no_dyfi.grid.xml']); % V4 dataset, without DYFI.
      xml_file=dir([Hdir,'ShakeMapV4+/',IDlist{i},'*with_dyfi.grid.xml']); % V4+ dataset, with DYFI.
      xml_file=[xml_file(1).folder,'/',xml_file(1).name];
      data=xml2struct(xml_file);
      
      % Stuff easy things into the new structure.
      S(i).EID=IDlist{i};
      S(i).M=str2double(data.shakemap_grid.event.Attributes.magnitude);
      S(i).eLat=str2double(data.shakemap_grid.event.Attributes.lat);
      S(i).eLon=str2double(data.shakemap_grid.event.Attributes.lon);
      S(i).eDep=str2double(data.shakemap_grid.event.Attributes.depth);
      
      i
      S(i).EID
      
      % Grab some other stuff that'll be useful.
      Ny=str2double(data.shakemap_grid.grid_specification.Attributes.nlat);
      Nx=str2double(data.shakemap_grid.grid_specification.Attributes.nlon);
      %dy=str2double(data.shakemap_grid.grid_specification.Attributes.nominal_lat_spacing);
      %dx=str2double(data.shakemap_grid.grid_specification.Attributes.nominal_lon_spacing);
      
      % Find what part of the grid data the LAT, LON, PGA, PGV, & MMI are in.
      temp=cell2mat(data.shakemap_grid.grid_field); temp=[temp.Attributes];
      N=length(temp);
      name={temp.name};
      index=str2double({temp.index});
      Ilat=index( strcmpi(name,'LAT') );
      Ilon=index( strcmpi(name,'LON') );
      Ipga=index( strcmpi(name,'PGA') );
      Ipgv=index( strcmpi(name,'PGV') );
      Immi=index( strcmpi(name,'MMI') );
      
      % Read in ShakMap grid data of ground motions.
      % Lon, Lat, PGA, PGV, MMI, PSA03, PSA10, PSA30, STDPGA, URAT, SVEL.
      if(N==8)
          g=textscan(data.shakemap_grid.grid_data.Text, '%f %f %f %f %f %f %f %f\n');
      elseif(N==9)
          g=textscan(data.shakemap_grid.grid_data.Text, '%f %f %f %f %f %f %f %f %f\n');
      elseif(N==10)
          g=textscan(data.shakemap_grid.grid_data.Text, '%f %f %f %f %f %f %f %f %f %f\n');
      elseif(N==11)
          g=textscan(data.shakemap_grid.grid_data.Text, '%f %f %f %f %f %f %f %f %f %f %f\n');
      end
      
      % Stuff ground motion grid into structure.
      S(i).gLon=unique(g{Ilon});
      S(i).gLat=unique(g{Ilat});
      S(i).gPGA=flipud(reshape(g{Ipga}, [Nx, Ny] )')*9.81/100;
      S(i).gPGV=flipud(reshape(g{Ipgv}, [Nx, Ny] )')/100;
      S(i).gMMI=flipud(reshape(g{Immi}, [Nx, Ny] )');
      
      
      
      % Read in the indvidualized DYFI data.
      % Lon, Lat, Felt?
      dyfi_file=dir([Hdir,'ind_dyfi/',IDlist{i},'*csv']);
      dyfi_file=[dyfi_file(1).folder,'/',dyfi_file(1).name];
      %system(['awk -F, ''/#/{next} {print $4, $3, $6, $2, $10}'' ', dyfi_file, ' | awk ''/undef/{next} {print}'' > temp.Pdyfi']);
      system(['/usr/local/bin/gawk -vFPAT=''([^,]+)|(\"[^\"]+\")|'' ''/#/{next} {print $4, $3, $6, $2}'' ', dyfi_file, ' | awk ''/undef/{next} {print}'' > temp.Pdyfi']);
      data=load('temp.Pdyfi');
      system('rm -f temp.Pdyfi');
      
      % Stuff DYFI data into structure.
      S(i).pLon=data(:,1);
      S(i).pLat=data(:,2);
      S(i).pDYFI=logical(data(:,3));
      S(i).pCDI=data(:,4);
      %S(i).pReact=data(:,5);
      
      % Make sure the data is within the ShakeMap grid.
      I=(S(i).pLon>max(S(i).gLon))|(S(i).pLon<min(S(i).gLon))|(S(i).pLat>max(S(i).gLat))|(S(i).pLat<min(S(i).gLat));
      S(i).pLon=S(i).pLon(~I);
      S(i).pLat=S(i).pLat(~I);
      S(i).pDYFI=S(i).pDYFI(~I);
      S(i).pCDI=S(i).pCDI(~I);
      %S(i).pReact=S(i).pReact(~I);
      
      % Compute distances.
      if(~isempty(S(i).pDYFI))
          S(i).pRe=Geoid_Distance(S(i).eLat,S(i).eLon, S(i).pLat,S(i).pLon, 'elliptical')*111.1949;
      else
          S(i).pRe=[];
      end
      
      % Interpolate
      S(i).pMMI=    interp2(S(i).gLon,S(i).gLat,      S(i).gMMI,   S(i).pLon,S(i).pLat, 'linear',NaN);
      S(i).pPGA=10.^interp2(S(i).gLon,S(i).gLat,log10(S(i).gPGA),  S(i).pLon,S(i).pLat, 'linear',NaN);
      S(i).pPGV=10.^interp2(S(i).gLon,S(i).gLat,log10(S(i).gPGV),  S(i).pLon,S(i).pLat, 'linear',NaN);
      
      % Compute weights.
      S(i).pW=ones(size(S(i).pMMI));
      
      
      
      % Read in zip code data.
      % ZIP, lat, lon, population.
      data=load('DBzip/zip_db.csv');
      S(i).zZip=data(:,1);
      S(i).zLat=data(:,2);
      S(i).zLon=data(:,3);
      S(i).zPop=data(:,4);
      
      % Keep zip codes within box.
      I=(S(i).zLon>max(S(i).gLon))|(S(i).zLon<min(S(i).gLon))|(S(i).zLat>max(S(i).gLat))|(S(i).zLat<min(S(i).gLat));
      S(i).zLon=S(i).zLon(~I);
      S(i).zLat=S(i).zLat(~I);
      S(i).zZip=S(i).zZip(~I);
      S(i).zPop=S(i).zPop(~I);
      
      
      
      % Read in the USGS DYFI zip code data.
      % ZIP, report-count.
      zip_file=dir([Hdir,'DYFI/',IDlist{i},'/',IDlist{i},'*cdi_zip.txt']);
      zip_file=[zip_file(1).folder,'/',zip_file(1).name];
      system([' awk -F[,\"] ''/#/ {next} {print $2, $4, $5}'' ',zip_file, ' > temp.Zdyfi']);
      data=load('temp.Zdyfi');
      system('rm -f temp.Zdyfi');
      
      % Flag the ZIP codes that did have felt reports.
      S(i).zDYFI=false(size(S(i).zZip));
      [~,I,J]=intersect(S(i).zZip,data(:,1));
      S(i).zDYFI(I)=true();
      
      % Fill in the CDI values.
      S(i).zCDI=zeros(size(S(i).zZip));
      S(i).zCDI(I)=data(J,2);
      
      % Fill in the report count values.
      S(i).zC=zeros(size(S(i).zZip));
      S(i).zC(I)=data(J,3);
      
      % Compute distances.
      if(~isempty(S(i).zDYFI))
          S(i).zRe=Geoid_Distance(S(i).eLat,S(i).eLon, S(i).zLat,S(i).zLon, 'elliptical')*111.1949;
      else
          S(i).zRe=[];
      end
      
      % Keep only ZIP codes within a certain distance.
      I=S(i).zRe<(1.2*max(S(i).pRe));
      S(i).zLon=S(i).zLon(I);
      S(i).zLat=S(i).zLat(I);
      S(i).zZip=S(i).zZip(I);
      S(i).zPop=S(i).zPop(I);
      S(i).zDYFI=S(i).zDYFI(I);
      S(i).zCDI=S(i).zCDI(I);
      S(i).zC=S(i).zC(I);
      S(i).zRe=S(i).zRe(I);
      
      % Compute weights.
      S(i).zW=((S(i).zPop)/sum(S(i).zPop))*length(S(i).zPop);
      S(i).zW=S(i).zW.*(S(i).zC+1);
      
      % Interpolate
      S(i).zMMI=    interp2(S(i).gLon,S(i).gLat,      S(i).gMMI,   S(i).zLon,S(i).zLat, 'linear',NaN);
      S(i).zPGA=10.^interp2(S(i).gLon,S(i).gLat,log10(S(i).gPGA),  S(i).zLon,S(i).zLat, 'linear',NaN);
      S(i).zPGV=10.^interp2(S(i).gLon,S(i).gLat,log10(S(i).gPGV),  S(i).zLon,S(i).zLat, 'linear',NaN);
      
  end
  
return;