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
    
    if(i-1 ~= 0)
    subplot(2,5,i);
    plot(linspace(0,Ts,Ns),reshape(z1,Ns,length(z1)/Ns));
    title(["Diagramme de l'oeil: Eb/N0 = " + (i-1) + " dB"]);
    xlabel("Temps (s)");
    end
end
subplot(2,5,1);
z1 = filter(hr, 1, y1);
plot(linspace(0,Ts,Ns),reshape(z1,Ns,length(z1)/Ns));
subplot(2,5,10);
semilogy(TEB1)
hold on 
semilogy(qfunc(sqrt(2*EbsN0)))
title(["TEB"])
legend(["Experimental","théorique"])

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
EbsN0 = TEB2;
for i = 1:9
    
    EbsN0(i) = 10^(db(i)/10);
    sigma_n2 = sqrt((Px2 * Ns)/(2*log2(m)*EbsN0(i)));

    bruit2 = sigma_n2 * randn(1, length(x2));

    y2_bruit = y2 + bruit2;

    z2 = filter(hr2, 1, y2_bruit);
    N0_2 = Ns;
    echantillonnage2 = z2(N0_2:Ns:length(z2));
    demapping2 = echantillonnage2>0;
    
    TEB2(i) = mean(demapping2 ~= entree);

    if(i-1 ~= 0)
    subplot(2,5,i);
    plot(linspace(0,Ts,Ns),reshape(z2,Ns,length(z2)/Ns));
    title(["Diagramme de l'oeil: Eb/N0 = " + (i-1) + " dB"]);
    xlabel("Temps (s)");
    end
end
subplot(2,5,1);
z2 = filter(hr2, 1, y2);
plot(linspace(0,Ts,Ns),reshape(z2,Ns,length(z2)/Ns));
subplot(2,5,10);
semilogy(TEB2)
hold on 
semilogy(qfunc(sqrt(EbsN0)))
title(["TEB"])
legend(["Experimental","théorique"])

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
    if (entree(i) == 1) && (entree(i+1) == 1)
        mapping(ceil(i/2)) = 1;
    end
    if (entree(i) == 1) && (entree(i+1) == 0)
        mapping(ceil(i/2)) = 3;
    end
end

h3 = ones(1, Ns);
hr3 = ones(1, Ns);

x3 = kron(mapping, [1 zeros(1,Ns-1)]);
y3 = filter(h3, 1, x3);

%bruit
figure("Name",'Chaine 3','NumberTitle','off');
Px3 = mean(abs(y3).^2);
TEB3 = zeros(1,9);
EbsN03 = TEB3;
for i = 1:9
    
    EbsN03(i) = 10^(db(i)/10);
    sigma_n3 = sqrt((Px3 * Ns)/(2*log2(m)*EbsN03(i)));

    bruit3 = sigma_n3 * randn(1, length(x3));

    y3_bruit = y3 + bruit3;


    z3 = filter(hr3, 1, y3_bruit);
    
    N0_3 = Ns;
    echantillonnage3 = z3(N0_3:Ns:length(z3));
    demapping3 = zeros(1,length(entree));
    
    for j = 1:length(echantillonnage3)
        
        if (echantillonnage3(j) >= 24)
            demapping3(2*j-1:2*j) = [1 0];
        end
        if (24 > echantillonnage3(j) && echantillonnage3(j) >= 0)
            demapping3(2*j-1:2*j) = [1 1];
        end
        if (0 > echantillonnage3(j) && echantillonnage3(j) >= -24)
            demapping3(2*j-1:2*j) = [0 1];
        end
        if (echantillonnage3(j) < -24)
            demapping3(2*j-1:2*j) = [0 0];
        end
    end
    
    TEB3(i) = mean(demapping3 ~= entree);
    if(i ~= 1)
    subplot(2,5,i);
    plot(linspace(0,Ts,Ns),reshape(z3,Ns,length(z3)/Ns));
    title(["Diagramme de l'oeil: Eb/N0 = " + (i-1) + " dB"]);
    xlabel("Temps (s)");
    end
end
subplot(2,5,1);
z3 = filter(hr3, 1, y3);
plot(linspace(0,Ts,Ns),reshape(z3,Ns,length(z3)/Ns));
subplot(2,5,10);
semilogy(TEB3)
hold on 
semilogy((3/4) * qfunc(sqrt((4/5) * EbsN03)))
title(["TEB"])
legend(["Experimental","théorique"])

%% comparaison
figure('Name','Comparaison TEB');
subplot(1,2,1)
semilogy(TEB1)
hold on
semilogy(TEB2)
legend(["TEB 1","TEB 2"])

subplot(1,2,2)
semilogy(TEB1)
hold on
semilogy(TEB3)
legend(["TEB 1","TEB 3"])















