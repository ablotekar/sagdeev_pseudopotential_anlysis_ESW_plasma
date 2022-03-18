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

dc =@(y, m, vbj, fj,  muj, zj) fj*(muj*(m-vbj)^2)*(1-sqrt(1-((2*zj*y)/(muj*(m-vbj)^2))));
