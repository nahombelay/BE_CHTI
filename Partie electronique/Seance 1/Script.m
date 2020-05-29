clear all;
close all;
Fsin = 25;
%T = 1/Fsin; %question 8) on doit avoir f = 1/T
T = 1;
M = 32;
Te = T/M;
Tsim = T - Te;
sim("fft_1.slx");
sind = fft(ans.Sin_Ech);

%sin continue
subplot(3,1,1)
plot(ans.Tps_Cont,ans.Sin_Cont);
%sin discrete
subplot(3,1,2)
scatter(ans.Tps_Ech,ans.Sin_Ech);
%fft
subplot(3,1,3)
f = linspace(0,1/Te-1/T, M); % question 9)
scatter(f, abs(sind));
%Commentaires 3Hz: 
%16 en abs car fft nous donne M*Ampli/2
%echelle de fréquence normalisee car on ne connait pas fe

%Commentaires 15Hz:
%Le theoreme de shannon est juste, donc le signal discret est illisible car
%ne donne pas fe
% sur la fft les deux pics de fréquences se rapprochent, on se rapporche du
% phenomène de repliement mais on se retrouve quand meme avec un sin de 15
% Hz soit fe

%commentaires 5.5 Hz : 
%Le tracé est bon 
%La fft ne donne pas fsin

%7) Il faut une frequence entiere 

% 10) critere de shannon pas respecté donc on obtient n'importe quoi 
% 11) critere de shannon pas respecté mais la fft nous donne Fsin (en symetrique) on a un repliement du spectre

%Mettre un filtre anti repliement