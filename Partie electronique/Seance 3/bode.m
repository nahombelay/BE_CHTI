clear all;
close all;
num=1;
den1=[8.976*10.^(-12) 2.783*10.^(-6) 1];
den2=[1.948*10.^(-12) 2.502*10.^(-7) 1];
T1=tf(num,den1);
T2=tf(num,den2);
bode(T1,'red', T2, 'blue');
