% Auther : Ajay Lotekar
% Date : June 14, 2018
%% Asking the number of species in the model
clear; close all; clc;
fg=1;
while fg ==1
    prompt1 = 'Enter the total number of species: ';
    tns = input(prompt1);
    prompt2 = 'Enter the negative polarity number of species: ';
    ns = input(prompt2);
    prompt3 = 'Enter the positive polarity number of species: ';
    ps = input(prompt3);
    
    if tns<=1
        disp('error: Wrong input')
    elseif (ps+ns)== tns
        fg=0;
    else
        disp('error: Wrong input')
    end
    
end

Hot_cold_stationary