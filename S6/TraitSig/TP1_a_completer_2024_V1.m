%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               TP1 de Traitement Num�rique du Signal
%                   SCIENCES DU NUMERIQUE 1A
%                       Fevrier 2024 
%                        Pr�nom Nom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARAMETRES GENERAUX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=1;        %amplitude du cosinus
f0=1100;       %fr�quence du cosinus en Hz
T0=1/f0;       %p�riode du cosinus en secondes
N=90;        %nombre d'�chantillons souhait�s pour le cosinus
Fe=10000;       %fr�quence d'�chantillonnage en Hz
Te=1/Fe;       %p�riode d'�chantillonnage en secondes
SNR="� completer";      %SNR souhait� en dB pour le cosinus bruit�


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATION DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%D�finition de l'�chelle temporelle
temps=(0:N-1)*Te;
%G�n�ration de N �chantillons de cosinus � la fr�quence f0
x=A*cos(2*pi*f0*temps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sans se pr�occuper de l'�chelle temporelle
figure
plot(x)
pause
close();
%Trac� avec une �chelle temporelle en secondes
%des labels sur les axes et un titre (utilisation de xlabel, ylabel et
%title)
figure
plot(temps,x);


grid
xlabel('Temps (s)')
ylabel('signal')
title(['Trac� d''un cosinus num�rique de fr�quence ' num2str(f0) 'Hz']);
close();
%Fe = 10k => A=1 et f0=1100
%Fe = 1k => A=1 et f0=100 ce qui est normal puisque on a du repliment si on considere la TF, -1000
%+ 1100 = 100 et 1000 - 1100 = -100 et on garde les valeurs dans [0;Fe] avec Fe < F0 donc on ne recupere pas le
%cosinus initial 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA TRANSFORMEE DE FOURIER NUMERIQUE (TFD) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sans zero padding 
X=fft(x);
%Avec zero padding (ZP : param�tre de zero padding � d�finir)         
X_ZP=fft(x,512);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU MODULE DE LA TFD DU COSINUS NUMERIQUE EN ECHELLE LOG
%SANS PUIS AVEC ZERO PADDING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%on calcule le spectre entre 0 et Fe car le spectre d'echantillonage est
%periodique de periode Fe

%Avec une �chelle fr�quentielle en Hz
%des labels sur les axes et des titres
%Trac�s en utilisant plusieurs zones de la figure (utilisation de subplot) 
figure('name',['Trac� du module de la TFD d''un cosinus num�rique de fr�quence ' num2str(f0) 'Hz'])

subplot(2,1,1)
echelle_frequentielle=linspace(0,Fe,length(X));
semilogy(echelle_frequentielle, abs(X));
grid
title('Sans zero padding')
xlabel('Fr�quence (Hz)')
ylabel('|TFD|')

subplot(2,1,2)
echelle_frequentielle=linspace(0,Fe,length(X_ZP));
semilogy(echelle_frequentielle, abs(X_ZP));
grid
title('Avec zero padding')
xlabel('Fr�quence (Hz)')
ylabel('|TFD|')
close();
%Avec une �chelle fr�quentielle en Hz
%des labels sur les axes et des titres
%Trac�s superpos�s sur une m�me figure 
% (utilisation de hold, de couleurs diff�rentes et de legend)
% !! UTILISER ICI fftshit POUR LE TRACE !!
figure
echelle_frequentielle=linspace(-Fe/2,Fe/2,length(X));
semilogy(echelle_frequentielle,fftshift(abs(X)),'b');    %Trac� en bleu : 'b'
hold on
echelle_frequentielle=linspace(-Fe/2,Fe/2,length(X_ZP));
semilogy(echelle_frequentielle,fftshift(abs(X_ZP)),'r'); %Trac� en rouge : 'r'
grid
legend('Sans zero padding','Avec zero padding')
xlabel('Fr�quence (Hz)')
ylabel('|TFD|')
title(['Trac� du module de la TFD d''un cosinus num�rique de fr�quence ' num2str(f0) 'Hz'])
close();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA TFD DU COSINUS NUMERIQUE AVEC FENETRAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Application de la fen�tre de pond�ration de Hamming
x_fenetre_hamming=x.*hamming(length(x)).';
%Calcul de la TFD pond�r�e, avec zeros padding
X_ZP_hamming=fft(x_fenetre_hamming,128);
%Application de la fen�tre de pond�ration de Blackman
x_fenetre_blackman=x.*blackman(length(x)).';
%Calcul de la TFD pond�r�e, avec zeros padding
X_ZP_blackman=fft(x_fenetre_blackman,128);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU MODULE DE LA TFD DU COSINUS NUMERIQUE AVEC FENETRAGE EN ECHELLE LOG
%POUR DIFFERENTES FENETRES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%"� r�aliser : trac�s superpos�s sur la m�me figure de la TFD non fen�tr�e, 
%de la TFD avec fen�trage de Hamming, de la TFD avec fen�trage de Blackman
%Le tout avec une �chelle fr�quentielle en Hz, un titre, des labels sur les axes, 
%une l�gende et en utilisant fftshift"
figure
echelle_frequentielle=linspace(-Fe/2,Fe/2,length(X_ZP));
semilogy(echelle_frequentielle,fftshift(abs(X_ZP)),'r'); 
hold on
echelle_frequentielle=linspace(-Fe/2,Fe/2,length(X_ZP_hamming));
semilogy(echelle_frequentielle,fftshift(abs(X_ZP_hamming)),'g'); 
hold on
echelle_frequentielle=linspace(-Fe/2,Fe/2,length(X_ZP_blackman));
semilogy(echelle_frequentielle,fftshift(abs(X_ZP_blackman)),'b'); 
grid
legend('Sans zero padding','Avec zero padding')
xlabel('Fr�quence (Hz)')
ylabel('|TFD|')
title(['Trac� du module de la TFD d''un cosinus num�rique de fr�quence selon differantes fenetres ' num2str(f0) 'Hz'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA DENSITE SPECTRALE DE PUISSANCE (DSP) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Estimation par p�riodogramme
Sx_periodogramme= 1/N* abs(X_ZP).^2;

%Estimation par p�riodogramme de Welch
Sx_Welch=pwelch(x, [],[],[],Fe,'twosided');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DE LA DENSITE SPECTRALE DE PUISSANCE (DSP) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Trac�s superpos�s sur une m�me figure en utilisant fftshift
%Avec une �chelle fr�quentielle en Hz
%des labels sur les axes, un titre, une l�gende
figure
echelle_frequentielle="� completer";
semilogy("� completer",'b')
hold on
echelle_frequentielle="a completer";
semilogy("� completer",'r')
legend('Periodogramme','Periodogramme de Welch')
xlabel('Fr�quences (Hz)')
ylabel('DSP')
title('Trac�s de la DSP d''un cosinus num�rique de fr�quence 1100 Hz');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL ET TRACE DE LA FONCTION D'AUTOCORRELATION DU COSINUS BRUITE AVEC LE
%BON SNR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       

%Calcul de la puissance du signal
P_signal=mean(abs(x).^2);
%Calcul de la puissance du bruit pour obtenir le SNR souhait�
P_bruit="� completer";

%G�n�ration du bruit gaussien � la puissance Pb
bruit=sqrt(P_bruit)*randn(1,length(x));
%Ajout du bruit sur le signal
x_bruite=x+bruit;

%Calcul de la fonction d'autocorr�lation du signal bruite
%attention pas le 1/N quand on utilise xcorr => � rajouter
Rx=(1/length(x_bruite))*xcorr(x_bruite); 

%Trac� du signal bruit� avec une �chelle temporelle en secondes
figure
plot("� completer")
grid
xlabel('Temps (s)')
ylabel('Signal')
title('Trac� du cosinus bruit�');

%Trac� de la fonction d'autocorr�lation du signal bruite avec une �chelle 
%temporelle en secondes
figure
echelle_tau="� completer";
plot("� completer")
grid
xlabel('\tau (s)')
ylabel('R_x(\tau)')
title('Trac� de la fonction d''autocorr�lation du cosinus bruit�');

