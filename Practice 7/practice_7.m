%% Practica 6 
% Daniel Enrique Fern�ndez Garc�a
% FFT y un tel�fono
% Adquisici�n y Tratamiento de Se�ales Fisiol�gicas
% Facultad de Medicina, Oto�o 2020
clc; clear all; close all;

%% Lectura y despliegue de la se�al de audio
[y,Fs] = audioread('data/telefono.wav');
y = y';
t = 0:(1/Fs):(length(y)/Fs)-(1/Fs); 
figure()
plot(t,y)
title('telefono.wav')
xlabel('Tiempo')
ylabel('Se�al de audio')

t_dig = 0.35/(1/Fs);
ints = 0:t_dig:size(y,2);
f = Fs*(0:(t_dig)/2)/t_dig;
figure()
for i = 1:size(ints,2)-1
    if i == 1
        dig(i,:) = y((ints(1)+1):ints(i+1))
        power(i,:) = abs(fft(dig(i,:))/length(dig));
        pow(i,:) = power(i,1:length(dig)/2+1);
    else
        dig(i,:) = y(ints(i)+1:ints(i+1)-1)
        power(i,:) = abs(fft(dig(i,:))/length(dig));
        pow(i,:) = power(i,1:length(dig)/2+1);
    end
    subplot(1,10,i)
    plot(f,pow(i,:))
    findpeaks(pow(i,:),Fs,'MinPeakHeight',0.1)
end