function dk = spp_maxwellian(y, fj, tuj, zj)
%% density term in sagdeev Psudo-potential due to kappa density distribution
% dk = spp_kappa(y, fj, tuj, kpj, zj)
%
% Input
% y =  potential (phi)
% fj = Density ratio Ns/Ntotal
% tuj = Temprature ratio Ts/Tnorm
% zj  =  charge(+ve or -ve) 
%
% Output:
%      dk = density 
%
%
% Author : Ajay Lotekar
% To Do:
%       (1) chane to actual maxwallian 
%%
kpj = 10000;
dk = fj*tuj*(1-(1+(zj*y/(tuj*(kpj-1.5) ) ))^(-1*kpj+1.5) );

end