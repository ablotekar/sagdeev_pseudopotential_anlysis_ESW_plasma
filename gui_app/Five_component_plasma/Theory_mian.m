clear all; close all; clc;
%%
vbce = 0;
Nce = 0.025;
Tce = 0.1725;


Nwe = 0.4842;
Twe = 0.2413;
vbwe = 0;

Nwce = 0.4631
Twce = 0.1839;
vbwce = 0;

Nhe = 1-Nce-Nwe-Nwce;
The = 1;
vbhe =0;

Ni = 1;
Ti = 0.001;
vbi= 0;

mu = 1836;


 M = 0.798601
phi_min = -0.5*(M-sqrt(3*Tce))^2;

%%
phi_min = -0.5*(M-sqrt(3*Tce))^2;
lf = phi_min;
rf = -1* phi_min;

dph = 0.0001

phi=0:dph:rf;


sti=1;
%% Genralized density
d =@(y, m, vbj, fj, sgj, muj, zj) ((muj*fj)/(6*sqrt((3*sgj)/muj)))*((((m-vbj) + sqrt((3*sgj)/muj)).^3 ...
    -(((m-vbj) + sqrt((3*sgj)/muj))*sqrt(1 - (2*zj*y)/(muj*((m-vbj) + sqrt((3*sgj)/muj)).^2))).^3) ...
    - (((m-vbj) -sqrt((3*sgj)/muj)).^3 - (((m-vbj) - sqrt((3*sgj)/muj))*sqrt( ...
    1 - (2*zj*y)/(muj*((m-vbj) - sqrt((3*sgj)/muj)).^2))).^3));

%% Psudopotential functional
S0 =@(y) d(y, M, vbce, Nce, Tce, 1, -1) + d(y, M, vbwe, Nwe, Twe, 1, -1) ...
    + d(y, M, vbhe, Nhe, The, 1, -1)  + d(y, M, vbwce, Nwce, Twce, 1, -1) +y -sti*(y - d(y, M, vbi, Ni, Ti, 1836, 1)) ;


for i=1:length(phi)
    u(i) = S0(phi(i));  
end
%%

for i=1:length(phi)
    if isreal(u(i))
        phi(1:i-1)=[];
        u(1:i-1)=[];
        break
    end
end


plot(gca, phi, u,'linewidth',2)
%hold on
%plot(handles.axes1, [lf rf], [0 0],'k','linewidth',2)
set(gca, 'XAxisLocation', 'origin')
if min(u)<0
%app.UIAxes.YLim = [(min(u) +0.01*min(u)) 0];
end
set(gca, 'XAxisLocation', 'origin')
ax = gca;
grid on
ax.GridLineStyle = '--';
set(ax,'FontSize',12,'FontWeight','bold','linewidth',2)
%%
[a b] = min(phi);

[~, l2] =size(phi);
for j=1:l2
    
    if (a <0) && (u(j)>0)   % if phi is negative
        ll=j;
    elseif (a >= 0) && (u(j)>0)   % if phi is positive
        ll=j;
        break
    end
end
phm=phi(ll);  % Phi max

ph=[];

%% Finding solution of S0
dxx = 0.01;      % Grid size for ode calculation (zheta)
xmax=100;           % Maximum x axis limit it shold be much greater than widht by simulation
%
if a<0
    t=[xmax:-dxx:0];    % x axis matrix to give input to ode solver for -ve phi
else
    t=[0:dxx:xmax];    % x axis matrix to give input to ode solver for +ve phi
end
%% clear x and y values
clc
x=[];
y=[];
%% Genralized density
d =@(y, m, vbj, fj, sgj, muj, zj) ((muj*fj)/(6*sqrt((3*sgj)/muj)))*((((m-vbj) + sqrt((3*sgj)/muj)).^3 ...
    -(((m-vbj) + sqrt((3*sgj)/muj))*sqrt(1 - (2*zj*y)/(muj*((m-vbj) + sqrt((3*sgj)/muj)).^2))).^3) ...
    - (((m-vbj) -sqrt((3*sgj)/muj)).^3 - (((m-vbj) - sqrt((3*sgj)/muj))*sqrt( ...
    1 - (2*zj*y)/(muj*((m-vbj) - sqrt((3*sgj)/muj)).^2))).^3));

%% Psudopotential functional
S =@(x, y) d(y, M, vbce, Nce, Tce, 1, -1) + d(y, M, vbwe, Nwe, Twe, 1, -1) ...
    + d(y, M, vbhe, Nhe, The, 1, -1)  + d(y, M, vbwce, Nwce, Twce, 1, -1) +y -sti*(y - d(y, M, vbi, Ni, Ti, 1836, 1)) ;

fn = @(x,y) 0-sqrt(0-2*S(x,y));  % Sagdive pseudo potential equation
%%
[xt,yt]=ode45(fn,t ,phm);  % Solving PDE using ODE45

%% Remove negative roots in the Matrix yt and xt
[l1 l2]=size(yt);
lk=0;

for j=1:l1
    if (a <0) &&(real(yt(j)))<=0
        lk=lk+1;
    elseif (a >=0) &&(real(yt(j)))>=0
        lk=lk+1;
    end
end
%
if lk<l1
    xt(lk+1:l1,:)=[];
    yt(lk+1:l1,:)=[];
end
%% Electric field
ex=[0;-diff(real(yt))./diff(xt)];

exm = max(abs(ex))
jk=0;
for kk=1:length(ex)
    if abs(ex(kk))<=abs(0.5*exm)  % it work for +ve and -ve phi
        jk=kk;
    end
end
wE=2*abs(xt(jk))
plot(xt, ex)
ph1=real(yt);
%% Finding another half

k1=lk;
ph2=zeros(1,lk);
for i=1:lk
    ph2(i)=ph1(k1-i+1);
    ex2(i)=0-ex(k1-i+1);
end

ph2(k1)=[];
ex2(k1)=[];
ph0=[ph2';ph1];
ex0=[ex2';ex];
clear ph1 ph2 ex1 ex2

nx=2*lk-1;
x=0:nx-1;
xc=(nx-1)*dxx/2;
x1=x.*dxx-xc;
x1=x1';
ph0=[x1 ph0 ex0];
%
%  plot(ph0(:,1) ,ph0(:,3),'g')



jk=0;
for kk=1:nx/2
    if abs(ph0(kk,2))<=abs(0.5*phm)  % it work for +ve and -ve phi
        jk=kk;
    end
end
A=phm;
w=2*abs(ph0(jk,1))

unNo =0 ;
unYes =1;
if unNo == 1
    en=1;
    pn = 1;
    lmd=1;
    
    M_unormalized = [];
    E_unormalized = [];
    w_unormalized = [];
    
%     set(handles.Et,'String',E_unormalized)
%     set(handles.Mt,'String',M_unormalized)
%     set(handles.wt,'String',w_unormalized)
    
elseif unYes==1
    %% Unormalization
    Th = 87;
    ni0 = 47.5;
    
    
    eps0 = 8.85*1.e-12;
    e = 1.6*1.e-19;
    me = 9.1*1.e-31;
    ni0 = ni0*1.e6;
    nh0 =  Nhe*ni0;
    Th  = Th*e %joul;
    
    lmd = ((eps0*Th)/(nh0*e^2))^0.5
    en  = (Th)/(e*lmd);
    pn = (Th)/(e);
    Cs  = sqrt(Th/me);
    M_unormalized = (M*Cs)/1000;
    E_unormalized = en*max(ph0(:,3))*1000;
    w_unormalized = wE*lmd;
    
    
%     set(handles.Et,'String',E_unormalized)
%     set(handles.Mt,'String',M_unormalized)
%     set(handles.wt,'String',w_unormalized)
end



%% Plotting
figure('units', 'normalized', 'outerposition',[0 0 1 1])
subplot(1,2,1);
plot(lmd*ph0(:,1),pn*ph0(:,2),'r','linewidth',2)
hold
plot(lmd*[-w/2 -w/2],pn*[0 phm],'k')
plot(lmd*[w/2 w/2],pn*[0 phm],'k')
plot(lmd*[min(x1) max(x1)], pn*[phm*0.5 phm*0.5],'k-.')
grid on
ylabel('\Phi')
xlabel('\zeta')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

subplot(1,2,2);
plot(lmd*ph0(:,1) ,en*ph0(:,3),'r','linewidth',2)
ylabel('E')
xlabel('\zeta')
grid on
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)
