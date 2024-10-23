%Frequence d’echantillonnage
Fe=24000;
%Debit binaire
Rb=3000;
%Niveau de Eb/N0 souhaite en dB
EbN0dB=6;
%Ordre de la modulation
M=4;
%Frequence porteuse
fp=2000;
%Periode d’echantillonnage
Te=1/Fe;
%Debit symbole
Rs=Rb/log2(M);
%Facteur de surechantillonnage
Ns=Fe/Rs;
%Generation de la reponse impulsionnelle du filtre de mise en forme
h=ones(1,Ns);
%Generation de la reponse impulsionnelle du filtre de reception (filtrage adapte)
hr=fliplr(h);
% Generation de l’information binaire
entree=randi([0,1],1,300);
% Mapping binaire à moyenne nulle
mapping = zeros(1, ceil(size(entree,1)/2));
for i=1:2:(length(entree)-1)
    if (entree(i) == 0) && (entree(i+1) == 0)
        mapping(ceil(i/2)) = -1-1i;
    end
    if (entree(i) == 0) && (entree(i+1) == 1)
        mapping(ceil(i/2)) = -1+1i;
    end
    if (entree(i) == 1) && (entree(i+1) == 0)
        mapping(ceil(i/2)) = 1-1i;
    end
    if (entree(i) == 1) && (entree(i+1) == 1)
        mapping(ceil(i/2)) = 1+1i;
    end
end
%Surechantillonnage (generation de la suite de Diracs ponderes par les symboles)
diracs=kron(mapping,[1 zeros(1,Ns-1)]);
%Filtrage de mise en forme (generation de l’enveloppe complexe associee au signal à transmettre)
xe=filter(h,1,diracs);
%Echelle temporelle
echelle_temp = 0:Te:(length(xe)-1)*Te;
%Transposition de frequence (generation du signal module sur porteuse)
x=real(xe.*exp(1i*2*pi*fp*echelle_temp));

figure
plot(echelle_temp, x);
title("Tracé du signal transmis sur fr´equence porteuse")
xlabel("Temps (s)")
ylebel("sigal x(t)")
%Calcul de la puissance du signal transmis
Px=mean(abs(x).^2);
%Calcul de la puissance du bruite à introduire pour travailler au niveau de Eb N0 souhaite
Pn=Px*Ns/(2*log2(M)*10 ^(EbN0dB/10));
%Generation du bruit
n=sqrt(Pn)*randn(1,length(x));
%Ajodemappingut du bruit
r=x+n;
%Retour en bande de base avec filtrage passe-bas = filtre adapte
z=filter(hr,1,r.* cos(2*pi*fp*(0:Te:(length(r)-1)*Te)));
%Choix de l’instant d’echantillonnage.
n0=Ns;
%Echantillonnage à n0+mNs
zm=z(n0:Ns:end);
%Decisions sur les symboles et demapping
demapping = zeros(1,length(entree));
for j = 1:length(zm)
    
    if (0 >= angle(zm(j)) && angle(zm(j)) >= -pi/2)
        demapping(2*j-1:2*j) = [1 0];
    end
    if (0 <= angle(zm(j)) && angle(zm(j)) <= pi/2)
        demapping(2*j-1:2*j) = [1 1];
    end
    if (pi/2 <= angle(zm(j)) && angle(zm(j)) <= pi)
        demapping(2*j-1:2*j) = [0 1];
    end
    if (-pi/2 >= angle(zm(j)) && angle(zm(j)) >= -pi)
        demapping(2*j-1:2*j) = [0 0];
    end
end
%Calcul du TEB
TEB=mean(demapping ~= entree)




























