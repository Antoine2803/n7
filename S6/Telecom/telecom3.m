close all

Fe = 24000;
Te=1/Fe;
Rb = 3000;
n = 1000;

m = 2;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);

entree = (randi(2, 1, n) - 1);

%% Chaine 1
mapping = entree*2 -1;
h = ones(1, Ns);
hr = h;

x1 = kron(mapping, [1 zeros(1,Ns-1)]);
y1 = filter(h, 1, x1);

%bruit
figure("Name",'Chaine 1','NumberTitle','off');
Px1 = mean(abs(y1).^2);
db = 0:8;
TEB1 = zeros(1,9);
EbsN0 = TEB1;
for i = 1:9
  
    EbsN0(i) = 10^(db(i)/10);
    sigma_n1 = sqrt((Px1 * Ns)/(2*log2(m)*EbsN0(i)));
    bruit1 = sigma_n1 * randn(1, length(x1));
    
    y1_bruit = bruit1 + y1;
    
    z1 = filter(hr, 1, y1_bruit);
    temps = 0:Te:Te*(length(y1)-1);
    
    N0_1 = Ns;
    echantillonnage1 = z1(N0_1:Ns:length(z1));
    demapping1 = echantillonnage1>0; 
    
    TEB1(i) = mean(demapping1 ~= entree);
    
    subplot(2,5,i);
    plot(linspace(0,Ts,Ns),reshape(z1,Ns,length(z1)/Ns));
    title(["Diagramme de l'oeil: Eb/N0 = " + (i-1) + " dB"]);
    xlabel("Temps (s)");
end
subplot(2,5,10);
semilogy(TEB1)
hold on 
semilogy(qfunc(sqrt(2*EbsN0)))
title(["TEB"])

%% Chaine 2
m = 2;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);

mapping = entree*2 -1;
h2 = ones(1, Ns);
hr2 = ones(1, Ns/2);

x2 = kron(mapping, [1 zeros(1,Ns-1)]);
y2 = filter(h2, 1, x2);

%bruit
figure("Name",'Chaine 2','NumberTitle','off');
Px2 = mean(abs(y2).^2);
TEB2 = zeros(1,9);
EBsN0 = TEB2;
for i = 1:9
    
    EbsN0(i) = 10^(db(i)/10);
    sigma_n2 = sqrt((Px1 * Ns)/(2*log2(m)*EbsN0(i)));

    bruit2 = sigma_n2 * randn(1, length(x2));

    y2_bruit = y2 + bruit2;

    z2 = filter(hr2, 1, y2_bruit);
    N0_2 = Ns;
    echantillonnage2 = z2(N0_2:Ns:length(z2));
    demapping2 = echantillonnage2>0;
    
    TEB2(i) = mean(demapping2 ~= entree);

    subplot(2,5,i);
    plot(linspace(0,Ts,Ns),reshape(z2,Ns,length(z2)/Ns));
    title(["Diagramme de l'oeil: Eb/N0 = " + (i-1) + " dB"]);
    xlabel("Temps (s)");
end
subplot(2,5,10);
semilogy(TEB2)
hold on 
semilogy(qfunc(sqrt(EbsN0)))
title(["TEB"])

%% Chaine 3
m = 4;
Ts = log2(m)/Rb;
Ns = floor(Ts/Te);

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

h3 = ones(1, Ns);
hr3 = ones(1, Ns);

x3 = kron(mapping, [1 zeros(1,Ns-1)]);
y3 = filter(h3, 1, x3);

z3 = filter(hr3, 1, y3);

N0_3 = Ns;
echantillonnage3 = z3(N0_3:Ns:length(z3));
demapping3 = zeros(1,length(entree));

for i = 1:length(mapping)
    
    if (mapping(i) == 3)
        demapping3(2*i-1:2*i) = [1 1];
    end
    if (mapping(i) == 1)
        demapping3(2*i-1:2*i) = [1 0];
    end
    if (mapping(i) == -1)
        demapping3(2*i-1:2*i) = [0 1];
    end
    if (mapping(i) == -3)
        demapping3(2*i-1:2*i) = [0 0];
    end
end

TEB3 = mean(demapping3 ~= entree)






















