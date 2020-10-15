clc, clear all, close all;

%% RAW Data from Rat ECG
rat = load('ecg_rata'); %1 minute recording from rat ECG
sf = 2000; %Sample frecuency
p = 1/sf; %Period
t = 0:p:(length(rat)/sf)-p; %Time vector
plt(t,rat,'Rat ECG')
pks = findpeaks(rat,sf,'MinPeakHeight',1)
hrf = size(pks[1]);
%% Plot function
function plt (x,y,tlt)
plot (x,y);
xlabel('seconds');
ylabel('voltage');
title(tlt);
end