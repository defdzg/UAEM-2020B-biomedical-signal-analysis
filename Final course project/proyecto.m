clc; clear all; close all;

arrit = table2array(readtable('arritmias.csv'));
norm=table2array(readtable('normal.csv'));

for n = 1:size(norm,1)
   a = strcat('s',num2str(n));
   % ARRYTHMIA ECG SIGNAL
   [arritmia.hr(n),arritmia.taco.(a)] = lpm(arrit(n,:),150); %HR
%    arritmia.sdnn(n) = sdnn(arritmia.taco.(a)); %SDNN
%    arritmia.rmssd(n) = rmssd(arritmia.taco.(a)); %RMSSD
   % NORMAL ECG SIGNAL
   [normal.hr(n),normal.taco.(a)] = lpm(norm(n,:),150); %HR
%    normal.sdnn(n) = sdnn(normal.taco.(a)); %SDNN
%    normal.rmssd(n) = rmssd(normal.taco.(a)); %RMSSD
end
clear a n;

% Sample Entropy
for x = 1:5
a = strcat('s',num2str(x));
%Normal ECG Signal
y = normal.taco.(a); 
n = length(y); % Length of the data
r = 0.25 * std(y); %Similarity criterion
m = 2; %Length of data that will be compared
sample = sampenc(y,m,r); %Sample Entropy
entropia.sample.normal(x) = sample(2,1);
%Arrythmia ECG Signal
y = arritmia.taco.(a); 
n = length(a); % Length of the data
r = 0.25 * std(y); %Similarity criterion
sample = sampenc(y,m,r); %Sample Entropy
entropia.sample.arritmia(x) = sample(2,1);
end

%% ESTADÍSTICA
% MEAN
normal.mean.hr = mean(normal.hr);
normal.mean.sdnn = mean(normal.sdnn);
normal.mean.rmssd = mean(normal.rmssd);

arritmia.mean.hr = mean(arritmia.hr);
arritmia.mean.sdnn = mean(arritmia.sdnn);
arritmia.mean.rmssd = mean(arritmia.rmssd);
% STD
normal.std.hr = std(normal.hr);
normal.std.sdnn = std(normal.sdnn);
normal.std.rmssd = std(normal.rmssd);

arritmia.std.hr = std(arritmia.hr);
arritmia.std.sdnn = std(arritmia.sdnn);
arritmia.std.rmssd = std(arritmia.rmssd);
 %
%% PARAMETERS
% HEART RATE
function [LPM, tt1] = lpm(senal,FsN)
if FsN==128
  [pks, locs]=findpeaks(senal,FsN,'MinPeakHeight',0.52);
else
  [pks, locs]=findpeaks(senal,FsN,'MinPeakHeight',0.57);
end
tt1=1000.*diff(locs);
LPM= length(pks);
end

% SAMPLE ENTROPY
function [e,A,B]=sampenc(y,M,r);
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

% % SDNN
% function [sdnn1] = sdnn(tt1)
% RR1=mean(tt1);
% sz1=size(tt1);
% n1=sqrt((sum((tt1-RR1).^2))./(sz1-1));
% sdnn1=n1(2);
% end
% % RMSSD
% function [rmssd1] = rmssd(tt1)
%   sz1=size(tt1);
%   rmssd1=sqrt((sum((diff(tt1)).^2))/sz1(2));
% end