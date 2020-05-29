clear all;
close all;
Fe = 320000;
T = 1/5000;
Te = 1/Fe;
M = T/Te;
F0 = 85000;
F1 = 85005.9;
F2 = 90000;
F3 = 95000;
F4 = 100000;
F5 = 115000;
F6 = 120000;

num=1;
den=[1.7483*10.^(-23) 7.6663*10.^(-18) 1.162*10.^(-11) 3.0332*10.^(-6) 1]
sim("fft_2.slx");

sig = zeros(10,1);
newSin = [sig;ans.Sin_Ech];
        
% sind = fft(ans.Sin_Ech);
% subplot(4,1,1)
% plot(ans.Tps_Cont,ans.Sin_Cont);
% %sin discrete
% subplot(4,1,2)
% plot(ans.Tps_Ech,ans.Sin_Ech, "*");
% %fft
% subplot(4,1,3)
% f = linspace(0,1/Te-1/T, M); 
% scatter(f, abs(sind), "*");
% %fft en hechelle log
% subplot(4,1,4)
% semilogy(f, abs(sind), "*");

% sind = fft(newSin);
% subplot(4,1,1)
% plot(ans.Tps_Cont,ans.Sin_Cont);
% %sin discrete
% subplot(4,1,2)
% plot(linspace(0,T, M+10),newSin, "*");
% %fft
% subplot(4,1,3)
% f = linspace(0,1/Te-1/T, M+10); 
% scatter(f, abs(sind), "*");
% %fft en hechelle log
% subplot(4,1,4)
% semilogy(f, abs(sind), "*");


sind = fft(ans.Car_Ech);
subplot(4,1,1)
plot(ans.Tps_Cont,ans.Car_Cont);
%sin discrete
subplot(4,1,2)
plot(ans.Tps_Ech,ans.Car_Ech, "*");
%fft
subplot(4,1,3)
f = linspace(0,1/Te-1/T, M); 
plot(f, abs(sind), "*");
%fft en hechelle log
subplot(4,1,4)
semilogy(f, abs(sind), "*");

num=1;
den=[1.7483*10.^(-23) 7.6663*10.^(-18) 1.162*10.^(-11) 3.0332*10.^(-6) 1]

figure(2)
T=tf(num,den)
bode(T);


















