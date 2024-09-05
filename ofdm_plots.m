% Traça gráfico de ganho das subportadoras
figure(1);
stem(abs (hf));
xlabel('Ordem da subportadora');
title('Ganho do subcanal');

% Traça gráfico do espalhamento da constelação de subcanal após OFDM
figure(2);

subplot (221) ;
plot (z_data (4,1:800),'.') % saída do subcanal 1
xlabel ("Real") ;
ylabel (" Imaginário");
title(' (a) Saída do subcanal 4');
axis('square');

subplot (222) ;
plot(z_data(11,1:800),'.'); % saída do subcanal 10
ylabel ("Imaginário");
title('(b) Saída do subcanal 11');
axis('square');

subplot (223) ;
plot (z_data(15,1:800),'.'); % Saída do subcanal 15
xlabel ("Real") ;
ylabel ("Imaginário");
title('(c) Saída do subcanal 15');
axis('square');

subplot (224) ;
plot(z_data(:,1:800),'b.'); % Saídas de canais misturados
xlabel ("Real") ;
ylabel ("Imaginário");
title('(d) Mixed OFDM output');
axis('square');
axis([-4 4 -4 4]);

% Traça gráfico de SER média de OFDM e de SER de "canal ideal"
% Com a desabilitação de 4 portadoras pobres, a SER média pode ser reduzida.

figure(3);
figc = semilogy(SNRa,Q,'k-',SNR,mean(SEReq),'r-o',...
        SNR,mean([SEReq(1:7,:);SEReq(10:24,:);SEReq(27:32,:)]),'b-s');
set(figc,'Linewidth',2);
legend('Canal ideal','Usando todas as subportadoras','Desabilitando 4 portadoras pobres');
title('SER média de OFDM');
axis([1 30 1.e-4 1]);
hold off;
xlabel('SNR (dB)');
ylabel('Taxa de erro de símbolo (SER)');

% Traça gráfico da Taxa de erro de símbolos (SER) das 32 subportadoras em um canal de multipercurso
figure(4);
figc = semilogy(SNRa,Q,'k--',...
        SNR,SEReq(1:32,:));
set(figc,'Linewidth',1);
legend('Canal ideal','Todas as subportadoras');
title('SER das 32 subportadoras');
axis([1 30 1.e-4 1]);
hold off;
xlabel('SNR (dB)');
ylabel('Taxa de erro de símbolo (SER)');
