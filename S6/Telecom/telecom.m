close all

Fe = 24000;
Te=1/Fe;
Rb = 3000;
n = 1000;

%% modulateur 1
m = 2;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);

entree = (randi(2, 1, n) - 1);

mapping = entree*2 -1;
h = ones(1, Ns);

x = kron(mapping, [1 zeros(1,Ns-1)]);

y = filter(h, 1, x);

temps = 0:Te:Te*(length(y)-1);
%affichage du signal
figure;
subplot(2,1,1)
plot(temps, y);
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé du signal généré 1']);

subplot(2,1,2)
Y1 = pwelch(y,[],[],[],Fe,'twosided');
frequence = linspace(-Fe/2,Fe/2,length(Y1));
semilogy(frequence,fftshift(Y1));
xlabel('Frequence (Hz)')
ylabel('Densite spectrale de puissance')
title(['Modulateur 1']);

%% modulateur 2
m = 4;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);
h = ones(1, Ns);

mapping = zeros(ceil(size(entree,1)/2),1);
for i=1:2:(n-1)
    if (entree(i) == 0) && (entree(i+1) == 0)
        mapping(ceil(i/2)) = -3;
    end
    if (entree(i) == 0) && (entree(i+1) == 1)
        mapping(ceil(i/2)) = -1;
    end
    if (entree(i) == 1) && (entree(i+1) == 0)
        mapping(ceil(i/2)) = 1;
    end
    if (entree(i) == 1) && (entree(i+1) == 1)
        mapping(ceil(i/2)) = 3;
    end
end

x = kron(mapping, [1 zeros(1,Ns-1)]);

y = filter(h, 1, x);

figure;
subplot(2,1,1)
plot(temps, y);
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé du signal généré 2']);

subplot(2,1,2)
Y2 = pwelch(y,[],[],[],Fe,'twosided');
semilogy(frequence,fftshift(Y2));
xlabel('Frequence (Hz)')
ylabel('Densite spectrale de puissance')
title(['Modulateur 2']);


%% modulateur 3
m = 2;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);
h = rcosdesign(0.5, 10, Ns);

mapping = entree*2 -1;

x = kron(mapping, [1 zeros(1, Ns-1)]);

y = filter(h, 1, x);

figure;
subplot(2,1,1)
plot(temps, y);
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé du signal généré 3']);

subplot(2,1,2)
Y3 = pwelch(y,[],[],[],Fe,'twosided');
semilogy(frequence,fftshift(Y3));
xlabel('Frequence (Hz)')
ylabel('Densite spectrale de puissance')
title(['Modulateur 3']);

%% Comparaison
figure;
semilogy(frequence,fftshift(Y1));
hold on
semilogy(frequence,fftshift(Y2));
hold on
semilogy(frequence,fftshift(Y3));
title(['comparaison des 3 DSP'])
xlabel('Frequence (Hz)')
ylabel('DSP')
legend('DSP 1','DSP 2', 'DSP 3')





















