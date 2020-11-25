clc; clear all; close all;
%% Práctica 9: VEP Y EEG
    % Adquisición y Tratamiento de Señales Fisiológicas
    % Facultad de Medicina, Otoño 2020

%% Alumnos
    % Fernández García Daniel Enrique
    % Galeana Ruaro Clara Nataly
    % Piña Martínez Michael Moncerrat
    % Quiroz Salazar Alberto

%% Parte 1
%% DATOS
% Para descargar la señal si no la tienes
% pev = websave('vep.mat','https://srv-store6.gofile.io/download/UZSdvU/vep.mat')
pev = 'vep.mat';
s = load(pev);
eeg=s.EEG;%10 canales de EEG's 
test=s.stim_times;%Tiempos de estimulación
%Se dividen los canales
s1=eeg(1,:);
s2=eeg(2,:);
s3=eeg(3,:);
s4=eeg(4,:);
s5=eeg(5,:);
s6=eeg(6,:);
s7=eeg(7,:);
s8=eeg(8,:);
s9=eeg(9,:);
s10=eeg(10,:);
%Frecuencia de muestreo y periodo
fm=512;  
t=1/fm;
%Vector de tiempo
[x,y]=size(s1);
T=0:t:(y/fm)-t;

%% VENTANAS

%Ventana tiempo
vT=-0.2:t:0.2;
vT=vT*1000;

%Ventana señal
fa=T(2);%Frecuencia de adquisición
r=.2/fa;%Inicio de ventana .2t
for a=1:120
    vs1(a,1:205)=s1(1,test(a)-r:test(a)+r);
    vs2(a,1:205)=s2(1,test(a)-r:test(a)+r);
    vs3(a,1:205)=s3(1,test(a)-r:test(a)+r);
    vs4(a,1:205)=s4(1,test(a)-r:test(a)+r);
    vs5(a,1:205)=s5(1,test(a)-r:test(a)+r);
    vs6(a,1:205)=s6(1,test(a)-r:test(a)+r);
    vs7(a,1:205)=s7(1,test(a)-r:test(a)+r);
    vs8(a,1:205)=s8(1,test(a)-r:test(a)+r);
    vs9(a,1:205)=s8(1,test(a)-r:test(a)+r);
    vs10(a,1:205)=s10(1,test(a)-r:test(a)+r);
end

%Promedios de ventanas
p1=mean(vs1);
p2=mean(vs2);
p3=mean(vs3);
p4=mean(vs4);
p5=mean(vs5);
p6=mean(vs6);
p7=mean(vs7);
p8=mean(vs8);
p9=mean(vs9);
p10=mean(vs10);

%Se definen las ondas
%Señal 1
n175s=p1(142);
p1100s=p1(155);
n1145s=p1(178);
%Señal 2
n275s=p2(142);
p2100s=p2(155);
n2145s=p2(178);
%Señal 3
n375s=p3(142);
p3100s=p3(155);
n3145s=p3(178);
%Señal 4
n475s=p4(142);
p4100s=p4(155);
n4145s=p4(178);
%Señal 5
n575s=p5(142);
p5100s=p5(155);
n5145s=p5(178);
%Señal 6
n675s=p6(142);
p6100s=p6(155);
n6145s=p6(178);
%Señal 7
n775s=p7(142);
p7100s=p7(155);
n7145s=p7(178);
%Señal 8
n875s=p8(142);
p8100s=p8(155);
n8145s=p8(178);
%Señal 9
n975s=p9(142);
p9100s=p9(155);
n9145s=p9(178);
%Señal 10
n1075s=p10(142);
p10100s=p10(155);
n10145s=p10(178);
%Tiempo
n75t=vT(142);
p100t=vT(155);
n145t=vT(178);

%Gráficas de potenciales Evocados
figure,
plot(vT,p1),title('Potencial Evocado 1');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n175s,'N75');
text(p100t,p1100s,'P100');
text(n145t,n1145s,'N145');

figure,
plot(vT,p2),title('Potencial Evocado 2');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n275s,'N75');
text(p100t,p2100s,'P100');
text(n145t,n2145s,'N145');

figure,
plot(vT,p3),title('Potencial Evocado 3');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n375s,'N75');
text(p100t,p3100s,'P100');
text(n145t,n3145s,'N145');

figure,
plot(vT,p4),title('Potencial Evocado 4');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n475s,'N75');
text(p100t,p4100s,'P100');
text(n145t,n4145s,'N145');

figure,
plot(vT,p5),title('Potencial Evocado 5');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n575s,'N75');
text(p100t,p5100s,'P100');
text(n145t,n5145s,'N145');

figure,
plot(vT,p6),title('Potencial Evocado 6');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n675s,'N75');
text(p100t,p6100s,'P100');
text(n145t,n6145s,'N145');

figure,
plot(vT,p7),title('Potencial Evocado 7');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n775s,'N75');
text(p100t,p7100s,'P100');
text(n145t,n7145s,'N145');

figure,
plot(vT,p8),title('Potencial Evocado 8');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n875s,'N75');
text(p100t,p8100s,'P100');
text(n145t,n8145s,'N145');

figure,
plot(vT,p9),title('Potencial Evocado 9');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n975s,'N75');
text(p100t,p9100s,'P100');
text(n145t,n9145s,'N145');

figure,
plot(vT,p10),title('Potencial Evocado 10');
xlabel('Time(ms)');
ylabel('Voltage(µV)');
text(n75t,n1075s,'N75');
text(p100t,p10100s,'P100');
text(n145t,n10145s,'N145');

%% Parte 2:
% Ve a la página de https://physionet.org/content/chbmit/1.0.0/ y descarga una señal de EEG.
% Para descargar la señal si no la tienes
% data = websave('chb01-01.edf','https://physionet.org/files/chbmit/1.0.0/chb01/chb01_01.edf?download')
data = 'chb01-01.edf';
% a) Grafica los primeros 2 segundos de la señal. Muestra la gráfica (tiempo vs. volts)
[hdr, record] = edfread(data); %edfread es una función utilizada para leer la señal
n = length(record); fs = 256; T = 1/fs; 
t=0:T:(n/fs)-T;

% Gráfica de todas las señales sólo en una figura
figure
for i = 1:size(record,2)
    plot(t(1:2/T),record(1:2/T,i))
    hold on
end
ylabel('Voltaje [uV]');
xlabel('Tiempo [s]');
title('EEG: chb01-01.edf');

    % Gráfica de cada canal en diferentes subplot
    % for i = 1:size(record,2)
    %     subplot(23,1,i)
    %     plot(t(1:2/T),record(1:2/T,i))
    % %     Units are hidden just for aesthetic
    % %     ylabel('Voltage [uV]');
    % %     xlabel('Time [s]');   
    % end
    % suptitle('chb01-01.edf');
    % segmentos = struct();
    % promedio_eeg = struct();

% b) Segmenta los primeros 20 segundos de la señal (en segmentos de 2 segundos cada uno). 
% Tendrás en total 10 segmentos. 
% c) Calcula la FFT de los 10 segmentos     
x = 1;
for i = 2:2:20
    a = strcat('s',num2str(x));
    if i == 2
    segmentos.(a) = record(1:(i/T)+1,:); %Segmentación en ventanas de 2 segundos
    else
    segmentos.(a) = record(i/T:(i+2)/T,:); %Segmentación en ventanas de 2 segundos
    end
    promedio_eeg.(a) = mean(segmentos.(a),2); %Promedio de los 23 canales del EEG
    ftrans.(a) = abs(fft(promedio_eeg.(a),[],1)); %FFT de la señal promediada
    x = x+1;
end
for x = 1:10 %Transformación de struct a array para operaciones
    a = strcat('s',num2str(x));
    ftrans_a(:,x) = ftrans.(a);
end
% d) Promedia el espectro de todos los segmentos
figure
frans_prom = mean(ftrans_a,2); %Promedio del espectro de las potencias
frans_prom = frans_prom/1000; %Transformando de uV a V
L = length(frans_prom);
P2 = abs(frans_prom/L);
P1 = frans_prom(1:length(frans_prom)/2+1);   % Espectro de potencia sólo de un lado
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Promedio de los espectros del EEG: chb01-01.edf')
xlabel('Frecuencia [Hz]')
ylabel('Potencia')

% e) Contesta ¿qué se observa del promedio de los espectros
% De la gráfica resultate del promedio de los espectros de potencia de
% cada segmento, podemos observar que esta información mostrada coincide
% con la esperada de un EEG de acuerdo con la teoría. Conocemos que las
% cada onda característica para el EEG se clasifica por el intervalo de
% frecuencia de esta misma. Siendo estas ondas las delta (0.5-4 Hz), theta
% (4-8 Hz), alpha (8-13 Hz) y las beta (13-30 Hz). La mayor amplitud de
% potencia de la señal de EEG procesada se encuentra en el intervalo de
% 0-8 Hz aproximadamente, esto se puede interpretar como que el paciente
% estaba en un estado de relajación o posiblemente dormido.

%% (Sólo adjuntar un archivo .m como reporte de la práctica)

%% Función para leer archivos *.EDF
function [hdr, record] = edfread(fname, varargin)

if nargin > 3
    error('EDFREAD: Too many input arguments.');
end

if ~nargin
    [fname] = uigetfile({'*.edf','European Data Format Files'});
if ~iscell(fname)
    if length(fname) <= 1 && fname == 0
        return;
    end
end

end

if nargin == 1
    assignToVariables = false;
end

[fid,msg] = fopen(fname,'r');
if fid == -1
    error(msg)
end

assignToVariables = false; %Default
for ii = 1:2:numel(varargin)
    switch lower(varargin{ii})
        case 'assigntovariables'
            assignToVariables = varargin{ii+1};
    end
end

% HEADER
hdr.ver        = str2double(char(fread(fid,8)'));
hdr.patientID  = fread(fid,80,'*char')';
hdr.recordID   = fread(fid,80,'*char')';
hdr.startdate  = fread(fid,8,'*char')';% (dd.mm.yy)
% hdr.startdate  = datestr(datenum(fread(fid,8,'*char')','dd.mm.yy'), 29); %'yyyy-mm-dd' (ISO 8601)
hdr.starttime  = fread(fid,8,'*char')';% (hh.mm.ss)
% hdr.starttime  = datestr(datenum(fread(fid,8,'*char')','hh.mm.ss'), 13); %'HH:MM:SS' (ISO 8601)
hdr.bytes      = str2double(fread(fid,8,'*char')');
reserved       = fread(fid,44);
hdr.records    = str2double(fread(fid,8,'*char')');
hdr.duration   = str2double(fread(fid,8,'*char')');
% Number of signals
hdr.ns    = str2double(fread(fid,4,'*char')');
for ii = 1:hdr.ns
    hdr.label{ii} = fread(fid,16,'*char')';
end
for ii = 1:hdr.ns
    hdr.transducer{ii} = fread(fid,80,'*char')';
end
% Physical dimension
for ii = 1:hdr.ns
    hdr.units{ii} = fread(fid,8,'*char')';
end
% Physical minimum
for ii = 1:hdr.ns
    hdr.physicalMin(ii) = str2double(fread(fid,8,'*char')');
end
% Physical maximum
for ii = 1:hdr.ns
    hdr.physicalMax(ii) = str2double(fread(fid,8,'*char')');
end
% Digital minimum
for ii = 1:hdr.ns
    hdr.digitalMin(ii) = str2double(fread(fid,8,'*char')');
end
% Digital maximum
for ii = 1:hdr.ns
    hdr.digitalMax(ii) = str2double(fread(fid,8,'*char')');
end
for ii = 1:hdr.ns
    hdr.prefilter{ii} = fread(fid,80,'*char')';
end
for ii = 1:hdr.ns
    hdr.samples(ii) = str2double(fread(fid,8,'*char')');
end
for ii = 1:hdr.ns
    reserved    = fread(fid,32,'*char')';
end
hdr.label = deblank(hdr.label);
hdr.units = deblank(hdr.units);


if nargout > 1 || assignToVariables
    % Scale data (linear scaling)
% %     scalefac = (hdr.physicalMax - hdr.physicalMin)./(hdr.digitalMax - hdr.digitalMin);
% %     dc = hdr.physicalMax - scalefac .* hdr.digitalMax;
% %     
    % RECORD DATA REQUESTED
    tmpdata = struct;
    for recnum = 1:hdr.records
        for ii = 1:hdr.ns
            % Use a cell array for DATA because number of samples may vary
            % from sample to sample
            tmpdata(recnum).data{ii} = fread(fid,hdr.samples(ii),'int16');% * scalefac(ii) + dc(ii);
        end
    end
    record = zeros(hdr.samples(1)*hdr.records, hdr.ns);
    
    for ii = 1:numel(hdr.label)
        ctr = 1;
        for jj = 1:hdr.records
            try
                record(ctr : ctr + hdr.samples - 1, ii) = tmpdata(jj).data{ii};
            catch exception
                if length(tmpdata(jj).data{ii}) ~= hdr.samples(ii)
                    record(ctr : ctr + length(tmpdata(jj).data{ii}) - 1, ii) = tmpdata(jj).data{ii};
                else
                    throw(exception);
                end
            end
            ctr = ctr + hdr.samples;
        end
    end
    
    if assignToVariables
        for ii = 1:numel(hdr.label)
            try
                eval(['assignin(''caller'',''',hdr.label{ii},''',record(ii,:))'])
            end
        end
    end
end
fclose(fid);
end