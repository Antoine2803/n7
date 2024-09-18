A=1;
f0=1000;
f1=3000;
T0=1/f0;
T1=1/f1;
N=1024;
Fe=10000;
Te=1/Fe;

temps=(0:N-1)*Te;

x=A*(cos(2*pi*f0*temps) + cos(2*pi*f1*temps));
%question 2
figure
plot(temps,x)
close();

%question 3
X = fft(x);

figure
echelle_frequentielle=linspace(0,Fe,length(X));
semilogy(echelle_frequentielle, abs(X));
close();

% Partie 2
%Q1 : h = 4000*sinc(pi*4000*temps)

ordre11 = linspace(-5, 5, 11);
ordre61 = linspace(-30, 30, 61);

figure
subplot(2,1,1)
plot(ordre11/5,4000*sinc(4000*ordre11*Te))

subplot(2,1,2)
plot(ordre61/30,4000*sinc(4000*ordre61*Te))
close();


H11 = fft(4000*sinc(4000*ordre11*Te),N);
H61 = fft(4000*sinc(4000*ordre61*Te),N);
figure
subplot(2,1,1)
plot(linspace(0,Fe,length(H11)),abs(H11.*X))

subplot(2,1,2)
plot(linspace(0,Fe,length(H61)),abs(H61.*X))
close();


%Partie 3

figure
semilogy(echelle_frequentielle, abs(X),'b');
hold on
semilogy(linspace(0,Fe,length(H11)),abs(H11.*X),'r');
hold on
semilogy(linspace(0,Fe,length(H61)),abs(H61.*X),'g');
grid
