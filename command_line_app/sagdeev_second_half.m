for j=1:l2
    u(j) = S(0, ph(j));

end

for i=1:l2
    if ~(isreal(u(i)))
        lk=i;
        break
    end 
end 
u(lk:l2)=[];
ph(lk:l2)=[];

plot(ph,u,'linewidth',2)
set(gca, 'XAxisLocation', 'origin')
ylabel('S(\Phi)')
xlabel('\zeta')
grid on
if min(u)<0
ylim([(min(u) +0.01*min(u)) 0+abs(0.1*min(u))]);
end
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)
 
