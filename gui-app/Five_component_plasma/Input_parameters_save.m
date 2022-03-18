% Part of Five component fluid software
% Auther : Ajay Lotekar
% Copyrigts (C) Ajay Lotekar
%% This program will update/write Input parmeters
global Nce Tce vbce
global Nwce Twce vbwce
global Nwe Twe vbwe
global Nhe The vbhe
global Ni Ti vbi
global M res_M lf rf  dph tlbr

In_fl=dir(fullfile('./','Inputs.txt'));
fid = fopen( 'Inputs.txt', 'at' );
if isempty(In_fl)
    fprintf( fid, '%8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %12s\n', 'Nce', 'Nwce', 'Nwe','Nhe','Ni', 'Tce','Twce', 'Twe','The','Ti', 'vbce','vbwce', 'vbwe','vbhe','vbi', 'M');
end
fprintf( fid, '%8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %12.8f\n', Nce, Nwce, Nwe, Nhe, Ni, Tce, Twce, Twe, The, Ti, vbce, vbwce, vbwe, vbhe, vbi, M);

fclose(fid);
