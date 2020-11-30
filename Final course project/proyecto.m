clc; clear all; close all;

%% READING SIGNALS
arrit = table2array(readtable('arritmias.csv'));
norm=table2array(readtable('normal.csv'));

for n = 1:size(norm,1)
a = strcat('s',num2str(n));
%% ARRYTHMIA ECG SIGNAL
% HR
[arritmia.hr(n),arritmia.taco.(a)] = lpm(arrit(n,:),150); 
% ENTROPY 
y = arritmia.taco.(a); 
r = 0.25 * std(y); %Similarity criterion
m = 2; %Length of data that will be compared
sample = sampenc(y,m,r); % Sample entropy
arritmia.entropia.sample(n) = sample(2,1);
approx = apen(y,m,r); % Approximate entropy
arritmia.entropia.approx(n) = approx;
%% NORMAL ECG SIGNAL
% HR
[normal.hr(n),normal.taco.(a)] = lpm(norm(n,:),150); 
% ENTROPY
y = normal.taco.(a); 
r = 0.25 * std(y); %Similarity criterion
m = 2; %Length of data that will be compared
sample = sampenc(y,m,r); % Sample entropy
normal.entropia.sample(n) = sample(2,1);
approx = apen(y,m,r); % Approximate entropy
normal.entropia.approx(n) = approx;
end
clear a n y N r m sample approx;

%% STATISTICS
% MEAN
normal.mean.hr = mean(normal.hr);
normal.mean.sampen= mean(normal.entropia.sample);
normal.mean.apen= mean(normal.entropia.approx);
arritmia.mean.hr = mean(arritmia.hr);
arritmia.mean.sampen= mean(arritmia.entropia.sample);
arritmia.mean.apen= mean(arritmia.entropia.approx);
% STD
normal.std.hr = std(normal.hr);
normal.std.sampen= std(normal.entropia.sample);
normal.std.apen= std(normal.entropia.approx);
arritmia.std.hr = std(arritmia.hr);
arritmia.std.sampen= std(arritmia.entropia.sample);
arritmia.std.apen= std(arritmia.entropia.approx);

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
end

% APROXIMATE ENTROPY
function [apent] = apen(a,n,r)
data =a;
for m=n:n+1; % run it twice, with window size differing by 1
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
end  %  for i=1:(length(data))-m+1, ends here
counter;  % this tells how many similar windows are present for each window of length m
%total_similar_windows = sum(counter);
%window_correlation = counter/(length(data)-m+1);
correlation(m-n+1) = ((sum(counter))/(length(data)-m+1));
 end % for m=n:n+1; % run it twice   
   correlation(1);
   correlation(2);
apent = log(correlation(1)/correlation(2));
end