clear; close all; clc;

ke1 = 1000;
ne1 = 0.92;
ze1 = -1;
te1 = 0.2267;
ke2 = 4;
ne2 = 1-ne1;
ze2 = -1;
te2 = 1;

np1 = 1;
zp1 = 1;
mup1 = 1;
vp1 = 0;


ph=0:0.001:0.5;
for M=0.4894:0.001:0.82;

Hot_fluid_Sagdeev;
kappa_distributed_fluid;
Cold_fluid_Sagdeev;
[~, l2] =size(ph);

S =@(x,y) dk(y, ne1, te1, ke1, ze1) +dk(y, ne2, te2, ke2, ze2) +dc(y, M, vp1, np1, mup1, zp1);


sagdeev_second_half
pause(0.2)
end 
