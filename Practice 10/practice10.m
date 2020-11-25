% Tratamiento de las se�ales en MATLAB
close all; clear all; clc;
ehg1=load('ECG1.dat');
ehg2=load('ECG2.dat');
fs=900; 
T=1/fs;
t=0:T:(length(ehg1)/fs)-T;
t2=0:T:(length(ehg2)/fs)-T;

% 1. Grafiquen al menos 5 latidos de ambas se�ales �de qu� se�ales estar� compuesta?
figure, plot(ehg1(1:3000))
figure, plot(ehg2(1:3500))

% 2. Dise�a un filtro digital con las caracter�sticas propuesta por Garc�a-Gonz�lez 
% et. al. 2013 para obtener la se�al de EHG cruda.
ehgraw_1 = filtrado(ehg1);
ehgraw_2 = filtrado(ehg2);

% 3. Una vez que hayan obtenido las se�ales de EHG crudo:
% - �c�mo identificar�as si la paciente estuvo en trabajo de parto o no? Justifica num�ricamente con alg�n par�metro que conozcas.
% -Calcula la envolvente de las se�ales.
envolv1 = envelope(abs(ehgraw_1),100,'rms');
envolv2 = envelope(abs(ehgraw_2),100,'rms');

figure, plot(ehgraw_1), hold on, plot(envolv1);
figure, plot(ehgraw_2), hold on, plot(envolv2);

% 4. Normaliza la se�al (0 a 1) de EHG crudo.
n1 = abs(ehgraw_1)/max(ehgraw_1);
n2 = abs(ehgraw_2)/max(ehgraw_2);

% 5. De tu se�al normalizada del EHG calcula la entrop�a muestra de las se�ales (funci�n sampenc.m),    
% ajusta los valores de M y r de acuerdo con el art�culo. �qu� informaci�n te estar� proporcionando el valor de la entrop�a? 
% �C�mo se vinculan los valores de entrop�a con las caracter�sticas del trabajo de parto o embarazo?
ent1 = sampenc(n1,2,0.15)
ent2 = sampenc(n2,2,0.15)

function senal = filtrado(signal)
    % Low pass 4Hz
    b1 = [0.028  0.053 0.071  0.053 0.028];
    a1 = [1.000 -2.026 2.148 -1.159 0.279];
    % High pass 0.3 Hz
    b2 = [0.028  0.053 0.071  0.053 0.028]; 
    a2 = [1.000 -2.026 2.148 -1.159 0.279];
    filter1 = filtfilt(b1,a1,signal); % First filter
    downsig =  downsample(filter1,10); % Downsample
    senal = filtfilt(b2,a2,downsig); % Second filter
end

