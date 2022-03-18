%% Kappa distributed fluid sagdeev function 
%
% Written by Ajay Lotekar
% Date:- June 20, 2018
%% Input parameter to the function 
%
% y = Phi
% fj = Density ratio Ns/Ntotal
% tuj = Temprature ratio Ts/Tnorm
% zj  = atomic number + charge(+ve or -ve) 


dk =@(y, fj, tuj, kpj, zj) fj*tuj*(1-(1+(zj*y/(tuj*(kpj-1.5) ) ))^(-1*kpj+1.5) );

%% 