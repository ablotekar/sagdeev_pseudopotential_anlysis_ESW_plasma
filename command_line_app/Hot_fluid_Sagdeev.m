%% Hot fluid sagdeev function 
%
% Written by Ajay Lotekar
% Date:- June 20, 2018
%% Input parameter to the function 
%
% y = Phi
% m = Mach number (M)
% vbj = Beam velocity
% fj = Density ratio Ns/Ntotal
% sgj = Temprature ratio Ts/Tnorm
% muj = Mass ratio ms/m_norm
% zj  = atomic number + charge(+ve or -ve) 

dh =@(y, m, vbj, fj, sgj, muj, zj) ((muj*fj)/(6*sqrt((3*sgj)/muj)))*((((m-vbj) + sqrt((3*sgj)/muj)).^3 ...
    -(((m-vbj) + sqrt((3*sgj)/muj))*sqrt(1 - (2*zj*y)/(muj*((m-vbj) + sqrt((3*sgj)/muj)).^2))).^3) ...
    - (((m-vbj) -sqrt((3*sgj)/muj)).^3 - (((m-vbj) - sqrt((3*sgj)/muj))*sqrt( ...
    1 - (2*zj*y)/(muj*((m-vbj) - sqrt((3*sgj)/muj)).^2))).^3));

%% Calling funciton 
% f = d(Phi, M, Vb, N, T, m, -1)