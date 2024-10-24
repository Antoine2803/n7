%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2. Implantation d.une transmission avec transposition de fréquence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;

%% Modulation QPSK
M = 4;

% Nombres de bits du signal
N = 100*log2(M);

% Signal généré
bits = randi([0, 1], 1, N);

% Paramètres
alpha = 0.35;
Fp = 2000;
Fe = 24000;
Te = 1/Fe;
Rb = 3000;
Tb = 1/Rb;
Rs = Rb/log2(M);
Ts = 1/Rs;
Ns = Ts*Fe;


%% Mapping binaire à moyenne nulle de la chaine QPSK
% Chaine complexe
ak = 1-2*bits(1:2:N); % Voie en phase
bk = 1-2*bits(2:2:N); % Voie en quadrature
%constellation:
% 10 00
% 11 01
dk = ak +1i*bk;


%% Suréchantillonnage
B = kron(dk, [1 zeros(1,Ns-1)]); % peigne de Dirac

%% Filtre en cos surélevé
L = 5;
h = rcosdesign(alpha, L, Ns);

%% Filtre de mise en forme
xe = filter(h, 1, [B zeros(1, length(h))]); 
time = 0:Te:(length(xe)-1)*Te;

%% Signal complexe transmis
figure("Name", "xe(t) : enveloppe complexe associée à x(t) (bits)");
plot(time, xe);
xlabel("Temps (s)");
ylabel("xe(t)");
title("xe(t) : enveloppe complexe associée à x(t) (bits)");

%% Signal sur les voies en phase et quadrature
I = real(xe);
figure("Name", "I(t) : voie en phase")
plot(time, I);
xlabel("Temps (s)");
ylabel("I(t)");
title("I(t) : voie en phase");

Q = imag(xe);
figure("Name", "Q(t) : voie en quadrature")
plot(time, Q);
xlabel("Temps (s)");
ylabel("Q(t)");
title("Q(t) : voie en quadrature");

%% DSP de l'enveloppe complexe: Sxe(f)
figure("Name", "Sxe(f)");
Sxe = pwelch(xe, [], [], Fe, "twosided");
Sxe = fftshift(Sxe);
f1 = linspace(-Fe/2, Fe/2, length(Sxe));

semilogy(f1, Sxe);

title("Sxe(f)");
xlabel("Fréquence (Hz)");
ylabel("Sxe(f)");

%% Transposition sur porteuse
x = I.*cos(2*pi*Fp*time) - Q.*sin(2*pi*Fp*time);

figure("Name", "x(t) : signal transmis sur porteuse")
plot(time, x);
xlabel("Temps (s)");
ylabel("x(t)");
title("x(t) : signal transmis sur porteuse");

%% DSP du singnal sur porteuse : Sx(f)
figure("Name", "Sx(f)");
Sx = pwelch(x, [], [], Fe, "twosided");
Sx = fftshift(Sx);
f1 = linspace(-Fe/2, Fe/2, length(Sx));

semilogy(f1, Sx);
EbN0dB = 0:6;
EbN0=10.^(EbN0dB./10);
BER3=zeros(1,length(EbN0));
title("Sx(f)");
xlabel("Fréquence (Hz)");
ylabel("Sx(f)");

%% Démodulation cohérente sans canal
% x retour
xcos = x.*cos(2*pi*Fp*time);
xjsin = x.*sin(2*pi*Fp*time);

x_ret = xcos -1i*xjsin;

figure("Name", "x_ret(t) : signal retour en bande de base");
plot(time, x_ret);
xlabel("Temps (s)");
ylabel("x_ret(t)");
title("x_ret(t) : signal retour en bande de base");

%% Filtre de réception
z = filter(h, 1, x_ret);

figure("Name", "z(t) : signal en sortie du filtre de réception");
plot(time, z);
xlabel("Temps (s)");
ylabel("z(t)");
title("z(t) : signal en sortie du filtre de réception");

%% Echantillonnage chaine retour
zm = z(length(h)+1:Ns:length(z));

%% Demapping
bits_recus(1:2:N) = ((real(zm)) < 0);
bits_recus(2:2:N) = ((imag(zm)) < 0);

%% TEB
TEB_sans_bruit = sum(bits ~= bits_recus);


%% Ajout du bruit. AWGN avec rapport signal à bruit par bit à l'entrée du récepteur Eb/N0 

EbN0dB = 0:6;
EbN0=10.^(EbN0dB./10);
TEB_Bruit=zeros(1,length(EbN0));

for k=0:(length(EbN0)-1)
    %% Ajout du bruit
    var_bruit(k+1)=mean(abs(x).^2)*Ns./(2*log2(M).*EbN0(k+1));
    r=x+sqrt(var_bruit(k+1))*randn(1,length(x)); % canal AWGN

    %% Démodulation cohérente avec canal
    % x retour
    rcos = r.*cos(2*pi*Fp*time);
    rjsin = r.*sin(2*pi*Fp*time);

    x_ret_bruit = rcos -1i*rjsin;
    
    %% Filtrage de réception
    % h filtre en racine de cos sur
    z_bruit = filter(h, 1, x_ret_bruit);

    %ù Échantillonnage
    zm_bruit = z_bruit(length(h)+1:Ns:length(z_bruit));
    
    %% Demapping
    bits_recus_bruit(1:2:N) = ((real(zm_bruit)) < 0);
    bits_recus_bruit(2:2:N) = ((imag(zm_bruit)) < 0);

    erreur_bruit(k+1)=sum(bits_recus_bruit~=bits);
    TEB_Bruit(k+1)=erreur_bruit(k+1)/N;
end


%% Affichage TEB
%TEB qpsk = Q(sqrt(2*EB/N0))
figure

semilogy(EbN0dB,TEB_Bruit)
title("TEB theorique et experimental")
hold on
semilogy(EbN0dB,qfunc(sqrt(2*EbN0)));
grid on
legend("TEB expérimental","TEB théorique")
xlabel("EB/N0")
ylabel("TEB")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                % Chaine avec passe bas equivalent %                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parametres
Fe = 6000;


%% filtre passe bas equivalent
BW = (1+alpha)*Rs;
temps=0:Te:N*Tb - Te;
passeBas = BW*sin(pi*BW*temps)./(pi*BW*temps);
passeBas(1) = BW; % car sinc(0) = 1
hce = filter(passeBas, 1, [B, zeros(1, length(passeBas))])/2;

EbN0dB = 0:6;
EbN0=10.^(EbN0dB./10);
TEB_Bruit_pbe=zeros(1,length(EbN0));

for k=0:(length(EbN0)-1)
    %% Ajout du bruit
    var_bruit_c(k+1)=mean(abs(hce).^2)*Ns./(2*log2(M).*EbN0(k+1));
    r=hce+sqrt(var_bruit_c(k+1))*randn(1,length(hce))+1i*sqrt(var_bruit_c(k+1))*randn(1,length(hce)); % canal AWGN complexe pour la chaine passe bas
    
    %% Filtrage de réception
    % h filtre en racine de cos sur
    z_bruit_pbe = filter(h, 1, r);

    %ù Échantillonnage
    zm_bruit_pbe = z_bruit_pbe(length(passeBas)+1:Ns:length(z_bruit_pbe));
    
    %% Demapping
    bits_recus_bruit_pbe(1:2:N) = ((real(zm_bruit_pbe)) < 0);
    bits_recus_bruit_pbe(2:2:N) = ((imag(zm_bruit_pbe)) < 0);
    

    erreur_bruit_pbe(k+1)=sum(bits_recus_bruit_pbe~=bits);
    TEB_Bruit_pbe(k+1)=erreur_bruit_pbe(k+1)/N;
end

%% Affichage TEB
%TEB qpsk = Q(sqrt(2*EB/N0))
figure

semilogy(EbN0dB,TEB_Bruit_pbe)
title("TEB theorique et experimental")
hold on
semilogy(EbN0dB,qfunc(sqrt(2*EbN0)));
grid on
legend("TEB expérimental","TEB théorique")
xlabel("EB/N0")
ylabel("TEB")

figure
plot(conv(h,conv(h,passeBas)))
