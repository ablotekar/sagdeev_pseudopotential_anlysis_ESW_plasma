% Auther : Ajay Lotekar
% Date : June 14, 2018
%% Writting program for the acoustic speed
clearvars -except tns ns ps st

% % For cold species
%
% fc = (nj*zj^2)/(muj*(m - vj)^2)
%
% % For Kappa distribution
% fk = ((nj*zj^2)/(tj))*((2*kj-1)/(2*kj-3))
%
% % For Hot species
% fh=nj/(muj*((m - vj)^2 - 3*Tj/mj))


prompt1 = 'Enter name want to give to the code  : ';
pro_name = input(prompt1, 's');
fname = [pro_name, '.m'];
fileID = fopen(fname,'w');
fprintf(fileID, 'clear; close all; clc;\n');

% For negative species
k=1;
srt=0;
for ic = 1:ns
    if st(ic,1)==0
        dumtxt1 = ['(-1)*(ne',num2str(ic),'*ze',num2str(ic),'^2)/(mue',num2str(ic),'*(m - ve',num2str(ic),')^2) +'];
        sl = length(dumtxt1);
        ftxt(srt+1:srt+sl)=dumtxt1;
    elseif st(ic,1)==5
        dumtxt2 = [ '((ne',num2str(ic),'*ze',num2str(ic),'^2)/(te',num2str(ic),'))*((2*ke',num2str(ic),'-1)/(2*ke',num2str(ic),'-3)) +'];
        sl = length(dumtxt2);
        ftxt(srt+1:srt+sl)=dumtxt2;
    elseif st(ic,1) == 1
        dumtxt3 = ['ne',num2str(ic), '/(mue',num2str(ic),'*((m - ve',num2str(ic),')^2 - 3*te',num2str(ic),'/mue',num2str(ic),')) +'];
        sl = length(dumtxt3);
        ftxt(srt+1:srt+sl)=dumtxt3;
    end
    srt = sl;
    
end
srt = length(ftxt);
ftxt(srt)=[];
srt = srt-1;
% For positve species
for ic = 1:ps
    if st(ns+ic,1)==0
        dumtxt3 = ['+(-1)*(np',num2str(ic),'*zp',num2str(ic),'^2)/(mup',num2str(ic),'*(m - vp',num2str(ic),')^2)'];
        sl = length(dumtxt3);
        ftxt(srt+1:srt+sl)=dumtxt3;
    elseif st(ns+ic,1)==5
        dumtxt4 = [ '+((np',num2str(ic),'*zp',num2str(ic),'^2)/(tp',num2str(ic),'))*((2*kp',num2str(ic),'-1)/(2*kp',num2str(ic),'-3)) '];
        sl = length(dumtxt4);
        ftxt(srt+1:srt+sl)=dumtxt4;
    elseif st(ns+ic,1) == 1
        dumtxt5 = ['+np',num2str(ic), '/(mup',num2str(ic),'*((m - vp',num2str(ic),')^2 - 3*tp',num2str(ic),'/mup',num2str(ic),'))'];
        sl = length(dumtxt5);
        ftxt(srt+1:srt+sl)=dumtxt5;
    end
    srt = length(ftxt);
    
end

for ic=1:ns
    if st(ic,1)==0
        s0=['ne',num2str(ic),' = 00;\n'];
        fprintf(fileID, s0);
        s1=['ze',num2str(ic),' = 00;\n'];
        fprintf(fileID, s1);
        s2=['mue',num2str(ic),' = 00;\n'];
        fprintf(fileID, s2);
        s20=['ve',num2str(ic),' = 00;\n'];
        fprintf(fileID, s20);
    elseif st(ic,1)==5
        s40=['ke',num2str(ic),' = 00;\n'];
        fprintf(fileID, s40);
        s4=['ne',num2str(ic),' = 00;\n'];
        fprintf(fileID, s4);
        s5=['ze',num2str(ic),' = 00;\n'];
        fprintf(fileID, s5);
        s6=['te',num2str(ic),' = 00;\n'];
        fprintf(fileID, s6);
        
    elseif st(ic,1)==1
        s7=['ne',num2str(ic),' = 00;\n'];
        fprintf(fileID, s4);
        s8=['ze',num2str(ic),' = 00;\n'];
        fprintf(fileID, s5);
        s9=['te',num2str(ic),' = 00;\n'];
        fprintf(fileID, s6);
        s10=['mue',num2str(ic),' = 00;\n'];
        fprintf(fileID, s6);
        s20=['ve',num2str(ic),' = 00;\n'];
        fprintf(fileID, s20);
        
    end
    
end
clear s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
fprintf(fileID, '\n');
for ic=1:ps
    if st(ns+ic,1)==0
        s0=['np',num2str(ic),' = 00;\n'];
        fprintf(fileID, s0);
        s1=['zp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s1);
        s2=['mup',num2str(ic),' = 00;\n'];
        fprintf(fileID, s2);
        s20=['vp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s20);
    elseif st(ns+ic,1)==5
        s40=['kp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s40);
        s4=['np',num2str(ic),' = 00;\n'];
        fprintf(fileID, s4);
        s5=['zp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s5);
        s6=['tp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s6);
        
    elseif st(ns+ic,1)==1
        s7=['np',num2str(ic),' = 00;\n'];
        fprintf(fileID, s7);
        s8=['zp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s8);
        s9=['tp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s9);
        s10=['mup',num2str(ic),' = 00;\n'];
        fprintf(fileID, s10);
        s20=['vp',num2str(ic),' = 00;\n'];
        fprintf(fileID, s20);
    end
end
fprintf(fileID, '\n');
st0 = 'syms m \n';
fprintf(fileID, st0);

st1 = ['f = ', ftxt,';'];
fprintf(fileID, st1);
fprintf(fileID, '\n');


fprintf(fileID,'V = vpa(solve(f==0,m));\n');
fprintf(fileID,'V= sort(real(V))');
clearvars -except tns ns ps st fileID pro_name

fprintf(fileID, '\n');

fclose(fileID);

sagdeev_pro



