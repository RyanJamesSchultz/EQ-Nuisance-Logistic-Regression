% Simple script to parse all of the USGS ShakeMap & DYFI data into a Matlab
% structure for further analysis.
clear;

% Predefine file names.
ISall='IS.csv';
ISdyfi='IS_dyfi.csv';
ISsmap='IS_smap.csv';
ISshit='shit_list';

% Get a list of all the event IDs.
% From the complete IS catalogue.
system(['tail +2 ', ISall, ' | awk -F, ''{print $1}'' > temp.makeDATA' ]);
fid = fopen('temp.makeDATA', 'r'); data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
IDall= data{1};
% From the DYFI IS catalogue.
system(['tail +2 ', ISdyfi, ' | awk -F, ''{print $1}'' > temp.makeDATA' ]);
fid = fopen('temp.makeDATA', 'r'); data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
IDdyfi= data{1};
% From the ShakeMap IS catalogue.
system(['tail +2 ', ISsmap, ' | awk -F, ''{print $1}'' > temp.makeDATA' ]);
fid = fopen('temp.makeDATA', 'r'); data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
IDsmap= data{1};
system('rm -f temp.makeDATA');
% From the indvidual DYFI information.
system('ls ind_dyfi/*.csv | awk -F[./] ''{print $2}'' > temp.makeDATA');
fid = fopen('temp.makeDATA', 'r'); data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
IDdyfi2= data{1};
system('rm -f temp.makeDATA');

% Get the shit-list: the IDs of bad events.
fid = fopen(ISshit, 'r'); data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
IDshit= data{1};

% Condense down to just events that are in all three catalogues.
list=intersect(IDall,IDdyfi);
list=intersect(list,IDsmap);
list=intersect(list,IDdyfi2);

% Remove IDs from the shit-list.
list=setdiff(list,IDshit);

% Call the parsing/wrapping function.
S=USGS_EQ_xml_wrapper(list);

% Save the data.
save('dataStruct.mat','S', '-v7.3');


