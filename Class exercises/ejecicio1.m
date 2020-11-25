clc; clear all; close all;

ecg = load("data/señal3.dat");
fetal = filtfilt(b,a,ecg);
maternal = ecg - fetal;