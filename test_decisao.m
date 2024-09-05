i = -4:0.05:4; 
deq=sign(real(i))+sign(real(i)-2)+sign(real(i)+2);

figure(6);
plot(i,deq)
axis([-4 4 -4 4])


