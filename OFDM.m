% Sistema OFDM que emprega sinalização QAM-16 em banda-base
% e canal de multipercurso com AWGN.
% Pressupomos portadora correta e sincronia.
% 32 subportadoras são usadas, com comprimento de canal = 6
% e prefixo cíclico de comprimento = 5.

clear;clf;

L=1000000;                           % Número total de símbolos no experimento é 1 milhão
Lfr=L/32;                            % Número de quadros de dados

% GERA DADOS ALEATÓRIOS DE SINAL PARA SINALIZAÇÃO POLAR %

s_data=4*round(rand(L,1))+2*round(rand(L,1))-3+...
     j*(4*round(rand(L,1))+2*round(rand(L,1))-3);

channel=[1 .3 .2 0 -.3 -.5];      % canal no domínio-t

hf=fft(channel,32);                  % calcula canal no domínio-f

p_data=reshape(s_data,32,Lfr);       % conversão S/P

p_td=ifft(p_data);                   % IFFT para converter ao domínio-t
p_cyc=[p_td(end-4:end,:);p_td];      % adiciona prefixo cíclico

s_cyc=reshape(p_cyc,37*Lfr,1);       % conversão P/S

Psig=10/32;                          % potência média de entrada do canal
chsout=filter (channel, 1,s_cyc);    % gera sinal de saída do canal
clear p_td p_cyc s_cyc;       % libera um pouco de memória
noiseq=(randn(37*Lfr,1)+j*randn(37*Lfr,1));

SEReq=[];

for ii=1:31
    SNR(ii)=ii-1;                                  % SNR em dB
    Asig=sqrt(Psig*10^(-SNR(ii)/10))*norm(channel);
    x_out=chsout+Asig*noiseq;                      % Adiciona ruído
    x_para=reshape(x_out,37,Lfr);                  % conversão S/P
    x_disc=x_para(6:37,:);                         % descarta caudas
    xhat_para=fft(x_disc);                         % FFT de volta ao domínio-f
    
    z_data=inv(diag(hf))*xhat_para;                % equalização no domínio-f
    
    % calcula a decisão QAM após equalização
    deq=sign(real(z_data))+sign(real(z_data)-2)+sign(real(z_data)+2)+...
        j*(sign(imag(z_data))+sign(imag(z_data)-2)+sign(imag(z_data)+2));
    
    % Agora, compara com dados originais para calcular a SER
    SEReq=[SEReq sum(p_data~=deq,2)/Lfr];
end

for ii=1:9
    SNRa(ii)=2*ii-2;
    Q(ii)=3*0.5*erfc(sqrt((2*10^(SNRa(ii)*0.1)/5)/2));
    %Calcula a BER analítica
end

% Análise OFDM
ofdm_plots;

