clc; clear all; close all;

ecg = load("data/se�al3.dat");
fetal = filtfilt(b,a,ecg);
maternal = ecg - fetal;