close all;
clear;
clc;

x = linspace(0,2*pi,201);
y = sin(x);

plot(x,y);

save_matlab_tree();
