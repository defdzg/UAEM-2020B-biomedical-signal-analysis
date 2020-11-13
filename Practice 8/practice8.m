%% Practica 6: EMG
    % Adquisición y Tratamiento de Señales Fisiológicas
    % Facultad de Medicina, Otoño 2020

%% Alumnos
    % Fernández García Daniel Enrique
    % Galeana Ruaro Clara Nataly
    % Piña Martínez Michael Moncerrat
    % Quiroz Salazar Alberto
    
close all; clear all; clc;

%% Datos
a=load('data/medio.mat'); %0.5 kg
b=load('data/tres.mat'); %3 kg
Fm=6250;%Frecuencia de muestreo en Hz
T=1/Fm;
Fs = Fm; % d
s1=a.data;
s2=b.data;
% Biceps
s1b=s1(:,1); %0.5 kg
s2b=s2(:,1); %3 kg
% Triceps
s1t=s1(:,2); %0.5 kg
s2t=s2(:,2); %3 kg 
% Vectores de tiempo
t05 = 0:(1/Fs):(length(s1)/Fs)-(1/Fs); 
t30 = 0:(1/Fs):(length(s2)/Fs)-(1/Fs); 

%% Graficas 0.5 kg
figure('Name','Gráfica 0.5 kg')
% Triceps
subplot(2,1,1)
plot(t05,s1t)
title('Triceps');
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% Biceps
subplot(2,1,2)
plot(t05,s1b)
title('Biceps');
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 0.5 kg')
ylim([-3 3])

%% Graficas 3.0 kg
figure('Name','Gráfica 3.0 kg')
% Triceps
subplot(2,1,1)
plot(t30,s2t)
title('Triceps');
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% Biceps
subplot(2,1,2)
plot(t30,s2b)
title('Biceps');
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])


%% Muestras EMG BURST
% # 0.5 kg muestra de inicio # de muestra final; 3kg # muestra inicio de # de muestra final 
b1 = [3600 12100; 3000 18000];
b2 = [17000 25500; 21700 36700];
b3 = [28500 37000; 38400 53400];
b4 = [40500 49000; 56800 71800];
b5 = [52200 60700; 77500 92500];

%% Gráficas EMG BURST 0.5 kg
%%%% BICEPS 0.5
% B1
figure('Name','Gráficas EMG BURST 0.5 kg')
subplot(2,5,1)
plot(0:(1/Fs):((abs(b1(1,2)-b1(1,1))/Fs)-(1/Fs)),s1b((b1(1,1):b1(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B2
subplot(2,5,2)
plot(0:(1/Fs):((abs(b2(1,2)-b2(1,1))/Fs)-(1/Fs)),s1b((b2(1,1):b2(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B3
subplot(2,5,3)
plot(0:(1/Fs):((abs(b3(1,2)-b3(1,1))/Fs)-(1/Fs)),s1b((b3(1,1):b3(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B4
subplot(2,5,4)
plot(0:(1/Fs):((abs(b4(1,2)-b4(1,1))/Fs)-(1/Fs)),s1b((b4(1,1):b4(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B5
subplot(2,5,5)
plot(0:(1/Fs):((abs(b5(1,2)-b5(1,1))/Fs)-(1/Fs)),s1b((b5(1,1):b5(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])

%%%% TRICEPS 0.5
% B1
subplot(2,5,6)
plot(0:(1/Fs):((abs(b1(1,2)-b1(1,1))/Fs)-(1/Fs)),s1t((b1(1,1):b1(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B2
subplot(2,5,7)
plot(0:(1/Fs):((abs(b2(1,2)-b2(1,1))/Fs)-(1/Fs)),s1t((b2(1,1):b2(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B3
subplot(2,5,8)
plot(0:(1/Fs):((abs(b3(1,2)-b3(1,1))/Fs)-(1/Fs)),s1t((b3(1,1):b3(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B4
subplot(2,5,9)
plot(0:(1/Fs):((abs(b4(1,2)-b4(1,1))/Fs)-(1/Fs)),s1t((b4(1,1):b4(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B5
subplot(2,5,10)
plot(0:(1/Fs):((abs(b5(1,2)-b5(1,1))/Fs)-(1/Fs)),s1t((b5(1,1):b5(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])

suptitle('Gráficas EMG BURST 0.5 kg')

%% Gráficas EMG BURST 3.0 kg
%%%% BICEPS 3.0
% B1
figure('Name','Gráficas EMG BURST 3.0 kg')
subplot(2,5,1)
plot(0:(1/Fs):((abs(b1(1,2)-b1(1,1))/Fs)-(1/Fs)),s2b((b1(1,1):b1(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B2
subplot(2,5,2)
plot(0:(1/Fs):((abs(b2(1,2)-b2(1,1))/Fs)-(1/Fs)),s2b((b2(1,1):b2(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B3
subplot(2,5,3)
plot(0:(1/Fs):((abs(b3(1,2)-b3(1,1))/Fs)-(1/Fs)),s2b((b3(1,1):b3(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B4
subplot(2,5,4)
plot(0:(1/Fs):((abs(b4(1,2)-b4(1,1))/Fs)-(1/Fs)),s2b((b4(1,1):b4(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
suptitle('Gráficas 3.0 kg')
ylim([-3 3])
% B5
subplot(2,5,5)
plot(0:(1/Fs):((abs(b5(1,2)-b5(1,1))/Fs)-(1/Fs)),s2b((b5(1,1):b5(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])

%%%% TRICEPS 3.0
% B1
subplot(2,5,6)
plot(0:(1/Fs):((abs(b1(1,2)-b1(1,1))/Fs)-(1/Fs)),s2t((b1(1,1):b1(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B2
subplot(2,5,7)
plot(0:(1/Fs):((abs(b2(1,2)-b2(1,1))/Fs)-(1/Fs)),s2t((b2(1,1):b2(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B3
subplot(2,5,8)
plot(0:(1/Fs):((abs(b3(1,2)-b3(1,1))/Fs)-(1/Fs)),s2t((b3(1,1):b3(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B4
subplot(2,5,9)
plot(0:(1/Fs):((abs(b4(1,2)-b4(1,1))/Fs)-(1/Fs)),s2t((b4(1,1):b4(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])
% B5
subplot(2,5,10)
plot(0:(1/Fs):((abs(b5(1,2)-b5(1,1))/Fs)-(1/Fs)),s2t((b5(1,1):b5(1,2)-1)))
xlabel('Tiempo [ms]')
ylabel('Voltaje [mv]')
ylim([-3 3])

suptitle('Gráficas EMG BURST 3.0 kg')