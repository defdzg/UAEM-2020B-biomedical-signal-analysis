%Inicialización
clc;close all; clear all;

%Señales
a=load('Prac_ECG');%1 min de registro de ECG
s1=a.ECG_MAT;%Señal 1
s2=a.ECG_MAT_2;%Señal 2
s3=a.ECG_REST;%Señal 3
s4=a.ECG_REST_2;%Señal 4


fm=500;%frecuencia de muestreo Hz
T=1/fm;%Periodo de muestreo
t1=0:T:(length(s1)/fm)-T; %vector de tiempo s1
t2=0:T:(length(s2)/fm)-T;%vector de tiempo s2
t3=0:T:(length(s3)/fm)-T;%vector de tiempo s3
t4=0:T:(length(s4)/fm)-T;%vector de tiempo s4

%Segmentación de señales y tiempo
m2=57/T; %Se segmentan 57 s
s1=(s1(1:m2));
s2=(s2(1:m2));
s3=(s3(1:m2));
s4=(s4(1:m2));
t1=t1(1:m2);
t2=t2(1:m2);
t3=t3(1:m2);
t4=t4(1:m2);

%Gráficas de 3segundos
figure
subplot(2,2,1)
plot(t3(1:3/T),s3(1:3/T))
title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,2)
plot(t1(1:3/T),s1(1:3/T))
title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,3)
plot(t4(1:3/T),s4(1:3/T))
title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,4)
plot(t2(1:3/T),s2(1:3/T))
title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
%%CHECAR UNIDADES

%Encontrar picos de todas las señales
[pks1, locs1]=findpeaks(s1,fm,'MinPeakHeight',0.4);%Pks amplitud, locs ubicación
[pks2, locs2]=findpeaks(s2,fm,'MinPeakHeight',0.4);
[pks3, locs3]=findpeaks(s3,fm,'MinPeakHeight',0.4);
[pks4, locs4]=findpeaks(s4,fm,'MinPeakHeight',0.4);

%Gráfica de ECG vs tiempo con picos identificados
figure
subplot(2,2,1)
plot(t3(1:5/T),s3(1:5/T));
hold on
plot(locs3(1:6),pks3(1:6),'x');
title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,2)
plot(t1(1:5/T),s1(1:5/T));
hold on
plot(locs1(1:7),pks1(1:7),'x');
title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,3)
plot(t4(1:5/T),s4(1:5/T))
hold on
plot(locs4(1:7),pks4(1:7),'x');
title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')
subplot(2,2,4)
plot(t2(1:5/T),s2(1:5/T))
hold on
plot(locs2(1:8),pks2(1:8),'x');
title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Tiempo (s)')
ylabel('Voltaje (mv)')


%Creación de Tacograma
taco1=diff(locs1);
taco2=diff(locs2);
taco3=diff(locs3);
taco4=diff(locs4);

%Cambio a ms
tt1=1000.*taco1;
tt2=1000.*taco2;
tt3=1000.*taco3;
tt4=1000.*taco4;

%Gráficas de tacograma
figure
subplot(2,2,1)
plot (tt3)
title('CARDIOTACOGRAMA EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Muestras(n)')
ylabel('Tiempo (ms)')
subplot(2,2,2)
plot (tt1)
title('CARDIOTACOGRAMA ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
xlabel('Muestras(n)')
ylabel('Tiempo (ms)')
subplot(2,2,3)
plot (tt4)
title('CARDIOTACOGRAMA EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Muestras(n)')
ylabel('Tiempo (ms)')
subplot(2,2,4)
plot (tt2)  
title('CARDIOTACOGRAMA ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
xlabel('Muestras(n)')
ylabel('Tiempo (ms)')

