            global Nce Tce vbce 
            global Nwce Twce vbwce 
            global Nwe Twe vbwe 
            global Nhe The vbhe 
            global Ni Ti vbi
            global M res_M lf rf  dph tlbr

% vbce = 0;
% Nce = 0.335;
% Tce = 0.001;

% 
% Nwe = 0.105;
% Twe = 0.225;
% vbwe = 0;
% 
% Nwce = 0.01
% Twce = 0.1;
% vbwce = 0;
% 
% Nhe = 1-Nce-Nwe-Nwce;
% The = 1;
% vbhe =0;
% 
% Ni = 1;
% Ti = 0.00001;
% vbi= 0;

mu = 1836;


% M = 0.71
phi_min = -0.5*(M-sqrt(3*Tce))^2;

%%
% phi_min = -0.5*(M-sqrt(3*Tce))^2;
% lf = phi_min;
% rf = -1* phi_min;
% 
% dph = 0.0001

phi=lf:dph:rf;


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


plot(app.UIAxes, phi, u,'linewidth',2)
%hold on
%plot(handles.axes1, [lf rf], [0 0],'k','linewidth',2)
%set(handles.axes1, 'XAxisLocation', 'origin')
if min(u)<0
%app.UIAxes.YLim = [(min(u) +0.01*min(u)) 0];
end
set(app.UIAxes, 'XAxisLocation', 'origin')
app.UIAxes.XGrid = 'on';
app.UIAxes.YGrid = 'on';
app.UIAxes.GridLineStyle = '--';
app.UIAxes.Box = 'on';
set(app.UIAxes,'FontSize',12,'FontWeight','bold','linewidth',2)
zoom(app.UIAxes,'on');
%%
[a b] = min(phi);

[~, l2] =size(phi);
ll=[];
for j=1:l2
    
    if (a <0) && (u(j)>0)   % if phi is negative
        ll=j;
    elseif (a >= 0) && (u(j)>0)   % if phi is positive
        ll=j;
        break
    end
end

if isempty(ll)
   app.SolutionButton.BackgroundColor  = [1 0 0];
    app.SolutionButton.Enable='off'
else
   app.SolutionButton.BackgroundColor  = [0 1 0];
       app.SolutionButton.Enable='on'    
end
