% Auther : Ajay Lotekar
% Date : June 14, 2018
%% Asking Hot, cold and stationary and distribution
clearvars -except tns ns ps 

% For negative species 
str1 =['0 Cold fluid'];
str2 =['1 Hot fluid '];
str3 =['2 Stationary '];
str4 =['4 Maxwellian '];
str5 =['5 Kappa '];
str6 =['6 Cairns '];
disp('Enter choice ')
disp(str1)
disp(str2)
disp(str3)
disp(str4)
disp(str5)
disp(str6)


k=1;
for ic = 1:ns
    prompt1 = ['Negative species ', num2str(ic), ' : '];
    st(k,1) = input(prompt1);
    k=k+1;
end

for ic = 1:ps
    prompt2 = ['Positive species ', num2str(ic), ' : '];
    st(k,1) = input(prompt2);
    k=k+1;
end

Acoustic_speed_pro_write