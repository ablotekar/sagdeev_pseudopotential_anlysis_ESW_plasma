clear; close all; clc;

ke1 = 10;
ne1 = 1;
ze1 = -1;
te1 = 1;

np1 = 0.8;
zp1 = 1;
mup1 = 16;
vp1 = 0;
np2 = 1-np1;
zp2 = 1;
tp2 = 0.01;
mup2 = 1;
vp2 = 00;

syms m 
f = ((ne1*ze1^2)/(te1))*((2*ke1-1)/(2*ke1-3)) +(-1)*(np1*zp1^2)/(mup1*(m - vp1)^2)+np2/(mup2*((m - vp2)^2 - 3*tp2/mup2));
V = vpa(solve(f==0,m));
V= sort(real(V))
M_min=double(V(4));

for M=M_min:0.001:8;
ph=-0.5:0.001:1;

Hot_fluid_Sagdeev;
kappa_distributed_fluid;
Cold_fluid_Sagdeev;
[~, l2] =size(ph);

S =@(x,y) dk(y, ne1, te1, ke1, ze1) +dc(y, M, vp1, np1, mup1, zp1)+dh(y, M, vp2, np2, tp2, mup2, zp2);


sagdeev_second_half
pause(0.2)
end
