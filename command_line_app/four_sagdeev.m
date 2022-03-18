clear; close all; clc;

ke1 = 1000;
ne1 = 0.055;
ze1 = -1;
te1 = 0.12;
ke2 = 1000;
ne2 = 1-ne1;
ze2 = -1;
te2 = 1;

np1 = 0.5;
zp1 = 1;
tp1 = 0.2;
mup1 = 1;
vp1 = 0;
np2 = 1-np1;
zp2 = 1;
tp2 = 0.1;
mup2 = 4;
vp2 = 0;

syms m 
f = ((ne1*ze1^2)/(te1))*((2*ke1-1)/(2*ke1-3)) +((ne2*ze2^2)/(te2))*((2*ke2-1)/(2*ke2-3)) +np1/(mup1*((m - vp1)^2 - 3*tp1/mup1))+np2/(mup2*((m - vp2)^2 - 3*tp2/mup2));
V = vpa(solve(f==0,m));
V= sort(real(V))

M=1.051;
ph=0:0.0001:8;

Hot_fluid_Sagdeev;
kappa_distributed_fluid;
Cold_fluid_Sagdeev;
[~, l2] =size(ph);

S =@(x,y) dk(y, ne1, te1, ke1, ze1) +dk(y, ne2, te2, ke2, ze2) +dh(y, M, vp1, np1, tp1, mup1, zp1)+dh(y, M, vp2, np2, tp2, mup2, zp2);


sagdeev_second_half
