close all

Fe = 24000;
Te=1/Fe;
Rb = 3000;
n = 40;

m = 2;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);

entree = (randi(2, 1, n) - 1);

mapping = entree*2 -1;
h = ones(1, Ns);
hr = h;

x = kron(mapping, [1 zeros(1,Ns-1)]);

g = conv(h, hr);

y = filter(g, 1, x);
temps = 0:Te:Te*(length(y)-1);

figure
subplot(2,2,1)
plot(temps, y);
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé du signal en sortie du filtre']);

subplot(2,2,2)
stem(g);
xlabel("Numero d'echantillon")
ylabel("g")
title(["Reponse impultionelle g"])

subplot(2,2,3)
plot(linspace(0,Ts,Ns),reshape(y,Ns,length(y)/Ns))
title(["diagramme de l'oeil"])
xlabel('Temps (s)')

%detecteur de seuil
un = y>=0;
moins_un = y < 0;
detecteur = un - moins_un;
N0 = 8;
detecteur1 = detecteur(:,N0:Ns:length(x));
N0 = 3;
detecteur2 = detecteur(:,N0:Ns:length(x)); 
demapping1 = detecteur1 > 0;
demapping2 = detecteur2 > 0;
figure 
plot(entree)

hold on
plot(demapping1)
title(["Comparaison du signal emis et du signal recu avec N0 = 8"])
xlabel("Temps (s)")


figure 
plot(entree)

hold on
plot(demapping2)
title(["Comparaison du signal emis et du signal recu avec N0 = 3"])
xlabel("Temps (s)")

TEB1 = mean(demapping1 ~= entree)
TEB2 = mean(demapping2 ~= entree)









