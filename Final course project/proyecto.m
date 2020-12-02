%% Análisis de la VFC en pacientes con taquiarritmia ventricular
    % Adquisición y Tratamiento de Señales Fisiológicas
    % Facultad de Medicina, Otoño 2020

% Alumnos
    % Fernández García Daniel Enrique
    % Galeana Ruaro Clara Nataly
    % Piña Martínez Michael Moncerrat
    % Quiroz Salazar Alberto
    
clc; clear all; close all;

%% LECTURA DE SEÑALES SELECCIONADAS
arrit = table2array(readtable('arritmias.csv'));
norm=table2array(readtable('normal.csv'));

for n = 1:size(norm,1)
a = strcat('s',num2str(n));
%% SEÑALES DE TAQUIARRITMIA
% FRECUENCIA CARDIACA
[arritmia.hr(n),arritmia.taco.(a)] = lpm(arrit(n,:),250); 
% ENTORPÍA
y = arritmia.taco.(a);
r = 0.2; %Criterio de similitúd
% r = 0.2*std(arritmia.taco.(a)); %Criterio de similitúd
m = 2; %Longitúd de la información a comparar
sample = sampenc(y,m,r); % Entropía Muestral
arritmia.entropia.sample(n) = sample(2,1);
approx = apen(y,m,r); % Entropía Aproximada
arritmia.entropia.approx(n) = approx;
%% SEÑALES DE GRUPO CONTROL
% FRECUENCIA CARDIACA
[normal.hr(n),normal.taco.(a)] = lpm(norm(n,:),128); 
% ENTORPÍA
y = normal.taco.(a);
r = 0.2; %Criterio de similitúd
% r = 0.2*std(normal.taco.(a)); %Criterio de similitúd
m = 2; %Longitúd de la información a comparar
sample = sampenc(y,m,r); % Entropía Muestral
normal.entropia.sample(n) = sample(2,1);
approx = apen(y,m,r); % Entropía Aproximada
normal.entropia.approx(n) = approx;
end
clear a n y N r m sample approx;

%% ESTRADÍSTICA
% MEDIA
normal.mean.hr = mean(normal.hr);
normal.mean.sampen= mean(normal.entropia.sample);
normal.mean.apen= mean(normal.entropia.approx);
arritmia.mean.hr = mean(arritmia.hr);
arritmia.mean.sampen= mean(arritmia.entropia.sample);
arritmia.mean.apen= mean(arritmia.entropia.approx);
% DESVIACIÓN ESTANDAR
normal.std.hr = std(normal.hr);
normal.std.sampen= std(normal.entropia.sample);
normal.std.apen= std(normal.entropia.approx);
arritmia.std.hr = std(arritmia.hr);
arritmia.std.sampen= std(arritmia.entropia.sample);
arritmia.std.apen= std(arritmia.entropia.approx);

%% GRAFICAS
hr = [normal.hr'; arritmia.hr'];
sample = [normal.entropia.sample'; arritmia.entropia.sample'];
approx = [normal.entropia.approx'; arritmia.entropia.approx'];
g1 = repmat({'Normal'},5,1); g2 = repmat({'Arritmia'},5,1);
groups = [g1; g2];
figure, boxplot(hr,groups);
title('Frecuencia Cardiaca')
ylabel('Latidos por minuto')
figure, boxplot(sample,groups); 
title('Entropía Muestral')
ylabel('Entropía')
figure, boxplot(approx,groups);
title('Entropía Aproximada')
ylabel('Entropía')
clear g1 g2 hr sample approx groups;


%% PARAMETROS
% FRECUENCIA CARDIACA
function [LPM, tt1] = lpm(senal,FsN)
if FsN==128
  [pks, locs]=findpeaks(senal,FsN,'MinPeakHeight',0.52);
else
  [pks, locs]=findpeaks(senal,FsN,'MinPeakHeight',0.57);
end
tt1=1000.*diff(locs);
LPM= length(pks);
end

% ENTROPÍA MUESTRAL
function [e,A,B]=sampenc(y,M,r)
n=length(y);
lastrun=zeros(1,n);
run=zeros(1,n);
A=zeros(M,1);
B=zeros(M,1);
p=zeros(M,1);
e=zeros(M,1);
for i=1:(n-1)
   nj=n-i;
   y1=y(i);
   for jj=1:nj
      j=jj+i;      
      if abs(y(j)-y1)<r
         run(jj)=lastrun(jj)+1;
         M1=min(M,run(jj));
         for m=1:M1           
            A(m)=A(m)+1;
            if j<n
               B(m)=B(m)+1;
            end            
         end
      else
         run(jj)=0;
      end      
   end
   for j=1:nj
      lastrun(j)=run(j);
   end
end
N=n*(n-1)/2;
B=[N;B(1:(M-1))];
p=A./B;
e=-log(p);
end

% ENTROPÍA APROXIMADA
function [apent] = apen(a,n,r)
data =a;
for m=n:n+1;
set = 0;
count = 0;
counter = 0;
window_correlation = zeros(1,(length(data)-m+1));
for i=1:(length(data))-m+1,
    current_window = data(i:i+m-1); % current window stores the sequence to be compared with other sequences
    
    for j=1:length(data)-m+1,
    sliding_window = data(j:j+m-1); % get a window for comparision with the current_window
    
    % compare two windows, element by element
    % can also use some kind of norm measure; that will perform better
    for k=1:m,
        if((abs(current_window(k)-sliding_window(k))>r) && set == 0)
            set = 1; % i.e. the difference between the two sequence is greater than the given value
        end
    end
    if(set==0) 
         count = count+1; % this measures how many sliding_windows are similar to the current_window
    end
    set = 0; % reseting 'set'
    
    end
   counter(i)=count/(length(data)-m+1); % we need the number of similar windows for every cuurent_window
   count=0;
i;
end  
counter;  
correlation(m-n+1) = ((sum(counter))/(length(data)-m+1));
 end 
   correlation(1);
   correlation(2);
apent = log(correlation(1)/correlation(2));
end