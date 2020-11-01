%% Practica 6 
    % Electrocardiograma y Variabilidad de la Frecuencia Cardiaca (HRV)
    % Adquisición y Tratamiento de Señales Fisiológicas
    % Facultad de Medicina, Otoño 2020

%% Alumnos
    % Fernández García Daniel Enrique
    % Galeana Ruaro Clara Nataly
    % Piña Martínez Michael Moncerrat
    % Quiroz Salazar Alberto

%% Inicialización
    clc; close all; clear all;
    a=load('data/Prac_ECG');
% Señales de ECG
    s1=a.ECG_MAT; %Señal 1
    s2=a.ECG_MAT_2;%Señal 2
    s3=a.ECG_REST; %Señal 3
    s4=a.ECG_REST_2; %Señal 4
% Datos
    fm=500;%Frecuencia de muestreo Hz
    T=1/fm;%Periodo de muestreo
% Vectores de tiempo
    t1=0:T:(length(s1)/fm)-T; %Vector de tiempo s1
    t2=0:T:(length(s2)/fm)-T;%Vector de tiempo s2
    t3=0:T:(length(s3)/fm)-T;%Vector de tiempo s3
    t4=0:T:(length(s4)/fm)-T;%Vector de tiempo s4

%% 1. Segmentación de 57 segundos de la señal
    m2=57/T;
    s1=(s1(1:m2)); s2=(s2(1:m2)); s3=(s3(1:m2)); s4=(s4(1:m2));
    t1=t1(1:m2); t2=t2(1:m2); t3=t3(1:m2); t4=t4(1:m2);

%% 2. Gráficas de 3 segundos
    figure('Name','Gráficas de 3 segundos')
    % Participante 1
    subplot(2,2,1)
        plot(t3(1:3/T),s3(1:3/T))
        title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
    subplot(2,2,2)
        plot(t1(1:3/T),s1(1:3/T))
        title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
    subplot(2,2,3)
    % Participante 2    
        plot(t4(1:3/T),s4(1:3/T))
        title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
    subplot(2,2,4)
        plot(t2(1:3/T),s2(1:3/T))
        title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')

%% 3. Picos de las señales de ECG
    [pks1, locs1]=findpeaks(s1,fm,'MinPeakHeight',0.4);
    [pks2, locs2]=findpeaks(s2,fm,'MinPeakHeight',0.4);
    [pks3, locs3]=findpeaks(s3,fm,'MinPeakHeight',0.4);
    [pks4, locs4]=findpeaks(s4,fm,'MinPeakHeight',0.4);

%% 4. Gráficas de 5 segundos con picos identificados
    figure('Name','Gráficas de 5 segundos con picos identificados')
    % Participante 1
    subplot(2,2,1)
        plot(t3(1:5/T),s3(1:5/T));
        hold on
        plot(locs3(1:6),pks3(1:6),'x');
        title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
        annotation('textbox', [0.41, 0.80, 0.1, 0.1],'String',strcat('FC=',num2str(size(locs3,2))),'FitBoxToText','on');
    subplot(2,2,2)
        plot(t1(1:5/T),s1(1:5/T));
        hold on
        plot(locs1(1:7),pks1(1:7),'x');
        title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
        annotation('textbox', [0.85, 0.80, 0.1, 0.1],'String',strcat('FC=',num2str(size(locs1,2))),'FitBoxToText','on');
    % Participante 2
    subplot(2,2,3)
        plot(t4(1:5/T),s4(1:5/T))
        hold on
        plot(locs4(1:7),pks4(1:7),'x');
        title('ECG EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
        annotation('textbox', [0.41, 0.33, 0.1, 0.1],'String',strcat('FC=',num2str(size(locs4,2))),'FitBoxToText','on');;
    subplot(2,2,4)
        plot(t2(1:5/T),s2(1:5/T))
        hold on
        plot(locs2(1:8),pks2(1:8),'x');
        title('ECG ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mv]')
        annotation('textbox', [0.85, 0.33, 0.1, 0.1],'String',strcat('FC=',num2str(size(locs2,2))),'FitBoxToText','on');

%% 5. Construcción de Cardiotacogramas
    taco1=diff(locs1);
    taco2=diff(locs2);
    taco3=diff(locs3);
    taco4=diff(locs4);
    %Cambio a ms
        tt1=1000.*taco1;
        tt2=1000.*taco2;
        tt3=1000.*taco3;
        tt4=1000.*taco4;
    % Gráficas de Cardiotacogramas
        figure('Name','Gráficas de Cardiotacogramas')
        % Participante 1
        subplot(2,2,1)
            plot (tt3)
            title('CARDIOTACOGRAMA EN REPOSO VS TIEMPO DEL PARTICIPANTE 1');
            xlabel('Muestras [n]')
            ylabel('Tiempo [ms]')
        subplot(2,2,2)
            plot (tt1)
            title('CARDIOTACOGRAMA ACTIVO VS TIEMPO DEL PARTICIPANTE 1');
            xlabel('Muestras [n]')
            ylabel('Tiempo [ms]')
        % Participante 2
        subplot(2,2,3)
            plot (tt4)
            title('CARDIOTACOGRAMA EN REPOSO VS TIEMPO DEL PARTICIPANTE 2');
            xlabel('Muestras [n]')
            ylabel('Tiempo [ms]')
        subplot(2,2,4)
            plot (tt2)  
            title('CARDIOTACOGRAMA ACTIVO VS TIEMPO DEL PARTICIPANTE 2');
            xlabel('Muestras [n]')
            ylabel('Tiempo [ms]')
            
%% 6. Parámetros referentes a la HRV
    % RR Promedio
        RR1=mean(tt1);
        RR2=mean(tt2);
        RR3=mean(tt3);
        RR4=mean(tt4);
    % SDNN
        sz1=size(tt1);
        sz2=size(tt2);
        sz3=size(tt3);
        sz4=size(tt4);
        n1=sqrt((sum((tt1-RR1).^2))./(sz1-1));
        sdnn1=n1(2);
        n2=sqrt((sum((tt2-RR2).^2))./(sz2-1));
        sdnn2=n2(2);
        n3=sqrt((sum((tt3-RR3).^2))./(sz3-1));
        sdnn3=n3(2);
        n4=sqrt((sum((tt4-RR4).^2))./(sz4-1));
        sdnn4=n4(2);
    %PNN50
        r1=double(abs(diff(tt1))>50/1000);
        P1=(sum(r1)./size(r1,2))*100;
        r2=double(abs(diff(tt2))>50/1000);
        P2=(sum(r2)./size(r2,2))*100;
        r3=double(abs(diff(tt3))>50/1000);
        P3=(sum(r3)./size(r3,2))*100;
        r4=double(abs(diff(tt4))>50/1000);
        P4=(sum(r4)./size(r4,2))*100;
    % RMSSD
        rm1=sqrt((sum((diff(tt1)).^2))/sz1(2)); 
        rm2=sqrt((sum((diff(tt2)).^2))/sz2(2));
        rm3=sqrt((sum((diff(tt3)).^2))/sz3(2));
        rm4=sqrt((sum((diff(tt4)).^2))/sz4(2));
    % Promedios de los parámetros
        pRRr=RR3+RR4/2;
        pRRa=RR1+RR2/2;
        pSDr=sdnn3+sdnn4/2;
        pSDa=sdnn1+sdnn2/2;
        pRMr=rm3+rm4/2;
        pMRa=rm1+rm2/2; 
        pPNr=P3+P4/2;
        pPNa=P2+P1/2;

%% Señales con ruido
    s5 = s3;
    s6 = s3;
    % Ruido 1
        ns1=a.ruido_1;
        ns1=ns1';
        s5(numel(ns1)) = 0;
        scr=s5+ns1;
        t5=0:T:(length(scr)/fm)-T;
        % Espectro de Frecuencia
            n = length(scr);
            fr = (0:n-1)*(fm/n);
            power = abs(fft(scr)).^2/n;
    % Ruido 2
        ns2=a.ruido_2;
        s6(numel(ns2)) = 0;
        scr2=s6+ns2;
        t6=0:T:(length(scr2)/fm)-T;
        % Espectro de Frecuencia
            n2 = length(scr2);
            fr2 = (0:n2-1)*(fm/n2);
            power2 = abs(fft(scr2)).^2/n2;
    % Graficas de señales con ruido
    figure('Name','Graficas de señales con ruido')
    %Ruido 1
    subplot(2,2,1)
        plot(t5,scr)
        title('SEÑAL CONTAMINADA CON RUIDO 1');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mV]')
    subplot(2,2,2)
        plot(fr(1,1:size(fr,2)/2),power(1,1:size(power,2)/2))
        title('ESPECTRO DE FRECUENCIA CON RUIDO 1');
        xlabel('Frecuencia [Hz]')
        ylabel('Potencia')
    % Ruido 2
    subplot(2,2,3)
        plot(t6,scr2)
        title('SEÑAL CONTAMINADA CON RUIDO 2');
        xlabel('Tiempo [s]')
        ylabel('Voltaje [mV]')
    subplot(2,2,4)
        plot(fr2(1,1:size(fr2,2)/2),power2(1,1:size(power2,2)/2))
        title('ESPECTRO DE FRECUENCIA CON RUIDO 2');
        xlabel('Frecuencia [Hz]')
        ylabel('Potencia')